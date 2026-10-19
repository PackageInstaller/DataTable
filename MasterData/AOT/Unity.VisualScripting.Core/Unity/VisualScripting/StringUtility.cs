using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;

namespace Unity.VisualScripting;

public static class StringUtility
{
	private static readonly Regex guidRegex = new Regex("[a-fA-F0-9]{8}(\\-[a-fA-F0-9]{4}){3}\\-[a-fA-F0-9]{12}");

	public static bool IsNullOrWhiteSpace(string s)
	{
		if (s != null)
		{
			return s.Trim() == string.Empty;
		}
		return true;
	}

	public static string FallbackEmpty(string s, string fallback)
	{
		if (string.IsNullOrEmpty(s))
		{
			s = fallback;
		}
		return s;
	}

	public static string FallbackWhitespace(string s, string fallback)
	{
		if (IsNullOrWhiteSpace(s))
		{
			s = fallback;
		}
		return s;
	}

	public static void AppendLineFormat(this StringBuilder sb, string format, params object[] args)
	{
		sb.AppendFormat(format, args);
		sb.AppendLine();
	}

	public static string ToSeparatedString(this IEnumerable enumerable, string separator)
	{
		return string.Join(separator, (from object o in enumerable
			select o?.ToString() ?? "(null)").ToArray());
	}

	public static string ToCommaSeparatedString(this IEnumerable enumerable)
	{
		return enumerable.ToSeparatedString(", ");
	}

	public static string ToLineSeparatedString(this IEnumerable enumerable)
	{
		return enumerable.ToSeparatedString(Environment.NewLine);
	}

	public static bool ContainsInsensitive(this string haystack, string needle)
	{
		return haystack.IndexOf(needle, StringComparison.OrdinalIgnoreCase) >= 0;
	}

	public static IEnumerable<int> AllIndexesOf(this string haystack, string needle)
	{
		if (string.IsNullOrEmpty(needle))
		{
			yield break;
		}
		int index = 0;
		while (true)
		{
			index = haystack.IndexOf(needle, index, StringComparison.OrdinalIgnoreCase);
			if (index != -1)
			{
				yield return index;
				index += needle.Length;
				continue;
			}
			break;
		}
	}

	public static string Filter(this string s, bool letters = true, bool numbers = true, bool whitespace = true, bool symbols = true, bool punctuation = true)
	{
		StringBuilder stringBuilder = new StringBuilder();
		foreach (char c in s)
		{
			if ((letters || !char.IsLetter(c)) && (numbers || !char.IsNumber(c)) && (whitespace || !char.IsWhiteSpace(c)) && (symbols || !char.IsSymbol(c)) && (punctuation || !char.IsPunctuation(c)))
			{
				stringBuilder.Append(c);
			}
		}
		return stringBuilder.ToString();
	}

	public static string FilterReplace(this string s, char replacement, bool merge, bool letters = true, bool numbers = true, bool whitespace = true, bool symbols = true, bool punctuation = true)
	{
		StringBuilder stringBuilder = new StringBuilder();
		bool flag = false;
		foreach (char c in s)
		{
			if ((!letters && char.IsLetter(c)) || (!numbers && char.IsNumber(c)) || (!whitespace && char.IsWhiteSpace(c)) || (!symbols && char.IsSymbol(c)) || (!punctuation && char.IsPunctuation(c)))
			{
				if (!merge || !flag)
				{
					stringBuilder.Append(replacement);
				}
				flag = true;
			}
			else
			{
				stringBuilder.Append(c);
				flag = false;
			}
		}
		return stringBuilder.ToString();
	}

	public static string Prettify(this string s)
	{
		return s.FirstCharacterToUpper().SplitWords(' ');
	}

	public static bool IsWordDelimiter(char c)
	{
		if (!char.IsWhiteSpace(c) && !char.IsSymbol(c))
		{
			return char.IsPunctuation(c);
		}
		return true;
	}

	public static bool IsWordBeginning(char? previous, char current, char? next)
	{
		bool flag = !previous.HasValue;
		bool flag2 = !next.HasValue;
		bool flag3 = char.IsLetter(current);
		bool flag4 = previous.HasValue && char.IsLetter(previous.Value);
		bool flag5 = char.IsNumber(current);
		bool flag6 = previous.HasValue && char.IsNumber(previous.Value);
		bool flag7 = char.IsUpper(current);
		bool flag8 = previous.HasValue && char.IsUpper(previous.Value);
		bool flag9 = IsWordDelimiter(current);
		bool flag10 = previous.HasValue && IsWordDelimiter(previous.Value);
		bool flag11 = next.HasValue && char.IsLower(next.Value);
		if (!(!flag9 & flag) && !(!flag9 & flag10) && (!(flag3 & flag4 & flag7) || flag8) && !(((flag3 & flag4 & flag7 & flag8) && !flag2) & flag11) && !(flag5 & flag4))
		{
			return flag3 & flag6 & flag7 & flag11;
		}
		return true;
	}

	public static bool IsWordBeginning(string s, int index)
	{
		Ensure.That("index").IsGte(index, 0);
		Ensure.That("index").IsLt(index, s.Length);
		char? previous = ((index > 0) ? new char?(s[index - 1]) : ((char?)null));
		char current = s[index];
		char? next = ((index < s.Length - 1) ? new char?(s[index + 1]) : ((char?)null));
		return IsWordBeginning(previous, current, next);
	}

