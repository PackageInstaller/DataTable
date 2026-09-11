using System;
using LuaInterface;
using UnityEngine;

public class FurnitureInfoWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(FurnitureInfo), typeof(object));
		L.RegFunction("New", _CreateFurnitureInfo);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("id", get_id, set_id);
		L.RegVar("tileType", get_tileType, set_tileType);
		L.RegVar("pos", get_pos, set_pos);
		L.RegVar("rotation", get_rotation, set_rotation);
		L.RegVar("state", get_state, set_state);
		L.RegVar("oriSuitID", get_oriSuitID, set_oriSuitID);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateFurnitureInfo(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				FurnitureInfo o = new FurnitureInfo();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: FurnitureInfo.New");
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
			int id = ((FurnitureInfo)obj).id;
			LuaDLL.lua_pushinteger(L, id);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index id on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_tileType(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ushort tileType = ((FurnitureInfo)obj).tileType;
			LuaDLL.lua_pushnumber(L, (int)tileType);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index tileType on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_pos(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector2 pos = ((FurnitureInfo)obj).pos;
			ToLua.Push(L, pos);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index pos on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_rotation(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float rotation = ((FurnitureInfo)obj).rotation;
			LuaDLL.lua_pushnumber(L, rotation);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index rotation on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_state(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			uint state = ((FurnitureInfo)obj).state;
			LuaDLL.lua_pushnumber(L, state);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index state on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_oriSuitID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int oriSuitID = ((FurnitureInfo)obj).oriSuitID;
			LuaDLL.lua_pushinteger(L, oriSuitID);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index oriSuitID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_id(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			FurnitureInfo obj2 = (FurnitureInfo)obj;
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
	private static int set_tileType(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			FurnitureInfo obj2 = (FurnitureInfo)obj;
			ushort tileType = (ushort)LuaDLL.luaL_checknumber(L, 2);
			obj2.tileType = tileType;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index tileType on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_pos(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			FurnitureInfo obj2 = (FurnitureInfo)obj;
			Vector2 pos = ToLua.ToVector2(L, 2);
			obj2.pos = pos;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index pos on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_rotation(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			FurnitureInfo obj2 = (FurnitureInfo)obj;
			float rotation = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.rotation = rotation;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index rotation on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_state(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			FurnitureInfo obj2 = (FurnitureInfo)obj;
			uint state = (uint)LuaDLL.luaL_checknumber(L, 2);
			obj2.state = state;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index state on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_oriSuitID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			FurnitureInfo obj2 = (FurnitureInfo)obj;
			int oriSuitID = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.oriSuitID = oriSuitID;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index oriSuitID on a nil value");
		}
	}
}
