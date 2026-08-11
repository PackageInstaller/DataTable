using System;
using System.Buffers;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using System.Threading;
using System.Threading.Tasks;

namespace MemoryPack.Internal;

public sealed class ReusableLinkedArrayBufferWriter : IBufferWriter<byte>
{
	public struct Enumerator(ReusableLinkedArrayBufferWriter parent) : IEnumerator<Memory<byte>>, IEnumerator, IDisposable
	{
		private enum State
		{
			FirstBuffer,
			BuffersInit,
			BuffersIterate,
			Current,
			End
		}

		private ReusableLinkedArrayBufferWriter parent = parent;

		private State state = State.FirstBuffer;

		private Memory<byte> current = default(Memory<byte>);

		private List<BufferSegment>.Enumerator buffersEnumerator = default(List<BufferSegment>.Enumerator);

		public Memory<byte> Current => current;

		object IEnumerator.Current
		{
			get
			{
				throw new NotSupportedException();
			}
		}

		public void Dispose()
		{
		}

		public bool MoveNext()
		{
			if (state == State.FirstBuffer)
			{
				state = State.BuffersInit;
				if (parent.UseFirstBuffer)
				{
					current = MemoryExtensions.AsMemory(parent.firstBuffer, 0, parent.firstBufferWritten);
					return true;
				}
			}
			if (state == State.BuffersInit)
			{
				state = State.BuffersIterate;
				buffersEnumerator = parent.buffers.GetEnumerator();
			}
			if (state == State.BuffersIterate)
			{
				if (buffersEnumerator.MoveNext())
				{
					current = buffersEnumerator.Current.WrittenMemory;
					return true;
				}
				buffersEnumerator.Dispose();
				state = State.Current;
			}
			if (state == State.Current)
			{
				state = State.End;
				current = parent.current.WrittenMemory;
				return true;
			}
			return false;
		}

		public void Reset()
		{
			throw new NotSupportedException();
		}
	}

	private const int InitialBufferSize = 262144;

	private static readonly byte[] noUseFirstBufferSentinel = new byte[0];

	private List<BufferSegment> buffers;

	private byte[] firstBuffer;

	private int firstBufferWritten;

	private BufferSegment current;

	private int nextBufferSize;

	private int totalWritten;

	public int TotalWritten => totalWritten;

	private bool UseFirstBuffer => firstBuffer != noUseFirstBufferSentinel;

	public ReusableLinkedArrayBufferWriter(bool useFirstBuffer, bool pinned)
	{
		buffers = new List<BufferSegment>();
		firstBuffer = (useFirstBuffer ? MemoryMarshalEx.AllocateUninitializedArray<byte>(262144, pinned) : noUseFirstBufferSentinel);
		firstBufferWritten = 0;
		current = default(BufferSegment);
		nextBufferSize = 262144;
		totalWritten = 0;
	}

	public byte[] DangerousGetFirstBuffer()
	{
		return firstBuffer;
	}

	public Memory<byte> GetMemory(int sizeHint = 0)
	{
		throw new NotSupportedException();
	}

