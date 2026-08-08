using System;
using LuaInterface;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

public class UITreeGroupWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(UITreeGroup), typeof(UIBehaviour));
		L.RegFunction("SetData", SetData);
		L.RegFunction("GetItemGameObjectByInstanceId", GetItemGameObjectByInstanceId);
		L.RegFunction("SetTree", SetTree);
		L.RegFunction("SetDefaultOn", SetDefaultOn);
		L.RegFunction("SetIsOn", SetIsOn);
		L.RegFunction("NotifySelect", NotifySelect);
		L.RegFunction("ForceLayout", ForceLayout);
		L.RegFunction("GetToggleGroup", GetToggleGroup);
		L.RegFunction("SetIndex", SetIndex);
		L.RegFunction("SelectItem", SelectItem);
		L.RegFunction("GetSelectedItem", GetSelectedItem);
		L.RegFunction("GetContainer", GetContainer);
		L.RegFunction("Refresh", Refresh);
		L.RegFunction("GetTitle", GetTitle);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("toggle", get_toggle, set_toggle);
		L.RegVar("index", get_index, set_index);
		L.RegVar("noticeContainer", get_noticeContainer, set_noticeContainer);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetData(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			UITreeGroup obj = (UITreeGroup)ToLua.CheckObject<UITreeGroup>(L, 1);
			UITreeGroupData data = (UITreeGroupData)ToLua.CheckObject<UITreeGroupData>(L, 2);
			obj.SetData(data);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetItemGameObjectByInstanceId(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			UITreeGroup obj = (UITreeGroup)ToLua.CheckObject<UITreeGroup>(L, 1);
			int id = (int)LuaDLL.luaL_checknumber(L, 2);
			GameObject itemGameObjectByInstanceId = obj.GetItemGameObjectByInstanceId(id);
			ToLua.PushSealed(L, itemGameObjectByInstanceId);
			return 1;
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
			UITreeGroup obj = (UITreeGroup)ToLua.CheckObject<UITreeGroup>(L, 1);
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
	private static int SetDefaultOn(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			UITreeGroup obj = (UITreeGroup)ToLua.CheckObject<UITreeGroup>(L, 1);
			bool defaultOn = LuaDLL.luaL_checkboolean(L, 2);
			obj.SetDefaultOn(defaultOn);
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
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				UITreeGroup obj2 = (UITreeGroup)ToLua.CheckObject<UITreeGroup>(L, 1);
				bool value2 = LuaDLL.luaL_checkboolean(L, 2);
				obj2.SetIsOn(value2);
				return 0;
			}
			case 3:
			{
				UITreeGroup obj = (UITreeGroup)ToLua.CheckObject<UITreeGroup>(L, 1);
				bool value = LuaDLL.luaL_checkboolean(L, 2);
				bool notify = LuaDLL.luaL_checkboolean(L, 3);
				obj.SetIsOn(value, notify);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UITreeGroup.SetIsOn");
			}
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
			((UITreeGroup)ToLua.CheckObject<UITreeGroup>(L, 1)).NotifySelect();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ForceLayout(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((UITreeGroup)ToLua.CheckObject<UITreeGroup>(L, 1)).ForceLayout();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetToggleGroup(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			ToggleGroup toggleGroup = ((UITreeGroup)ToLua.CheckObject<UITreeGroup>(L, 1)).GetToggleGroup();
			ToLua.Push(L, toggleGroup);
			return 1;
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
			UITreeGroup obj = (UITreeGroup)ToLua.CheckObject<UITreeGroup>(L, 1);
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
	private static int SelectItem(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			UITreeGroup obj = (UITreeGroup)ToLua.CheckObject<UITreeGroup>(L, 1);
			int index = (int)LuaDLL.luaL_checknumber(L, 2);
			obj.SelectItem(index);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetSelectedItem(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			UITreeItem selectedItem = ((UITreeGroup)ToLua.CheckObject<UITreeGroup>(L, 1)).GetSelectedItem();
			ToLua.Push(L, selectedItem);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetContainer(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			RectTransform container = ((UITreeGroup)ToLua.CheckObject<UITreeGroup>(L, 1)).GetContainer();
			ToLua.PushSealed(L, container);
			return 1;
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
			((UITreeGroup)ToLua.CheckObject<UITreeGroup>(L, 1)).Refresh();
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
			Text title = ((UITreeGroup)ToLua.CheckObject<UITreeGroup>(L, 1)).GetTitle();
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
			Toggle toggle = ((UITreeGroup)obj).toggle;
			ToLua.Push(L, toggle);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index toggle on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_index(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int index = ((UITreeGroup)obj).index;
			LuaDLL.lua_pushinteger(L, index);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index index on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_noticeContainer(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RectTransform noticeContainer = ((UITreeGroup)obj).noticeContainer;
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
			UITreeGroup obj2 = (UITreeGroup)obj;
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
	private static int set_index(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UITreeGroup obj2 = (UITreeGroup)obj;
			int index = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.index = index;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index index on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_noticeContainer(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UITreeGroup obj2 = (UITreeGroup)obj;
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
