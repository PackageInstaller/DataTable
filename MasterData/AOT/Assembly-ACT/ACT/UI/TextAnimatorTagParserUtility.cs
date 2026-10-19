using System;
using System.Globalization;

namespace ACT.UI;

public static class TextAnimatorTagParserUtility
{
	public static bool TryReadTagName(ReadOnlySpan<char> text, out ReadOnlySpan<char> tagName, out int attributesStart, out bool isClosing)
	{
		int i = 0;
		SkipWhiteSpace(text, ref i);
		isClosing = i < text.Length && text[i] == '/';
		if (isClosing)
		{
			i++;
			SkipWhiteSpace(text, ref i);
		}
		int num = i;
		for (; i < text.Length && !IsNameTerminator(text[i]); i++)
		{
		}
		int num2 = i - num;
		if (num2 <= 0)
		{
			tagName = default;
			attributesStart = i;
			return false;
		}
		tagName = text.Slice(num, num2);
		attributesStart = i;
		return true;
	}

	public static float ReadFloat(ReadOnlySpan<char> text, int startIndex, float fallback, string primaryName, string secondaryName)
	{
		if ((TryReadAttributeValue(text, startIndex, primaryName, out var value) || TryReadAttributeValue(text, startIndex, secondaryName, out value) || TryReadUnnamedValue(text, startIndex, out value)) && float.TryParse(value, NumberStyles.Float, CultureInfo.InvariantCulture, out var result))
		{
			return result;
		}
		return fallback;
	}

	public static string ReadString(ReadOnlySpan<char> text, int startIndex, string fallback, string primaryName, string secondaryName)
	{
		if (TryReadAttributeValue(text, startIndex, primaryName, out var value) || TryReadAttributeValue(text, startIndex, secondaryName, out value) || TryReadUnnamedValue(text, startIndex, out value))
		{
			return value.ToString();
		}
		return fallback;
	}

	private static bool TryReadUnnamedValue(ReadOnlySpan<char> text, int startIndex, out ReadOnlySpan<char> value)
	{
		int index = startIndex;
		SkipWhiteSpace(text, ref index);
		if (index >= text.Length || text[index] != '=')
		{
			value = default;
			return false;
		}
		index++;
		SkipWhiteSpace(text, ref index);
		return TryReadValue(text, ref index, out value);
	}

	private static bool TryReadAttributeValue(ReadOnlySpan<char> text, int startIndex, ReadOnlySpan<char> attributeName, out ReadOnlySpan<char> value)
	{
		int i = startIndex;
		while (i < text.Length)
		{
			SkipWhiteSpace(text, ref i);
			if (i >= text.Length || text[i] == '/')
			{
				break;
			}
			int num = i;
			for (; i < text.Length && !char.IsWhiteSpace(text[i]) && text[i] != '=' && text[i] != '/'; i++)
			{
			}
			ReadOnlySpan<char> span = text.Slice(num, i - num);
			SkipWhiteSpace(text, ref i);
			if (i < text.Length && text[i] == '=')
			{
				i++;
				SkipWhiteSpace(text, ref i);
				if (TryReadValue(text, ref i, out var value2) && span.SequenceEqual(attributeName))
				{
					value = value2;
					return true;
				}
			}
		}
		value = default;
		return false;
	}

	private static bool TryReadValue(ReadOnlySpan<char> text, ref int index, out ReadOnlySpan<char> value)
	{
		if (index >= text.Length)
		{
			value = default;
			return false;
		}
		if (text[index] == '"')
		{
			int num = ++index;
			while (index < text.Length)
			{
				if (text[index] == '"' && !IsEscaped(text, index))
				{
					value = text.Slice(num, index - num);
					index++;
					return true;
				}
				index++;
			}
			value = text.Slice(num);
			return true;
		}
		int num2 = index;
		while (index < text.Length && !char.IsWhiteSpace(text[index]) && text[index] != '/')
		{
			index++;
		}
		value = text.Slice(num2, index - num2);
		return value.Length > 0;
	}

	private static bool IsEscaped(ReadOnlySpan<char> text, int index)
	{
		int num = 0;
		int num2 = index - 1;
		while (num2 >= 0 && text[num2] == '\\')
		{
			num++;
			num2--;
		}
		return (num & 1) != 0;
	}

	private static void SkipWhiteSpace(ReadOnlySpan<char> text, ref int index)
	{
		while (index < text.Length && char.IsWhiteSpace(text[index]))
		{
			index++;
		}
	}

	private static bool IsNameTerminator(char character)
	{
		if (!char.IsWhiteSpace(character) && character != '=' && character != '/')
		{
			return character == '>';
		}
		return true;
	}
}
