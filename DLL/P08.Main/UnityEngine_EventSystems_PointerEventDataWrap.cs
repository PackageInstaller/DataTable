using System;
using System.Collections.Generic;
using LuaInterface;
using UnityEngine;
using UnityEngine.EventSystems;

public class UnityEngine_EventSystems_PointerEventDataWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(PointerEventData), typeof(BaseEventData));
		L.RegFunction("IsPointerMoving", IsPointerMoving);
		L.RegFunction("IsScrolling", IsScrolling);
		L.RegFunction("ToString", ToString);
		L.RegFunction("New", _CreateUnityEngine_EventSystems_PointerEventData);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("hovered", get_hovered, set_hovered);
		L.RegVar("pointerEnter", get_pointerEnter, set_pointerEnter);
		L.RegVar("lastPress", get_lastPress, null);
		L.RegVar("rawPointerPress", get_rawPointerPress, set_rawPointerPress);
		L.RegVar("pointerDrag", get_pointerDrag, set_pointerDrag);
		L.RegVar("pointerCurrentRaycast", get_pointerCurrentRaycast, set_pointerCurrentRaycast);
		L.RegVar("pointerPressRaycast", get_pointerPressRaycast, set_pointerPressRaycast);
		L.RegVar("eligibleForClick", get_eligibleForClick, set_eligibleForClick);
		L.RegVar("pointerId", get_pointerId, set_pointerId);
		L.RegVar("position", get_position, set_position);
		L.RegVar("delta", get_delta, set_delta);
		L.RegVar("pressPosition", get_pressPosition, set_pressPosition);
		L.RegVar("clickTime", get_clickTime, set_clickTime);
		L.RegVar("clickCount", get_clickCount, set_clickCount);
		L.RegVar("scrollDelta", get_scrollDelta, set_scrollDelta);
		L.RegVar("useDragThreshold", get_useDragThreshold, set_useDragThreshold);
		L.RegVar("dragging", get_dragging, set_dragging);
		L.RegVar("button", get_button, set_button);
		L.RegVar("enterEventCamera", get_enterEventCamera, null);
		L.RegVar("pressEventCamera", get_pressEventCamera, null);
		L.RegVar("pointerPress", get_pointerPress, set_pointerPress);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateUnityEngine_EventSystems_PointerEventData(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 1)
			{
				PointerEventData o = new PointerEventData((EventSystem)ToLua.CheckObject<EventSystem>(L, 1));
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: UnityEngine.EventSystems.PointerEventData.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IsPointerMoving(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = ((PointerEventData)ToLua.CheckObject<PointerEventData>(L, 1)).IsPointerMoving();
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IsScrolling(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = ((PointerEventData)ToLua.CheckObject<PointerEventData>(L, 1)).IsScrolling();
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ToString(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			string str = ((PointerEventData)ToLua.CheckObject<PointerEventData>(L, 1)).ToString();
			LuaDLL.lua_pushstring(L, str);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_hovered(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<GameObject> hovered = ((PointerEventData)obj).hovered;
			ToLua.PushSealed(L, hovered);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index hovered on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_pointerEnter(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GameObject pointerEnter = ((PointerEventData)obj).pointerEnter;
			ToLua.PushSealed(L, pointerEnter);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index pointerEnter on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_lastPress(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GameObject lastPress = ((PointerEventData)obj).lastPress;
			ToLua.PushSealed(L, lastPress);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index lastPress on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_rawPointerPress(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GameObject rawPointerPress = ((PointerEventData)obj).rawPointerPress;
			ToLua.PushSealed(L, rawPointerPress);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index rawPointerPress on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_pointerDrag(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GameObject pointerDrag = ((PointerEventData)obj).pointerDrag;
			ToLua.PushSealed(L, pointerDrag);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index pointerDrag on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_pointerCurrentRaycast(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RaycastResult pointerCurrentRaycast = ((PointerEventData)obj).pointerCurrentRaycast;
			ToLua.PushValue(L, pointerCurrentRaycast);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index pointerCurrentRaycast on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_pointerPressRaycast(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RaycastResult pointerPressRaycast = ((PointerEventData)obj).pointerPressRaycast;
			ToLua.PushValue(L, pointerPressRaycast);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index pointerPressRaycast on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_eligibleForClick(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool eligibleForClick = ((PointerEventData)obj).eligibleForClick;
			LuaDLL.lua_pushboolean(L, eligibleForClick);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index eligibleForClick on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_pointerId(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int pointerId = ((PointerEventData)obj).pointerId;
			LuaDLL.lua_pushinteger(L, pointerId);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index pointerId on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_position(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector2 position = ((PointerEventData)obj).position;
			ToLua.Push(L, position);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index position on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_delta(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector2 delta = ((PointerEventData)obj).delta;
			ToLua.Push(L, delta);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index delta on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_pressPosition(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector2 pressPosition = ((PointerEventData)obj).pressPosition;
			ToLua.Push(L, pressPosition);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index pressPosition on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_clickTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float clickTime = ((PointerEventData)obj).clickTime;
			LuaDLL.lua_pushnumber(L, clickTime);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index clickTime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_clickCount(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int clickCount = ((PointerEventData)obj).clickCount;
			LuaDLL.lua_pushinteger(L, clickCount);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index clickCount on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_scrollDelta(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector2 scrollDelta = ((PointerEventData)obj).scrollDelta;
			ToLua.Push(L, scrollDelta);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index scrollDelta on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_useDragThreshold(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool useDragThreshold = ((PointerEventData)obj).useDragThreshold;
			LuaDLL.lua_pushboolean(L, useDragThreshold);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index useDragThreshold on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_dragging(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool dragging = ((PointerEventData)obj).dragging;
			LuaDLL.lua_pushboolean(L, dragging);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index dragging on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_button(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PointerEventData.InputButton button = ((PointerEventData)obj).button;
			ToLua.Push(L, button);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index button on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_enterEventCamera(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Camera enterEventCamera = ((PointerEventData)obj).enterEventCamera;
			ToLua.PushSealed(L, enterEventCamera);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index enterEventCamera on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_pressEventCamera(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Camera pressEventCamera = ((PointerEventData)obj).pressEventCamera;
			ToLua.PushSealed(L, pressEventCamera);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index pressEventCamera on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_pointerPress(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GameObject pointerPress = ((PointerEventData)obj).pointerPress;
			ToLua.PushSealed(L, pointerPress);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index pointerPress on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_hovered(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PointerEventData obj2 = (PointerEventData)obj;
			List<GameObject> hovered = (List<GameObject>)ToLua.CheckObject(L, 2, typeof(List<GameObject>));
			obj2.hovered = hovered;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index hovered on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_pointerEnter(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PointerEventData obj2 = (PointerEventData)obj;
			GameObject pointerEnter = (GameObject)ToLua.CheckObject(L, 2, typeof(GameObject));
			obj2.pointerEnter = pointerEnter;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index pointerEnter on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_rawPointerPress(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PointerEventData obj2 = (PointerEventData)obj;
			GameObject rawPointerPress = (GameObject)ToLua.CheckObject(L, 2, typeof(GameObject));
			obj2.rawPointerPress = rawPointerPress;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index rawPointerPress on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_pointerDrag(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PointerEventData obj2 = (PointerEventData)obj;
			GameObject pointerDrag = (GameObject)ToLua.CheckObject(L, 2, typeof(GameObject));
			obj2.pointerDrag = pointerDrag;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index pointerDrag on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_pointerCurrentRaycast(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PointerEventData obj2 = (PointerEventData)obj;
			RaycastResult pointerCurrentRaycast = StackTraits<RaycastResult>.Check(L, 2);
			obj2.pointerCurrentRaycast = pointerCurrentRaycast;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index pointerCurrentRaycast on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_pointerPressRaycast(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PointerEventData obj2 = (PointerEventData)obj;
			RaycastResult pointerPressRaycast = StackTraits<RaycastResult>.Check(L, 2);
			obj2.pointerPressRaycast = pointerPressRaycast;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index pointerPressRaycast on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_eligibleForClick(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PointerEventData obj2 = (PointerEventData)obj;
			bool eligibleForClick = LuaDLL.luaL_checkboolean(L, 2);
			obj2.eligibleForClick = eligibleForClick;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index eligibleForClick on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_pointerId(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PointerEventData obj2 = (PointerEventData)obj;
			int pointerId = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.pointerId = pointerId;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index pointerId on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_position(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PointerEventData obj2 = (PointerEventData)obj;
			Vector2 position = ToLua.ToVector2(L, 2);
			obj2.position = position;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index position on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_delta(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PointerEventData obj2 = (PointerEventData)obj;
			Vector2 delta = ToLua.ToVector2(L, 2);
			obj2.delta = delta;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index delta on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_pressPosition(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PointerEventData obj2 = (PointerEventData)obj;
			Vector2 pressPosition = ToLua.ToVector2(L, 2);
			obj2.pressPosition = pressPosition;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index pressPosition on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_clickTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PointerEventData obj2 = (PointerEventData)obj;
			float clickTime = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.clickTime = clickTime;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index clickTime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_clickCount(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PointerEventData obj2 = (PointerEventData)obj;
			int clickCount = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.clickCount = clickCount;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index clickCount on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_scrollDelta(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PointerEventData obj2 = (PointerEventData)obj;
			Vector2 scrollDelta = ToLua.ToVector2(L, 2);
			obj2.scrollDelta = scrollDelta;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index scrollDelta on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_useDragThreshold(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PointerEventData obj2 = (PointerEventData)obj;
			bool useDragThreshold = LuaDLL.luaL_checkboolean(L, 2);
			obj2.useDragThreshold = useDragThreshold;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index useDragThreshold on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_dragging(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PointerEventData obj2 = (PointerEventData)obj;
			bool dragging = LuaDLL.luaL_checkboolean(L, 2);
			obj2.dragging = dragging;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index dragging on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_button(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PointerEventData obj2 = (PointerEventData)obj;
			PointerEventData.InputButton button = (PointerEventData.InputButton)ToLua.CheckObject(L, 2, typeof(PointerEventData.InputButton));
			obj2.button = button;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index button on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_pointerPress(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PointerEventData obj2 = (PointerEventData)obj;
			GameObject pointerPress = (GameObject)ToLua.CheckObject(L, 2, typeof(GameObject));
			obj2.pointerPress = pointerPress;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index pointerPress on a nil value");
		}
	}
}
