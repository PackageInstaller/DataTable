using System;

namespace Bamboo.NumberString;

public static class StringToFloat
{
	public static float FastToFloat(this string value)
	{
		int num = 1;
		int num2 = 0;
		if (value[0] == '-')
		{
			num = -1;
			num2 = 1;
		}
		float num3 = 0f;
		float num4 = 0f;
		float num5 = 1f;
		bool flag = false;
		int length = value.Length;
		for (int i = num2; i < length; i++)
		{
			char c = value[i];
			switch (c)
			{
			case '.':
				if (flag)
				{
					throw new Exception(value + " can't convert to float, has multiple decimal points.");
				}
				flag = true;
				break;
			default:
				throw new Exception(value + " can't convert to float, illegal.");
			case '0':
			case '1':
			case '2':
			case '3':
			case '4':
			case '5':
			case '6':
			case '7':
			case '8':
			case '9':
				if (flag)
				{
					num5 *= 10f;
					num4 += (float)(c - 48) / num5;
					if (num4 < 0f)
					{
						throw new Exception(value + " can't convert to float, overflow.");
					}
				}
				else
				{
					num3 = 10f * num3 + (float)(c - 48);
					if (num3 < 0f)
					{
						throw new Exception(value + " can't convert to float, overflow.");
					}
				}
				break;
			}
		}
		return (float)num * (num3 + num4);
	}

	public static float SafeToFloat(this string value)
	{
		if (string.IsNullOrEmpty(value))
		{
			return 0f;
		}
		int num = 1;
		int num2 = 0;
		if (value[0] == '-')
		{
			num = -1;
			num2 = 1;
		}
		float num3 = 0f;
		float num4 = 0f;
		float num5 = 1f;
		bool flag = false;
		int length = value.Length;
		for (int i = num2; i < length; i++)
		{
			char c = value[i];
			switch (c)
			{
			case '.':
				if (flag)
				{
					return 0f;
				}
				flag = true;
				break;
			default:
				return 0f;
			case '0':
			case '1':
			case '2':
			case '3':
			case '4':
			case '5':
			case '6':
			case '7':
			case '8':
			case '9':
				if (flag)
				{
					num5 *= 10f;
					num4 += (float)(c - 48) / num5;
					if (num4 < 0f)
					{
						return 0f;
					}
				}
				else
				{
					num3 = 10f * num3 + (float)(c - 48);
					if (num3 < 0f)
					{
						return 0f;
					}
				}
				break;
			}
		}
		return (float)num * (num3 + num4);
	}
}
