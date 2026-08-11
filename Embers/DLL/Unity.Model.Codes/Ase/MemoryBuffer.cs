using System;
using System.Buffers;
using System.IO;

namespace Ase;

public class MemoryBuffer : MemoryStream, IBufferWriter<byte>
{
	private int origin;

	public ReadOnlyMemory<byte> WrittenMemory => GetBuffer().AsMemory(origin, (int)Position);

	public ReadOnlySpan<byte> WrittenSpan => GetBuffer().AsSpan(origin, (int)Position);

	public MemoryBuffer()
	{
	}

	public MemoryBuffer(int capacity)
		: base(capacity)
	{
	}

	public MemoryBuffer(byte[] buffer)
		: base(buffer)
	{
	}

	public MemoryBuffer(byte[] buffer, int index, int length)
		: base(buffer, index, length)
	{
		origin = index;
	}

	public void Advance(int count)
	{
		long num = Position + count;
		if (num > Length)
		{
			SetLength(num);
		}
		Position = num;
	}

	public Memory<byte> GetMemory(int sizeHint = 0)
	{
		if (Length - Position < sizeHint)
		{
			SetLength(Position + sizeHint);
		}
		return GetBuffer().AsMemory((int)Position + origin, (int)(Length - Position));
	}

	public Span<byte> GetSpan(int sizeHint = 0)
	{
		if (Length - Position < sizeHint)
		{
			SetLength(Position + sizeHint);
		}
		return GetBuffer().AsSpan((int)Position + origin, (int)(Length - Position));
	}
}
