using System;
using System.IO;
using GameFramework;

public static class BinaryExtension
{
	private static readonly byte[] s_CachedBytes = new byte[256];

	public static int Read7BitEncodedInt32(this BinaryReader binaryReader)
	{
		int num = 0;
		int num2 = 0;
		byte b;
		do
		{
			if (num2 >= 35)
			{
				throw new GameFrameworkException("7 bit encoded int is invalid.");
			}
			b = binaryReader.ReadByte();
			num |= (b & 0x7F) << num2;
			num2 += 7;
		}
		while ((b & 0x80) != 0);
		return num;
	}

	public static void Write7BitEncodedInt32(this BinaryWriter binaryWriter, int value)
	{
		uint num;
		for (num = (uint)value; num >= 128; num >>= 7)
		{
			binaryWriter.Write((byte)(num | 0x80));
		}
		binaryWriter.Write((byte)num);
	}

	public static uint Read7BitEncodedUInt32(this BinaryReader binaryReader)
	{
		return (uint)binaryReader.Read7BitEncodedInt32();
	}

	public static void Write7BitEncodedUInt32(this BinaryWriter binaryWriter, uint value)
	{
		binaryWriter.Write7BitEncodedInt32((int)value);
	}

	public static long Read7BitEncodedInt64(this BinaryReader binaryReader)
	{
		long num = 0L;
		int num2 = 0;
		byte b;
		do
		{
			if (num2 >= 70)
			{
				throw new GameFrameworkException("7 bit encoded int is invalid.");
			}
			b = binaryReader.ReadByte();
			num |= (long)(((ulong)b & 0x7FuL) << num2);
			num2 += 7;
		}
		while ((b & 0x80) != 0);
		return num;
	}

	public static void Write7BitEncodedInt64(this BinaryWriter binaryWriter, long value)
	{
		ulong num;
		for (num = (ulong)value; num >= 128; num >>= 7)
		{
			binaryWriter.Write((byte)(num | 0x80));
		}
		binaryWriter.Write((byte)num);
	}

	public static ulong Read7BitEncodedUInt64(this BinaryReader binaryReader)
	{
		return (ulong)binaryReader.Read7BitEncodedInt64();
	}

	public static void Write7BitEncodedUInt64(this BinaryWriter binaryWriter, ulong value)
	{
		binaryWriter.Write7BitEncodedInt64((long)value);
	}

	public static string ReadEncryptedString(this BinaryReader binaryReader, byte[] encryptBytes)
	{
		byte b = binaryReader.ReadByte();
		if (b <= 0)
		{
			return null;
		}
		if (b > byte.MaxValue)
		{
			throw new GameFrameworkException("String is too long.");
		}
		for (byte b2 = 0; b2 < b; b2++)
		{
			s_CachedBytes[b2] = binaryReader.ReadByte();
		}
		Utility.Encryption.GetSelfXorBytes(s_CachedBytes, 0, b, encryptBytes);
		string result = Utility.Converter.GetString(s_CachedBytes, 0, b);
		Array.Clear(s_CachedBytes, 0, b);
		return result;
	}

	public static void WriteEncryptedString(this BinaryWriter binaryWriter, string value, byte[] encryptBytes)
	{
		if (string.IsNullOrEmpty(value))
		{
			binaryWriter.Write((byte)0);
			return;
		}
		int bytes = Utility.Converter.GetBytes(value, s_CachedBytes);
		if (bytes > 255)
		{
			throw new GameFrameworkException(Utility.Text.Format("String '{0}' is too long.", value));
		}
		Utility.Encryption.GetSelfXorBytes(s_CachedBytes, encryptBytes);
		binaryWriter.Write((byte)bytes);
		binaryWriter.Write(s_CachedBytes, 0, bytes);
	}
}
