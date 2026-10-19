using System;
using System.IO;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using Microsoft.Win32.SafeHandles;

namespace Microsoft.Win32;

internal static class NativeMethods
{
	public static bool DuplicateHandle(HandleRef hSourceProcessHandle, HandleRef hSourceHandle, HandleRef hTargetProcess, out SafeProcessHandle targetHandle, int dwDesiredAccess, bool bInheritHandle, int dwOptions)
	{
		bool result = MonoIO.DuplicateHandle(hSourceProcessHandle.Handle, hSourceHandle.Handle, hTargetProcess.Handle, out var target_handle, dwDesiredAccess, bInheritHandle ? 1 : 0, dwOptions, out var error);
		if (error != MonoIOError.ERROR_SUCCESS)
		{
			throw MonoIO.GetException(error);
		}
		targetHandle = new SafeProcessHandle(target_handle, ownsHandle: true);
		return result;
	}

	[MethodImpl((MethodImplOptions)4096)]
	public static extern IntPtr GetCurrentProcess();

	[MethodImpl((MethodImplOptions)4096)]
	public static extern bool GetExitCodeProcess(IntPtr processHandle, out int exitCode);

	public static bool GetExitCodeProcess(SafeProcessHandle processHandle, out int exitCode)
	{
		bool success = false;
		try
		{
			processHandle.DangerousAddRef(ref success);
			return GetExitCodeProcess(processHandle.DangerousGetHandle(), out exitCode);
		}
		finally
		{
			if (success)
			{
				processHandle.DangerousRelease();
			}
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	public static extern bool TerminateProcess(IntPtr processHandle, int exitCode);

	public static bool TerminateProcess(SafeProcessHandle processHandle, int exitCode)
	{
		bool success = false;
		try
		{
			processHandle.DangerousAddRef(ref success);
			return TerminateProcess(processHandle.DangerousGetHandle(), exitCode);
		}
		finally
		{
			if (success)
			{
				processHandle.DangerousRelease();
			}
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	public static extern int WaitForInputIdle(IntPtr handle, int milliseconds);

	public static int WaitForInputIdle(SafeProcessHandle handle, int milliseconds)
	{
		bool success = false;
		try
		{
			handle.DangerousAddRef(ref success);
			return WaitForInputIdle(handle.DangerousGetHandle(), milliseconds);
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
	public static extern bool GetProcessWorkingSetSize(IntPtr handle, out IntPtr min, out IntPtr max);

	public static bool GetProcessWorkingSetSize(SafeProcessHandle handle, out IntPtr min, out IntPtr max)
	{
		bool success = false;
		try
		{
			handle.DangerousAddRef(ref success);
			return GetProcessWorkingSetSize(handle.DangerousGetHandle(), out min, out max);
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
	public static extern bool SetProcessWorkingSetSize(IntPtr handle, IntPtr min, IntPtr max);

	public static bool SetProcessWorkingSetSize(SafeProcessHandle handle, IntPtr min, IntPtr max)
	{
		bool success = false;
		try
		{
			handle.DangerousAddRef(ref success);
			return SetProcessWorkingSetSize(handle.DangerousGetHandle(), min, max);
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
	public static extern bool GetProcessTimes(IntPtr handle, out long creation, out long exit, out long kernel, out long user);

	public static bool GetProcessTimes(SafeProcessHandle handle, out long creation, out long exit, out long kernel, out long user)
	{
		bool success = false;
		try
		{
			handle.DangerousAddRef(ref success);
			return GetProcessTimes(handle.DangerousGetHandle(), out creation, out exit, out kernel, out user);
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
	public static extern int GetCurrentProcessId();

	[MethodImpl((MethodImplOptions)4096)]
	public static extern int GetPriorityClass(IntPtr handle);

	public static int GetPriorityClass(SafeProcessHandle handle)
	{
		bool success = false;
		try
		{
			handle.DangerousAddRef(ref success);
			return GetPriorityClass(handle.DangerousGetHandle());
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
	public static extern bool SetPriorityClass(IntPtr handle, int priorityClass);

	public static bool SetPriorityClass(SafeProcessHandle handle, int priorityClass)
	{
		bool success = false;
		try
		{
			handle.DangerousAddRef(ref success);
			return SetPriorityClass(handle.DangerousGetHandle(), priorityClass);
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
	public static extern bool CloseProcess(IntPtr handle);
}
