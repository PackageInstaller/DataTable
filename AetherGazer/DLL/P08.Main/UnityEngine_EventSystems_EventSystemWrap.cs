using System;
using System.Collections.Generic;
using LuaInterface;
using UnityEngine;
using UnityEngine.EventSystems;

public class UnityEngine_EventSystems_EventSystemWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(EventSystem), typeof(UIBehaviour));
		L.RegFunction("UpdateModules", UpdateModules);
		L.RegFunction("SetSelectedGameObject", SetSelectedGameObject);
		L.RegFunction("RaycastAll", RaycastAll);
		L.RegFunction("IsPointerOverGameObject", IsPointerOverGameObject);
		L.RegFunction("ToString", ToString);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("current", get_current, set_current);
		L.RegVar("sendNavigationEvents", get_sendNavigationEvents, set_sendNavigationEvents);
		L.RegVar("pixelDragThreshold", get_pixelDragThreshold, set_pixelDragThreshold);
		L.RegVar("currentInputModule", get_currentInputModule, null);
		L.RegVar("firstSelectedGameObject", get_firstSelectedGameObject, set_firstSelectedGameObject);
		L.RegVar("currentSelectedGameObject", get_currentSelectedGameObject, null);
		L.RegVar("isFocused", get_isFocused, null);
		L.RegVar("alreadySelecting", get_alreadySelecting, null);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UpdateModules(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((EventSystem)ToLua.CheckObject<EventSystem>(L, 1)).UpdateModules();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetSelectedGameObject(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				EventSystem obj2 = (EventSystem)ToLua.CheckObject<EventSystem>(L, 1);
				GameObject selectedGameObject = (GameObject)ToLua.CheckObject(L, 2, typeof(GameObject));
				obj2.SetSelectedGameObject(selectedGameObject);
				return 0;
			}
			case 3:
			{
				EventSystem obj = (EventSystem)ToLua.CheckObject<EventSystem>(L, 1);
				GameObject selected = (GameObject)ToLua.CheckObject(L, 2, typeof(GameObject));
				BaseEventData pointer = (BaseEventData)ToLua.CheckObject<BaseEventData>(L, 3);
				obj.SetSelectedGameObject(selected, pointer);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.EventSystems.EventSystem.SetSelectedGameObject");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RaycastAll(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			EventSystem obj = (EventSystem)ToLua.CheckObject<EventSystem>(L, 1);
			PointerEventData eventData = (PointerEventData)ToLua.CheckObject<PointerEventData>(L, 2);
			List<RaycastResult> raycastResults = (List<RaycastResult>)ToLua.CheckObject(L, 3, typeof(List<RaycastResult>));
			obj.RaycastAll(eventData, raycastResults);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IsPointerOverGameObject(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
			{
				bool value2 = ((EventSystem)ToLua.CheckObject<EventSystem>(L, 1)).IsPointerOverGameObject();
				LuaDLL.lua_pushboolean(L, value2);
				return 1;
			}
			case 2:
			{
				EventSystem obj = (EventSystem)ToLua.CheckObject<EventSystem>(L, 1);
				int pointerId = (int)LuaDLL.luaL_checknumber(L, 2);
				bool value = obj.IsPointerOverGameObject(pointerId);
				LuaDLL.lua_pushboolean(L, value);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.EventSystems.EventSystem.IsPointerOverGameObject");
			}
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
			string str = ((EventSystem)ToLua.CheckObject<EventSystem>(L, 1)).ToString();
			LuaDLL.lua_pushstring(L, str);
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
	private static int get_current(IntPtr L)
	{
		try
		{
			ToLua.Push(L, EventSystem.current);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_sendNavigationEvents(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool sendNavigationEvents = ((EventSystem)obj).sendNavigationEvents;
			LuaDLL.lua_pushboolean(L, sendNavigationEvents);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index sendNavigationEvents on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_pixelDragThreshold(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int pixelDragThreshold = ((EventSystem)obj).pixelDragThreshold;
			LuaDLL.lua_pushinteger(L, pixelDragThreshold);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index pixelDragThreshold on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_currentInputModule(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BaseInputModule currentInputModule = ((EventSystem)obj).currentInputModule;
			ToLua.Push(L, currentInputModule);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index currentInputModule on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_firstSelectedGameObject(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GameObject firstSelectedGameObject = ((EventSystem)obj).firstSelectedGameObject;
			ToLua.PushSealed(L, firstSelectedGameObject);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index firstSelectedGameObject on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_currentSelectedGameObject(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GameObject currentSelectedGameObject = ((EventSystem)obj).currentSelectedGameObject;
			ToLua.PushSealed(L, currentSelectedGameObject);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index currentSelectedGameObject on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isFocused(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isFocused = ((EventSystem)obj).isFocused;
			LuaDLL.lua_pushboolean(L, isFocused);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isFocused on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_alreadySelecting(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool alreadySelecting = ((EventSystem)obj).alreadySelecting;
			LuaDLL.lua_pushboolean(L, alreadySelecting);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index alreadySelecting on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_current(IntPtr L)
	{
		try
		{
			EventSystem.current = (EventSystem)ToLua.CheckObject<EventSystem>(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_sendNavigationEvents(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			EventSystem obj2 = (EventSystem)obj;
			bool sendNavigationEvents = LuaDLL.luaL_checkboolean(L, 2);
			obj2.sendNavigationEvents = sendNavigationEvents;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index sendNavigationEvents on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_pixelDragThreshold(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			EventSystem obj2 = (EventSystem)obj;
			int pixelDragThreshold = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.pixelDragThreshold = pixelDragThreshold;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index pixelDragThreshold on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_firstSelectedGameObject(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			EventSystem obj2 = (EventSystem)obj;
			GameObject firstSelectedGameObject = (GameObject)ToLua.CheckObject(L, 2, typeof(GameObject));
			obj2.firstSelectedGameObject = firstSelectedGameObject;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index firstSelectedGameObject on a nil value");
		}
	}
}
