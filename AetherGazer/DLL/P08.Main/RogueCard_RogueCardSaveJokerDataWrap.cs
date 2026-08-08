using System;
using System.Collections.Generic;
using LuaInterface;
using RogueCard;

public class RogueCard_RogueCardSaveJokerDataWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(RogueCardSaveJokerData), typeof(object));
		L.RegFunction("New", _CreateRogueCard_RogueCardSaveJokerData);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("id", get_id, set_id);
		L.RegVar("real_id", get_real_id, set_real_id);
		L.RegVar("version_id", get_version_id, set_version_id);
		L.RegVar("add_point", get_add_point, set_add_point);
		L.RegVar("add_mutli", get_add_mutli, set_add_mutli);
		L.RegVar("mul_ratio", get_mul_ratio, set_mul_ratio);
		L.RegVar("other_data", get_other_data, set_other_data);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateRogueCard_RogueCardSaveJokerData(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				RogueCardSaveJokerData o = new RogueCardSaveJokerData();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: RogueCard.RogueCardSaveJokerData.New");
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
			int id = ((RogueCardSaveJokerData)obj).id;
			LuaDLL.lua_pushinteger(L, id);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index id on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_real_id(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int real_id = ((RogueCardSaveJokerData)obj).real_id;
			LuaDLL.lua_pushinteger(L, real_id);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index real_id on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_version_id(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int version_id = ((RogueCardSaveJokerData)obj).version_id;
			LuaDLL.lua_pushinteger(L, version_id);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index version_id on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_add_point(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int add_point = ((RogueCardSaveJokerData)obj).add_point;
			LuaDLL.lua_pushinteger(L, add_point);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index add_point on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_add_mutli(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int add_mutli = ((RogueCardSaveJokerData)obj).add_mutli;
			LuaDLL.lua_pushinteger(L, add_mutli);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index add_mutli on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_mul_ratio(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int mul_ratio = ((RogueCardSaveJokerData)obj).mul_ratio;
			LuaDLL.lua_pushinteger(L, mul_ratio);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mul_ratio on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_other_data(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<int> other_data = ((RogueCardSaveJokerData)obj).other_data;
			ToLua.PushSealed(L, other_data);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index other_data on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_id(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardSaveJokerData obj2 = (RogueCardSaveJokerData)obj;
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
	private static int set_real_id(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardSaveJokerData obj2 = (RogueCardSaveJokerData)obj;
			int real_id = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.real_id = real_id;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index real_id on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_version_id(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardSaveJokerData obj2 = (RogueCardSaveJokerData)obj;
			int version_id = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.version_id = version_id;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index version_id on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_add_point(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardSaveJokerData obj2 = (RogueCardSaveJokerData)obj;
			int add_point = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.add_point = add_point;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index add_point on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_add_mutli(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardSaveJokerData obj2 = (RogueCardSaveJokerData)obj;
			int add_mutli = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.add_mutli = add_mutli;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index add_mutli on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_mul_ratio(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardSaveJokerData obj2 = (RogueCardSaveJokerData)obj;
			int mul_ratio = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.mul_ratio = mul_ratio;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mul_ratio on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_other_data(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardSaveJokerData obj2 = (RogueCardSaveJokerData)obj;
			List<int> other_data = (List<int>)ToLua.CheckObject(L, 2, typeof(List<int>));
			obj2.other_data = other_data;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index other_data on a nil value");
		}
	}
}
