using System.Text;

namespace System.IO.Enumeration;

public static class FileSystemName
{
	private static readonly char[] s_wildcardChars = new char[5] { '"', '<', '>', '*', '?' };

	private static readonly char[] s_simpleWildcardChars = new char[2] { '*', '?' };

	public static string TranslateWin32Expression(string expression)
	{
		if (string.IsNullOrEmpty(expression) || expression == "*" || expression == "*.*")
		{
			return "*";
		}
		bool flag = false;
		Span<char> initialBuffer = stackalloc char[32];
		ValueStringBuilder valueStringBuilder = new ValueStringBuilder(initialBuffer);
		int length = expression.Length;
		for (int i = 0; i < length; i++)
		{
			char c = expression[i];
			switch (c)
			{
			case '.':
				flag = true;
				if (i >= 1 && i == length - 1 && expression[i - 1] == '*')
				{
					valueStringBuilder[valueStringBuilder.Length - 1] = '<';
				}
				else if (i < length - 1 && (expression[i + 1] == '?' || expression[i + 1] == '*'))
				{
					valueStringBuilder.Append('"');
				}
				else
				{
					valueStringBuilder.Append('.');
				}
				break;
			case '?':
				flag = true;
				valueStringBuilder.Append('>');
				break;
			default:
				valueStringBuilder.Append(c);
				break;
			}
		}
		if (!flag)
		{
			return expression;
		}
		return valueStringBuilder.ToString();
	}

	public static bool MatchesWin32Expression(ReadOnlySpan<char> expression, ReadOnlySpan<char> name, bool ignoreCase = true)
	{
		return MatchPattern(expression, name, ignoreCase, useExtendedWildcards: true);
	}

	public static bool MatchesSimpleExpression(ReadOnlySpan<char> expression, ReadOnlySpan<char> name, bool ignoreCase = true)
	{
		return MatchPattern(expression, name, ignoreCase, useExtendedWildcards: false);
	}

	private static bool MatchPattern(ReadOnlySpan<char> expression, ReadOnlySpan<char> name, bool ignoreCase, bool useExtendedWildcards)
	{
		if (expression.Length == 0 || name.Length == 0)
		{
			return false;
		}
		if (expression[0] == '*')
		{
			if (expression.Length == 1)
			{
				return true;
			}
			ReadOnlySpan<char> readOnlySpan = expression.Slice(1);
			if (readOnlySpan.IndexOfAny(useExtendedWildcards ? s_wildcardChars : s_simpleWildcardChars) == -1)
			{
				if (name.Length < readOnlySpan.Length)
				{
					return false;
				}
				return name.EndsWith(readOnlySpan, ignoreCase ? StringComparison.OrdinalIgnoreCase : StringComparison.Ordinal);
			}
		}
		int num = 0;
		int num2 = 1;
		char c = '\0';
		Span<int> span = default;
		Span<int> span2 = stackalloc int[16];
		Span<int> span3 = stackalloc int[16];
		span3[0] = 0;
		int num3 = expression.Length * 2;
		bool flag = false;
		int num6;
		while (!flag)
		{
			if (num < name.Length)
			{
				c = name[num++];
			}
			else
			{
				if (span3[num2 - 1] == num3)
				{
					break;
				}
				flag = true;
			}
			int i = 0;
			int num4 = 0;
			int j = 0;
			while (i < num2)
			{
				int num5 = (span3[i++] + 1) / 2;
				while (num5 < expression.Length)
				{
					num6 = num5 * 2;
					char c2 = expression[num5];
					if (num4 >= span2.Length - 2)
					{
						int num7 = span2.Length * 2;
						span = new int[num7];
						span2.CopyTo(span);
						span2 = span;
						span = new int[num7];
						span3.CopyTo(span);
						span3 = span;
					}
					if (c2 != '*')
					{
						if (!useExtendedWildcards || c2 != '<')
						{
							num6 += 2;
							if (useExtendedWildcards && c2 == '>')
							{
								if (!flag && c != '.')
								{
									span2[num4++] = num6;
									break;
								}
							}
							else
							{
								if (!useExtendedWildcards || c2 != '"')
								{
									if (c2 == '\\')
									{
										if (++num5 == expression.Length)
										{
											span2[num4++] = num3;
											break;
										}
										num6 = num5 * 2 + 2;
										c2 = expression[num5];
									}
									if (!flag)
									{
										if (c2 == '?')
										{
											span2[num4++] = num6;
										}
										else if (ignoreCase ? (char.ToUpperInvariant(c2) == char.ToUpperInvariant(c)) : (c2 == c))
										{
											span2[num4++] = num6;
										}
									}
									break;
								}
								if (!flag)
								{
									if (c == '.')
									{
										span2[num4++] = num6;
									}
									break;
								}
							}
							goto IL_02d7;
						}
						bool flag2 = false;
						if (!flag && c == '.')
						{
							for (int k = num; k < name.Length; k++)
							{
								if (name[k] == '.')
								{
									flag2 = true;
									break;
								}
							}
						}
						if (!((flag || c != '.') | flag2))
						{
							goto IL_02c6;
						}
					}
					span2[num4++] = num6;
					goto IL_02c6;
					IL_02d7:
					if (++num5 == expression.Length)
					{
						span2[num4++] = num3;
					}
					continue;
					IL_02c6:
					span2[num4++] = num6 + 1;
					goto IL_02d7;
				}
				if (i >= num2 || j >= num4)
				{
					continue;
				}
				for (; j < num4; j++)
				{
					for (int length = span3.Length; i < length && span3[i] < span2[j]; i++)
					{
					}
				}
			}
			if (num4 == 0)
			{
				return false;
			}
			span = span3;
			span3 = span2;
			span2 = span;
			num2 = num4;
		}
		num6 = span3[num2 - 1];
		return num6 == num3;
	}
}
