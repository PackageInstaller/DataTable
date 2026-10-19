using System.Runtime.CompilerServices;
using Microsoft.Win32.SafeHandles;

namespace System.Threading;

internal static class NativeEventCalls
{
	public unsafe static IntPtr CreateEvent_internal(bool manual, bool initial, string name, out int errorCode)
	{
		fixed (char* name2 = name)
		{
			return CreateEvent_icall(manual, initial, name2, name?.Length ?? 0, out errorCode);
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	private unsafe static extern IntPtr CreateEvent_icall(bool manual, bool initial, char* name, int name_length, out int errorCode);

	public static bool SetEvent(SafeWaitHandle handle)
	{
		bool success = false;
		try
		{
			handle.DangerousAddRef(ref success);
			return SetEvent_internal(handle.DangerousGetHandle());
		}
		finally
		{
			if (success)
			{
				handle.DangerousRelease();
			}
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern bool SetEvent_internal(IntPtr handle);

	public static bool ResetEvent(SafeWaitHandle handle)
	{
		bool success = false;
		try
		{
			handle.DangerousAddRef(ref success);
			return ResetEvent_internal(handle.DangerousGetHandle());
		}
		finally
		{
			if (success)
			{
				handle.DangerousRelease();
			}
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern bool ResetEvent_internal(IntPtr handle);

	[MethodImpl((MethodImplOptions)4096)]
	public static extern void CloseEvent_internal(IntPtr handle);
}
