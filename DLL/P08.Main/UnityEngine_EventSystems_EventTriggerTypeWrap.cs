using System;
using LuaInterface;
using UnityEngine.EventSystems;

public class UnityEngine_EventSystems_EventTriggerTypeWrap
{
	public static void Register(LuaState L)
	{
		L.BeginEnum(typeof(EventTriggerType));
		L.RegVar("PointerEnter", get_PointerEnter, null);
		L.RegVar("PointerExit", get_PointerExit, null);
		L.RegVar("PointerDown", get_PointerDown, null);
		L.RegVar("PointerUp", get_PointerUp, null);
		L.RegVar("PointerClick", get_PointerClick, null);
		L.RegVar("Drag", get_Drag, null);
		L.RegVar("Drop", get_Drop, null);
		L.RegVar("Scroll", get_Scroll, null);
		L.RegVar("UpdateSelected", get_UpdateSelected, null);
		L.RegVar("Select", get_Select, null);
		L.RegVar("Deselect", get_Deselect, null);
		L.RegVar("Move", get_Move, null);
		L.RegVar("InitializePotentialDrag", get_InitializePotentialDrag, null);
		L.RegVar("BeginDrag", get_BeginDrag, null);
		L.RegVar("EndDrag", get_EndDrag, null);
		L.RegVar("Submit", get_Submit, null);
		L.RegVar("Cancel", get_Cancel, null);
		L.RegFunction("IntToEnum", IntToEnum);
		L.EndEnum();
		TypeTraits<EventTriggerType>.Check = CheckType;
		StackTraits<EventTriggerType>.Push = Push;
	}

	private static void Push(IntPtr L, EventTriggerType arg)
	{
		ToLua.Push(L, arg);
	}

	private static bool CheckType(IntPtr L, int pos)
	{
		return TypeChecker.CheckEnumType(typeof(EventTriggerType), L, pos);
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_PointerEnter(IntPtr L)
	{
		ToLua.Push(L, EventTriggerType.PointerEnter);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_PointerExit(IntPtr L)
	{
		ToLua.Push(L, EventTriggerType.PointerExit);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_PointerDown(IntPtr L)
	{
		ToLua.Push(L, EventTriggerType.PointerDown);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_PointerUp(IntPtr L)
	{
		ToLua.Push(L, EventTriggerType.PointerUp);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_PointerClick(IntPtr L)
	{
		ToLua.Push(L, EventTriggerType.PointerClick);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Drag(IntPtr L)
	{
		ToLua.Push(L, EventTriggerType.Drag);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Drop(IntPtr L)
	{
		ToLua.Push(L, EventTriggerType.Drop);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Scroll(IntPtr L)
	{
		ToLua.Push(L, EventTriggerType.Scroll);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_UpdateSelected(IntPtr L)
	{
		ToLua.Push(L, EventTriggerType.UpdateSelected);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Select(IntPtr L)
	{
		ToLua.Push(L, EventTriggerType.Select);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Deselect(IntPtr L)
	{
		ToLua.Push(L, EventTriggerType.Deselect);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Move(IntPtr L)
	{
		ToLua.Push(L, EventTriggerType.Move);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_InitializePotentialDrag(IntPtr L)
	{
		ToLua.Push(L, EventTriggerType.InitializePotentialDrag);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_BeginDrag(IntPtr L)
	{
		ToLua.Push(L, EventTriggerType.BeginDrag);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_EndDrag(IntPtr L)
	{
		ToLua.Push(L, EventTriggerType.EndDrag);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Submit(IntPtr L)
	{
		ToLua.Push(L, EventTriggerType.Submit);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Cancel(IntPtr L)
	{
		ToLua.Push(L, EventTriggerType.Cancel);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IntToEnum(IntPtr L)
	{
		EventTriggerType eventTriggerType = (EventTriggerType)LuaDLL.lua_tonumber(L, 1);
		ToLua.Push(L, eventTriggerType);
		return 1;
	}
}
