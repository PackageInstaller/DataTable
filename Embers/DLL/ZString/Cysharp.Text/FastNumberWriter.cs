using System;

namespace Cysharp.Text;

internal static class FastNumberWriter
{
	public static bool TryWriteInt64(Span<char> buffer, out int charsWritten, long value)
	{
		int num = 0;
		charsWritten = 0;
		long num2 = value;
		if (value < 0)
		{
			if (value == long.MinValue)
			{
				if (buffer.Length < 20)
				{
					return false;
				}
				buffer[num++] = '-';
				buffer[num++] = '9';
				buffer[num++] = '2';
				buffer[num++] = '2';
				buffer[num++] = '3';
				buffer[num++] = '3';
				buffer[num++] = '7';
				buffer[num++] = '2';
				buffer[num++] = '0';
				buffer[num++] = '3';
				buffer[num++] = '6';
				buffer[num++] = '8';
				buffer[num++] = '5';
				buffer[num++] = '4';
				buffer[num++] = '7';
				buffer[num++] = '7';
				buffer[num++] = '5';
				buffer[num++] = '8';
				buffer[num++] = '0';
				buffer[num++] = '8';
				charsWritten = num;
				return true;
			}
			if (buffer.Length < 1)
			{
				return false;
			}
			buffer[num++] = '-';
			num2 = -value;
		}
		if (num2 < 10000)
		{
			if (num2 < 10)
			{
				if (buffer.Length < 1)
				{
					return false;
				}
				goto IL_0677;
			}
			if (num2 < 100)
			{
				if (buffer.Length < 2)
				{
					return false;
				}
				goto IL_064e;
			}
			if (num2 < 1000)
			{
				if (buffer.Length < 3)
				{
					return false;
				}
				goto IL_0625;
			}
			if (buffer.Length < 4)
			{
				return false;
			}
			goto IL_05f9;
		}
		long num3 = num2 / 10000;
		num2 -= num3 * 10000;
		if (num3 < 10000)
		{
			if (num3 < 10)
			{
				if (buffer.Length < 5)
				{
					return false;
				}
				goto IL_05e6;
			}
			if (num3 < 100)
			{
				if (buffer.Length < 6)
				{
					return false;
				}
				goto IL_05bd;
			}
			if (num3 < 1000)
			{
				if (buffer.Length < 7)
				{
					return false;
				}
				goto IL_0594;
			}
			if (buffer.Length < 8)
			{
				return false;
			}
			goto IL_0568;
		}
		long num4 = num3 / 10000;
		num3 -= num4 * 10000;
		if (num4 < 10000)
		{
			if (num4 < 10)
			{
				if (buffer.Length < 9)
				{
					return false;
				}
				goto IL_0555;
			}
			if (num4 < 100)
			{
				if (buffer.Length < 10)
				{
					return false;
				}
				goto IL_052c;
			}
			if (num4 < 1000)
			{
				if (buffer.Length < 11)
				{
					return false;
				}
				goto IL_0503;
			}
			if (buffer.Length < 12)
			{
				return false;
			}
			goto IL_04d7;
		}
		long num5 = num4 / 10000;
		num4 -= num5 * 10000;
		if (num5 < 10000)
		{
			if (num5 < 10)
			{
				if (buffer.Length < 13)
				{
					return false;
				}
				goto IL_04c3;
			}
			if (num5 < 100)
			{
				if (buffer.Length < 14)
				{
					return false;
				}
				goto IL_0497;
			}
			if (num5 < 1000)
			{
				if (buffer.Length < 15)
				{
					return false;
				}
				goto IL_046b;
			}
			if (buffer.Length < 16)
			{
				return false;
			}
			goto IL_043c;
		}
		long num6 = num5 / 10000;
		num5 -= num6 * 10000;
		if (num6 < 10000)
		{
			if (num6 < 10)
			{
				if (buffer.Length < 17)
				{
					return false;
				}
				goto IL_0428;
			}
			if (num6 < 100)
			{
				if (buffer.Length < 18)
				{
					return false;
				}
				goto IL_03fc;
			}
			if (num6 < 1000)
			{
				if (buffer.Length < 19)
				{
					return false;
				}
				goto IL_03d0;
			}
			if (buffer.Length < 20)
			{
				return false;
			}
		}
		long num7;
		buffer[num++] = (char)(48 + (num7 = num6 * 8389 >> 23));
		num6 -= num7 * 1000;
		goto IL_03d0;
		IL_043c:
		buffer[num++] = (char)(48 + (num7 = num5 * 8389 >> 23));
		num5 -= num7 * 1000;
		goto IL_046b;
		IL_0497:
		buffer[num++] = (char)(48 + (num7 = num5 * 6554 >> 16));
		num5 -= num7 * 10;
		goto IL_04c3;
		IL_05f9:
		buffer[num++] = (char)(48 + (num7 = num2 * 8389 >> 23));
		num2 -= num7 * 1000;
		goto IL_0625;
		IL_0555:
		buffer[num++] = (char)(48 + num4);
		goto IL_0568;
		IL_0594:
		buffer[num++] = (char)(48 + (num7 = num3 * 5243 >> 19));
		num3 -= num7 * 100;
		goto IL_05bd;
		IL_0568:
		buffer[num++] = (char)(48 + (num7 = num3 * 8389 >> 23));
		num3 -= num7 * 1000;
		goto IL_0594;
		IL_0503:
		buffer[num++] = (char)(48 + (num7 = num4 * 5243 >> 19));
		num4 -= num7 * 100;
		goto IL_052c;
		IL_04d7:
		buffer[num++] = (char)(48 + (num7 = num4 * 8389 >> 23));
		num4 -= num7 * 1000;
		goto IL_0503;
		IL_052c:
		buffer[num++] = (char)(48 + (num7 = num4 * 6554 >> 16));
		num4 -= num7 * 10;
		goto IL_0555;
		IL_064e:
		buffer[num++] = (char)(48 + (num7 = num2 * 6554 >> 16));
		num2 -= num7 * 10;
		goto IL_0677;
		IL_0677:
		buffer[num++] = (char)(48 + num2);
		charsWritten = num;
		return true;
		IL_0428:
		buffer[num++] = (char)(48 + num6);
		goto IL_043c;
		IL_0625:
		buffer[num++] = (char)(48 + (num7 = num2 * 5243 >> 19));
		num2 -= num7 * 100;
		goto IL_064e;
		IL_05bd:
		buffer[num++] = (char)(48 + (num7 = num3 * 6554 >> 16));
		num3 -= num7 * 10;
		goto IL_05e6;
		IL_046b:
		buffer[num++] = (char)(48 + (num7 = num5 * 5243 >> 19));
		num5 -= num7 * 100;
		goto IL_0497;
		IL_03d0:
		buffer[num++] = (char)(48 + (num7 = num6 * 5243 >> 19));
		num6 -= num7 * 100;
		goto IL_03fc;
		IL_05e6:
		buffer[num++] = (char)(48 + num3);
		goto IL_05f9;
		IL_04c3:
		buffer[num++] = (char)(48 + num5);
		goto IL_04d7;
		IL_03fc:
		buffer[num++] = (char)(48 + (num7 = num6 * 6554 >> 16));
		num6 -= num7 * 10;
		goto IL_0428;
	}

