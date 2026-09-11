using System;
using LuaInterface;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Events;

public class InputFieldExtWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(InputFieldExt), typeof(MonoBehaviour));
		L.RegFunction("AddEventTrigger", AddEventTrigger);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("eventTrigger", get_eventTrigger, null);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int AddEventTrigger(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			InputFieldExt obj = (InputFieldExt)ToLua.CheckObject<InputFieldExt>(L, 1);
			EventTriggerType eventType = (EventTriggerType)ToLua.CheckObject(L, 2, typeof(EventTriggerType));
			UnityAction<BaseEventData> unityAction = (UnityAction<BaseEventData>)ToLua.CheckDelegate<UnityAction<BaseEventData>>(L, 3);
			obj.AddEventTrigger(eventType, unityAction);
			return 0;
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
	private static int get_eventTrigger(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			EventTrigger eventTrigger = ((InputFieldExt)obj).eventTrigger;
			ToLua.Push(L, eventTrigger);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index eventTrigger on a nil value");
		}
	}
}
