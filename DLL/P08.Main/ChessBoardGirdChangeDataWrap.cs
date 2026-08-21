using System;
using LuaInterface;

public class ChessBoardGirdChangeDataWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(ChessBoardGirdChangeData), typeof(object));
		L.RegFunction("New", _CreateChessBoardGirdChangeData);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("x", get_x, set_x);
		L.RegVar("z", get_z, set_z);
		L.RegVar("tag", get_tag, set_tag);
		L.RegVar("status", get_status, set_status);
		L.RegVar("rotationY", get_rotationY, set_rotationY);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateChessBoardGirdChangeData(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				ChessBoardGirdChangeData o = new ChessBoardGirdChangeData();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: ChessBoardGirdChangeData.New");
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
			short x = ((ChessBoardGirdChangeData)obj).x;
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
			short z = ((ChessBoardGirdChangeData)obj).z;
			LuaDLL.lua_pushnumber(L, z);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index z on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_tag(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int tag = ((ChessBoardGirdChangeData)obj).tag;
			LuaDLL.lua_pushinteger(L, tag);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index tag on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_status(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int status = ((ChessBoardGirdChangeData)obj).status;
			LuaDLL.lua_pushinteger(L, status);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index status on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_rotationY(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float rotationY = ((ChessBoardGirdChangeData)obj).rotationY;
			LuaDLL.lua_pushnumber(L, rotationY);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index rotationY on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_x(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ChessBoardGirdChangeData obj2 = (ChessBoardGirdChangeData)obj;
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
			ChessBoardGirdChangeData obj2 = (ChessBoardGirdChangeData)obj;
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
	private static int set_tag(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ChessBoardGirdChangeData obj2 = (ChessBoardGirdChangeData)obj;
			int tag = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.tag = tag;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index tag on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_status(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ChessBoardGirdChangeData obj2 = (ChessBoardGirdChangeData)obj;
			int status = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.status = status;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index status on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_rotationY(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ChessBoardGirdChangeData obj2 = (ChessBoardGirdChangeData)obj;
			float rotationY = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.rotationY = rotationY;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index rotationY on a nil value");
		}
	}
}
