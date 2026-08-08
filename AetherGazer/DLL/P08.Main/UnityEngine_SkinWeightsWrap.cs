using System;
using LuaInterface;
using UnityEngine;

public class UnityEngine_SkinWeightsWrap
{
	public static void Register(LuaState L)
	{
		L.BeginEnum(typeof(SkinWeights));
		L.RegVar("OneBone", get_OneBone, null);
		L.RegVar("TwoBones", get_TwoBones, null);
		L.RegVar("FourBones", get_FourBones, null);
		L.RegVar("Unlimited", get_Unlimited, null);
		L.RegFunction("IntToEnum", IntToEnum);
		L.EndEnum();
		TypeTraits<SkinWeights>.Check = CheckType;
		StackTraits<SkinWeights>.Push = Push;
	}

	private static void Push(IntPtr L, SkinWeights arg)
	{
		ToLua.Push(L, arg);
	}

	private static bool CheckType(IntPtr L, int pos)
	{
		return TypeChecker.CheckEnumType(typeof(SkinWeights), L, pos);
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_OneBone(IntPtr L)
	{
		ToLua.Push(L, SkinWeights.OneBone);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_TwoBones(IntPtr L)
	{
		ToLua.Push(L, SkinWeights.TwoBones);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_FourBones(IntPtr L)
	{
		ToLua.Push(L, SkinWeights.FourBones);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Unlimited(IntPtr L)
	{
		ToLua.Push(L, SkinWeights.Unlimited);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IntToEnum(IntPtr L)
	{
		SkinWeights skinWeights = (SkinWeights)LuaDLL.lua_tonumber(L, 1);
		ToLua.Push(L, skinWeights);
		return 1;
	}
}
