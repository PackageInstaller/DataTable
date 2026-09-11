using System;
using LuaInterface;

public class NewWarChessThingConfigWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(NewWarChessThingConfig), typeof(object));
		L.RegFunction("New", _CreateNewWarChessThingConfig);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("thingID", get_thingID, set_thingID);
		L.RegVar("walkable", get_walkable, set_walkable);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateNewWarChessThingConfig(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				NewWarChessThingConfig o = new NewWarChessThingConfig();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: NewWarChessThingConfig.New");
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
			int thingID = ((NewWarChessThingConfig)obj).thingID;
			LuaDLL.lua_pushinteger(L, thingID);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index thingID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_walkable(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int walkable = ((NewWarChessThingConfig)obj).walkable;
			LuaDLL.lua_pushinteger(L, walkable);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index walkable on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_thingID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			NewWarChessThingConfig obj2 = (NewWarChessThingConfig)obj;
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
	private static int set_walkable(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			NewWarChessThingConfig obj2 = (NewWarChessThingConfig)obj;
			int walkable = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.walkable = walkable;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index walkable on a nil value");
		}
	}
}
