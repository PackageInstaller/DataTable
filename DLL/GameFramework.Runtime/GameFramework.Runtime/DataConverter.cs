using System;
using System.Text;
using UnityEngine;

namespace GameFramework.Runtime;

public static class DataConverter
{
	public static string GetString(bool value)
	{
		return Convert.ToBase64String(BitConverter.GetBytes(value));
	}

	public static string GetString(float value)
	{
		return Convert.ToBase64String(BitConverter.GetBytes(value));
	}

	public static string GetString(int value)
	{
		return Convert.ToBase64String(BitConverter.GetBytes(value));
	}

	public static string GetString(string value)
	{
		return Convert.ToBase64String(Encoding.UTF8.GetBytes((value == null) ? "" : value));
	}

	public static string GetString(Color value)
	{
		byte[] array = new byte[16];
		Buffer.BlockCopy(BitConverter.GetBytes(value.r), 0, array, 0, 4);
		Buffer.BlockCopy(BitConverter.GetBytes(value.g), 0, array, 4, 4);
		Buffer.BlockCopy(BitConverter.GetBytes(value.b), 0, array, 8, 4);
		Buffer.BlockCopy(BitConverter.GetBytes(value.a), 0, array, 12, 4);
		return Convert.ToBase64String(array);
	}

	public static string GetString(Vector2 value)
	{
		byte[] array = new byte[8];
		Buffer.BlockCopy(BitConverter.GetBytes(value.x), 0, array, 0, 4);
		Buffer.BlockCopy(BitConverter.GetBytes(value.y), 0, array, 4, 4);
		return Convert.ToBase64String(array);
	}

	public static string GetString(Vector3 value)
	{
		byte[] array = new byte[12];
		Buffer.BlockCopy(BitConverter.GetBytes(value.x), 0, array, 0, 4);
		Buffer.BlockCopy(BitConverter.GetBytes(value.y), 0, array, 4, 4);
		Buffer.BlockCopy(BitConverter.GetBytes(value.z), 0, array, 8, 4);
		return Convert.ToBase64String(array);
	}

	public static string GetString(Vector4 value)
	{
		byte[] array = new byte[16];
		Buffer.BlockCopy(BitConverter.GetBytes(value.x), 0, array, 0, 4);
		Buffer.BlockCopy(BitConverter.GetBytes(value.y), 0, array, 4, 4);
		Buffer.BlockCopy(BitConverter.GetBytes(value.z), 0, array, 8, 4);
		Buffer.BlockCopy(BitConverter.GetBytes(value.w), 0, array, 12, 4);
		return Convert.ToBase64String(array);
	}

	public static string GetString(Rect value)
	{
		byte[] array = new byte[16];
		Buffer.BlockCopy(BitConverter.GetBytes(value.x), 0, array, 0, 4);
		Buffer.BlockCopy(BitConverter.GetBytes(value.y), 0, array, 4, 4);
		Buffer.BlockCopy(BitConverter.GetBytes(value.width), 0, array, 8, 4);
		Buffer.BlockCopy(BitConverter.GetBytes(value.height), 0, array, 12, 4);
		return Convert.ToBase64String(array);
	}

	public static bool ToBoolean(string value)
	{
		try
		{
			if (string.IsNullOrEmpty(value))
			{
				return false;
			}
			return BitConverter.ToBoolean(Convert.FromBase64String(value), 0);
		}
		catch (Exception)
		{
			return false;
		}
	}

	public static float ToSingle(string value)
	{
		try
		{
			if (string.IsNullOrEmpty(value))
			{
				return 0f;
			}
			return BitConverter.ToSingle(Convert.FromBase64String(value), 0);
		}
		catch (Exception)
		{
			return 0f;
		}
	}

	public static int ToInt32(string value)
	{
		try
		{
			if (string.IsNullOrEmpty(value))
			{
				return 0;
			}
			return BitConverter.ToInt32(Convert.FromBase64String(value), 0);
		}
		catch (Exception)
		{
			return 0;
		}
	}

	public static string ToString(string value)
	{
		try
		{
			if (string.IsNullOrEmpty(value))
			{
				return string.Empty;
			}
			return Encoding.UTF8.GetString(Convert.FromBase64String(value));
		}
		catch (Exception)
		{
			return string.Empty;
		}
	}

	public static Color ToColor(string value)
	{
		try
		{
			if (string.IsNullOrEmpty(value))
			{
				return Color.white;
			}
			byte[] value2 = Convert.FromBase64String(value);
			Color white = Color.white;
			white.r = BitConverter.ToSingle(value2, 0);
			white.g = BitConverter.ToSingle(value2, 4);
			white.b = BitConverter.ToSingle(value2, 8);
			white.a = BitConverter.ToSingle(value2, 12);
			return white;
		}
		catch (Exception)
		{
			return Color.white;
		}
	}

	public static Vector2 ToVector2(string value)
	{
		try
		{
			if (string.IsNullOrEmpty(value))
			{
				return Vector2.zero;
			}
			byte[] value2 = Convert.FromBase64String(value);
			Vector2 zero = Vector2.zero;
			zero.x = BitConverter.ToSingle(value2, 0);
			zero.y = BitConverter.ToSingle(value2, 4);
			return zero;
		}
		catch (Exception)
		{
			return Vector2.zero;
		}
	}

	public static Vector3 ToVector3(string value)
	{
		try
		{
			if (string.IsNullOrEmpty(value))
			{
				return Vector3.zero;
			}
			byte[] value2 = Convert.FromBase64String(value);
			Vector3 zero = Vector3.zero;
			zero.x = BitConverter.ToSingle(value2, 0);
			zero.y = BitConverter.ToSingle(value2, 4);
			zero.z = BitConverter.ToSingle(value2, 8);
			return zero;
		}
		catch (Exception)
		{
			return Vector3.zero;
		}
	}

	public static Vector4 ToVector4(string value)
	{
		try
		{
			if (string.IsNullOrEmpty(value))
			{
				return Vector4.zero;
			}
			byte[] value2 = Convert.FromBase64String(value);
			Vector4 zero = Vector4.zero;
			zero.x = BitConverter.ToSingle(value2, 0);
			zero.y = BitConverter.ToSingle(value2, 4);
			zero.z = BitConverter.ToSingle(value2, 8);
			zero.w = BitConverter.ToSingle(value2, 12);
			return zero;
		}
		catch (Exception)
		{
			return Vector4.zero;
		}
	}

	public static Rect ToRect(string value)
	{
		try
		{
			if (string.IsNullOrEmpty(value))
			{
				return Rect.zero;
			}
			byte[] value2 = Convert.FromBase64String(value);
			Rect zero = Rect.zero;
			zero.x = BitConverter.ToSingle(value2, 0);
			zero.y = BitConverter.ToSingle(value2, 4);
			zero.width = BitConverter.ToSingle(value2, 8);
			zero.height = BitConverter.ToSingle(value2, 12);
			return zero;
		}
		catch (Exception)
		{
			return Rect.zero;
		}
	}
}
