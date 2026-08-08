using System;

namespace Mono.Net.Security;

internal class BufferOffsetSize2 : BufferOffsetSize
{
	public readonly int InitialSize;

	public BufferOffsetSize2(int size)
		: base(new byte[size], 0, 0)
	{
		InitialSize = size;
	}

	public void Reset()
	{
		Offset = (Size = 0);
		TotalBytes = 0;
		Buffer = new byte[InitialSize];
		Complete = false;
	}

	public void MakeRoom(int size)
	{
		if (base.Remaining < size)
		{
			int num = size - base.Remaining;
			if (Offset == 0 && Size == 0)
			{
				Buffer = new byte[size];
				return;
			}
			byte[] array = new byte[Buffer.Length + num];
			Buffer.CopyTo(array, 0);
			Buffer = array;
		}
	}

	public void AppendData(byte[] buffer, int offset, int size)
	{
		MakeRoom(size);
		System.Buffer.BlockCopy(buffer, offset, Buffer, base.EndOffset, size);
		Size += size;
	}
}
