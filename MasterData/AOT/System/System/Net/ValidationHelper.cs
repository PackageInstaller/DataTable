namespace System.Net;

internal static class ValidationHelper
{
	public static string[] EmptyArray = new string[0];

	internal static readonly char[] InvalidMethodChars = new char[4] { ' ', '\r', '\n', '\t' };

	internal static readonly char[] InvalidParamChars = new char[22]
	{
		'(', ')', '<', '>', '@', ',', ';', ':', '\\', '"',
		'\'', '/', '[', ']', '?', '=', '{', '}', ' ', '\t',
		'\r', '\n'
	};

	public static string MakeStringNull(string stringValue)
	{
		if (stringValue == null || stringValue.Length == 0)
		{
			return null;
		}
		return stringValue;
	}

	public static bool IsBlankString(string stringValue)
	{
		if (stringValue != null)
		{
			return stringValue.Length == 0;
		}
		return true;
	}

	public static bool ValidateTcpPort(int port)
	{
		if (port >= 0)
		{
			return port <= 65535;
		}
		return false;
	}
}
