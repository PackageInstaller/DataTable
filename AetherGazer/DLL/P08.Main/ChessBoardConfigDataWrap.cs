using System;
using LuaInterface;

public class ChessBoardConfigDataWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(ChessBoardConfigData), typeof(object));
		L.RegFunction("New", _CreateChessBoardConfigData);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("GridConfig", get_GridConfig, set_GridConfig);
		L.RegVar("ThingConfig", get_ThingConfig, set_ThingConfig);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateChessBoardConfigData(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				ChessBoardConfigData o = new ChessBoardConfigData();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: ChessBoardConfigData.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_GridConfig(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ChessBoardGridConfig[] gridConfig = ((ChessBoardConfigData)obj).GridConfig;
			ToLua.Push(L, gridConfig);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index GridConfig on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_ThingConfig(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ChessBoardThingConfig[] thingConfig = ((ChessBoardConfigData)obj).ThingConfig;
			ToLua.Push(L, thingConfig);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index ThingConfig on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_GridConfig(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ChessBoardConfigData obj2 = (ChessBoardConfigData)obj;
			ChessBoardGridConfig[] gridConfig = ToLua.CheckObjectArray<ChessBoardGridConfig>(L, 2);
			obj2.GridConfig = gridConfig;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index GridConfig on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_ThingConfig(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ChessBoardConfigData obj2 = (ChessBoardConfigData)obj;
			ChessBoardThingConfig[] thingConfig = ToLua.CheckObjectArray<ChessBoardThingConfig>(L, 2);
			obj2.ThingConfig = thingConfig;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index ThingConfig on a nil value");
		}
	}
}
