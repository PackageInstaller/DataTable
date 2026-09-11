using System;
using LuaInterface;
using UnityEngine;

public class UnityEngine_CameraClearFlagsWrap
{
	public static void Register(LuaState L)
	{
		L.BeginEnum(typeof(CameraClearFlags));
		L.RegVar("Skybox", get_Skybox, null);
		L.RegVar("Color", get_Color, null);
		L.RegVar("SolidColor", get_SolidColor, null);
		L.RegVar("Depth", get_Depth, null);
		L.RegVar("Nothing", get_Nothing, null);
		L.RegFunction("IntToEnum", IntToEnum);
		L.EndEnum();
		TypeTraits<CameraClearFlags>.Check = CheckType;
		StackTraits<CameraClearFlags>.Push = Push;
	}

	private static void Push(IntPtr L, CameraClearFlags arg)
	{
		ToLua.Push(L, arg);
	}

	private static bool CheckType(IntPtr L, int pos)
	{
		return TypeChecker.CheckEnumType(typeof(CameraClearFlags), L, pos);
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Skybox(IntPtr L)
	{
		ToLua.Push(L, CameraClearFlags.Skybox);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Color(IntPtr L)
	{
		ToLua.Push(L, CameraClearFlags.Color);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_SolidColor(IntPtr L)
	{
		ToLua.Push(L, CameraClearFlags.Color);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Depth(IntPtr L)
	{
		ToLua.Push(L, CameraClearFlags.Depth);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Nothing(IntPtr L)
	{
		ToLua.Push(L, CameraClearFlags.Nothing);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IntToEnum(IntPtr L)
	{
		CameraClearFlags cameraClearFlags = (CameraClearFlags)LuaDLL.lua_tonumber(L, 1);
		ToLua.Push(L, cameraClearFlags);
		return 1;
	}
}
