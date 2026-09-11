using System;
using LuaInterface;
using UnityEngine;
using UnityEngine.EventSystems;

public class UnityEngine_EventSystems_BaseEventDataWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(BaseEventData), typeof(AbstractEventData));
		L.RegFunction("New", _CreateUnityEngine_EventSystems_BaseEventData);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("currentInputModule", get_currentInputModule, null);
		L.RegVar("selectedObject", get_selectedObject, set_selectedObject);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateUnityEngine_EventSystems_BaseEventData(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 1)
			{
				BaseEventData o = new BaseEventData((EventSystem)ToLua.CheckObject<EventSystem>(L, 1));
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: UnityEngine.EventSystems.BaseEventData.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_currentInputModule(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BaseInputModule currentInputModule = ((BaseEventData)obj).currentInputModule;
			ToLua.Push(L, currentInputModule);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index currentInputModule on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_selectedObject(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GameObject selectedObject = ((BaseEventData)obj).selectedObject;
			ToLua.PushSealed(L, selectedObject);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index selectedObject on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_selectedObject(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BaseEventData obj2 = (BaseEventData)obj;
			GameObject selectedObject = (GameObject)ToLua.CheckObject(L, 2, typeof(GameObject));
			obj2.selectedObject = selectedObject;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index selectedObject on a nil value");
		}
	}
}