	public static string SplitWords(this string s, char separator)
	{
		StringBuilder stringBuilder = new StringBuilder();
		for (int i = 0; i < s.Length; i++)
		{
			char value = s[i];
			if (i > 0 && IsWordBeginning(s, i))
			{
				stringBuilder.Append(separator);
			}
			stringBuilder.Append(value);
		}
		return stringBuilder.ToString();
	}

	public static string RemoveConsecutiveCharacters(this string s, char c)
	{
		StringBuilder stringBuilder = new StringBuilder();
		char c2 = '\0';
		foreach (char c3 in s)
		{
			if (c3 != c || c3 != c2)
			{
				stringBuilder.Append(c3);
				c2 = c3;
			}
		}
		return stringBuilder.ToString();
	}

	public static string ReplaceMultiple(this string s, HashSet<char> haystacks, char replacement)
	{
		Ensure.That("haystacks").IsNotNull(haystacks);
		StringBuilder stringBuilder = new StringBuilder();
		foreach (char c in s)
		{
			if (haystacks.Contains(c))
			{
				stringBuilder.Append(replacement);
			}
			else
			{
				stringBuilder.Append(c);
			}
		}
		return stringBuilder.ToString();
	}

	public static string Truncate(this string value, int maxLength, string suffix = "...")
	{
		if (value.Length > maxLength)
		{
			return value.Substring(0, maxLength) + suffix;
		}
		return value;
	}

	public static string TrimEnd(this string source, string value)
	{
		if (!source.EndsWith(value))
		{
			return source;
		}
		return source.Remove(source.LastIndexOf(value));
	}

	public static string TrimStart(this string source, string value)
	{
		if (!source.StartsWith(value))
		{
			return source;
		}
		return source.Substring(value.Length);
	}

	public static string FirstCharacterToLower(this string s)
	{
		if (string.IsNullOrEmpty(s) || char.IsLower(s, 0))
		{
			return s;
		}
		return char.ToLowerInvariant(s[0]) + s.Substring(1);
	}

	public static string FirstCharacterToUpper(this string s)
	{
		if (string.IsNullOrEmpty(s) || char.IsUpper(s, 0))
		{
			return s;
		}
		return char.ToUpperInvariant(s[0]) + s.Substring(1);
	}

	public static string PartBefore(this string s, char c)
	{
		Ensure.That("s").IsNotNull(s);
		int num = s.IndexOf(c);
		if (num > 0)
		{
			return s.Substring(0, num);
		}
		return s;
	}

	public static string PartAfter(this string s, char c)
	{
		Ensure.That("s").IsNotNull(s);
		int num = s.IndexOf(c);
		if (num > 0)
		{
			return s.Substring(num + 1);
		}
		return s;
	}

	public static void PartsAround(this string s, char c, out string before, out string after)
	{
		Ensure.That("s").IsNotNull(s);
		int num = s.IndexOf(c);
		if (num > 0)
		{
			before = s.Substring(0, num);
			after = s.Substring(num + 1);
		}
		else
		{
			before = s;
			after = null;
		}
	}

	public static bool EndsWith(this string s, char c)
	{
		Ensure.That("s").IsNotNull(s);
		return s[s.Length - 1] == c;
	}

	public static bool StartsWith(this string s, char c)
	{
		Ensure.That("s").IsNotNull(s);
		return s[0] == c;
	}

	public static bool Contains(this string s, char c)
	{
		Ensure.That("s").IsNotNull(s);
		for (int i = 0; i < s.Length; i++)
		{
			if (s[i] == c)
			{
				return true;
			}
		}
		return false;
	}

	public static string NullIfEmpty(this string s)
	{
		if (s == string.Empty)
		{
			return null;
		}
		return s;
	}

	public static string ToBinaryString(this int value)
	{
		return Convert.ToString(value, 2).PadLeft(8, '0');
	}

	public static string ToBinaryString(this long value)
	{
		return Convert.ToString(value, 2).PadLeft(16, '0');
	}

	public static string ToBinaryString(this Enum value)
	{
		return Convert.ToString(Convert.ToInt64(value), 2).PadLeft(16, '0');
	}

	public static int CountIndices(this string s, char c)
	{
		int num = 0;
		foreach (char c2 in s)
		{
			if (c == c2)
			{
				num++;
			}
		}
		return num;
	}

	public static bool IsGuid(string value)
	{
		return guidRegex.IsMatch(value);
	}

	public static string PathEllipsis(string s, int maxLength)
	{
		string text = "...";
		if (s.Length < maxLength)
		{
			return s;
		}
		string fileName = Path.GetFileName(s);
		string directoryName = Path.GetDirectoryName(s);
		int num = maxLength - fileName.Length - text.Length;
		char directorySeparatorChar;
		if (num > 0)
		{
			string text2 = directoryName.Substring(0, num);
			directorySeparatorChar = Path.DirectorySeparatorChar;
			return text2 + text + directorySeparatorChar + fileName;
		}
		directorySeparatorChar = Path.DirectorySeparatorChar;
		return text + directorySeparatorChar + fileName;
	}

	public static string ToHexString(this byte[] bytes)
	{
		return BitConverter.ToString(bytes).Replace("-", "");
	}
}
