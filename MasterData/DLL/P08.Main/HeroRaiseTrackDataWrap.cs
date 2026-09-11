using System;
using System.Collections.Generic;
using LuaInterface;
using UnityEngine;

public class HeroRaiseTrackDataWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(HeroRaiseTrackData), typeof(ScriptableObject));
		L.RegFunction("New", _CreateHeroRaiseTrackData);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("nodes", get_nodes, set_nodes);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateHeroRaiseTrackData(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				HeroRaiseTrackData obj = new HeroRaiseTrackData();
				ToLua.Push(L, obj);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: HeroRaiseTrackData.New");
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
	private static int get_nodes(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<HeroRaiseCameraNode> nodes = ((HeroRaiseTrackData)obj).nodes;
			ToLua.PushSealed(L, nodes);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index nodes on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_nodes(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			HeroRaiseTrackData obj2 = (HeroRaiseTrackData)obj;
			List<HeroRaiseCameraNode> nodes = (List<HeroRaiseCameraNode>)ToLua.CheckObject(L, 2, typeof(List<HeroRaiseCameraNode>));
			obj2.nodes = nodes;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index nodes on a nil value");
		}
	}
}
