using System;
using LuaInterface;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

public class ScrollRectCastWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(ScrollRectCast), typeof(ScrollRect));
		L.RegFunction("SetParent", SetParent);
		L.RegFunction("OnBeginDrag", OnBeginDrag);
		L.RegFunction("OnDrag", OnDrag);
		L.RegFunction("OnEndDrag", OnEndDrag);
		L.RegFunction("OnScroll", OnScroll);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("m_parent", get_m_parent, set_m_parent);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetParent(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			ScrollRectCast obj = (ScrollRectCast)ToLua.CheckObject<ScrollRectCast>(L, 1);
			GameObject parent = (GameObject)ToLua.CheckObject(L, 2, typeof(GameObject));
			obj.SetParent(parent);
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
			ScrollRectCast obj = (ScrollRectCast)ToLua.CheckObject<ScrollRectCast>(L, 1);
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
			ScrollRectCast obj = (ScrollRectCast)ToLua.CheckObject<ScrollRectCast>(L, 1);
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
			ScrollRectCast obj = (ScrollRectCast)ToLua.CheckObject<ScrollRectCast>(L, 1);
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
	private static int OnScroll(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			ScrollRectCast obj = (ScrollRectCast)ToLua.CheckObject<ScrollRectCast>(L, 1);
			PointerEventData data = (PointerEventData)ToLua.CheckObject<PointerEventData>(L, 2);
			obj.OnScroll(data);
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
	private static int get_m_parent(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GameObject parent = ((ScrollRectCast)obj).m_parent;
			ToLua.PushSealed(L, parent);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index m_parent on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_m_parent(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ScrollRectCast obj2 = (ScrollRectCast)obj;
			GameObject parent = (GameObject)ToLua.CheckObject(L, 2, typeof(GameObject));
			obj2.m_parent = parent;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index m_parent on a nil value");
		}
	}
}
