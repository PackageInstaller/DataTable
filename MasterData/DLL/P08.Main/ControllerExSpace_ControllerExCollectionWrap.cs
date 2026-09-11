using System;
using System.Collections.Generic;
using ControllerExSpace;
using LuaInterface;
using UnityEngine;

public class ControllerExSpace_ControllerExCollectionWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(ControllerExCollection), typeof(MonoBehaviour));
		L.RegFunction("Add", Add);
		L.RegFunction("Remove", Remove);
		L.RegFunction("GetController", GetController);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("list", get_list, set_list);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Add(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((ControllerExCollection)ToLua.CheckObject<ControllerExCollection>(L, 1)).Add();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Remove(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			ControllerExCollection obj = (ControllerExCollection)ToLua.CheckObject<ControllerExCollection>(L, 1);
			int index = (int)LuaDLL.luaL_checknumber(L, 2);
			obj.Remove(index);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetController(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			ControllerExCollection obj = (ControllerExCollection)ToLua.CheckObject<ControllerExCollection>(L, 1);
			string name = ToLua.CheckString(L, 2);
			ControllerEx controller = obj.GetController(name);
			ToLua.PushObject(L, controller);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int op_Equality(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			UnityEngine.Object obj = (UnityEngine.Object)ToLua.ToObject(L, 1);
			UnityEngine.Object obj2 = (UnityEngine.Object)ToLua.ToObject(L, 2);
			bool value = obj == obj2;
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_list(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<ControllerEx> list = ((ControllerExCollection)obj).list;
			ToLua.PushSealed(L, list);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index list on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_list(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ControllerExCollection obj2 = (ControllerExCollection)obj;
			List<ControllerEx> list = (List<ControllerEx>)ToLua.CheckObject(L, 2, typeof(List<ControllerEx>));
			obj2.list = list;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index list on a nil value");
		}
	}
}
