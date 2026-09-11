using System;
using LuaInterface;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

public class UITreeItemWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(UITreeItem), typeof(UIBehaviour));
		L.RegFunction("SetData", SetData);
		L.RegFunction("SetTree", SetTree);
		L.RegFunction("SetGroup", SetGroup);
		L.RegFunction("SetIsOn", SetIsOn);
		L.RegFunction("NotifySelect", NotifySelect);
		L.RegFunction("SetIndex", SetIndex);
		L.RegFunction("Refresh", Refresh);
		L.RegFunction("GetTitle", GetTitle);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("toggle", get_toggle, set_toggle);
		L.RegVar("noticeContainer", get_noticeContainer, set_noticeContainer);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetData(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			UITreeItem obj = (UITreeItem)ToLua.CheckObject<UITreeItem>(L, 1);
			UITreeItemData data = (UITreeItemData)ToLua.CheckObject<UITreeItemData>(L, 2);
			obj.SetData(data);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetTree(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			UITreeItem obj = (UITreeItem)ToLua.CheckObject<UITreeItem>(L, 1);
			UITree tree = (UITree)ToLua.CheckObject<UITree>(L, 2);
			obj.SetTree(tree);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetGroup(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			UITreeItem obj = (UITreeItem)ToLua.CheckObject<UITreeItem>(L, 1);
			UITreeGroup uITreeGroup = (UITreeGroup)ToLua.CheckObject<UITreeGroup>(L, 2);
			obj.SetGroup(uITreeGroup);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetIsOn(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			UITreeItem obj = (UITreeItem)ToLua.CheckObject<UITreeItem>(L, 1);
			bool isOn = LuaDLL.luaL_checkboolean(L, 2);
			obj.SetIsOn(isOn);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int NotifySelect(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((UITreeItem)ToLua.CheckObject<UITreeItem>(L, 1)).NotifySelect();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetIndex(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			UITreeItem obj = (UITreeItem)ToLua.CheckObject<UITreeItem>(L, 1);
			int index = (int)LuaDLL.luaL_checknumber(L, 2);
			obj.SetIndex(index);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Refresh(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((UITreeItem)ToLua.CheckObject<UITreeItem>(L, 1)).Refresh();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetTitle(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			Text title = ((UITreeItem)ToLua.CheckObject<UITreeItem>(L, 1)).GetTitle();
			ToLua.Push(L, title);
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
	private static int get_toggle(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Toggle toggle = ((UITreeItem)obj).toggle;
			ToLua.Push(L, toggle);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index toggle on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_noticeContainer(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RectTransform noticeContainer = ((UITreeItem)obj).noticeContainer;
			ToLua.PushSealed(L, noticeContainer);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index noticeContainer on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_toggle(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UITreeItem obj2 = (UITreeItem)obj;
			Toggle toggle = (Toggle)ToLua.CheckObject<Toggle>(L, 2);
			obj2.toggle = toggle;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index toggle on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_noticeContainer(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UITreeItem obj2 = (UITreeItem)obj;
			RectTransform noticeContainer = (RectTransform)ToLua.CheckObject(L, 2, typeof(RectTransform));
			obj2.noticeContainer = noticeContainer;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index noticeContainer on a nil value");
		}
	}
}
