using System;
using System.Text;

namespace Ase.Serializing;

internal class ReaderStatics
{
	private static byte[] _guidBuffer = new byte[16];

	private static readonly UTF8Encoding _encoding = new UTF8Encoding(encoderShouldEmitUTF8Identifier: false, throwOnInvalidBytes: true);

	public static byte[] GetGuidBuffer()
	{
		return _guidBuffer;
	}

	public static string GetString(ArraySegment<byte> data)
	{
		return _encoding.GetString(data.Array, data.Offset, data.Count);
	}
}
