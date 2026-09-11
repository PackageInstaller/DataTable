using System;
using LuaInterface;

public class ChessBoardGridConfigWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(ChessBoardGridConfig), typeof(object));
		L.RegFunction("New", _CreateChessBoardGridConfig);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("id", get_id, set_id);
		L.RegVar("walkable", get_walkable, set_walkable);
		L.RegVar("updatable", get_updatable, set_updatable);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateChessBoardGridConfig(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				ChessBoardGridConfig o = new ChessBoardGridConfig();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: ChessBoardGridConfig.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_id(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int id = ((ChessBoardGridConfig)obj).id;
			LuaDLL.lua_pushinteger(L, id);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index id on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_walkable(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int walkable = ((ChessBoardGridConfig)obj).walkable;
			LuaDLL.lua_pushinteger(L, walkable);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index walkable on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_updatable(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int updatable = ((ChessBoardGridConfig)obj).updatable;
			LuaDLL.lua_pushinteger(L, updatable);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index updatable on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_id(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ChessBoardGridConfig obj2 = (ChessBoardGridConfig)obj;
			int id = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.id = id;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index id on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_walkable(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ChessBoardGridConfig obj2 = (ChessBoardGridConfig)obj;
			int walkable = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.walkable = walkable;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index walkable on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_updatable(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ChessBoardGridConfig obj2 = (ChessBoardGridConfig)obj;
			int updatable = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.updatable = updatable;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index updatable on a nil value");
		}
	}
}
