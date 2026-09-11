using System;
using LuaInterface;
using UnityEngine;

public class UnityEngine_AnimationBlendModeWrap
{
	public static void Register(LuaState L)
	{
		L.BeginEnum(typeof(AnimationBlendMode));
		L.RegVar("Blend", get_Blend, null);
		L.RegVar("Additive", get_Additive, null);
		L.RegFunction("IntToEnum", IntToEnum);
		L.EndEnum();
		TypeTraits<AnimationBlendMode>.Check = CheckType;
		StackTraits<AnimationBlendMode>.Push = Push;
	}

	private static void Push(IntPtr L, AnimationBlendMode arg)
	{
		ToLua.Push(L, arg);
	}

	private static bool CheckType(IntPtr L, int pos)
	{
		return TypeChecker.CheckEnumType(typeof(AnimationBlendMode), L, pos);
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Blend(IntPtr L)
	{
		ToLua.Push(L, AnimationBlendMode.Blend);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Additive(IntPtr L)
	{
		ToLua.Push(L, AnimationBlendMode.Additive);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IntToEnum(IntPtr L)
	{
		AnimationBlendMode animationBlendMode = (AnimationBlendMode)LuaDLL.lua_tonumber(L, 1);
		ToLua.Push(L, animationBlendMode);
		return 1;
	}
}
