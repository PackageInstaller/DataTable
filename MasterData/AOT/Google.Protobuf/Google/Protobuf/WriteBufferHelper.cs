using System;
using System.Buffers;
using System.Runtime.CompilerServices;

namespace Google.Protobuf;

internal struct WriteBufferHelper
{
	private IBufferWriter<byte> bufferWriter;

	private CodedOutputStream codedOutputStream;

	public CodedOutputStream CodedOutputStream => codedOutputStream;

	[MethodImpl((MethodImplOptions)256)]
	public static void Initialize(CodedOutputStream codedOutputStream, out WriteBufferHelper instance)
	{
		instance.bufferWriter = null;
		instance.codedOutputStream = codedOutputStream;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static void Initialize(IBufferWriter<byte> bufferWriter, out WriteBufferHelper instance, out Span<byte> buffer)
	{
		instance.bufferWriter = bufferWriter;
		instance.codedOutputStream = null;
		buffer = default;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static void InitializeNonRefreshable(out WriteBufferHelper instance)
	{
		instance.bufferWriter = null;
		instance.codedOutputStream = null;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static void CheckNoSpaceLeft(ref WriterInternalState state)
	{
		if (GetSpaceLeft(ref state) != 0)
		{
			throw new InvalidOperationException("Did not write as much data as expected.");
		}
	}

	[MethodImpl((MethodImplOptions)256)]
	public static int GetSpaceLeft(ref WriterInternalState state)
	{
		if (state.writeBufferHelper.codedOutputStream?.InternalOutputStream == null && state.writeBufferHelper.bufferWriter == null)
		{
			return state.limit - state.position;
		}
		throw new InvalidOperationException("SpaceLeft can only be called on CodedOutputStreams that are writing to a flat array or when writing to a single span.");
	}

	[MethodImpl((MethodImplOptions)8)]
	public static void RefreshBuffer(ref Span<byte> buffer, ref WriterInternalState state)
	{
		if (state.writeBufferHelper.codedOutputStream?.InternalOutputStream != null)
		{
			state.writeBufferHelper.codedOutputStream.InternalOutputStream.Write(state.writeBufferHelper.codedOutputStream.InternalBuffer, 0, state.position);
			state.position = 0;
			return;
		}
		if (state.writeBufferHelper.bufferWriter != null)
		{
			state.writeBufferHelper.bufferWriter.Advance(state.position);
			state.position = 0;
			buffer = state.writeBufferHelper.bufferWriter.GetSpan();
			state.limit = buffer.Length;
			return;
		}
		throw new CodedOutputStream.OutOfSpaceException();
	}

	[MethodImpl((MethodImplOptions)256)]
	public static void Flush(ref Span<byte> buffer, ref WriterInternalState state)
	{
		if (state.writeBufferHelper.codedOutputStream?.InternalOutputStream != null)
		{
			state.writeBufferHelper.codedOutputStream.InternalOutputStream.Write(state.writeBufferHelper.codedOutputStream.InternalBuffer, 0, state.position);
			state.position = 0;
		}
		else if (state.writeBufferHelper.bufferWriter != null)
		{
			state.writeBufferHelper.bufferWriter.Advance(state.position);
			state.position = 0;
			state.limit = 0;
			buffer = default;
		}
	}
}
