using System;
using System.Collections.Generic;
using LuaInterface;
using UnityEngine;
using UnityEngine.EventSystems;

public class UnityEngine_EventSystems_BaseRaycasterWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(BaseRaycaster), typeof(UIBehaviour));
		L.RegFunction("Raycast", Raycast);
		L.RegFunction("ToString", ToString);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("eventCamera", get_eventCamera, null);
		L.RegVar("sortOrderPriority", get_sortOrderPriority, null);
		L.RegVar("renderOrderPriority", get_renderOrderPriority, null);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Raycast(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			BaseRaycaster obj = (BaseRaycaster)ToLua.CheckObject<BaseRaycaster>(L, 1);
			PointerEventData eventData = (PointerEventData)ToLua.CheckObject<PointerEventData>(L, 2);
			List<RaycastResult> resultAppendList = (List<RaycastResult>)ToLua.CheckObject(L, 3, typeof(List<RaycastResult>));
			obj.Raycast(eventData, resultAppendList);
			return 0;
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
			string str = ((BaseRaycaster)ToLua.CheckObject<BaseRaycaster>(L, 1)).ToString();
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
	private static int get_eventCamera(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Camera eventCamera = ((BaseRaycaster)obj).eventCamera;
			ToLua.PushSealed(L, eventCamera);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index eventCamera on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_sortOrderPriority(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int sortOrderPriority = ((BaseRaycaster)obj).sortOrderPriority;
			LuaDLL.lua_pushinteger(L, sortOrderPriority);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index sortOrderPriority on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_renderOrderPriority(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int renderOrderPriority = ((BaseRaycaster)obj).renderOrderPriority;
			LuaDLL.lua_pushinteger(L, renderOrderPriority);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index renderOrderPriority on a nil value");
		}
	}
}
