using System;
using System.Collections.Generic;
using LuaInterface;
using UnityEngine;
using UnityEngine.EventSystems;

public class UnityEngine_EventSystems_PhysicsRaycasterWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(PhysicsRaycaster), typeof(BaseRaycaster));
		L.RegFunction("Raycast", Raycast);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("eventCamera", get_eventCamera, null);
		L.RegVar("depth", get_depth, null);
		L.RegVar("finalEventMask", get_finalEventMask, null);
		L.RegVar("eventMask", get_eventMask, set_eventMask);
		L.RegVar("maxRayIntersections", get_maxRayIntersections, set_maxRayIntersections);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Raycast(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			PhysicsRaycaster obj = (PhysicsRaycaster)ToLua.CheckObject<PhysicsRaycaster>(L, 1);
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
			Camera eventCamera = ((PhysicsRaycaster)obj).eventCamera;
			ToLua.PushSealed(L, eventCamera);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index eventCamera on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_depth(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int depth = ((PhysicsRaycaster)obj).depth;
			LuaDLL.lua_pushinteger(L, depth);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index depth on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_finalEventMask(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int finalEventMask = ((PhysicsRaycaster)obj).finalEventMask;
			LuaDLL.lua_pushinteger(L, finalEventMask);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index finalEventMask on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_eventMask(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LayerMask eventMask = ((PhysicsRaycaster)obj).eventMask;
			ToLua.PushLayerMask(L, eventMask);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index eventMask on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_maxRayIntersections(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int maxRayIntersections = ((PhysicsRaycaster)obj).maxRayIntersections;
			LuaDLL.lua_pushinteger(L, maxRayIntersections);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index maxRayIntersections on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_eventMask(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PhysicsRaycaster obj2 = (PhysicsRaycaster)obj;
			LayerMask eventMask = ToLua.ToLayerMask(L, 2);
			obj2.eventMask = eventMask;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index eventMask on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_maxRayIntersections(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PhysicsRaycaster obj2 = (PhysicsRaycaster)obj;
			int maxRayIntersections = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.maxRayIntersections = maxRayIntersections;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index maxRayIntersections on a nil value");
		}
	}
}
