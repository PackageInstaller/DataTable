using System.Runtime.CompilerServices;

namespace System.Net;

internal static class ValidationHelper
{
	public static string[] EmptyArray;

	internal static readonly char[] InvalidMethodChars;

	internal static readonly char[] InvalidParamChars;

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

	static ValidationHelper()
	{
		//IL_002e: Field data (rva=0x7e8) could not be found in any section!
		//IL_002e: Field data (rva=0x7e8) could not be found in any section!
		//IL_0017: Field data (rva=0x728) could not be found in any section!
		//IL_0017: Field data (rva=0x728) could not be found in any section!
		EmptyArray = new string[0];
		char[] array = new char[4];
		RuntimeHelpers.InitializeArray(array, (RuntimeFieldHandle)/*OpCode not supported: LdMemberToken*/);
		InvalidMethodChars = array;
		char[] array2 = new char[22];
		RuntimeHelpers.InitializeArray(array2, (RuntimeFieldHandle)/*OpCode not supported: LdMemberToken*/);
		InvalidParamChars = array2;
	}
}
