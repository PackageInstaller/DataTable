using System;
using System.Collections.Generic;
using LuaInterface;
using UnityEngine;
using UnityEngine.Playables;

public class UnityEngine_Playables_PlayableAssetWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(PlayableAsset), typeof(ScriptableObject));
		L.RegFunction("CreatePlayable", CreatePlayable);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("duration", get_duration, null);
		L.RegVar("outputs", get_outputs, null);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CreatePlayable(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			PlayableAsset obj = (PlayableAsset)ToLua.CheckObject<PlayableAsset>(L, 1);
			PlayableGraph graph = StackTraits<PlayableGraph>.Check(L, 2);
			GameObject owner = (GameObject)ToLua.CheckObject(L, 3, typeof(GameObject));
			Playable v = obj.CreatePlayable(graph, owner);
			ToLua.PushValue(L, v);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int op_Equality(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			UnityEngine.Object obj = (UnityEngine.Object)ToLua.ToObject(L, 1);
			UnityEngine.Object obj2 = (UnityEngine.Object)ToLua.ToObject(L, 2);
			bool value = obj == obj2;
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_duration(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			double duration = ((PlayableAsset)obj).duration;
			LuaDLL.lua_pushnumber(L, duration);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index duration on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_outputs(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			IEnumerable<PlayableBinding> outputs = ((PlayableAsset)obj).outputs;
			ToLua.PushObject(L, outputs);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index outputs on a nil value");
		}
	}
}
