using System;
using System.Runtime.InteropServices;
using AOT;

public static class CriErrorNotifier
{
	public delegate void Callback(string message);

	[UnmanagedFunctionPointer(CallingConvention.Cdecl)]
	internal delegate void ErrorCallbackFunc(IntPtr errmsgPtr, uint p1, uint p2, IntPtr parray);

	private static class NativeMethod
	{
		[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
		internal static extern void criErr_SetCallback(ErrorCallbackFunc callback);

		[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
		internal static extern void criErr_SetCallback(IntPtr callback);

		[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
		internal static extern IntPtr criErr_ConvertIdToMessage(IntPtr errmsgPtr, uint p1, uint p2);
	}

	private static object objectLock = new object();

	private static event Callback _onCallbackThreadUnsafe = null;

	public static event Callback OnCallbackThreadUnsafe
	{
		add
		{
			lock (objectLock)
			{
				if (_onCallbackThreadUnsafe == null || _onCallbackThreadUnsafe.GetInvocationList().Length == 0)
				{
					SetCallbackNative(null);
					SetCallbackNative(ErrorCallbackFromNative);
				}
				_onCallbackThreadUnsafe += value;
			}
		}
		remove
		{
			lock (objectLock)
			{
				_onCallbackThreadUnsafe -= value;
				if (_onCallbackThreadUnsafe == null || _onCallbackThreadUnsafe.GetInvocationList().Length == 0)
				{
					SetCallbackNative(null);
				}
			}
		}
	}

	public static bool IsRegistered(Callback target)
	{
		if (_onCallbackThreadUnsafe == null)
		{
			return false;
		}
		Delegate[] invocationList = _onCallbackThreadUnsafe.GetInvocationList();
		for (int i = 0; i < invocationList.Length; i++)
		{
			if ((Callback)invocationList[i] == target)
			{
				return true;
			}
		}
		return false;
	}

	public static void CallEvent(string message)
	{
		if (_onCallbackThreadUnsafe != null)
		{
			_onCallbackThreadUnsafe(message);
		}
	}

	public static void SetCallbackNative(IntPtr errorCallback)
	{
		NativeMethod.criErr_SetCallback(errorCallback);
	}

	internal static void SetCallbackNative(ErrorCallbackFunc errorCallback)
	{
		NativeMethod.criErr_SetCallback(errorCallback);
	}

	internal static ErrorCallbackFunc GetManagedPluginFunc()
	{
		return ErrorCallbackFromNative;
	}

	[MonoPInvokeCallback(typeof(ErrorCallbackFunc))]
	private static void ErrorCallbackFromNative(IntPtr errmsgPtr, uint p1, uint p2, IntPtr parray)
	{
		CallEvent(Marshal.PtrToStringAnsi(NativeMethod.criErr_ConvertIdToMessage(errmsgPtr, p1, p2)));
	}
}
