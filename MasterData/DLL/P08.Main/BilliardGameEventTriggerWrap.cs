using System;
using LuaInterface;
using UnityEngine;
using UnityEngine.EventSystems;

public class BilliardGameEventTriggerWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(BilliardGameEventTrigger), typeof(EventTrigger));
		L.RegFunction("SetClickCallBack", SetClickCallBack);
		L.RegFunction("SetDragBeginCallBack", SetDragBeginCallBack);
		L.RegFunction("SetDragCallBack", SetDragCallBack);
		L.RegFunction("SetDragEndCallBack", SetDragEndCallBack);
		L.RegFunction("SetPressDownCallBack", SetPressDownCallBack);
		L.RegFunction("SetPressUpCallBack", SetPressUpCallBack);
		L.RegFunction("SetDragEnterCallBack", SetDragEnterCallBack);
		L.RegFunction("OnPointerClick", OnPointerClick);
		L.RegFunction("OnBeginDrag", OnBeginDrag);
		L.RegFunction("OnDrag", OnDrag);
		L.RegFunction("OnEndDrag", OnEndDrag);
		L.RegFunction("OnPointerDown", OnPointerDown);
		L.RegFunction("OnPointerUp", OnPointerUp);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetClickCallBack(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			BilliardGameEventTrigger obj = (BilliardGameEventTrigger)ToLua.CheckObject<BilliardGameEventTrigger>(L, 1);
			Action<Vector3> clickCallBack = (Action<Vector3>)ToLua.CheckDelegate<Action<Vector3>>(L, 2);
			obj.SetClickCallBack(clickCallBack);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetDragBeginCallBack(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			BilliardGameEventTrigger obj = (BilliardGameEventTrigger)ToLua.CheckObject<BilliardGameEventTrigger>(L, 1);
			Action<Vector3> dragBeginCallBack = (Action<Vector3>)ToLua.CheckDelegate<Action<Vector3>>(L, 2);
			obj.SetDragBeginCallBack(dragBeginCallBack);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetDragCallBack(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			BilliardGameEventTrigger obj = (BilliardGameEventTrigger)ToLua.CheckObject<BilliardGameEventTrigger>(L, 1);
			Action<Vector3, bool> dragCallBack = (Action<Vector3, bool>)ToLua.CheckDelegate<Action<Vector3, bool>>(L, 2);
			obj.SetDragCallBack(dragCallBack);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetDragEndCallBack(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			BilliardGameEventTrigger obj = (BilliardGameEventTrigger)ToLua.CheckObject<BilliardGameEventTrigger>(L, 1);
			Action<Vector3, bool> dragEndCallBack = (Action<Vector3, bool>)ToLua.CheckDelegate<Action<Vector3, bool>>(L, 2);
			obj.SetDragEndCallBack(dragEndCallBack);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetPressDownCallBack(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			BilliardGameEventTrigger obj = (BilliardGameEventTrigger)ToLua.CheckObject<BilliardGameEventTrigger>(L, 1);
			Action pressDownCallBack = (Action)ToLua.CheckDelegate<Action>(L, 2);
			obj.SetPressDownCallBack(pressDownCallBack);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetPressUpCallBack(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			BilliardGameEventTrigger obj = (BilliardGameEventTrigger)ToLua.CheckObject<BilliardGameEventTrigger>(L, 1);
			Action pressUpCallBack = (Action)ToLua.CheckDelegate<Action>(L, 2);
			obj.SetPressUpCallBack(pressUpCallBack);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetDragEnterCallBack(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((BilliardGameEventTrigger)ToLua.CheckObject<BilliardGameEventTrigger>(L, 1)).SetDragEnterCallBack();
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
			BilliardGameEventTrigger obj = (BilliardGameEventTrigger)ToLua.CheckObject<BilliardGameEventTrigger>(L, 1);
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
			BilliardGameEventTrigger obj = (BilliardGameEventTrigger)ToLua.CheckObject<BilliardGameEventTrigger>(L, 1);
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
			BilliardGameEventTrigger obj = (BilliardGameEventTrigger)ToLua.CheckObject<BilliardGameEventTrigger>(L, 1);
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
			BilliardGameEventTrigger obj = (BilliardGameEventTrigger)ToLua.CheckObject<BilliardGameEventTrigger>(L, 1);
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
	private static int OnPointerDown(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			BilliardGameEventTrigger obj = (BilliardGameEventTrigger)ToLua.CheckObject<BilliardGameEventTrigger>(L, 1);
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
			BilliardGameEventTrigger obj = (BilliardGameEventTrigger)ToLua.CheckObject<BilliardGameEventTrigger>(L, 1);
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
}
