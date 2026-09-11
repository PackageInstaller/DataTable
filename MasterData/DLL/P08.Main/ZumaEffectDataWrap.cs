using System;
using LuaInterface;

public class ZumaEffectDataWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(ZumaEffectData), typeof(object));
		L.RegFunction("New", _CreateZumaEffectData);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("effectType", get_effectType, set_effectType);
		L.RegVar("effectValueList", get_effectValueList, set_effectValueList);
		L.RegVar("effectValueStrList", get_effectValueStrList, set_effectValueStrList);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateZumaEffectData(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				ZumaEffectData o = new ZumaEffectData();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: ZumaEffectData.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_effectType(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int effectType = ((ZumaEffectData)obj).effectType;
			LuaDLL.lua_pushinteger(L, effectType);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index effectType on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_effectValueList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int[] effectValueList = ((ZumaEffectData)obj).effectValueList;
			ToLua.Push(L, effectValueList);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index effectValueList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_effectValueStrList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string[] effectValueStrList = ((ZumaEffectData)obj).effectValueStrList;
			ToLua.Push(L, effectValueStrList);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index effectValueStrList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_effectType(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ZumaEffectData obj2 = (ZumaEffectData)obj;
			int effectType = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.effectType = effectType;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index effectType on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_effectValueList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ZumaEffectData obj2 = (ZumaEffectData)obj;
			int[] effectValueList = ToLua.CheckNumberArray<int>(L, 2);
			obj2.effectValueList = effectValueList;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index effectValueList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_effectValueStrList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ZumaEffectData obj2 = (ZumaEffectData)obj;
			string[] effectValueStrList = ToLua.CheckStringArray(L, 2);
			obj2.effectValueStrList = effectValueStrList;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index effectValueStrList on a nil value");
		}
	}
}
