namespace Internal.Cryptography;

internal static class Helpers
{
	public static byte[] CloneByteArray(this byte[] src)
	{
		if (src == null)
		{
			return null;
		}
		return (byte[])src.Clone();
	}

	public static void WriteInt(uint i, byte[] arr, int offset)
	{
		arr[offset] = (byte)(i >> 24);
		arr[offset + 1] = (byte)(i >> 16);
		arr[offset + 2] = (byte)(i >> 8);
		arr[offset + 3] = (byte)i;
	}

	public static char[] ToHexArrayUpper(this byte[] bytes)
	{
		char[] array = new char[bytes.Length * 2];
		int num = 0;
		foreach (byte b in bytes)
		{
			array[num++] = NibbleToHex((byte)(b >> 4));
			array[num++] = NibbleToHex((byte)(b & 0xF));
		}
		return array;
	}

	public static string ToHexStringUpper(this byte[] bytes)
	{
		return new string(bytes.ToHexArrayUpper());
	}

	private static char NibbleToHex(byte b)
	{
		return (char)((b >= 0 && b <= 9) ? (48 + b) : (65 + (b - 10)));
	}
}
