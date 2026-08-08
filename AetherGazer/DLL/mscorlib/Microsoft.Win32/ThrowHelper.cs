using System;
using System.Security;

namespace Microsoft.Win32;

internal static class ThrowHelper
{
	internal static void ThrowArgumentException(string msg, string argument)
	{
		throw new ArgumentException(msg, argument);
	}

	internal static void ThrowArgumentNullException(string argument)
	{
		throw new ArgumentNullException(argument);
	}

	internal static void ThrowSecurityException(string msg)
	{
		throw new SecurityException(msg);
	}

	internal static void ThrowObjectDisposedException(string objectName, string msg)
	{
		throw new ObjectDisposedException(objectName, msg);
	}
}
