using System;
using LuaInterface;
using UnityEngine;
using UnityEngine.EventSystems;

public class MutiTouchHelperWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(MutiTouchHelper), typeof(MonoBehaviour));
		L.RegFunction("OnPointerClick", OnPointerClick);
		L.RegFunction("OnBeginDrag", OnBeginDrag);
		L.RegFunction("OnDrag", OnDrag);
		L.RegFunction("OnEndDrag", OnEndDrag);
		L.RegFunction("OnScroll", OnScroll);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("limitTrs", get_limitTrs, set_limitTrs);
		L.RegVar("OnSingleDrag", get_OnSingleDrag, set_OnSingleDrag);
		L.RegVar("OnMutiDrag", get_OnMutiDrag, set_OnMutiDrag);
		L.RegVar("OnClick", get_OnClick, set_OnClick);
		L.RegVar("OnIdle", get_OnIdle, set_OnIdle);
		L.RegVar("EndDrag", get_EndDrag, set_EndDrag);
		L.RegVar("isOnDrag", get_isOnDrag, set_isOnDrag);
		L.RegVar("idleTime", get_idleTime, set_idleTime);
		L.RegVar("maxDraging", get_maxDraging, set_maxDraging);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OnPointerClick(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			MutiTouchHelper obj = (MutiTouchHelper)ToLua.CheckObject<MutiTouchHelper>(L, 1);
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
	private static int OnBeginDrag(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			MutiTouchHelper obj = (MutiTouchHelper)ToLua.CheckObject<MutiTouchHelper>(L, 1);
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
			MutiTouchHelper obj = (MutiTouchHelper)ToLua.CheckObject<MutiTouchHelper>(L, 1);
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
			MutiTouchHelper obj = (MutiTouchHelper)ToLua.CheckObject<MutiTouchHelper>(L, 1);
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
			MutiTouchHelper obj = (MutiTouchHelper)ToLua.CheckObject<MutiTouchHelper>(L, 1);
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
	private static int get_limitTrs(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RectTransform limitTrs = ((MutiTouchHelper)obj).limitTrs;
			ToLua.PushSealed(L, limitTrs);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index limitTrs on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_OnSingleDrag(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Action<float, float> onSingleDrag = ((MutiTouchHelper)obj).OnSingleDrag;
			ToLua.Push(L, onSingleDrag);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index OnSingleDrag on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_OnMutiDrag(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Action<float> onMutiDrag = ((MutiTouchHelper)obj).OnMutiDrag;
			ToLua.Push(L, onMutiDrag);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index OnMutiDrag on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_OnClick(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LuaHelper.ETLCallBack1 onClick = ((MutiTouchHelper)obj).OnClick;
			ToLua.Push(L, onClick);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index OnClick on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_OnIdle(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Action onIdle = ((MutiTouchHelper)obj).OnIdle;
			ToLua.Push(L, onIdle);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index OnIdle on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_EndDrag(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Action endDrag = ((MutiTouchHelper)obj).EndDrag;
			ToLua.Push(L, endDrag);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index EndDrag on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isOnDrag(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isOnDrag = ((MutiTouchHelper)obj).isOnDrag;
			LuaDLL.lua_pushboolean(L, isOnDrag);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isOnDrag on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_idleTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float idleTime = ((MutiTouchHelper)obj).idleTime;
			LuaDLL.lua_pushnumber(L, idleTime);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index idleTime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_maxDraging(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int maxDraging = ((MutiTouchHelper)obj).maxDraging;
			LuaDLL.lua_pushinteger(L, maxDraging);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index maxDraging on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_limitTrs(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			MutiTouchHelper obj2 = (MutiTouchHelper)obj;
			RectTransform limitTrs = (RectTransform)ToLua.CheckObject(L, 2, typeof(RectTransform));
			obj2.limitTrs = limitTrs;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index limitTrs on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_OnSingleDrag(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			MutiTouchHelper obj2 = (MutiTouchHelper)obj;
			Action<float, float> onSingleDrag = (Action<float, float>)ToLua.CheckDelegate<Action<float, float>>(L, 2);
			obj2.OnSingleDrag = onSingleDrag;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index OnSingleDrag on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_OnMutiDrag(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			MutiTouchHelper obj2 = (MutiTouchHelper)obj;
			Action<float> onMutiDrag = (Action<float>)ToLua.CheckDelegate<Action<float>>(L, 2);
			obj2.OnMutiDrag = onMutiDrag;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index OnMutiDrag on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_OnClick(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			MutiTouchHelper obj2 = (MutiTouchHelper)obj;
			LuaHelper.ETLCallBack1 onClick = (LuaHelper.ETLCallBack1)ToLua.CheckDelegate<LuaHelper.ETLCallBack1>(L, 2);
			obj2.OnClick = onClick;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index OnClick on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_OnIdle(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			MutiTouchHelper obj2 = (MutiTouchHelper)obj;
			Action onIdle = (Action)ToLua.CheckDelegate<Action>(L, 2);
			obj2.OnIdle = onIdle;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index OnIdle on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_EndDrag(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			MutiTouchHelper obj2 = (MutiTouchHelper)obj;
			Action endDrag = (Action)ToLua.CheckDelegate<Action>(L, 2);
			obj2.EndDrag = endDrag;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index EndDrag on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_isOnDrag(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			MutiTouchHelper obj2 = (MutiTouchHelper)obj;
			bool isOnDrag = LuaDLL.luaL_checkboolean(L, 2);
			obj2.isOnDrag = isOnDrag;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isOnDrag on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_idleTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			MutiTouchHelper obj2 = (MutiTouchHelper)obj;
			float idleTime = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.idleTime = idleTime;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index idleTime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_maxDraging(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			MutiTouchHelper obj2 = (MutiTouchHelper)obj;
			int maxDraging = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.maxDraging = maxDraging;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index maxDraging on a nil value");
		}
	}
}
