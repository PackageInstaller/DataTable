namespace System.Net;

internal static class HttpValidationHelpers
{
	private static readonly char[] s_httpTrimCharacters = new char[6] { '\t', '\n', '\v', '\f', '\r', ' ' };

	public static bool IsInvalidMethodOrHeaderString(string stringValue)
	{
		for (int i = 0; i < stringValue.Length; i++)
		{
			switch (stringValue[i])
			{
			case '\t':
			case '\n':
			case '\r':
			case ' ':
			case '"':
			case '\'':
			case '(':
			case ')':
			case ',':
			case '/':
			case ':':
			case ';':
			case '<':
			case '=':
			case '>':
			case '?':
			case '@':
			case '[':
			case '\\':
			case ']':
			case '{':
			case '}':
				return true;
			}
		}
		return false;
	}
}
