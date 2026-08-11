using System.Runtime.InteropServices;

namespace System.Security;

[ComVisible(true)]
public static class SecurityManager
{
	[Obsolete("The security manager cannot be turned off on MS runtime")]
	public static bool SecurityEnabled => false;

	internal static void EnsureElevatedPermissions()
	{
	}
}
