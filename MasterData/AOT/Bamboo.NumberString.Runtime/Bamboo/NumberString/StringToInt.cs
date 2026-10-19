using System;

namespace Bamboo.NumberString;

public static class StringToInt
{
	public static int FastToInt(this string value)
	{
		int num = 1;
		int num2 = 0;
		if (value[0] == '-')
		{
			num = -1;
			num2 = 1;
		}
		int num3 = 0;
		int length = value.Length;
		for (int i = num2; i < length; i++)
		{
			char c = value[i];
			if (c < '0' || c > '9')
			{
				throw new Exception(value + " can't convert to int, illegal.");
			}
			num3 = 10 * num3 + (c - 48);
			if (num3 < 0)
			{
				throw new Exception(value + " can't convert to int, overflow.");
			}
		}
		return num3 * num;
	}

	public static int SafeToInt(this string value)
	{
		if (string.IsNullOrEmpty(value))
		{
			return 0;
		}
		int num = 1;
		int num2 = 0;
		if (value[0] == '-')
		{
			num = -1;
			num2 = 1;
		}
		int num3 = 0;
		int length = value.Length;
		for (int i = num2; i < length; i++)
		{
			char c = value[i];
			if (c < '0' || c > '9')
			{
				return 0;
			}
			num3 = 10 * num3 + (c - 48);
			if (num3 < 0)
			{
				return 0;
			}
		}
		return num3 * num;
	}
}
