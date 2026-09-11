using System;
using LuaInterface;

public class ChessBoardThingChangeDataWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(ChessBoardThingChangeData), typeof(object));
		L.RegFunction("New", _CreateChessBoardThingChangeData);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("x", get_x, set_x);
		L.RegVar("z", get_z, set_z);
		L.RegVar("thingtag", get_thingtag, set_thingtag);
		L.RegVar("thingRotationY", get_thingRotationY, set_thingRotationY);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateChessBoardThingChangeData(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				ChessBoardThingChangeData o = new ChessBoardThingChangeData();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: ChessBoardThingChangeData.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_x(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			short x = ((ChessBoardThingChangeData)obj).x;
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
			short z = ((ChessBoardThingChangeData)obj).z;
			LuaDLL.lua_pushnumber(L, z);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index z on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_thingtag(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int thingtag = ((ChessBoardThingChangeData)obj).thingtag;
			LuaDLL.lua_pushinteger(L, thingtag);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index thingtag on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_thingRotationY(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float thingRotationY = ((ChessBoardThingChangeData)obj).thingRotationY;
			LuaDLL.lua_pushnumber(L, thingRotationY);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index thingRotationY on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_x(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ChessBoardThingChangeData obj2 = (ChessBoardThingChangeData)obj;
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
			ChessBoardThingChangeData obj2 = (ChessBoardThingChangeData)obj;
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
	private static int set_thingtag(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ChessBoardThingChangeData obj2 = (ChessBoardThingChangeData)obj;
			int thingtag = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.thingtag = thingtag;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index thingtag on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_thingRotationY(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ChessBoardThingChangeData obj2 = (ChessBoardThingChangeData)obj;
			float thingRotationY = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.thingRotationY = thingRotationY;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index thingRotationY on a nil value");
		}
	}
}
