using System;
using LuaInterface;
using UnityEngine;

public class UnityEngine_AnimatorClipInfoWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(AnimatorClipInfo), null);
		L.RegFunction("New", _CreateUnityEngine_AnimatorClipInfo);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("clip", get_clip, null);
		L.RegVar("weight", get_weight, null);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateUnityEngine_AnimatorClipInfo(IntPtr L)
	{
		ToLua.PushValue(L, default(AnimatorClipInfo));
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_clip(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			AnimationClip clip = ((AnimatorClipInfo)obj).clip;
			ToLua.PushSealed(L, clip);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index clip on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_weight(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float weight = ((AnimatorClipInfo)obj).weight;
			LuaDLL.lua_pushnumber(L, weight);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index weight on a nil value");
		}
	}
}
