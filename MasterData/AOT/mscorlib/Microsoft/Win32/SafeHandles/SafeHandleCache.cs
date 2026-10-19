using System.Runtime.InteropServices;
using System.Threading;

namespace Microsoft.Win32.SafeHandles;

internal static class SafeHandleCache<T> where T : SafeHandle
{
	private static T s_invalidHandle;

	internal static bool IsCachedInvalidHandle(SafeHandle handle)
	{
		return handle == Volatile.Read(ref s_invalidHandle);
	}
}
