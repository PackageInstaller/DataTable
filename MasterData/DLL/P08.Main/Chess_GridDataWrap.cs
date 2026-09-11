using System;
using Chess;
using LuaInterface;

public class Chess_GridDataWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(GridData), typeof(object));
		L.RegFunction("New", _CreateChess_GridData);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("prefab", get_prefab, set_prefab);
		L.RegVar("rotationY", get_rotationY, set_rotationY);
		L.RegVar("typeID", get_typeID, set_typeID);
		L.RegVar("x", get_x, set_x);
		L.RegVar("z", get_z, set_z);
		L.RegVar("paramList", get_paramList, set_paramList);
		L.RegVar("status", get_status, set_status);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateChess_GridData(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 0:
			{
				GridData o2 = new GridData();
				ToLua.PushObject(L, o2);
				return 1;
			}
			case 1:
			{
				GridData o = new GridData((GridData)ToLua.CheckObject<GridData>(L, 1));
				ToLua.PushObject(L, o);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: Chess.GridData.New");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_prefab(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string prefab = ((GridData)obj).prefab;
			LuaDLL.lua_pushstring(L, prefab);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index prefab on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_rotationY(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float rotationY = ((GridData)obj).rotationY;
			LuaDLL.lua_pushnumber(L, rotationY);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index rotationY on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_typeID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int typeID = ((GridData)obj).typeID;
			LuaDLL.lua_pushinteger(L, typeID);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index typeID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_x(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			short x = ((GridData)obj).x;
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
			short z = ((GridData)obj).z;
			LuaDLL.lua_pushnumber(L, z);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index z on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_paramList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int[] paramList = ((GridData)obj).paramList;
			ToLua.Push(L, paramList);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index paramList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_status(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int status = ((GridData)obj).status;
			LuaDLL.lua_pushinteger(L, status);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index status on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_prefab(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GridData obj2 = (GridData)obj;
			string prefab = ToLua.CheckString(L, 2);
			obj2.prefab = prefab;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index prefab on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_rotationY(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GridData obj2 = (GridData)obj;
			float rotationY = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.rotationY = rotationY;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index rotationY on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_typeID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GridData obj2 = (GridData)obj;
			int typeID = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.typeID = typeID;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index typeID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_x(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GridData obj2 = (GridData)obj;
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
			GridData obj2 = (GridData)obj;
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
	private static int set_paramList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GridData obj2 = (GridData)obj;
			int[] paramList = ToLua.CheckNumberArray<int>(L, 2);
			obj2.paramList = paramList;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index paramList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_status(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GridData obj2 = (GridData)obj;
			int status = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.status = status;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index status on a nil value");
		}
	}
}
