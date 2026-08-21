using System;
using System.Buffers;
using System.Runtime.CompilerServices;

namespace MemoryPack.Internal;

internal struct BufferSegment
{
	private byte[] buffer;

	private int written;

	public bool IsNull => buffer == null;

	public int WrittenCount => written;

	public Span<byte> WrittenBuffer => MemoryExtensions.AsSpan(buffer, 0, written);

	public Memory<byte> WrittenMemory => MemoryExtensions.AsMemory(buffer, 0, written);

	public Span<byte> FreeBuffer => MemoryExtensions.AsSpan(buffer, written);

	public BufferSegment(int size)
	{
		buffer = ArrayPool<byte>.Shared.Rent(size);
		written = 0;
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void Advance(int count)
	{
		written += count;
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public void Clear()
	{
		if (buffer != null)
		{
			ArrayPool<byte>.Shared.Return(buffer);
		}
		buffer = null;
		written = 0;
	}
}
