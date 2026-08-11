using System;
using System.Collections.Generic;
using System.Linq;

namespace UnityEngine.InputSystem.Utilities;

public struct NameAndParameters
{
	public string name { get; set; }

	public ReadOnlyArray<NamedValue> parameters { get; set; }

	public override string ToString()
	{
		if (parameters.Count == 0)
		{
			return name;
		}
		string text = string.Join(",", parameters.Select((NamedValue x) => x.ToString()).ToArray());
		return name + "(" + text + ")";
	}

	public static IEnumerable<NameAndParameters> ParseMultiple(string text)
	{
		List<NameAndParameters> list = null;
		if (!ParseMultiple(text, ref list))
		{
			return Enumerable.Empty<NameAndParameters>();
		}
		return list;
	}

	internal static bool ParseMultiple(string text, ref List<NameAndParameters> list)
	{
		text = text.Trim();
		if (string.IsNullOrEmpty(text))
		{
			return false;
		}
		if (list == null)
		{
			list = new List<NameAndParameters>();
		}
		else
		{
			list.Clear();
		}
		int index = 0;
		int length = text.Length;
		while (index < length)
		{
			list.Add(ParseNameAndParameters(text, ref index));
		}
		return true;
	}

	internal static string ParseName(string text)
	{
		if (text == null)
		{
			throw new ArgumentNullException("text");
		}
		int index = 0;
		return ParseNameAndParameters(text, ref index, nameOnly: true).name;
	}

	public static NameAndParameters Parse(string text)
	{
		if (text == null)
		{
			throw new ArgumentNullException("text");
		}
		int index = 0;
		return ParseNameAndParameters(text, ref index);
	}

	private static NameAndParameters ParseNameAndParameters(string text, ref int index, bool nameOnly = false)
	{
		int length = text.Length;
		while (index < length && char.IsWhiteSpace(text[index]))
		{
			index++;
		}
		int num = index;
		while (index < length)
		{
			char c = text[index];
			if (c == '(' || c == ","[0] || char.IsWhiteSpace(c))
			{
				break;
			}
			index++;
		}
		if (index - num == 0)
		{
			throw new ArgumentException($"Expecting name at position {num} in '{text}'", "text");
		}
		string text2 = text.Substring(num, index - num);
		if (nameOnly)
		{
			return new NameAndParameters
			{
				name = text2
			};
		}
		while (index < length && char.IsWhiteSpace(text[index]))
		{
			index++;
		}
		NamedValue[] array = null;
		if (index < length && text[index] == '(')
		{
			index++;
			int num2 = text.IndexOf(')', index);
			if (num2 == -1)
			{
				throw new ArgumentException($"Expecting ')' after '(' at position {index} in '{text}'", "text");
			}
			array = NamedValue.ParseMultiple(text.Substring(index, num2 - index));
			index = num2 + 1;
		}
		if (index < length && (text[index] == ',' || text[index] == ';'))
		{
			index++;
		}
		return new NameAndParameters
		{
			name = text2,
			parameters = new ReadOnlyArray<NamedValue>(array)
		};
	}
}
