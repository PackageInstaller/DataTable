using System;
using System.Collections.Generic;
using System.Text;

namespace ACT;

public static class TextParser
{
	private const string NoParseStartTag = "<noparse>";

	private const string NoParseEndTag = "</noparse>";

	private const string NoParseSelfClosingTag = "<noparse/>";

	public static string ParseText(string text, StringBuilder buffer, IList<ITagParserBase> rules)
	{
		if (rules == null || rules.Count == 0)
		{
			return text;
		}
		buffer.Clear();
		ReadOnlySpan<char> characters = text;
		int length = text.Length;
		int num = 0;
		int i = 0;
		int realTextIndex = 0;
		for (; i < length; i++)
		{
			bool flag = false;
			if (characters[i] == '<')
			{
				ReadOnlySpan<char> span = characters.Slice(i);
				if (span.StartsWith("<noparse>"))
				{
					num++;
					flag = true;
					buffer.Append("<noparse>");
					i += "<noparse>".Length - 1;
				}
				else if (span.StartsWith("</noparse>"))
				{
					if (num <= 0)
					{
						break;
					}
					num--;
					flag = true;
					buffer.Append("</noparse>");
					i += "</noparse>".Length - 1;
				}
				else if (span.StartsWith("<noparse/>"))
				{
					flag = true;
					i += "<noparse/>".Length - 1;
				}
			}
			if (num <= 0 && !flag)
			{
				foreach (ITagParserBase rule in rules)
				{
					if (characters[i] != rule.StartSymbol)
					{
						continue;
					}
					bool flag2 = false;
					for (int j = i + 1; j < length; j++)
					{
						if (flag)
						{
							break;
						}
						if (characters[j] == '"' && !IsEscaped(characters, j))
						{
							flag2 = !flag2;
						}
						if (flag2)
						{
							continue;
						}
						if (characters[j] == rule.StartSymbol)
						{
							break;
						}
						if (characters[j] == rule.EndSymbol)
						{
							int num2 = j - i - 1;
							if (num2 == 0)
							{
								break;
							}
							ReadOnlySpan<char> textInsideBrackets = text.AsSpan(i + 1, num2);
							if (rule.TryProcessingTag(textInsideBrackets, num2, ref realTextIndex, buffer, i))
							{
								flag = true;
								i = j;
								break;
							}
						}
					}
				}
			}
			if (!flag)
			{
				buffer.Append(text[i]);
				realTextIndex++;
			}
		}
		string result = buffer.ToString();
		buffer.Clear();
		return result;
	}

	private static bool IsEscaped(ReadOnlySpan<char> characters, int index)
	{
		int num = 0;
		int num2 = index - 1;
		while (num2 >= 0 && characters[num2] == '\\')
		{
			num++;
			num2--;
		}
		return (num & 1) != 0;
	}
}
