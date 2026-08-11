using System;
using System.Buffers;
using System.Runtime.CompilerServices;

namespace MemoryPack.Internal;

internal struct FixedArrayBufferWriter(byte[] buffer) : IBufferWriter<byte>
{
	private byte[] buffer = buffer;

	private int written = 0;

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void Advance(int count)
	{
		written += count;
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public Memory<byte> GetMemory(int sizeHint = 0)
	{
		Memory<byte> result = MemoryExtensions.AsMemory(buffer, written);
		if (result.Length >= sizeHint)
		{
			return result;
		}
		MemoryPackSerializationException.ThrowMessage("Requested invalid sizeHint.");
		return result;
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public Span<byte> GetSpan(int sizeHint = 0)
	{
		Span<byte> result = MemoryExtensions.AsSpan(buffer, written);
		if (result.Length >= sizeHint)
		{
			return result;
		}
		MemoryPackSerializationException.ThrowMessage("Requested invalid sizeHint.");
		return result;
	}

	public byte[] GetFilledBuffer()
	{
		if (written != buffer.Length)
		{
			MemoryPackSerializationException.ThrowMessage("Not filled buffer.");
		}
		return buffer;
	}
}
