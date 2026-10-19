using System.Text.RegularExpressions;

namespace UnityEngine.Localization;

internal static class StringExtensionMethods
{
	private static readonly Regex s_WhitespaceRegex = new Regex("\\s+");

	public static string ReplaceWhiteSpaces(this string str, string replacement = "")
	{
		return s_WhitespaceRegex.Replace(str, replacement);
	}
}
