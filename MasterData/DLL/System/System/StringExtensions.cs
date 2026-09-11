namespace System;

internal static class StringExtensions
{
	internal static string SubstringTrim(this string value, int startIndex, int length)
	{
		if (length == 0)
		{
			return string.Empty;
		}
		int num = startIndex + length - 1;
		while (startIndex <= num && char.IsWhiteSpace(value[startIndex]))
		{
			startIndex++;
		}
		while (num >= startIndex && char.IsWhiteSpace(value[num]))
		{
			num--;
		}
		int num2 = num - startIndex + 1;
		if (num2 != 0)
		{
			if (num2 != value.Length)
			{
				return value.Substring(startIndex, num2);
			}
			return value;
		}
		return string.Empty;
	}
}
