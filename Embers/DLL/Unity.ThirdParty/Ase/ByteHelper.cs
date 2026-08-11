using System.Text;

namespace Ase;

public static class ByteHelper
{
	public static string ToHex(this byte b)
	{
		return b.ToString("X2");
	}

	public static string ToHex(this byte[] bytes)
	{
		StringBuilder stringBuilder = new StringBuilder();
		foreach (byte b in bytes)
		{
			stringBuilder.Append(b.ToString("X2"));
		}
		return stringBuilder.ToString();
	}

	public static string ToHex(this byte[] bytes, string format)
	{
		StringBuilder stringBuilder = new StringBuilder();
		foreach (byte b in bytes)
		{
			stringBuilder.Append(b.ToString(format));
		}
		return stringBuilder.ToString();
	}

	public static string ToHex(this byte[] bytes, int offset, int count)
	{
		StringBuilder stringBuilder = new StringBuilder();
		for (int i = offset; i < offset + count; i++)
		{
			stringBuilder.Append(bytes[i].ToString("X2"));
		}
		return stringBuilder.ToString();
	}

	public static string ToStr(this byte[] bytes)
	{
		return Encoding.Default.GetString(bytes);
	}

	public static string ToStr(this byte[] bytes, int index, int count)
	{
		return Encoding.Default.GetString(bytes, index, count);
	}

	public static string Utf8ToStr(this byte[] bytes)
	{
		return Encoding.UTF8.GetString(bytes);
	}

	public static string Utf8ToStr(this byte[] bytes, int index, int count)
	{
		return Encoding.UTF8.GetString(bytes, index, count);
	}

	public static void WriteTo(this byte[] bytes, int offset, uint num)
	{
		bytes[offset] = (byte)(num & 0xFF);
		bytes[offset + 1] = (byte)((num & 0xFF00) >> 8);
		bytes[offset + 2] = (byte)((num & 0xFF0000) >> 16);
		bytes[offset + 3] = (byte)((num & 0xFF000000u) >> 24);
	}

	public static void WriteTo(this byte[] bytes, int offset, int num)
	{
		bytes[offset] = (byte)(num & 0xFF);
		bytes[offset + 1] = (byte)((num & 0xFF00) >> 8);
		bytes[offset + 2] = (byte)((num & 0xFF0000) >> 16);
		bytes[offset + 3] = (byte)((num & 0xFF000000u) >> 24);
	}

	public static void WriteTo(this byte[] bytes, int offset, byte num)
	{
		bytes[offset] = num;
	}

	public static void WriteTo(this byte[] bytes, int offset, short num)
	{
		bytes[offset] = (byte)(num & 0xFF);
		bytes[offset + 1] = (byte)((num & 0xFF00) >> 8);
	}

	public static void WriteTo(this byte[] bytes, int offset, ushort num)
	{
		bytes[offset] = (byte)(num & 0xFF);
		bytes[offset + 1] = (byte)((num & 0xFF00) >> 8);
	}

	public unsafe static void WriteTo(this byte[] bytes, int offset, long num)
	{
		byte* ptr = (byte*)(&num);
		for (int i = 0; i < 8; i++)
		{
			bytes[offset + i] = ptr[i];
		}
	}

	public static long Hash(this byte[] data, int index, int length)
	{
		long num = 2166136261L;
		for (int i = index; i < index + length; i++)
		{
			num = (num ^ data[i]) * 16777619;
		}
		num += num << 13;
		num ^= num >> 7;
		num += num << 3;
		num ^= num >> 17;
		return num + (num << 5);
	}
}
