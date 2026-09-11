namespace System.Net;

internal class BufferOffsetSize
{
	internal byte[] Buffer;

	internal int Offset;

	internal int Size;

	internal BufferOffsetSize(byte[] buffer, int offset, int size, bool copyBuffer)
	{
		if (copyBuffer)
		{
			byte[] array = new byte[size];
			System.Buffer.BlockCopy(buffer, offset, array, 0, size);
			offset = 0;
			buffer = array;
		}
		Buffer = buffer;
		Offset = offset;
		Size = size;
	}

	internal BufferOffsetSize(byte[] buffer, bool copyBuffer)
		: this(buffer, 0, buffer.Length, copyBuffer)
	{
	}
}