	public Span<byte> GetSpan(int sizeHint = 0)
	{
		if (current.IsNull)
		{
			int num = firstBuffer.Length - firstBufferWritten;
			if (num != 0 && sizeHint <= num)
			{
				return MemoryExtensions.AsSpan(firstBuffer, firstBufferWritten);
			}
		}
		else
		{
			Span<byte> freeBuffer = current.FreeBuffer;
			if (freeBuffer.Length > sizeHint)
			{
				return freeBuffer;
			}
		}
		BufferSegment bufferSegment;
		if (sizeHint <= nextBufferSize)
		{
			bufferSegment = new BufferSegment(nextBufferSize);
			nextBufferSize = MathEx.NewArrayCapacity(nextBufferSize);
		}
		else
		{
			bufferSegment = new BufferSegment(sizeHint);
		}
		if (current.WrittenCount != 0)
		{
			buffers.Add(current);
		}
		current = bufferSegment;
		return bufferSegment.FreeBuffer;
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void Advance(int count)
	{
		if (current.IsNull)
		{
			firstBufferWritten += count;
		}
		else
		{
			current.Advance(count);
		}
		totalWritten += count;
	}

	public byte[] ToArrayAndReset()
	{
		if (totalWritten == 0)
		{
			return Array.Empty<byte>();
		}
		byte[] array = MemoryMarshalEx.AllocateUninitializedArray<byte>(totalWritten);
		Span<byte> destination = MemoryExtensions.AsSpan(array);
		if (UseFirstBuffer)
		{
			MemoryExtensions.AsSpan(firstBuffer, 0, firstBufferWritten).CopyTo(destination);
			destination = destination.Slice(firstBufferWritten);
		}
		if (buffers.Count > 0)
		{
			foreach (BufferSegment buffer in buffers)
			{
				buffer.WrittenBuffer.CopyTo(destination);
				destination = destination.Slice(buffer.WrittenCount);
				buffer.Clear();
			}
		}
		if (!current.IsNull)
		{
			current.WrittenBuffer.CopyTo(destination);
			current.Clear();
		}
		ResetCore();
		return array;
	}

	public void WriteToAndReset(ref MemoryPackWriter writer)
	{
		if (totalWritten == 0)
		{
			return;
		}
		if (UseFirstBuffer)
		{
			ref byte spanReference = ref writer.GetSpanReference(firstBufferWritten);
			MemoryExtensions.AsSpan(firstBuffer, 0, firstBufferWritten).CopyTo(MemoryMarshal.CreateSpan(ref spanReference, firstBufferWritten));
			writer.Advance(firstBufferWritten);
		}
		if (buffers.Count > 0)
		{
			foreach (BufferSegment buffer in buffers)
			{
				ref byte spanReference2 = ref writer.GetSpanReference(buffer.WrittenCount);
				buffer.WrittenBuffer.CopyTo(MemoryMarshal.CreateSpan(ref spanReference2, buffer.WrittenCount));
				writer.Advance(buffer.WrittenCount);
				buffer.Clear();
			}
		}
		if (!current.IsNull)
		{
			ref byte spanReference3 = ref writer.GetSpanReference(current.WrittenCount);
			current.WrittenBuffer.CopyTo(MemoryMarshal.CreateSpan(ref spanReference3, current.WrittenCount));
			writer.Advance(current.WrittenCount);
			current.Clear();
		}
		ResetCore();
	}

	public async ValueTask WriteToAndResetAsync(Stream stream, CancellationToken cancellationToken)
	{
		if (totalWritten == 0)
		{
			return;
		}
		if (UseFirstBuffer)
		{
			await stream.WriteAsync(MemoryExtensions.AsMemory(firstBuffer, 0, firstBufferWritten), cancellationToken).ConfigureAwait(continueOnCapturedContext: false);
		}
		if (buffers.Count > 0)
		{
			foreach (BufferSegment item in buffers)
			{
				await stream.WriteAsync(item.WrittenMemory, cancellationToken).ConfigureAwait(continueOnCapturedContext: false);
				item.Clear();
			}
		}
		if (!current.IsNull)
		{
			await stream.WriteAsync(current.WrittenMemory, cancellationToken).ConfigureAwait(continueOnCapturedContext: false);
			current.Clear();
		}
		ResetCore();
	}

	public Enumerator GetEnumerator()
	{
		return new Enumerator(this);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	private void ResetCore()
	{
		firstBufferWritten = 0;
		buffers.Clear();
		totalWritten = 0;
		current = default(BufferSegment);
		nextBufferSize = 262144;
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void Reset()
	{
		if (totalWritten == 0)
		{
			return;
		}
		foreach (BufferSegment buffer in buffers)
		{
			buffer.Clear();
		}
		current.Clear();
		ResetCore();
	}
}
