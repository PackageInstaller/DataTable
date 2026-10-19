using Unity.VisualScripting.Community.Libraries.Humility;

namespace Unity.VisualScripting.Community.Libraries.CSharp;

public static class Patcher
{
	private static string[] _constructNames;

	public static string[] constructNames
	{
		get
		{
			string[] result = _constructNames ?? new string[27]
			{
				"object", "var", "func", "delegate", "class", "struct", "enum", "interface", "void", "float",
				"int", "string", "bool", "in", "out", "as", "is", "ref", "return", "public",
				"private", "protected", "internal", "static", "where", "from", "select"
			};
			_constructNames = result;
			return result;
		}
	}

	public static string LegalVariableName(string name, bool underscoreMiddleSpaces)
	{
		return RemoveIllegalVariableCharacters(RemoveStartingSpaces(name), underscoreMiddleSpaces);
	}

	private static string RemoveStartingSpaces(string text)
	{
		int length = text.Length;
		int num = 0;
		for (int i = 0; i < length && !(text[i].ToString() != " "); i++)
		{
			num++;
		}
		return text.Remove(0, num);
	}

	private static string RemoveIllegalVariableCharacters(string name, bool underscoreSpaces)
	{
		string text = string.Empty;
		int length = name.Length;
		for (int i = 0; i < length && name[i].ToString() != null; i++)
		{
			if (char.IsLetter(name[i]))
			{
				text += name[i];
			}
			else if (char.IsWhiteSpace(name[i]) && underscoreSpaces)
			{
				text += "_";
			}
		}
		return text;
	}

	public static string PeriodsToSlashes(this string member)
	{
		if (!string.IsNullOrEmpty(member))
		{
			return member.Replace(".", "/");
		}
		return string.Empty;
	}

	public static string SlashesToPeriods(this string member)
	{
		if (!string.IsNullOrEmpty(member))
		{
			return member.Replace("/", ".").Replace("\\", ".");
		}
		return string.Empty;
	}

	public static string RemoveIllegalFirstLetters(this string text)
	{
		if (text.Length > 0)
		{
			string value = text[0].ToString().RemoveAllButLettersorDigitsExcept(new string[1] { "_" });
			return text.Remove(0, 1).Insert(0, value);
		}
		return text;
	}

	public static string EnsureNonConstructName(this string text)
	{
		for (int i = 0; i < constructNames.Length; i++)
		{
			if (constructNames[i] == text)
			{
				return "@" + text;
			}
		}
		return text;
	}
}