	public static bool TryWriteUInt64(Span<char> buffer, out int charsWritten, ulong value)
	{
		ulong num = value;
		charsWritten = 0;
		int num2 = 0;
		if (num < 10000)
		{
			if (num < 10)
			{
				if (buffer.Length < 1)
				{
					return false;
				}
				goto IL_0518;
			}
			if (num < 100)
			{
				if (buffer.Length < 2)
				{
					return false;
				}
				goto IL_04ed;
			}
			if (num < 1000)
			{
				if (buffer.Length < 3)
				{
					return false;
				}
				goto IL_04c2;
			}
			if (buffer.Length < 4)
			{
				return false;
			}
			goto IL_0494;
		}
		ulong num3 = num / 10000;
		num -= num3 * 10000;
		if (num3 < 10000)
		{
			if (num3 < 10)
			{
				if (buffer.Length < 5)
				{
					return false;
				}
				goto IL_047f;
			}
			if (num3 < 100)
			{
				if (buffer.Length < 6)
				{
					return false;
				}
				goto IL_0454;
			}
			if (num3 < 1000)
			{
				if (buffer.Length < 7)
				{
					return false;
				}
				goto IL_0429;
			}
			if (buffer.Length < 8)
			{
				return false;
			}
			goto IL_03fb;
		}
		ulong num4 = num3 / 10000;
		num3 -= num4 * 10000;
		if (num4 < 10000)
		{
			if (num4 < 10)
			{
				if (buffer.Length < 9)
				{
					return false;
				}
				goto IL_03e6;
			}
			if (num4 < 100)
			{
				if (buffer.Length < 10)
				{
					return false;
				}
				goto IL_03bb;
			}
			if (num4 < 1000)
			{
				if (buffer.Length < 11)
				{
					return false;
				}
				goto IL_0390;
			}
			if (buffer.Length < 12)
			{
				return false;
			}
			goto IL_0362;
		}
		ulong num5 = num4 / 10000;
		num4 -= num5 * 10000;
		if (num5 < 10000)
		{
			if (num5 < 10)
			{
				if (buffer.Length < 13)
				{
					return false;
				}
				goto IL_034d;
			}
			if (num5 < 100)
			{
				if (buffer.Length < 14)
				{
					return false;
				}
				goto IL_0322;
			}
			if (num5 < 1000)
			{
				if (buffer.Length < 15)
				{
					return false;
				}
				goto IL_02f7;
			}
			if (buffer.Length < 16)
			{
				return false;
			}
			goto IL_02c9;
		}
		ulong num6 = num5 / 10000;
		num5 -= num6 * 10000;
		if (num6 < 10000)
		{
			if (num6 < 10)
			{
				if (buffer.Length < 17)
				{
					return false;
				}
				goto IL_02b3;
			}
			if (num6 < 100)
			{
				if (buffer.Length < 18)
				{
					return false;
				}
				goto IL_0285;
			}
			if (num6 < 1000)
			{
				if (buffer.Length < 19)
				{
					return false;
				}
				goto IL_0257;
			}
			if (buffer.Length < 20)
			{
				return false;
			}
		}
		ulong num7;
		buffer[num2++] = (char)(48 + (num7 = num6 * 8389 >> 23));
		num6 -= num7 * 1000;
		goto IL_0257;
		IL_0390:
		buffer[num2++] = (char)(48 + (num7 = num4 * 5243 >> 19));
		num4 -= num7 * 100;
		goto IL_03bb;
		IL_034d:
		buffer[num2++] = (char)(48 + num5);
		goto IL_0362;
		IL_03bb:
		buffer[num2++] = (char)(48 + (num7 = num4 * 6554 >> 16));
		num4 -= num7 * 10;
		goto IL_03e6;
		IL_0429:
		buffer[num2++] = (char)(48 + (num7 = num3 * 5243 >> 19));
		num3 -= num7 * 100;
		goto IL_0454;
		IL_0494:
		buffer[num2++] = (char)(48 + (num7 = num * 8389 >> 23));
		num -= num7 * 1000;
		goto IL_04c2;
		IL_03fb:
		buffer[num2++] = (char)(48 + (num7 = num3 * 8389 >> 23));
		num3 -= num7 * 1000;
		goto IL_0429;
		IL_03e6:
		buffer[num2++] = (char)(48 + num4);
		goto IL_03fb;
		IL_0454:
		buffer[num2++] = (char)(48 + (num7 = num3 * 6554 >> 16));
		num3 -= num7 * 10;
		goto IL_047f;
		IL_0362:
		buffer[num2++] = (char)(48 + (num7 = num4 * 8389 >> 23));
		num4 -= num7 * 1000;
		goto IL_0390;
		IL_02c9:
		buffer[num2++] = (char)(48 + (num7 = num5 * 8389 >> 23));
		num5 -= num7 * 1000;
		goto IL_02f7;
		IL_02f7:
		buffer[num2++] = (char)(48 + (num7 = num5 * 5243 >> 19));
		num5 -= num7 * 100;
		goto IL_0322;
		IL_0257:
		buffer[num2++] = (char)(48 + (num7 = num6 * 5243 >> 19));
		num6 -= num7 * 100;
		goto IL_0285;
		IL_0518:
		buffer[num2++] = (char)(48 + num);
		charsWritten = num2;
		return true;
		IL_0322:
		buffer[num2++] = (char)(48 + (num7 = num5 * 6554 >> 16));
		num5 -= num7 * 10;
		goto IL_034d;
		IL_0285:
		buffer[num2++] = (char)(48 + (num7 = num6 * 6554 >> 16));
		num6 -= num7 * 10;
		goto IL_02b3;
		IL_04ed:
		buffer[num2++] = (char)(48 + (num7 = num * 6554 >> 16));
		num -= num7 * 10;
		goto IL_0518;
		IL_047f:
		buffer[num2++] = (char)(48 + num3);
		goto IL_0494;
		IL_02b3:
		buffer[num2++] = (char)(48 + num6);
		goto IL_02c9;
		IL_04c2:
		buffer[num2++] = (char)(48 + (num7 = num * 5243 >> 19));
		num -= num7 * 100;
		goto IL_04ed;
	}
}
