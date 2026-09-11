using System;

namespace Mono.Net.Security;

internal class BufferOffsetSize
{
	public byte[] Buffer;

	public int Offset;

	public int Size;

	public int TotalBytes;

	public bool Complete;

	public int EndOffset => Offset + Size;

	public int Remaining => Buffer.Length - Offset - Size;

	public BufferOffsetSize(byte[] buffer, int offset, int size)
	{
		if (buffer == null)
		{
			throw new ArgumentNullException("buffer");
		}
		if (offset < 0)
		{
			throw new ArgumentOutOfRangeException("offset");
		}
		if (size < 0 || offset + size > buffer.Length)
		{
			throw new ArgumentOutOfRangeException("size");
		}
		Buffer = buffer;
		Offset = offset;
		Size = size;
		Complete = false;
	}

	public override string ToString()
	{
		return $"[BufferOffsetSize: {Offset} {Size}]";
	}
}
