using System;
using System.Collections.Generic;
using LuaInterface;
using UnityEngine;
using UnityEngine.EventSystems;

public class UnityEngine_EventSystems_EventTriggerWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(EventTrigger), typeof(MonoBehaviour));
		L.RegFunction("OnPointerEnter", OnPointerEnter);
		L.RegFunction("OnPointerExit", OnPointerExit);
		L.RegFunction("OnDrag", OnDrag);
		L.RegFunction("OnDrop", OnDrop);
		L.RegFunction("OnPointerDown", OnPointerDown);
		L.RegFunction("OnPointerUp", OnPointerUp);
		L.RegFunction("OnPointerClick", OnPointerClick);
		L.RegFunction("OnSelect", OnSelect);
		L.RegFunction("OnDeselect", OnDeselect);
		L.RegFunction("OnScroll", OnScroll);
		L.RegFunction("OnMove", OnMove);
		L.RegFunction("OnUpdateSelected", OnUpdateSelected);
		L.RegFunction("OnInitializePotentialDrag", OnInitializePotentialDrag);
		L.RegFunction("OnBeginDrag", OnBeginDrag);
		L.RegFunction("OnEndDrag", OnEndDrag);
		L.RegFunction("OnSubmit", OnSubmit);
		L.RegFunction("OnCancel", OnCancel);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("triggers", get_triggers, set_triggers);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OnPointerEnter(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			EventTrigger obj = (EventTrigger)ToLua.CheckObject<EventTrigger>(L, 1);
			PointerEventData eventData = (PointerEventData)ToLua.CheckObject<PointerEventData>(L, 2);
			obj.OnPointerEnter(eventData);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OnPointerExit(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			EventTrigger obj = (EventTrigger)ToLua.CheckObject<EventTrigger>(L, 1);
			PointerEventData eventData = (PointerEventData)ToLua.CheckObject<PointerEventData>(L, 2);
			obj.OnPointerExit(eventData);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OnDrag(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			EventTrigger obj = (EventTrigger)ToLua.CheckObject<EventTrigger>(L, 1);
			PointerEventData eventData = (PointerEventData)ToLua.CheckObject<PointerEventData>(L, 2);
			obj.OnDrag(eventData);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OnDrop(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			EventTrigger obj = (EventTrigger)ToLua.CheckObject<EventTrigger>(L, 1);
			PointerEventData eventData = (PointerEventData)ToLua.CheckObject<PointerEventData>(L, 2);
			obj.OnDrop(eventData);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OnPointerDown(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			EventTrigger obj = (EventTrigger)ToLua.CheckObject<EventTrigger>(L, 1);
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
	private static int OnPointerUp(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			EventTrigger obj = (EventTrigger)ToLua.CheckObject<EventTrigger>(L, 1);
			PointerEventData eventData = (PointerEventData)ToLua.CheckObject<PointerEventData>(L, 2);
			obj.OnPointerUp(eventData);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OnPointerClick(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			EventTrigger obj = (EventTrigger)ToLua.CheckObject<EventTrigger>(L, 1);
			PointerEventData eventData = (PointerEventData)ToLua.CheckObject<PointerEventData>(L, 2);
			obj.OnPointerClick(eventData);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OnSelect(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			EventTrigger obj = (EventTrigger)ToLua.CheckObject<EventTrigger>(L, 1);
			BaseEventData eventData = (BaseEventData)ToLua.CheckObject<BaseEventData>(L, 2);
			obj.OnSelect(eventData);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OnDeselect(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			EventTrigger obj = (EventTrigger)ToLua.CheckObject<EventTrigger>(L, 1);
			BaseEventData eventData = (BaseEventData)ToLua.CheckObject<BaseEventData>(L, 2);
			obj.OnDeselect(eventData);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OnScroll(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			EventTrigger obj = (EventTrigger)ToLua.CheckObject<EventTrigger>(L, 1);
			PointerEventData eventData = (PointerEventData)ToLua.CheckObject<PointerEventData>(L, 2);
			obj.OnScroll(eventData);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OnMove(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			EventTrigger obj = (EventTrigger)ToLua.CheckObject<EventTrigger>(L, 1);
			AxisEventData eventData = (AxisEventData)ToLua.CheckObject<AxisEventData>(L, 2);
			obj.OnMove(eventData);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OnUpdateSelected(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			EventTrigger obj = (EventTrigger)ToLua.CheckObject<EventTrigger>(L, 1);
			BaseEventData eventData = (BaseEventData)ToLua.CheckObject<BaseEventData>(L, 2);
			obj.OnUpdateSelected(eventData);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OnInitializePotentialDrag(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			EventTrigger obj = (EventTrigger)ToLua.CheckObject<EventTrigger>(L, 1);
			PointerEventData eventData = (PointerEventData)ToLua.CheckObject<PointerEventData>(L, 2);
			obj.OnInitializePotentialDrag(eventData);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OnBeginDrag(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			EventTrigger obj = (EventTrigger)ToLua.CheckObject<EventTrigger>(L, 1);
			PointerEventData eventData = (PointerEventData)ToLua.CheckObject<PointerEventData>(L, 2);
			obj.OnBeginDrag(eventData);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OnEndDrag(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			EventTrigger obj = (EventTrigger)ToLua.CheckObject<EventTrigger>(L, 1);
			PointerEventData eventData = (PointerEventData)ToLua.CheckObject<PointerEventData>(L, 2);
			obj.OnEndDrag(eventData);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OnSubmit(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			EventTrigger obj = (EventTrigger)ToLua.CheckObject<EventTrigger>(L, 1);
			BaseEventData eventData = (BaseEventData)ToLua.CheckObject<BaseEventData>(L, 2);
			obj.OnSubmit(eventData);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OnCancel(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			EventTrigger obj = (EventTrigger)ToLua.CheckObject<EventTrigger>(L, 1);
			BaseEventData eventData = (BaseEventData)ToLua.CheckObject<BaseEventData>(L, 2);
			obj.OnCancel(eventData);
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
	private static int get_triggers(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<EventTrigger.Entry> triggers = ((EventTrigger)obj).triggers;
			ToLua.PushSealed(L, triggers);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index triggers on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_triggers(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			EventTrigger obj2 = (EventTrigger)obj;
			List<EventTrigger.Entry> triggers = (List<EventTrigger.Entry>)ToLua.CheckObject(L, 2, typeof(List<EventTrigger.Entry>));
			obj2.triggers = triggers;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index triggers on a nil value");
		}
	}
}
