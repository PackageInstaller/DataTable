using System;
using System.Buffers;
using System.IO;
using System.IO.Compression;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using System.Threading;
using System.Threading.Tasks;
using MemoryPack.Internal;

namespace MemoryPack.Compression;

public class BrotliCompressor : IBufferWriter<byte>, IDisposable
{
	private ReusableLinkedArrayBufferWriter? bufferWriter;

	private readonly int quality;

	private readonly int window;

	public BrotliCompressor(CompressionLevel compressionLevel)
		: this(BrotliUtils.GetQualityFromCompressionLevel(compressionLevel))
	{
	}

	public BrotliCompressor(CompressionLevel compressionLevel, int window)
		: this(BrotliUtils.GetQualityFromCompressionLevel(compressionLevel), window)
	{
	}

	public BrotliCompressor(int quality = 1, int window = 22)
	{
		bufferWriter = ReusableLinkedArrayBufferWriterPool.Rent();
		this.quality = quality;
		this.window = window;
	}

	void IBufferWriter<byte>.Advance(int count)
	{
		ThrowIfDisposed();
		bufferWriter.Advance(count);
	}

	Memory<byte> IBufferWriter<byte>.GetMemory(int sizeHint)
	{
		ThrowIfDisposed();
		return bufferWriter.GetMemory(sizeHint);
	}

	Span<byte> IBufferWriter<byte>.GetSpan(int sizeHint)
	{
		ThrowIfDisposed();
		return bufferWriter.GetSpan(sizeHint);
	}

	public unsafe byte[] ToArray()
	{
		ThrowIfDisposed();
		BrotliEncoder val = default(BrotliEncoder);
		((BrotliEncoder)(ref val))._002Ector(quality, window);
		try
		{
			int num = BrotliUtils.BrotliEncoderMaxCompressedSize(bufferWriter.TotalWritten);
			byte[] array = ArrayPool<byte>.Shared.Rent(num);
			try
			{
				int num2 = 0;
				Span<byte> span = MemoryExtensions.AsSpan(array, 0, num);
				int num3 = default(int);
				int num4 = default(int);
				foreach (Memory<byte> item in bufferWriter)
				{
					OperationStatus operationStatus = ((BrotliEncoder)(ref val)).Compress((ReadOnlySpan<byte>)item.Span, span, ref num3, ref num4, false);
					if (operationStatus != OperationStatus.Done)
					{
						MemoryPackSerializationException.ThrowCompressionFailed(operationStatus);
					}
					if (num3 != item.Span.Length)
					{
						MemoryPackSerializationException.ThrowCompressionFailed();
					}
					if (num4 > 0)
					{
						span = span.Slice(num4);
						num2 += num4;
					}
				}
				int num5 = default(int);
				int num6 = default(int);
				((BrotliEncoder)(ref val)).Compress(ReadOnlySpan<byte>.Empty, span, ref num5, ref num6, true);
				num2 += num6;
				return MemoryExtensions.AsSpan(array, 0, num2).ToArray();
			}
			finally
			{
				ArrayPool<byte>.Shared.Return(array);
			}
		}
		finally
		{
			((IDisposable)(*(BrotliEncoder*)(&val))/*cast due to constrained. prefix*/).Dispose();
		}
	}

	public void CopyTo(in IBufferWriter<byte> destBufferWriter)
	{
		ThrowIfDisposed();
		BrotliEncoder encoder = default(BrotliEncoder);
		((BrotliEncoder)(ref encoder))._002Ector(quality, window);
		try
		{
			int num = 0;
			foreach (Memory<byte> item in bufferWriter)
			{
				num = CompressCore(ref encoder, item.Span, ref Unsafe.AsRef(in destBufferWriter), null, isFinalBlock: false);
			}
			int? initialLength = ((num == 0) ? ((int?)null) : new int?(num + 10));
			CompressCore(ref encoder, ReadOnlySpan<byte>.Empty, ref Unsafe.AsRef(in destBufferWriter), initialLength, isFinalBlock: true);
		}
		finally
		{
			((BrotliEncoder)(ref encoder)).Dispose();
		}
	}

