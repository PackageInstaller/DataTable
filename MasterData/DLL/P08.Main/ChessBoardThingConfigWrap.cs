using System;
using LuaInterface;

public class ChessBoardThingConfigWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(ChessBoardThingConfig), typeof(object));
		L.RegFunction("New", _CreateChessBoardThingConfig);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("thingID", get_thingID, set_thingID);
		L.RegVar("fixWalkable", get_fixWalkable, set_fixWalkable);
		L.RegVar("destoryable", get_destoryable, set_destoryable);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateChessBoardThingConfig(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				ChessBoardThingConfig o = new ChessBoardThingConfig();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: ChessBoardThingConfig.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_thingID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int thingID = ((ChessBoardThingConfig)obj).thingID;
			LuaDLL.lua_pushinteger(L, thingID);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index thingID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_fixWalkable(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int fixWalkable = ((ChessBoardThingConfig)obj).fixWalkable;
			LuaDLL.lua_pushinteger(L, fixWalkable);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index fixWalkable on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_destoryable(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int destoryable = ((ChessBoardThingConfig)obj).destoryable;
			LuaDLL.lua_pushinteger(L, destoryable);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index destoryable on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_thingID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ChessBoardThingConfig obj2 = (ChessBoardThingConfig)obj;
			int thingID = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.thingID = thingID;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index thingID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_fixWalkable(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ChessBoardThingConfig obj2 = (ChessBoardThingConfig)obj;
			int fixWalkable = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.fixWalkable = fixWalkable;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index fixWalkable on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_destoryable(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ChessBoardThingConfig obj2 = (ChessBoardThingConfig)obj;
			int destoryable = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.destoryable = destoryable;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index destoryable on a nil value");
		}
	}
}
