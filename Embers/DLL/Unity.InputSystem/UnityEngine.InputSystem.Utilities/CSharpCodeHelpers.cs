using System;
using System.Linq;
using System.Text;

namespace UnityEngine.InputSystem.Utilities;

internal static class CSharpCodeHelpers
{
	public static bool IsProperIdentifier(string name)
	{
		if (string.IsNullOrEmpty(name))
		{
			return false;
		}
		if (char.IsDigit(name[0]))
		{
			return false;
		}
		foreach (char c in name)
		{
			if (!char.IsLetterOrDigit(c) && c != '_')
			{
				return false;
			}
		}
		return true;
	}

	public static bool IsEmptyOrProperIdentifier(string name)
	{
		if (string.IsNullOrEmpty(name))
		{
			return true;
		}
		return IsProperIdentifier(name);
	}

	public static bool IsEmptyOrProperNamespaceName(string name)
	{
		if (string.IsNullOrEmpty(name))
		{
			return true;
		}
		return name.Split('.').All(IsProperIdentifier);
	}

	public static string MakeIdentifier(string name, string suffix = "")
	{
		if (string.IsNullOrEmpty(name))
		{
			throw new ArgumentNullException("name");
		}
		if (char.IsDigit(name[0]))
		{
			name = "_" + name;
		}
		bool flag = false;
		foreach (char c in name)
		{
			if (!char.IsLetterOrDigit(c) && c != '_')
			{
				flag = true;
				break;
			}
		}
		if (flag)
		{
			StringBuilder stringBuilder = new StringBuilder();
			foreach (char c2 in name)
			{
				if (char.IsLetterOrDigit(c2) || c2 == '_')
				{
					stringBuilder.Append(c2);
				}
			}
			name = stringBuilder.ToString();
		}
		return name + suffix;
	}

	public static string MakeTypeName(string name, string suffix = "")
	{
		string text = MakeIdentifier(name, suffix);
		if (char.IsLower(text[0]))
		{
			text = char.ToUpper(text[0]) + text.Substring(1);
		}
		return text;
	}
}
