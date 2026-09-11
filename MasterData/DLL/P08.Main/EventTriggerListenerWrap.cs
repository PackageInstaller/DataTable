using System;
using LuaInterface;
using UnityEngine;
using UnityEngine.EventSystems;

public class EventTriggerListenerWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(EventTriggerListener), typeof(EventTrigger));
		L.RegFunction("Get", Get);
		L.RegFunction("RemoveListenerType", RemoveListenerType);
		L.RegFunction("RemoveAllListeners", RemoveAllListeners);
		L.RegFunction("AddListenerType1", AddListenerType1);
		L.RegFunction("AddListenerType2", AddListenerType2);
		L.RegFunction("AddListenerType3", AddListenerType3);
		L.RegFunction("OnPointerClick", OnPointerClick);
		L.RegFunction("OnPointerEnter", OnPointerEnter);
		L.RegFunction("OnPointerExit", OnPointerExit);
		L.RegFunction("OnPointerDown", OnPointerDown);
		L.RegFunction("OnPointerUp", OnPointerUp);
		L.RegFunction("OnInitializePotentialDrag", OnInitializePotentialDrag);
		L.RegFunction("OnScroll", OnScroll);
		L.RegFunction("OnBeginDrag", OnBeginDrag);
		L.RegFunction("OnDrag", OnDrag);
		L.RegFunction("OnEndDrag", OnEndDrag);
		L.RegFunction("OnDrop", OnDrop);
		L.RegFunction("OnMove", OnMove);
		L.RegFunction("OnSelect", OnSelect);
		L.RegFunction("OnUpdateSelected", OnUpdateSelected);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("onPointerEnter", get_onPointerEnter, set_onPointerEnter);
		L.RegVar("onPointerExit", get_onPointerExit, set_onPointerExit);
		L.RegVar("onPointerDown", get_onPointerDown, set_onPointerDown);
		L.RegVar("onPointerUp", get_onPointerUp, set_onPointerUp);
		L.RegVar("onPointerClick", get_onPointerClick, set_onPointerClick);
		L.RegVar("onInitializePotentialDrag", get_onInitializePotentialDrag, set_onInitializePotentialDrag);
		L.RegVar("onScroll", get_onScroll, set_onScroll);
		L.RegVar("onBeginDrag", get_onBeginDrag, set_onBeginDrag);
		L.RegVar("onDrag", get_onDrag, set_onDrag);
		L.RegVar("onEndDrag", get_onEndDrag, set_onEndDrag);
		L.RegVar("onDrop", get_onDrop, set_onDrop);
		L.RegVar("onSelect", get_onSelect, set_onSelect);
		L.RegVar("onUpdateSelect", get_onUpdateSelect, set_onUpdateSelect);
		L.RegVar("onMove", get_onMove, set_onMove);
		L.RegVar("isPassAll", get_isPassAll, set_isPassAll);
		L.RegVar("isExecuteHierarchy", get_isExecuteHierarchy, set_isExecuteHierarchy);
		L.RegVar("alwaysPassDragToLastDragObject", get_alwaysPassDragToLastDragObject, set_alwaysPassDragToLastDragObject);
		L.RegVar("isPassEvent", get_isPassEvent, set_isPassEvent);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Get(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			EventTriggerListener obj = EventTriggerListener.Get((GameObject)ToLua.CheckObject(L, 1, typeof(GameObject)));
			ToLua.Push(L, obj);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RemoveListenerType(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			EventTriggerListener obj = (EventTriggerListener)ToLua.CheckObject<EventTriggerListener>(L, 1);
			EventTriggerType t = (EventTriggerType)ToLua.CheckObject(L, 2, typeof(EventTriggerType));
			obj.RemoveListenerType(t);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RemoveAllListeners(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((EventTriggerListener)ToLua.CheckObject<EventTriggerListener>(L, 1)).RemoveAllListeners();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int AddListenerType1(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			EventTriggerListener obj = (EventTriggerListener)ToLua.CheckObject<EventTriggerListener>(L, 1);
			EventTriggerType t = (EventTriggerType)ToLua.CheckObject(L, 2, typeof(EventTriggerType));
			LuaHelper.ETLCallBack1 func = (LuaHelper.ETLCallBack1)ToLua.CheckDelegate<LuaHelper.ETLCallBack1>(L, 3);
			obj.AddListenerType1(t, func);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int AddListenerType2(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			EventTriggerListener obj = (EventTriggerListener)ToLua.CheckObject<EventTriggerListener>(L, 1);
			EventTriggerType t = (EventTriggerType)ToLua.CheckObject(L, 2, typeof(EventTriggerType));
			LuaHelper.ETLCallBack2 func = (LuaHelper.ETLCallBack2)ToLua.CheckDelegate<LuaHelper.ETLCallBack2>(L, 3);
			obj.AddListenerType2(t, func);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int AddListenerType3(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			EventTriggerListener obj = (EventTriggerListener)ToLua.CheckObject<EventTriggerListener>(L, 1);
			EventTriggerType t = (EventTriggerType)ToLua.CheckObject(L, 2, typeof(EventTriggerType));
			LuaHelper.ETLCallBack3 func = (LuaHelper.ETLCallBack3)ToLua.CheckDelegate<LuaHelper.ETLCallBack3>(L, 3);
			obj.AddListenerType3(t, func);
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
			EventTriggerListener obj = (EventTriggerListener)ToLua.CheckObject<EventTriggerListener>(L, 1);
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
	private static int OnPointerEnter(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			EventTriggerListener obj = (EventTriggerListener)ToLua.CheckObject<EventTriggerListener>(L, 1);
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
			EventTriggerListener obj = (EventTriggerListener)ToLua.CheckObject<EventTriggerListener>(L, 1);
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
	private static int OnPointerDown(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			EventTriggerListener obj = (EventTriggerListener)ToLua.CheckObject<EventTriggerListener>(L, 1);
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
			EventTriggerListener obj = (EventTriggerListener)ToLua.CheckObject<EventTriggerListener>(L, 1);
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
	private static int OnInitializePotentialDrag(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			EventTriggerListener obj = (EventTriggerListener)ToLua.CheckObject<EventTriggerListener>(L, 1);
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
	private static int OnScroll(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			EventTriggerListener obj = (EventTriggerListener)ToLua.CheckObject<EventTriggerListener>(L, 1);
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
	private static int OnBeginDrag(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			EventTriggerListener obj = (EventTriggerListener)ToLua.CheckObject<EventTriggerListener>(L, 1);
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
	private static int OnDrag(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			EventTriggerListener obj = (EventTriggerListener)ToLua.CheckObject<EventTriggerListener>(L, 1);
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
	private static int OnEndDrag(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			EventTriggerListener obj = (EventTriggerListener)ToLua.CheckObject<EventTriggerListener>(L, 1);
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
	private static int OnDrop(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			EventTriggerListener obj = (EventTriggerListener)ToLua.CheckObject<EventTriggerListener>(L, 1);
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
	private static int OnMove(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			EventTriggerListener obj = (EventTriggerListener)ToLua.CheckObject<EventTriggerListener>(L, 1);
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
	private static int OnSelect(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			EventTriggerListener obj = (EventTriggerListener)ToLua.CheckObject<EventTriggerListener>(L, 1);
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
	private static int OnUpdateSelected(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			EventTriggerListener obj = (EventTriggerListener)ToLua.CheckObject<EventTriggerListener>(L, 1);
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
	private static int get_onPointerEnter(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LuaHelper.ETLCallBack1 onPointerEnter = ((EventTriggerListener)obj).onPointerEnter;
			ToLua.Push(L, onPointerEnter);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index onPointerEnter on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_onPointerExit(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LuaHelper.ETLCallBack1 onPointerExit = ((EventTriggerListener)obj).onPointerExit;
			ToLua.Push(L, onPointerExit);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index onPointerExit on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_onPointerDown(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LuaHelper.ETLCallBack1 onPointerDown = ((EventTriggerListener)obj).onPointerDown;
			ToLua.Push(L, onPointerDown);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index onPointerDown on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_onPointerUp(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LuaHelper.ETLCallBack1 onPointerUp = ((EventTriggerListener)obj).onPointerUp;
			ToLua.Push(L, onPointerUp);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index onPointerUp on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_onPointerClick(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LuaHelper.ETLCallBack1 onPointerClick = ((EventTriggerListener)obj).onPointerClick;
			ToLua.Push(L, onPointerClick);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index onPointerClick on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_onInitializePotentialDrag(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LuaHelper.ETLCallBack1 onInitializePotentialDrag = ((EventTriggerListener)obj).onInitializePotentialDrag;
			ToLua.Push(L, onInitializePotentialDrag);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index onInitializePotentialDrag on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_onScroll(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LuaHelper.ETLCallBack1 onScroll = ((EventTriggerListener)obj).onScroll;
			ToLua.Push(L, onScroll);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index onScroll on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_onBeginDrag(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LuaHelper.ETLCallBack1 onBeginDrag = ((EventTriggerListener)obj).onBeginDrag;
			ToLua.Push(L, onBeginDrag);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index onBeginDrag on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_onDrag(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LuaHelper.ETLCallBack1 onDrag = ((EventTriggerListener)obj).onDrag;
			ToLua.Push(L, onDrag);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index onDrag on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_onEndDrag(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LuaHelper.ETLCallBack1 onEndDrag = ((EventTriggerListener)obj).onEndDrag;
			ToLua.Push(L, onEndDrag);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index onEndDrag on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_onDrop(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LuaHelper.ETLCallBack1 onDrop = ((EventTriggerListener)obj).onDrop;
			ToLua.Push(L, onDrop);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index onDrop on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_onSelect(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LuaHelper.ETLCallBack2 onSelect = ((EventTriggerListener)obj).onSelect;
			ToLua.Push(L, onSelect);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index onSelect on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_onUpdateSelect(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LuaHelper.ETLCallBack2 onUpdateSelect = ((EventTriggerListener)obj).onUpdateSelect;
			ToLua.Push(L, onUpdateSelect);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index onUpdateSelect on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_onMove(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LuaHelper.ETLCallBack3 onMove = ((EventTriggerListener)obj).onMove;
			ToLua.Push(L, onMove);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index onMove on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isPassAll(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isPassAll = ((EventTriggerListener)obj).isPassAll;
			LuaDLL.lua_pushboolean(L, isPassAll);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isPassAll on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isExecuteHierarchy(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isExecuteHierarchy = ((EventTriggerListener)obj).isExecuteHierarchy;
			LuaDLL.lua_pushboolean(L, isExecuteHierarchy);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isExecuteHierarchy on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_alwaysPassDragToLastDragObject(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool alwaysPassDragToLastDragObject = ((EventTriggerListener)obj).alwaysPassDragToLastDragObject;
			LuaDLL.lua_pushboolean(L, alwaysPassDragToLastDragObject);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index alwaysPassDragToLastDragObject on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isPassEvent(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isPassEvent = ((EventTriggerListener)obj).isPassEvent;
			LuaDLL.lua_pushboolean(L, isPassEvent);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isPassEvent on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_onPointerEnter(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			EventTriggerListener obj2 = (EventTriggerListener)obj;
			LuaHelper.ETLCallBack1 onPointerEnter = (LuaHelper.ETLCallBack1)ToLua.CheckDelegate<LuaHelper.ETLCallBack1>(L, 2);
			obj2.onPointerEnter = onPointerEnter;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index onPointerEnter on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_onPointerExit(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			EventTriggerListener obj2 = (EventTriggerListener)obj;
			LuaHelper.ETLCallBack1 onPointerExit = (LuaHelper.ETLCallBack1)ToLua.CheckDelegate<LuaHelper.ETLCallBack1>(L, 2);
			obj2.onPointerExit = onPointerExit;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index onPointerExit on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_onPointerDown(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			EventTriggerListener obj2 = (EventTriggerListener)obj;
			LuaHelper.ETLCallBack1 onPointerDown = (LuaHelper.ETLCallBack1)ToLua.CheckDelegate<LuaHelper.ETLCallBack1>(L, 2);
			obj2.onPointerDown = onPointerDown;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index onPointerDown on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_onPointerUp(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			EventTriggerListener obj2 = (EventTriggerListener)obj;
			LuaHelper.ETLCallBack1 onPointerUp = (LuaHelper.ETLCallBack1)ToLua.CheckDelegate<LuaHelper.ETLCallBack1>(L, 2);
			obj2.onPointerUp = onPointerUp;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index onPointerUp on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_onPointerClick(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			EventTriggerListener obj2 = (EventTriggerListener)obj;
			LuaHelper.ETLCallBack1 onPointerClick = (LuaHelper.ETLCallBack1)ToLua.CheckDelegate<LuaHelper.ETLCallBack1>(L, 2);
			obj2.onPointerClick = onPointerClick;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index onPointerClick on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_onInitializePotentialDrag(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			EventTriggerListener obj2 = (EventTriggerListener)obj;
			LuaHelper.ETLCallBack1 onInitializePotentialDrag = (LuaHelper.ETLCallBack1)ToLua.CheckDelegate<LuaHelper.ETLCallBack1>(L, 2);
			obj2.onInitializePotentialDrag = onInitializePotentialDrag;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index onInitializePotentialDrag on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_onScroll(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			EventTriggerListener obj2 = (EventTriggerListener)obj;
			LuaHelper.ETLCallBack1 onScroll = (LuaHelper.ETLCallBack1)ToLua.CheckDelegate<LuaHelper.ETLCallBack1>(L, 2);
			obj2.onScroll = onScroll;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index onScroll on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_onBeginDrag(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			EventTriggerListener obj2 = (EventTriggerListener)obj;
			LuaHelper.ETLCallBack1 onBeginDrag = (LuaHelper.ETLCallBack1)ToLua.CheckDelegate<LuaHelper.ETLCallBack1>(L, 2);
			obj2.onBeginDrag = onBeginDrag;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index onBeginDrag on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_onDrag(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			EventTriggerListener obj2 = (EventTriggerListener)obj;
			LuaHelper.ETLCallBack1 onDrag = (LuaHelper.ETLCallBack1)ToLua.CheckDelegate<LuaHelper.ETLCallBack1>(L, 2);
			obj2.onDrag = onDrag;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index onDrag on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_onEndDrag(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			EventTriggerListener obj2 = (EventTriggerListener)obj;
			LuaHelper.ETLCallBack1 onEndDrag = (LuaHelper.ETLCallBack1)ToLua.CheckDelegate<LuaHelper.ETLCallBack1>(L, 2);
			obj2.onEndDrag = onEndDrag;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index onEndDrag on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_onDrop(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			EventTriggerListener obj2 = (EventTriggerListener)obj;
			LuaHelper.ETLCallBack1 onDrop = (LuaHelper.ETLCallBack1)ToLua.CheckDelegate<LuaHelper.ETLCallBack1>(L, 2);
			obj2.onDrop = onDrop;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index onDrop on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_onSelect(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			EventTriggerListener obj2 = (EventTriggerListener)obj;
			LuaHelper.ETLCallBack2 onSelect = (LuaHelper.ETLCallBack2)ToLua.CheckDelegate<LuaHelper.ETLCallBack2>(L, 2);
			obj2.onSelect = onSelect;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index onSelect on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_onUpdateSelect(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			EventTriggerListener obj2 = (EventTriggerListener)obj;
			LuaHelper.ETLCallBack2 onUpdateSelect = (LuaHelper.ETLCallBack2)ToLua.CheckDelegate<LuaHelper.ETLCallBack2>(L, 2);
			obj2.onUpdateSelect = onUpdateSelect;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index onUpdateSelect on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_onMove(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			EventTriggerListener obj2 = (EventTriggerListener)obj;
			LuaHelper.ETLCallBack3 onMove = (LuaHelper.ETLCallBack3)ToLua.CheckDelegate<LuaHelper.ETLCallBack3>(L, 2);
			obj2.onMove = onMove;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index onMove on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_isPassAll(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			EventTriggerListener obj2 = (EventTriggerListener)obj;
			bool isPassAll = LuaDLL.luaL_checkboolean(L, 2);
			obj2.isPassAll = isPassAll;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isPassAll on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_isExecuteHierarchy(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			EventTriggerListener obj2 = (EventTriggerListener)obj;
			bool isExecuteHierarchy = LuaDLL.luaL_checkboolean(L, 2);
			obj2.isExecuteHierarchy = isExecuteHierarchy;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isExecuteHierarchy on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_alwaysPassDragToLastDragObject(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			EventTriggerListener obj2 = (EventTriggerListener)obj;
			bool alwaysPassDragToLastDragObject = LuaDLL.luaL_checkboolean(L, 2);
			obj2.alwaysPassDragToLastDragObject = alwaysPassDragToLastDragObject;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index alwaysPassDragToLastDragObject on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_isPassEvent(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			EventTriggerListener obj2 = (EventTriggerListener)obj;
			bool isPassEvent = LuaDLL.luaL_checkboolean(L, 2);
			obj2.isPassEvent = isPassEvent;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isPassEvent on a nil value");
		}
	}
}
