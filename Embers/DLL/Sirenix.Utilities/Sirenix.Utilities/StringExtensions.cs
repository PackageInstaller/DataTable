using System;
using System.Globalization;
using System.Text;

namespace Sirenix.Utilities;

public static class StringExtensions
{
	public static string ToTitleCase(this string input)
	{
		StringBuilder stringBuilder = new StringBuilder();
		for (int i = 0; i < input.Length; i++)
		{
			char c = input[i];
			if (c == '_' && i + 1 < input.Length)
			{
				char c2 = input[i + 1];
				if (char.IsLower(c2))
				{
					c2 = char.ToUpper(c2, CultureInfo.InvariantCulture);
				}
				stringBuilder.Append(c2);
				i++;
			}
			else
			{
				stringBuilder.Append(c);
			}
		}
		return stringBuilder.ToString();
	}

	public static bool Contains(this string source, string toCheck, StringComparison comparisonType)
	{
		return source.IndexOf(toCheck, comparisonType) >= 0;
	}

	public static string SplitPascalCase(this string input)
	{
		if (input == null || input.Length == 0)
		{
			return input;
		}
		StringBuilder stringBuilder = new StringBuilder(input.Length);
		if (char.IsLetter(input[0]))
		{
			stringBuilder.Append(char.ToUpper(input[0]));
		}
		else
		{
			stringBuilder.Append(input[0]);
		}
		for (int i = 1; i < input.Length; i++)
		{
			char c = input[i];
			if (char.IsUpper(c) && !char.IsUpper(input[i - 1]))
			{
				stringBuilder.Append(' ');
			}
			stringBuilder.Append(c);
		}
		return stringBuilder.ToString();
	}

	public static bool IsNullOrWhitespace(this string str)
	{
		if (!string.IsNullOrEmpty(str))
		{
			for (int i = 0; i < str.Length; i++)
			{
				if (!char.IsWhiteSpace(str[i]))
				{
					return false;
				}
			}
		}
		return true;
	}

	public static int CalculateLevenshteinDistance(string source1, string source2)
	{
		int length = source1.Length;
		int length2 = source2.Length;
		int[,] array = new int[length + 1, length2 + 1];
		if (length == 0)
		{
			return length2;
		}
		if (length2 == 0)
		{
			return length;
		}
		int num = 0;
		while (num <= length)
		{
			array[num, 0] = num++;
		}
		int num2 = 0;
		while (num2 <= length2)
		{
			array[0, num2] = num2++;
		}
		for (int i = 1; i <= length; i++)
		{
			for (int j = 1; j <= length2; j++)
			{
				int num3 = ((source2[j - 1] != source1[i - 1]) ? 1 : 0);
				array[i, j] = Math.Min(Math.Min(array[i - 1, j] + 1, array[i, j - 1] + 1), array[i - 1, j - 1] + num3);
			}
		}
		return array[length, length2];
	}
}
