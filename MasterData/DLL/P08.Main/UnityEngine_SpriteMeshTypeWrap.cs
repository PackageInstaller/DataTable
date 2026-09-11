using System;
using LuaInterface;
using UnityEngine;

public class UnityEngine_SpriteMeshTypeWrap
{
	public static void Register(LuaState L)
	{
		L.BeginEnum(typeof(SpriteMeshType));
		L.RegVar("FullRect", get_FullRect, null);
		L.RegVar("Tight", get_Tight, null);
		L.RegFunction("IntToEnum", IntToEnum);
		L.EndEnum();
		TypeTraits<SpriteMeshType>.Check = CheckType;
		StackTraits<SpriteMeshType>.Push = Push;
	}

	private static void Push(IntPtr L, SpriteMeshType arg)
	{
		ToLua.Push(L, arg);
	}

	private static bool CheckType(IntPtr L, int pos)
	{
		return TypeChecker.CheckEnumType(typeof(SpriteMeshType), L, pos);
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_FullRect(IntPtr L)
	{
		ToLua.Push(L, SpriteMeshType.FullRect);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Tight(IntPtr L)
	{
		ToLua.Push(L, SpriteMeshType.Tight);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IntToEnum(IntPtr L)
	{
		SpriteMeshType spriteMeshType = (SpriteMeshType)LuaDLL.lua_tonumber(L, 1);
		ToLua.Push(L, spriteMeshType);
		return 1;
	}
}
