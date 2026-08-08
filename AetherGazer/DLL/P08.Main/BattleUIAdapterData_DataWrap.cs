using System;
using LuaInterface;
using UnityEngine;

public class BattleUIAdapterData_DataWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(BattleUIAdapterData.Data), typeof(object));
		L.RegFunction("New", _CreateBattleUIAdapterData_Data);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("path", get_path, set_path);
		L.RegVar("offest", get_offest, set_offest);
		L.RegVar("scale", get_scale, set_scale);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateBattleUIAdapterData_Data(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				BattleUIAdapterData.Data o = new BattleUIAdapterData.Data();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: BattleUIAdapterData.Data.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_path(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string path = ((BattleUIAdapterData.Data)obj).path;
			LuaDLL.lua_pushstring(L, path);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index path on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_offest(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector2 offest = ((BattleUIAdapterData.Data)obj).offest;
			ToLua.Push(L, offest);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index offest on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_scale(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float scale = ((BattleUIAdapterData.Data)obj).scale;
			LuaDLL.lua_pushnumber(L, scale);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index scale on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_path(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BattleUIAdapterData.Data obj2 = (BattleUIAdapterData.Data)obj;
			string path = ToLua.CheckString(L, 2);
			obj2.path = path;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index path on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_offest(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BattleUIAdapterData.Data obj2 = (BattleUIAdapterData.Data)obj;
			Vector2 offest = ToLua.ToVector2(L, 2);
			obj2.offest = offest;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index offest on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_scale(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BattleUIAdapterData.Data obj2 = (BattleUIAdapterData.Data)obj;
			float scale = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.scale = scale;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index scale on a nil value");
		}
	}
}
