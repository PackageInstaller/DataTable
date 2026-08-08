using System;
using LuaInterface;
using UnityEngine;

public class ComponentCfger_ComponentFieldWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(ComponentCfger.ComponentField), typeof(object));
		L.RegFunction("New", _CreateComponentCfger_ComponentField);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("go", get_go, set_go);
		L.RegVar("type", get_type, set_type);
		L.RegVar("LuaName", get_LuaName, set_LuaName);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateComponentCfger_ComponentField(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				ComponentCfger.ComponentField o = new ComponentCfger.ComponentField();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: ComponentCfger.ComponentField.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_go(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GameObject go = ((ComponentCfger.ComponentField)obj).go;
			ToLua.PushSealed(L, go);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index go on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_type(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ComponentCfger.UIComponentType type = ((ComponentCfger.ComponentField)obj).type;
			ToLua.Push(L, type);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index type on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_LuaName(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string luaName = ((ComponentCfger.ComponentField)obj).LuaName;
			LuaDLL.lua_pushstring(L, luaName);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index LuaName on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_go(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ComponentCfger.ComponentField obj2 = (ComponentCfger.ComponentField)obj;
			GameObject go = (GameObject)ToLua.CheckObject(L, 2, typeof(GameObject));
			obj2.go = go;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index go on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_type(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ComponentCfger.ComponentField obj2 = (ComponentCfger.ComponentField)obj;
			ComponentCfger.UIComponentType type = (ComponentCfger.UIComponentType)ToLua.CheckObject(L, 2, typeof(ComponentCfger.UIComponentType));
			obj2.type = type;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index type on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_LuaName(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ComponentCfger.ComponentField obj2 = (ComponentCfger.ComponentField)obj;
			string luaName = ToLua.CheckString(L, 2);
			obj2.LuaName = luaName;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index LuaName on a nil value");
		}
	}
}
