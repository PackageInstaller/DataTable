using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using UnityEngine;

namespace ParadoxNotion;

public static class StringUtils
{
	private const string ALPHABET = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";

	private static readonly char[] CHAR_EMPTY_ARRAY = new char[1] { ' ' };

	private static Dictionary<string, string> splitCaseCache = new Dictionary<string, string>(StringComparer.Ordinal);

	public static string SplitCamelCase(this string s)
	{
		if (string.IsNullOrEmpty(s))
		{
			return s;
		}
		if (splitCaseCache.TryGetValue(s, out var value))
		{
			return value;
		}
		value = s;
		int num = value.IndexOf('_');
		if (num >= 0)
		{
			value = value.Substring(num + 1);
		}
		value = Regex.Replace(value, "(?<=[a-z])([A-Z])", " $1").CapitalizeFirst().Trim();
		return splitCaseCache[s] = value;
	}

	public static string CapitalizeFirst(this string s)
	{
		if (string.IsNullOrEmpty(s))
		{
			return s;
		}
		return s.First().ToString().ToUpper() + s.Substring(1);
	}

	public static string CapLength(this string s, int max)
	{
		if (string.IsNullOrEmpty(s) || s.Length <= max || max <= 3)
		{
			return s;
		}
		return s.Substring(0, Mathf.Min(s.Length, max) - 3) + "...";
	}

	public static string GetCapitals(this string s)
	{
		if (string.IsNullOrEmpty(s))
		{
			return string.Empty;
		}
		string text = "";
		for (int i = 0; i < s.Length; i++)
		{
			char c = s[i];
			if (char.IsUpper(c))
			{
				text += c;
			}
		}
		return text.Trim();
	}

	public static string GetAlphabetLetter(int index)
	{
		if (index < 0)
		{
			return null;
		}
		if (index >= "ABCDEFGHIJKLMNOPQRSTUVWXYZ".Length)
		{
			return index.ToString();
		}
		return "ABCDEFGHIJKLMNOPQRSTUVWXYZ"[index].ToString();
	}

	public static string GetStringWithin(this string input, string from, string to)
	{
		return new Regex($"{from}(.*?){to}").Match(input).Groups[1].ToString();
	}

	public static float ScoreSearchMatch(string input, string leafName, string categoryName = "")
	{
		if (input == null || leafName == null)
		{
			return float.PositiveInfinity;
		}
		if (categoryName == null)
		{
			categoryName = string.Empty;
		}
		input = input.ToUpper();
		leafName = leafName.ToUpper().Replace(" ", string.Empty);
		string[] array = input.Replace('.', ' ').Split(CHAR_EMPTY_ARRAY, StringSplitOptions.RemoveEmptyEntries);
		if (array.Length == 0)
		{
			return 1f;
		}
		if (input.LastOrDefault() == '.')
		{
			leafName = categoryName.ToUpper().Replace(" ", string.Empty);
		}
		int length = leafName.Length;
		string text = leafName;
		foreach (string oldValue in array)
		{
			text = text.Replace(oldValue, string.Empty);
		}
		float num = (float)text.Length / (float)length;
		if (leafName.StartsWith(array[0]))
		{
			num *= 0.25f;
		}
		if (leafName.StartsWith(array[array.Length - 1]))
		{
			num *= 0.5f;
		}
		return num;
	}

	public static bool SearchMatch(string input, string leafName, string categoryName = "")
	{
		if (input == null || leafName == null)
		{
			return false;
		}
		if (categoryName == null)
		{
			categoryName = string.Empty;
		}
		if (input.Length <= 1)
		{
			if (leafName.Length <= 1)
			{
				string value = null;
				if (ReflectionTools.op_CSharpAliases.TryGetValue(input, out value))
				{
					return value == leafName;
				}
			}
			return input == leafName;
		}
		input = input.ToUpper();
		leafName = leafName.ToUpper().Replace(" ", string.Empty);
		categoryName = categoryName.ToUpper().Replace(" ", string.Empty);
		string text = categoryName + "/" + leafName;
		string[] array = input.Replace('.', ' ').Split(CHAR_EMPTY_ARRAY, StringSplitOptions.RemoveEmptyEntries);
		if (array.Length == 0)
		{
			return false;
		}
		if (input.LastOrDefault() == '.')
		{
			return categoryName.Contains(array[0]);
		}
		string text2 = text;
		foreach (string text3 in array)
		{
			if (!text2.Contains(text3))
			{
				return false;
			}
			text2 = text2.Substring(text2.IndexOf(text3) + text3.Length);
		}
		string value2 = array[array.Length - 1];
		return leafName.Contains(value2);
	}

	public static string ReplaceWithin(this string text, char startChar, char endChar, Func<string, string> Process)
	{
		string text2 = text;
		int startIndex = 0;
		while ((startIndex = text2.IndexOf(startChar, startIndex)) != -1)
		{
			int num = text2.Substring(startIndex + 1).IndexOf(endChar);
			string arg = text2.Substring(startIndex + 1, num);
			string oldValue = text2.Substring(startIndex, num + 2);
			string newValue = Process(arg);
			text2 = text2.Replace(oldValue, newValue);
			startIndex++;
		}
		return text2;
	}

	public static string ToStringAdvanced(this object o)
	{
		if (o == null || o.Equals(null))
		{
			return "NULL";
		}
		if (o is string)
		{
			return $"\"{(string)o}\"";
		}
		if (o is UnityEngine.Object)
		{
			return (o as UnityEngine.Object).name;
		}
		Type type = o.GetType();
		if (type.RTIsSubclassOf(typeof(Enum)) && type.RTIsDefined<FlagsAttribute>(inherited: true))
		{
			string text = string.Empty;
			int num = 0;
			Array values = Enum.GetValues(type);
			foreach (object item in values)
			{
				if ((Convert.ToInt32(item) & Convert.ToInt32(o)) == Convert.ToInt32(item))
				{
					num++;
					text = ((!(text == string.Empty)) ? "Mixed..." : item.ToString());
				}
			}
			if (num == 0)
			{
				return "Nothing";
			}
			if (num == values.Length)
			{
				return "Everything";
			}
			return text;
		}
		return o.ToString();
	}
}
