using System;
using LuaInterface;
using UnityEngine;
using UnityEngine.EventSystems;

public class OnClickDownListenerWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(OnClickDownListener), typeof(MonoBehaviour));
		L.RegFunction("OnPointerDown", OnPointerDown);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("onValueChanged", get_onValueChanged, set_onValueChanged);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OnPointerDown(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			OnClickDownListener obj = (OnClickDownListener)ToLua.CheckObject<OnClickDownListener>(L, 1);
			PointerEventData eventData = (PointerEventData)ToLua.CheckObject<PointerEventData>(L, 2);
			obj.OnPointerDown(eventData);
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
	private static int get_onValueChanged(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			OnClickDownListener.ClickedEvent onValueChanged = ((OnClickDownListener)obj).onValueChanged;
			ToLua.PushObject(L, onValueChanged);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index onValueChanged on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_onValueChanged(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			OnClickDownListener obj2 = (OnClickDownListener)obj;
			OnClickDownListener.ClickedEvent onValueChanged = (OnClickDownListener.ClickedEvent)ToLua.CheckObject<OnClickDownListener.ClickedEvent>(L, 2);
			obj2.onValueChanged = onValueChanged;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index onValueChanged on a nil value");
		}
	}
}
