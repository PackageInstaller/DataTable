using System;
using LuaInterface;

public class ZumaDataForExchangeWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(ZumaDataForExchange), typeof(object));
		L.RegFunction("New", _CreateZumaDataForExchange);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("mapName", get_mapName, set_mapName);
		L.RegVar("difficult", get_difficult, set_difficult);
		L.RegVar("useSkillType", get_useSkillType, set_useSkillType);
		L.RegVar("isEndless", get_isEndless, set_isEndless);
		L.RegVar("effectList", get_effectList, set_effectList);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateZumaDataForExchange(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				ZumaDataForExchange o = new ZumaDataForExchange();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: ZumaDataForExchange.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_mapName(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string mapName = ((ZumaDataForExchange)obj).mapName;
			LuaDLL.lua_pushstring(L, mapName);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mapName on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_difficult(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int difficult = ((ZumaDataForExchange)obj).difficult;
			LuaDLL.lua_pushinteger(L, difficult);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index difficult on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_useSkillType(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int useSkillType = ((ZumaDataForExchange)obj).useSkillType;
			LuaDLL.lua_pushinteger(L, useSkillType);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index useSkillType on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isEndless(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isEndless = ((ZumaDataForExchange)obj).isEndless;
			LuaDLL.lua_pushboolean(L, isEndless);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isEndless on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_effectList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ZumaEffectData[] effectList = ((ZumaDataForExchange)obj).effectList;
			ToLua.Push(L, effectList);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index effectList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_mapName(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ZumaDataForExchange obj2 = (ZumaDataForExchange)obj;
			string mapName = ToLua.CheckString(L, 2);
			obj2.mapName = mapName;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mapName on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_difficult(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ZumaDataForExchange obj2 = (ZumaDataForExchange)obj;
			int difficult = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.difficult = difficult;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index difficult on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_useSkillType(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ZumaDataForExchange obj2 = (ZumaDataForExchange)obj;
			int useSkillType = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.useSkillType = useSkillType;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index useSkillType on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_isEndless(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ZumaDataForExchange obj2 = (ZumaDataForExchange)obj;
			bool isEndless = LuaDLL.luaL_checkboolean(L, 2);
			obj2.isEndless = isEndless;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isEndless on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_effectList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ZumaDataForExchange obj2 = (ZumaDataForExchange)obj;
			ZumaEffectData[] effectList = ToLua.CheckObjectArray<ZumaEffectData>(L, 2);
			obj2.effectList = effectList;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index effectList on a nil value");
		}
	}
}
