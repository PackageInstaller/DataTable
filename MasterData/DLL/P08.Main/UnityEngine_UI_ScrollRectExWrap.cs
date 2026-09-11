using System;
using LuaInterface;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

public class UnityEngine_UI_ScrollRectExWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(ScrollRectEx), typeof(ScrollRect));
		L.RegFunction("AddContentPosition", AddContentPosition);
		L.RegFunction("SetContentAnchoredPositionInter", SetContentAnchoredPositionInter);
		L.RegFunction("SetVerticalAnchoredPositionInter", SetVerticalAnchoredPositionInter);
		L.RegFunction("OnDrag", OnDrag);
		L.RegFunction("OnInitializePotentialDrag", OnInitializePotentialDrag);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("ResetPosition", get_ResetPosition, set_ResetPosition);
		L.RegVar("ExitScrollArea", get_ExitScrollArea, set_ExitScrollArea);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int AddContentPosition(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			ScrollRectEx obj = (ScrollRectEx)ToLua.CheckObject<ScrollRectEx>(L, 1);
			Vector2 newPos = ToLua.ToVector2(L, 2);
			obj.AddContentPosition(newPos);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetContentAnchoredPositionInter(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			ScrollRectEx obj = (ScrollRectEx)ToLua.CheckObject<ScrollRectEx>(L, 1);
			Vector2 contentAnchoredPositionInter = ToLua.ToVector2(L, 2);
			obj.SetContentAnchoredPositionInter(contentAnchoredPositionInter);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetVerticalAnchoredPositionInter(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			ScrollRectEx obj = (ScrollRectEx)ToLua.CheckObject<ScrollRectEx>(L, 1);
			float verticalAnchoredPositionInter = (float)LuaDLL.luaL_checknumber(L, 2);
			obj.SetVerticalAnchoredPositionInter(verticalAnchoredPositionInter);
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
			ScrollRectEx obj = (ScrollRectEx)ToLua.CheckObject<ScrollRectEx>(L, 1);
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
	private static int OnInitializePotentialDrag(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			ScrollRectEx obj = (ScrollRectEx)ToLua.CheckObject<ScrollRectEx>(L, 1);
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
	private static int get_ResetPosition(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool resetPosition = ((ScrollRectEx)obj).ResetPosition;
			LuaDLL.lua_pushboolean(L, resetPosition);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index ResetPosition on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_ExitScrollArea(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ScrollRectEx.ExitScrollAreaEvent exitScrollArea = ((ScrollRectEx)obj).ExitScrollArea;
			ToLua.PushObject(L, exitScrollArea);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index ExitScrollArea on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_ResetPosition(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ScrollRectEx obj2 = (ScrollRectEx)obj;
			bool resetPosition = LuaDLL.luaL_checkboolean(L, 2);
			obj2.ResetPosition = resetPosition;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index ResetPosition on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_ExitScrollArea(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ScrollRectEx obj2 = (ScrollRectEx)obj;
			ScrollRectEx.ExitScrollAreaEvent exitScrollArea = (ScrollRectEx.ExitScrollAreaEvent)ToLua.CheckObject<ScrollRectEx.ExitScrollAreaEvent>(L, 2);
			obj2.ExitScrollArea = exitScrollArea;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index ExitScrollArea on a nil value");
		}
	}
}
