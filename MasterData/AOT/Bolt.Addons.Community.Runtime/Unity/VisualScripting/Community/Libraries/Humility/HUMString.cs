using System.Runtime.InteropServices;
using System.Text.RegularExpressions;

namespace Unity.VisualScripting.Community.Libraries.Humility;

public static class HUMString
{
	public static class Data
	{
		public struct Add(string text)
		{
			public string text = text;
		}

		public struct Remove(string text, string remove)
		{
			public string text = text;

			public string remove = remove;
		}

		public struct SpaceBetweenLowercaseAnd(SpaceBetweenLowercase lowercase)
		{
			public SpaceBetweenLowercase lowercase = lowercase;
		}

		public struct Space(Add add)
		{
			public Add add = add;
		}

		public struct SpaceBetween(Space space)
		{
			public Space space = space;
		}

		public struct SpaceBefore(Space space)
		{
			public Space space = space;
		}

		[StructLayout(LayoutKind.Sequential, Size = 1)]
		public struct After
		{
		}

		public struct Capitalize(string text)
		{
			public string text = text;
		}

		public struct CapitalizeFirst(Capitalize capitalize)
		{
			public Capitalize capitalize = capitalize;
		}

		public struct SpaceBetweenLowercase(SpaceBetween between)
		{
			public SpaceBetween between = between;
		}

		public struct As(string text)
		{
			public string text = text;
		}
	}

	public static Data.Remove Remove(this string text, string remove)
	{
		return new Data.Remove(text, remove);
	}

	public static string RemoveBetween(this string sourceString, string startTag, string endTag)
	{
		return new Regex($"{Regex.Escape(startTag)}(.*?){Regex.Escape(endTag)}", RegexOptions.RightToLeft).Replace(sourceString, startTag + endTag);
	}

	public static string RemoveAfterFirst(this string text, char character)
	{
		int num = text.IndexOf(character);
		string result = text;
		if (num < text.Length - 1)
		{
			result = text.Remove(num + 1, text.Length - 1 - num);
		}
		return result;
	}

	public static Data.Add Add(this string text)
	{
		return new Data.Add(text);
	}

	public static Data.Capitalize Capitalize(this string text)
	{
		return new Data.Capitalize(text);
	}

	public static string Nice(this string str)
	{
		string text = str.Add().Space().Between()
			.Lowercase()
			.And()
			.Uppercase();
		string value = text[0].ToString().ToUpper();
		return text.Remove(0).Insert(0, value);
	}

	public static string NullReplace(this string text, string replacement)
	{
		if (!string.IsNullOrEmpty(text))
		{
			return text;
		}
		return replacement;
	}

	public static string OnNullOrEmpty(this string textToCheck, string text)
	{
		if (!string.IsNullOrEmpty(textToCheck))
		{
			return string.Empty;
		}
		return text;
	}

	public static string OnNotNullOrEmpty(this string textToCheck, string text)
	{
		if (!string.IsNullOrEmpty(textToCheck))
		{
			return text;
		}
		return string.Empty;
	}

	public static string ReplaceFirstIf(this string text, string first, string replacement)
	{
		if (text[0].ToString() == first)
		{
			text.Remove(0, 0);
			text.Insert(0, replacement);
		}
		return text;
	}

	public static string ReplaceFirstIfNotNumberorDigitExcept(this string text, string[] exceptions)
	{
		string value = text[0].ToString().RemoveAllButLettersorDigitsExcept(exceptions);
		text.Remove(0, 1);
		text.Insert(0, value);
		return text;
	}

	public static string RemoveAllButLettersorDigitsExcept(this string member, string[] exceptions)
	{
		char[] array = member.ToCharArray();
		string text = string.Empty;
		for (int i = 0; i < array.Length; i++)
		{
			string text2 = array[i].ToString();
			bool flag = true;
			for (int j = 0; j < exceptions.Length; j++)
			{
				if (char.IsLetterOrDigit(array[i]) || text2 == exceptions[j])
				{
					flag = true;
					break;
				}
				if (j == exceptions.Length - 1)
				{
					flag = false;
				}
			}
			if (flag)
			{
				text += text2;
			}
		}
		return text;
	}
}
