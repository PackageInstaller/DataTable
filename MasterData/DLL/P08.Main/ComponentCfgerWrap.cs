using System;
using System.Collections.Generic;
using LuaInterface;
using UnityEngine;

public class ComponentCfgerWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(ComponentCfger), typeof(MonoBehaviour));
		L.RegFunction("GetLuaNames", GetLuaNames);
		L.RegFunction("GetComponentValues", GetComponentValues);
		L.RegFunction("GetGuideLuaNames", GetGuideLuaNames);
		L.RegFunction("GetGuideComponentValues", GetGuideComponentValues);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("componentList", get_componentList, set_componentList);
		L.RegVar("guideComponentList", get_guideComponentList, set_guideComponentList);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetLuaNames(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			string[] luaNames = ((ComponentCfger)ToLua.CheckObject<ComponentCfger>(L, 1)).GetLuaNames();
			ToLua.Push(L, luaNames);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetComponentValues(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			UnityEngine.Object[] componentValues = ((ComponentCfger)ToLua.CheckObject<ComponentCfger>(L, 1)).GetComponentValues();
			ToLua.Push(L, componentValues);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetGuideLuaNames(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			string[] guideLuaNames = ((ComponentCfger)ToLua.CheckObject<ComponentCfger>(L, 1)).GetGuideLuaNames();
			ToLua.Push(L, guideLuaNames);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetGuideComponentValues(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			UnityEngine.Object[] guideComponentValues = ((ComponentCfger)ToLua.CheckObject<ComponentCfger>(L, 1)).GetGuideComponentValues();
			ToLua.Push(L, guideComponentValues);
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
	private static int get_componentList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<ComponentCfger.ComponentField> componentList = ((ComponentCfger)obj).componentList;
			ToLua.PushSealed(L, componentList);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index componentList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_guideComponentList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<ComponentCfger.ComponentField> guideComponentList = ((ComponentCfger)obj).guideComponentList;
			ToLua.PushSealed(L, guideComponentList);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index guideComponentList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_componentList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ComponentCfger obj2 = (ComponentCfger)obj;
			List<ComponentCfger.ComponentField> componentList = (List<ComponentCfger.ComponentField>)ToLua.CheckObject(L, 2, typeof(List<ComponentCfger.ComponentField>));
			obj2.componentList = componentList;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index componentList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_guideComponentList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ComponentCfger obj2 = (ComponentCfger)obj;
			List<ComponentCfger.ComponentField> guideComponentList = (List<ComponentCfger.ComponentField>)ToLua.CheckObject(L, 2, typeof(List<ComponentCfger.ComponentField>));
			obj2.guideComponentList = guideComponentList;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index guideComponentList on a nil value");
		}
	}
}
