using System;
using LuaInterface;
using UnityEngine;

public class UnityEngine_RuntimePlatformWrap
{
	public static void Register(LuaState L)
	{
		L.BeginEnum(typeof(RuntimePlatform));
		L.RegVar("OSXEditor", get_OSXEditor, null);
		L.RegVar("OSXPlayer", get_OSXPlayer, null);
		L.RegVar("WindowsPlayer", get_WindowsPlayer, null);
		L.RegVar("WindowsEditor", get_WindowsEditor, null);
		L.RegVar("IPhonePlayer", get_IPhonePlayer, null);
		L.RegVar("Android", get_Android, null);
		L.RegVar("LinuxPlayer", get_LinuxPlayer, null);
		L.RegVar("LinuxEditor", get_LinuxEditor, null);
		L.RegVar("WebGLPlayer", get_WebGLPlayer, null);
		L.RegVar("WSAPlayerX86", get_WSAPlayerX86, null);
		L.RegVar("WSAPlayerX64", get_WSAPlayerX64, null);
		L.RegVar("WSAPlayerARM", get_WSAPlayerARM, null);
		L.RegVar("PS4", get_PS4, null);
		L.RegVar("XboxOne", get_XboxOne, null);
		L.RegVar("tvOS", get_tvOS, null);
		L.RegVar("Switch", get_Switch, null);
		L.RegVar("Lumin", get_Lumin, null);
		L.RegFunction("IntToEnum", IntToEnum);
		L.EndEnum();
		TypeTraits<RuntimePlatform>.Check = CheckType;
		StackTraits<RuntimePlatform>.Push = Push;
	}

	private static void Push(IntPtr L, RuntimePlatform arg)
	{
		ToLua.Push(L, arg);
	}

	private static bool CheckType(IntPtr L, int pos)
	{
		return TypeChecker.CheckEnumType(typeof(RuntimePlatform), L, pos);
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_OSXEditor(IntPtr L)
	{
		ToLua.Push(L, RuntimePlatform.OSXEditor);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_OSXPlayer(IntPtr L)
	{
		ToLua.Push(L, RuntimePlatform.OSXPlayer);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_WindowsPlayer(IntPtr L)
	{
		ToLua.Push(L, RuntimePlatform.WindowsPlayer);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_WindowsEditor(IntPtr L)
	{
		ToLua.Push(L, RuntimePlatform.WindowsEditor);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_IPhonePlayer(IntPtr L)
	{
		ToLua.Push(L, RuntimePlatform.IPhonePlayer);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Android(IntPtr L)
	{
		ToLua.Push(L, RuntimePlatform.Android);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_LinuxPlayer(IntPtr L)
	{
		ToLua.Push(L, RuntimePlatform.LinuxPlayer);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_LinuxEditor(IntPtr L)
	{
		ToLua.Push(L, RuntimePlatform.LinuxEditor);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_WebGLPlayer(IntPtr L)
	{
		ToLua.Push(L, RuntimePlatform.WebGLPlayer);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_WSAPlayerX86(IntPtr L)
	{
		ToLua.Push(L, RuntimePlatform.MetroPlayerX86);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_WSAPlayerX64(IntPtr L)
	{
		ToLua.Push(L, RuntimePlatform.MetroPlayerX64);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_WSAPlayerARM(IntPtr L)
	{
		ToLua.Push(L, RuntimePlatform.MetroPlayerARM);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_PS4(IntPtr L)
	{
		ToLua.Push(L, RuntimePlatform.PS4);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_XboxOne(IntPtr L)
	{
		ToLua.Push(L, RuntimePlatform.XboxOne);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_tvOS(IntPtr L)
	{
		ToLua.Push(L, RuntimePlatform.tvOS);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Switch(IntPtr L)
	{
		ToLua.Push(L, RuntimePlatform.Switch);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Lumin(IntPtr L)
	{
		ToLua.Push(L, RuntimePlatform.Lumin);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IntToEnum(IntPtr L)
	{
		RuntimePlatform runtimePlatform = (RuntimePlatform)LuaDLL.lua_tonumber(L, 1);
		ToLua.Push(L, runtimePlatform);
		return 1;
	}
}
