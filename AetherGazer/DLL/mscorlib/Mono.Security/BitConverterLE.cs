using System;

namespace Mono.Security;

internal sealed class BitConverterLE
{
	private unsafe static byte[] GetUIntBytes(byte* bytes)
	{
		if (!BitConverter.IsLittleEndian)
		{
			return new byte[4]
			{
				bytes[3],
				bytes[2],
				bytes[1],
				*bytes
			};
		}
		return new byte[4]
		{
			*bytes,
			bytes[1],
			bytes[2],
			bytes[3]
		};
	}

	private unsafe static byte[] GetULongBytes(byte* bytes)
	{
		if (!BitConverter.IsLittleEndian)
		{
			return new byte[8]
			{
				bytes[7],
				bytes[6],
				bytes[5],
				bytes[4],
				bytes[3],
				bytes[2],
				bytes[1],
				*bytes
			};
		}
		return new byte[8]
		{
			*bytes,
			bytes[1],
			bytes[2],
			bytes[3],
			bytes[4],
			bytes[5],
			bytes[6],
			bytes[7]
		};
	}

	internal unsafe static byte[] GetBytes(int value)
	{
		return GetUIntBytes((byte*)(&value));
	}

	internal unsafe static byte[] GetBytes(float value)
	{
		return GetUIntBytes((byte*)(&value));
	}

	internal unsafe static byte[] GetBytes(double value)
	{
		return GetULongBytes((byte*)(&value));
	}

	private unsafe static void UIntFromBytes(byte* dst, byte[] src, int startIndex)
	{
		if (BitConverter.IsLittleEndian)
		{
			*dst = src[startIndex];
			dst[1] = src[startIndex + 1];
			dst[2] = src[startIndex + 2];
			dst[3] = src[startIndex + 3];
		}
		else
		{
			*dst = src[startIndex + 3];
			dst[1] = src[startIndex + 2];
			dst[2] = src[startIndex + 1];
			dst[3] = src[startIndex];
		}
	}

	private unsafe static void ULongFromBytes(byte* dst, byte[] src, int startIndex)
	{
		if (BitConverter.IsLittleEndian)
		{
			for (int i = 0; i < 8; i++)
			{
				dst[i] = src[startIndex + i];
			}
		}
		else
		{
			for (int j = 0; j < 8; j++)
			{
				dst[j] = src[startIndex + (7 - j)];
			}
		}
	}

	internal unsafe static float ToSingle(byte[] value, int startIndex)
	{
		float result = default(float);
		UIntFromBytes((byte*)(&result), value, startIndex);
		return result;
	}

	internal unsafe static double ToDouble(byte[] value, int startIndex)
	{
		double result = default(double);
		ULongFromBytes((byte*)(&result), value, startIndex);
		return result;
	}
}
