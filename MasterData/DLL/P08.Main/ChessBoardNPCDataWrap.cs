using System;
using LuaInterface;

public class ChessBoardNPCDataWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(ChessBoardNPCData), typeof(object));
		L.RegFunction("New", _CreateChessBoardNPCData);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("entityID", get_entityID, set_entityID);
		L.RegVar("x", get_x, set_x);
		L.RegVar("z", get_z, set_z);
		L.RegVar("dir", get_dir, set_dir);
		L.RegVar("prefab", get_prefab, set_prefab);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateChessBoardNPCData(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				ChessBoardNPCData o = new ChessBoardNPCData();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: ChessBoardNPCData.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_entityID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int entityID = ((ChessBoardNPCData)obj).entityID;
			LuaDLL.lua_pushinteger(L, entityID);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index entityID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_x(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			short x = ((ChessBoardNPCData)obj).x;
			LuaDLL.lua_pushnumber(L, x);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index x on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_z(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			short z = ((ChessBoardNPCData)obj).z;
			LuaDLL.lua_pushnumber(L, z);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index z on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_dir(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int dir = ((ChessBoardNPCData)obj).dir;
			LuaDLL.lua_pushinteger(L, dir);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index dir on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_prefab(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string prefab = ((ChessBoardNPCData)obj).prefab;
			LuaDLL.lua_pushstring(L, prefab);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index prefab on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_entityID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ChessBoardNPCData obj2 = (ChessBoardNPCData)obj;
			int entityID = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.entityID = entityID;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index entityID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_x(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ChessBoardNPCData obj2 = (ChessBoardNPCData)obj;
			short x = (short)LuaDLL.luaL_checknumber(L, 2);
			obj2.x = x;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index x on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_z(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ChessBoardNPCData obj2 = (ChessBoardNPCData)obj;
			short z = (short)LuaDLL.luaL_checknumber(L, 2);
			obj2.z = z;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index z on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_dir(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ChessBoardNPCData obj2 = (ChessBoardNPCData)obj;
			int dir = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.dir = dir;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index dir on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_prefab(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ChessBoardNPCData obj2 = (ChessBoardNPCData)obj;
			string prefab = ToLua.CheckString(L, 2);
			obj2.prefab = prefab;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index prefab on a nil value");
		}
	}
}
