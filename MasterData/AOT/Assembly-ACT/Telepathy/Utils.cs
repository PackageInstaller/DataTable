namespace Telepathy;

public static class Utils
{
	public static void IntToBytesBigEndianNonAlloc(int value, byte[] bytes, int offset = 0)
	{
		bytes[offset] = (byte)(value >> 24);
		bytes[offset + 1] = (byte)(value >> 16);
		bytes[offset + 2] = (byte)(value >> 8);
		bytes[offset + 3] = (byte)value;
	}

	public static int BytesToIntBigEndian(byte[] bytes)
	{
		return (bytes[0] << 24) | (bytes[1] << 16) | (bytes[2] << 8) | bytes[3];
	}
}
