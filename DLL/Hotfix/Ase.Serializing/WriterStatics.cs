using System;
using System.Text;

namespace Ase.Serializing;

internal class WriterStatics
{
	private static readonly UTF8Encoding _encoding = new UTF8Encoding(encoderShouldEmitUTF8Identifier: false, throwOnInvalidBytes: true);

	private static byte[] _stringBuffer = new byte[64];

	public static byte[] GetStringBuffer(string str, out int size)
	{
		int length = str.Length;
		int maxByteCount = _encoding.GetMaxByteCount(length);
		if (maxByteCount >= _stringBuffer.Length)
		{
			int newSize = _stringBuffer.Length * 2 + maxByteCount;
			Array.Resize(ref _stringBuffer, newSize);
		}
		size = _encoding.GetBytes(str, 0, length, _stringBuffer, 0);
		return _stringBuffer;
	}

	public static byte[] GetStringBuffer(string str)
	{
		int maxByteCount = _encoding.GetMaxByteCount(str.Length);
		if (maxByteCount >= _stringBuffer.Length)
		{
			int newSize = _stringBuffer.Length * 2 + maxByteCount;
			Array.Resize(ref _stringBuffer, newSize);
		}
		return _stringBuffer;
	}
}
