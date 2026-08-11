using System;
using System.Text;

namespace Sirenix.Utilities;

public static class StringUtilities
{
	public static string NicifyByteSize(int bytes, int decimals = 1)
	{
		StringBuilder stringBuilder = new StringBuilder();
		if (bytes < 0)
		{
			stringBuilder.Append('-');
			bytes = Math.Abs(bytes);
		}
		int num = 0;
		string text = null;
		if (bytes > 1000000000)
		{
			stringBuilder.Append(bytes / 1000000000);
			bytes -= bytes / 1000000000 * 1000000000;
			num = 9;
			text = " GB";
		}
		else if (bytes > 1000000)
		{
			stringBuilder.Append(bytes / 1000000);
			bytes -= bytes / 1000000 * 1000000;
			num = 6;
			text = " MB";
		}
		else if (bytes > 1000)
		{
			stringBuilder.Append(bytes / 1000);
			bytes -= bytes / 1000 * 1000;
			num = 3;
			text = " KB";
		}
		else
		{
			stringBuilder.Append(bytes);
			decimals = 0;
			num = 0;
			text = " bytes";
		}
		if (decimals > 0 && num > 0 && bytes > 0)
		{
			string text2 = bytes.ToString().PadLeft(num, '0');
			text2 = text2.Substring(0, (decimals < text2.Length) ? decimals : text2.Length).TrimEnd(new char[1] { '0' });
			if (text2.Length > 0)
			{
				stringBuilder.Append('.');
				stringBuilder.Append(text2);
			}
		}
		stringBuilder.Append(text);
		return stringBuilder.ToString();
	}

	public static bool FastEndsWith(this string str, string endsWith)
	{
		if (str.Length < endsWith.Length)
		{
			return false;
		}
		int length = str.Length;
		for (int i = 0; i < endsWith.Length; i++)
		{
			if (str[str.Length - (1 + i)] != endsWith[endsWith.Length - (1 + i)])
			{
				return false;
			}
		}
		return true;
	}

	public static int NumberAwareStringCompare(string a, string b, bool ignoreLeadingZeroes = true, bool ignoreWhiteSpace = true, bool ignoreCase = false)
	{
		int length = a.Length;
		int length2 = b.Length;
		int i = 0;
		int j = 0;
		char c3;
		char c4;
		while (true)
		{
			bool flag = i == length;
			bool flag2 = j == length2;
			if (flag & flag2)
			{
				if (length == length2)
				{
					return 0;
				}
				if (length < length2)
				{
					return -1;
				}
				return 1;
			}
			if (flag)
			{
				return -1;
			}
			if (flag2)
			{
				return 1;
			}
			if (ignoreWhiteSpace)
			{
				for (; i < length && char.IsWhiteSpace(a[i]); i++)
				{
				}
				for (; j < length2 && char.IsWhiteSpace(b[j]); j++)
				{
				}
			}
			char c = a[i];
			char c2 = b[j];
			if (char.IsDigit(c) && char.IsDigit(c2))
			{
				if (ignoreLeadingZeroes)
				{
					for (; i < length && a[i] == '0'; i++)
					{
					}
					for (; j < length2 && b[j] == '0'; j++)
					{
					}
				}
				int k = i;
				int l = j;
				for (; k < length && char.IsDigit(a[k]); k++)
				{
				}
				for (; l < length2 && char.IsDigit(b[l]); l++)
				{
				}
				int num = k - i;
				int num2 = l - j;
				if (num != num2)
				{
					return num - num2;
				}
				while (i < k)
				{
					if (a[i] != b[j])
					{
						return a[i] - b[j];
					}
					i++;
					j++;
				}
				continue;
			}
			if (ignoreCase)
			{
				if (c != c2)
				{
					c = char.ToLower(c);
					c2 = char.ToLower(c2);
					if (c != c2)
					{
						return c - c2;
					}
				}
			}
			else
			{
				c3 = char.ToLower(c);
				c4 = char.ToLower(c2);
				if (c3 != c4)
				{
					break;
				}
				if (c != c2)
				{
					return c2 - c;
				}
			}
			i++;
			j++;
		}
		return c3 - c4;
	}
}
