using System.Runtime.CompilerServices;

namespace System.Net;

internal static class HttpValidationHelpers
{
	private static readonly char[] s_httpTrimCharacters;

	public static string CheckBadHeaderValueChars(string value)
	{
		if (string.IsNullOrEmpty(value))
		{
			return string.Empty;
		}
		value = value.Trim(s_httpTrimCharacters);
		int num = 0;
		for (int i = 0; i < value.Length; i++)
		{
			char c = (char)(0xFF & value[i]);
			switch (num)
			{
			case 0:
				if (c == '\r')
				{
					num = 1;
				}
				else if (c == '\n')
				{
					num = 2;
				}
				else if (c == '\u007f' || (c < ' ' && c != '\t'))
				{
					throw new ArgumentException("Specified value has invalid Control characters.", "value");
				}
				break;
			case 1:
				if (c == '\n')
				{
					num = 2;
					break;
				}
				throw new ArgumentException("Specified value has invalid CRLF characters.", "value");
			case 2:
				if (c == ' ' || c == '\t')
				{
					num = 0;
					break;
				}
				throw new ArgumentException("Specified value has invalid Control characters.", "value");
			}
		}
		if (num != 0)
		{
			throw new ArgumentException("Specified value has invalid CRLF characters.", "value");
		}
		return value;
	}

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

	static HttpValidationHelpers()
	{
		//IL_000c: Field data (rva=0x730) could not be found in any section!
		//IL_000c: Field data (rva=0x730) could not be found in any section!
		char[] array = new char[6];
		RuntimeHelpers.InitializeArray(array, (RuntimeFieldHandle)/*OpCode not supported: LdMemberToken*/);
		s_httpTrimCharacters = array;
	}
}
