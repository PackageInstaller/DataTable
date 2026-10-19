using System;
using System.Globalization;

namespace UnityEngine.Localization.SmartFormat.Core.Parsing;

public class LiteralText : FormatItem
{
	public override string ToString()
	{
		if (!SmartSettings.ConvertCharacterStringLiterals)
		{
			return RawText;
		}
		return ConvertCharacterLiteralsToUnicode();
	}

	private string ConvertCharacterLiteralsToUnicode()
	{
		string rawText = RawText;
		if (rawText.Length == 0)
		{
			return rawText;
		}
		if (rawText[0] != '\\')
		{
			return rawText;
		}
		if (rawText.Length < 2)
		{
			throw new ArgumentException("Missing escape sequence in literal: \"" + rawText + "\"");
		}
		char c;
		switch (rawText[1])
		{
		case '\'':
			c = '\'';
			break;
		case '"':
			c = '"';
			break;
		case '\\':
			c = '\\';
			break;
		case '0':
			c = '\0';
			break;
		case 'a':
			c = '\a';
			break;
		case 'b':
			c = '\b';
			break;
		case 'f':
			c = '\f';
			break;
		case 'n':
			c = '\n';
			break;
		case 'r':
			c = '\r';
			break;
		case 't':
			c = '\t';
			break;
		case 'v':
			c = '\v';
			break;
		case 'u':
		{
			if (!int.TryParse(rawText.Substring(2, rawText.Length - 2), NumberStyles.HexNumber, null, out var result))
			{
				throw new ArgumentException("Failed to parse unicode escape sequence in literal: \"" + rawText + "\"");
			}
			c = (char)result;
			break;
		}
		default:
			throw new ArgumentException("Unrecognized escape sequence in literal: \"" + rawText + "\"");
		}
		return c.ToString();
	}
}