	public unsafe async ValueTask CopyToAsync(Stream stream, int bufferSize = 65535, CancellationToken cancellationToken = default(CancellationToken))
	{
		ThrowIfDisposed();
		BrotliEncoder encoder = new BrotliEncoder(quality, window);
		try
		{
			byte[] buffer = ArrayPool<byte>.Shared.Rent(bufferSize);
			try
			{
				int bytesConsumed = default(int);
				int num = default(int);
				foreach (Memory<byte> item in bufferWriter)
				{
					Memory<byte> source = item;
					OperationStatus lastResult = OperationStatus.DestinationTooSmall;
					while (lastResult == OperationStatus.DestinationTooSmall)
					{
						lastResult = ((BrotliEncoder)(ref encoder)).Compress((ReadOnlySpan<byte>)source.Span, (Span<byte>)buffer, ref bytesConsumed, ref num, false);
						if (lastResult == OperationStatus.InvalidData)
						{
							MemoryPackSerializationException.ThrowCompressionFailed();
						}
						if (num > 0)
						{
							await stream.WriteAsync(MemoryExtensions.AsMemory(buffer, 0, num), cancellationToken).ConfigureAwait(continueOnCapturedContext: false);
						}
						if (bytesConsumed > 0)
						{
							source = source.Slice(bytesConsumed);
						}
					}
				}
				int num2 = default(int);
				int num3 = default(int);
				((BrotliEncoder)(ref encoder)).Compress(ReadOnlySpan<byte>.Empty, (Span<byte>)buffer, ref num2, ref num3, true);
				if (num3 > 0)
				{
					await stream.WriteAsync(MemoryExtensions.AsMemory(buffer, 0, num3), cancellationToken).ConfigureAwait(continueOnCapturedContext: false);
				}
			}
			finally
			{
				ArrayPool<byte>.Shared.Return(buffer);
			}
		}
		finally
		{
			((IDisposable)(*(BrotliEncoder*)(&encoder))/*cast due to constrained. prefix*/).Dispose();
		}
	}

	public void CopyTo(ref MemoryPackWriter memoryPackWriter)
	{
		ThrowIfDisposed();
		BrotliEncoder encoder = default(BrotliEncoder);
		((BrotliEncoder)(ref encoder))._002Ector(quality, window);
		try
		{
			int num = 0;
			foreach (Memory<byte> item in bufferWriter)
			{
				num = CompressCore(ref encoder, item.Span, ref memoryPackWriter, null, isFinalBlock: false);
			}
			int? initialLength = ((num == 0) ? ((int?)null) : new int?(num + 10));
			CompressCore(ref encoder, ReadOnlySpan<byte>.Empty, ref memoryPackWriter, initialLength, isFinalBlock: true);
		}
		finally
		{
			((BrotliEncoder)(ref encoder)).Dispose();
		}
	}

	private static int CompressCore(ref BrotliEncoder encoder, ReadOnlySpan<byte> source, ref IBufferWriter<byte> destBufferWriter, int? initialLength, bool isFinalBlock)
	{
		int num = 0;
		OperationStatus operationStatus = OperationStatus.DestinationTooSmall;
		int num2 = default(int);
		int num3 = default(int);
		while (operationStatus == OperationStatus.DestinationTooSmall)
		{
			Span<byte> span = destBufferWriter.GetSpan(initialLength ?? source.Length);
			operationStatus = ((BrotliEncoder)(ref encoder)).Compress(source, span, ref num2, ref num3, isFinalBlock);
			num += num2;
			if (operationStatus == OperationStatus.InvalidData)
			{
				MemoryPackSerializationException.ThrowCompressionFailed();
			}
			if (num3 > 0)
			{
				destBufferWriter.Advance(num3);
				num = 0;
			}
			if (num2 > 0)
			{
				source = source.Slice(num2);
			}
		}
		return num;
	}

	private static int CompressCore(ref BrotliEncoder encoder, ReadOnlySpan<byte> source, ref MemoryPackWriter destBufferWriter, int? initialLength, bool isFinalBlock)
	{
		int num = 0;
		OperationStatus operationStatus = OperationStatus.DestinationTooSmall;
		int num2 = default(int);
		int num3 = default(int);
		while (operationStatus == OperationStatus.DestinationTooSmall)
		{
			Span<byte> span = MemoryMarshal.CreateSpan(ref destBufferWriter.GetSpanReference(initialLength ?? source.Length), destBufferWriter.BufferLength);
			operationStatus = ((BrotliEncoder)(ref encoder)).Compress(source, span, ref num2, ref num3, isFinalBlock);
			num += num2;
			if (operationStatus == OperationStatus.InvalidData)
			{
				MemoryPackSerializationException.ThrowCompressionFailed();
			}
			if (num3 > 0)
			{
				destBufferWriter.Advance(num3);
				num = 0;
			}
			if (num2 > 0)
			{
				source = source.Slice(num2);
			}
		}
		return num;
	}

	public void Dispose()
	{
		if (bufferWriter != null)
		{
			bufferWriter.Reset();
			ReusableLinkedArrayBufferWriterPool.Return(bufferWriter);
			bufferWriter = null;
		}
	}

	private void ThrowIfDisposed()
	{
		if (bufferWriter == null)
		{
			throw new ObjectDisposedException(null);
		}
	}
}
