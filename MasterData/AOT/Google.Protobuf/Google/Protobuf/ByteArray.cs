using System;

namespace Google.Protobuf;

internal static class ByteArray
{
	internal static void Copy(byte[] src, int srcOffset, byte[] dst, int dstOffset, int count)
	{
		if (count > 12)
		{
			Buffer.BlockCopy(src, srcOffset, dst, dstOffset, count);
			return;
		}
		int num = srcOffset + count;
		for (int i = srcOffset; i < num; i++)
		{
			dst[dstOffset++] = src[i];
		}
	}
}
