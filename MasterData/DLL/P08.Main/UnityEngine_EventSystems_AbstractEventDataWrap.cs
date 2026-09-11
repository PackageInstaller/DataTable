using System;
using LuaInterface;
using UnityEngine.EventSystems;

public class UnityEngine_EventSystems_AbstractEventDataWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(AbstractEventData), typeof(object));
		L.RegFunction("Reset", Reset);
		L.RegFunction("Use", Use);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("used", get_used, null);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Reset(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((AbstractEventData)ToLua.CheckObject<AbstractEventData>(L, 1)).Reset();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Use(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((AbstractEventData)ToLua.CheckObject<AbstractEventData>(L, 1)).Use();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_used(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool used = ((AbstractEventData)obj).used;
			LuaDLL.lua_pushboolean(L, used);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index used on a nil value");
		}
	}
}
