using System;
using LuaInterface;
using UnityEngine;
using UnityEngine.EventSystems;

public class VerticalCenterOnChildWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(VerticalCenterOnChild), typeof(MonoBehaviour));
		L.RegFunction("OnEndDrag", OnEndDrag);
		L.RegFunction("OnBeginDrag", OnBeginDrag);
		L.RegFunction("RemoveAllListeners", RemoveAllListeners);
		L.RegFunction("MoveToIndex", MoveToIndex);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("centerSpeed", get_centerSpeed, set_centerSpeed);
		L.RegVar("childCount", get_childCount, set_childCount);
		L.RegVar("childPosY", get_childPosY, set_childPosY);
		L.RegVar("deltaY", get_deltaY, set_deltaY);
		L.RegVar("current", get_current, set_current);
		L.RegVar("onBeginDrag", get_onBeginDrag, set_onBeginDrag);
		L.RegVar("onEndDrag", get_onEndDrag, set_onEndDrag);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OnEndDrag(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			VerticalCenterOnChild obj = (VerticalCenterOnChild)ToLua.CheckObject<VerticalCenterOnChild>(L, 1);
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
	private static int OnBeginDrag(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			VerticalCenterOnChild obj = (VerticalCenterOnChild)ToLua.CheckObject<VerticalCenterOnChild>(L, 1);
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
	private static int RemoveAllListeners(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((VerticalCenterOnChild)ToLua.CheckObject<VerticalCenterOnChild>(L, 1)).RemoveAllListeners();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int MoveToIndex(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			VerticalCenterOnChild obj = (VerticalCenterOnChild)ToLua.CheckObject<VerticalCenterOnChild>(L, 1);
			int index = (int)LuaDLL.luaL_checknumber(L, 2);
			obj.MoveToIndex(index);
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
	private static int get_centerSpeed(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float centerSpeed = ((VerticalCenterOnChild)obj).centerSpeed;
			LuaDLL.lua_pushnumber(L, centerSpeed);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index centerSpeed on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_childCount(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int childCount = ((VerticalCenterOnChild)obj).childCount;
			LuaDLL.lua_pushinteger(L, childCount);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index childCount on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_childPosY(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float childPosY = ((VerticalCenterOnChild)obj).childPosY;
			LuaDLL.lua_pushnumber(L, childPosY);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index childPosY on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_deltaY(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float deltaY = ((VerticalCenterOnChild)obj).deltaY;
			LuaDLL.lua_pushnumber(L, deltaY);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index deltaY on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_current(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int current = ((VerticalCenterOnChild)obj).current;
			LuaDLL.lua_pushinteger(L, current);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index current on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_onBeginDrag(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LuaHelper.ETLCallBack1 onBeginDrag = ((VerticalCenterOnChild)obj).onBeginDrag;
			ToLua.Push(L, onBeginDrag);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index onBeginDrag on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_onEndDrag(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LuaHelper.ETLCallBack1 onEndDrag = ((VerticalCenterOnChild)obj).onEndDrag;
			ToLua.Push(L, onEndDrag);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index onEndDrag on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_centerSpeed(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			VerticalCenterOnChild obj2 = (VerticalCenterOnChild)obj;
			float centerSpeed = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.centerSpeed = centerSpeed;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index centerSpeed on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_childCount(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			VerticalCenterOnChild obj2 = (VerticalCenterOnChild)obj;
			int childCount = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.childCount = childCount;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index childCount on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_childPosY(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			VerticalCenterOnChild obj2 = (VerticalCenterOnChild)obj;
			float childPosY = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.childPosY = childPosY;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index childPosY on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_deltaY(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			VerticalCenterOnChild obj2 = (VerticalCenterOnChild)obj;
			float deltaY = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.deltaY = deltaY;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index deltaY on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_current(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			VerticalCenterOnChild obj2 = (VerticalCenterOnChild)obj;
			int current = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.current = current;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index current on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_onBeginDrag(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			VerticalCenterOnChild obj2 = (VerticalCenterOnChild)obj;
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
	private static int set_onEndDrag(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			VerticalCenterOnChild obj2 = (VerticalCenterOnChild)obj;
			LuaHelper.ETLCallBack1 onEndDrag = (LuaHelper.ETLCallBack1)ToLua.CheckDelegate<LuaHelper.ETLCallBack1>(L, 2);
			obj2.onEndDrag = onEndDrag;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index onEndDrag on a nil value");
		}
	}
}
