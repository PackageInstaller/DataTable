using System;
using LuaInterface;
using UnityEngine;

public class UnityEngine_PlayModeWrap
{
	public static void Register(LuaState L)
	{
		L.BeginEnum(typeof(PlayMode));
		L.RegVar("StopSameLayer", get_StopSameLayer, null);
		L.RegVar("StopAll", get_StopAll, null);
		L.RegFunction("IntToEnum", IntToEnum);
		L.EndEnum();
		TypeTraits<PlayMode>.Check = CheckType;
		StackTraits<PlayMode>.Push = Push;
	}

	private static void Push(IntPtr L, PlayMode arg)
	{
		ToLua.Push(L, arg);
	}

	private static bool CheckType(IntPtr L, int pos)
	{
		return TypeChecker.CheckEnumType(typeof(PlayMode), L, pos);
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_StopSameLayer(IntPtr L)
	{
		ToLua.Push(L, PlayMode.StopSameLayer);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_StopAll(IntPtr L)
	{
		ToLua.Push(L, PlayMode.StopAll);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IntToEnum(IntPtr L)
	{
		PlayMode playMode = (PlayMode)LuaDLL.lua_tonumber(L, 1);
		ToLua.Push(L, playMode);
		return 1;
	}
}
