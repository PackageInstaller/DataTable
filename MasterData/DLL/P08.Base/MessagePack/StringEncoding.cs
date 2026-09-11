using System;
using System.Text;

namespace MessagePack;

internal static class StringEncoding
{
	internal static readonly Encoding UTF8 = new UTF8Encoding(encoderShouldEmitUTF8Identifier: false);

	internal unsafe static string GetString(this Encoding encoding, ReadOnlySpan<byte> bytes)
	{
		if (bytes.Length == 0)
		{
			return string.Empty;
		}
		fixed (byte* bytes2 = bytes)
		{
			return encoding.GetString(bytes2, bytes.Length);
		}
	}
}
