using System;
using LuaInterface;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

public class UITreeWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(UITree), typeof(UIBehaviour));
		L.RegFunction("SetData", SetData);
		L.RegFunction("CLearView", CLearView);
		L.RegFunction("UpdateView", UpdateView);
		L.RegFunction("InitWithJsonData", InitWithJsonData);
		L.RegFunction("SetGroupSelectHandler", SetGroupSelectHandler);
		L.RegFunction("SetItemSelectHandler", SetItemSelectHandler);
		L.RegFunction("SetItemRenderer", SetItemRenderer);
		L.RegFunction("SetGroupRenderer", SetGroupRenderer);
		L.RegFunction("NotifyGroupSelect", NotifyGroupSelect);
		L.RegFunction("NotifyItemSelect", NotifyItemSelect);
		L.RegFunction("ForceLayout", ForceLayout);
		L.RegFunction("GetToggleGroup", GetToggleGroup);
		L.RegFunction("SelectGroup", SelectGroup);
		L.RegFunction("SelectItem", SelectItem);
		L.RegFunction("GetSelectedGroup", GetSelectedGroup);
		L.RegFunction("GetGroupGameObjectById", GetGroupGameObjectById);
		L.RegFunction("GetItemGameObjectById", GetItemGameObjectById);
		L.RegFunction("Refresh", Refresh);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("itemSelectHandler", get_itemSelectHandler, set_itemSelectHandler);
		L.RegVar("groupSelectHandler", get_groupSelectHandler, set_groupSelectHandler);
		L.RegVar("itemRenderer", get_itemRenderer, set_itemRenderer);
		L.RegVar("groupRenderer", get_groupRenderer, set_groupRenderer);
		L.RegVar("selectedGroup", get_selectedGroup, set_selectedGroup);
		L.RegVar("selectedItem", get_selectedItem, set_selectedItem);
		L.RegVar("data", get_data, set_data);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetData(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			UITree obj = (UITree)ToLua.CheckObject<UITree>(L, 1);
			UITreeData data = (UITreeData)ToLua.CheckObject<UITreeData>(L, 2);
			obj.SetData(data);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CLearView(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = ((UITree)ToLua.CheckObject<UITree>(L, 1)).CLearView();
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UpdateView(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((UITree)ToLua.CheckObject<UITree>(L, 1)).UpdateView();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int InitWithJsonData(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			UITree obj = (UITree)ToLua.CheckObject<UITree>(L, 1);
			string jsonData = ToLua.CheckString(L, 2);
			obj.InitWithJsonData(jsonData);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetGroupSelectHandler(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			UITree obj = (UITree)ToLua.CheckObject<UITree>(L, 1);
			Action<int, int, string, string> groupSelectHandler = (Action<int, int, string, string>)ToLua.CheckDelegate<Action<int, int, string, string>>(L, 2);
			obj.SetGroupSelectHandler(groupSelectHandler);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetItemSelectHandler(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			UITree obj = (UITree)ToLua.CheckObject<UITree>(L, 1);
			Action<int, int, string, string> itemSelectHandler = (Action<int, int, string, string>)ToLua.CheckDelegate<Action<int, int, string, string>>(L, 2);
			obj.SetItemSelectHandler(itemSelectHandler);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetItemRenderer(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			UITree obj = (UITree)ToLua.CheckObject<UITree>(L, 1);
			Action<int, GameObject> itemRenderer = (Action<int, GameObject>)ToLua.CheckDelegate<Action<int, GameObject>>(L, 2);
			obj.SetItemRenderer(itemRenderer);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetGroupRenderer(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			UITree obj = (UITree)ToLua.CheckObject<UITree>(L, 1);
			Action<int, GameObject> groupRenderer = (Action<int, GameObject>)ToLua.CheckDelegate<Action<int, GameObject>>(L, 2);
			obj.SetGroupRenderer(groupRenderer);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int NotifyGroupSelect(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			UITree obj = (UITree)ToLua.CheckObject<UITree>(L, 1);
			int index = (int)LuaDLL.luaL_checknumber(L, 2);
			obj.NotifyGroupSelect(index);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int NotifyItemSelect(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			UITree obj = (UITree)ToLua.CheckObject<UITree>(L, 1);
			int groupIndex = (int)LuaDLL.luaL_checknumber(L, 2);
			int itemIndex = (int)LuaDLL.luaL_checknumber(L, 3);
			obj.NotifyItemSelect(groupIndex, itemIndex);
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
			((UITree)ToLua.CheckObject<UITree>(L, 1)).ForceLayout();
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
			ToggleGroup toggleGroup = ((UITree)ToLua.CheckObject<UITree>(L, 1)).GetToggleGroup();
			ToLua.Push(L, toggleGroup);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SelectGroup(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				UITree obj2 = (UITree)ToLua.CheckObject<UITree>(L, 1);
				int index2 = (int)LuaDLL.luaL_checknumber(L, 2);
				obj2.SelectGroup(index2);
				return 0;
			}
			case 3:
			{
				UITree obj = (UITree)ToLua.CheckObject<UITree>(L, 1);
				int index = (int)LuaDLL.luaL_checknumber(L, 2);
				bool notify = LuaDLL.luaL_checkboolean(L, 3);
				obj.SelectGroup(index, notify);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UITree.SelectGroup");
			}
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
			ToLua.CheckArgsCount(L, 3);
			UITree obj = (UITree)ToLua.CheckObject<UITree>(L, 1);
			int groupIndex = (int)LuaDLL.luaL_checknumber(L, 2);
			int itemIndex = (int)LuaDLL.luaL_checknumber(L, 3);
			obj.SelectItem(groupIndex, itemIndex);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetSelectedGroup(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			UITreeGroup selectedGroup = ((UITree)ToLua.CheckObject<UITree>(L, 1)).GetSelectedGroup();
			ToLua.Push(L, selectedGroup);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetGroupGameObjectById(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			UITree obj = (UITree)ToLua.CheckObject<UITree>(L, 1);
			int groupId = (int)LuaDLL.luaL_checknumber(L, 2);
			GameObject groupGameObjectById = obj.GetGroupGameObjectById(groupId);
			ToLua.PushSealed(L, groupGameObjectById);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetItemGameObjectById(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			UITree obj = (UITree)ToLua.CheckObject<UITree>(L, 1);
			int groupId = (int)LuaDLL.luaL_checknumber(L, 2);
			int itemId = (int)LuaDLL.luaL_checknumber(L, 3);
			GameObject itemGameObjectById = obj.GetItemGameObjectById(groupId, itemId);
			ToLua.PushSealed(L, itemGameObjectById);
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
			((UITree)ToLua.CheckObject<UITree>(L, 1)).Refresh();
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
	private static int get_itemSelectHandler(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Action<int, int, string, string> itemSelectHandler = ((UITree)obj).itemSelectHandler;
			ToLua.Push(L, itemSelectHandler);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index itemSelectHandler on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_groupSelectHandler(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Action<int, int, string, string> groupSelectHandler = ((UITree)obj).groupSelectHandler;
			ToLua.Push(L, groupSelectHandler);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index groupSelectHandler on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_itemRenderer(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Action<int, GameObject> itemRenderer = ((UITree)obj).itemRenderer;
			ToLua.Push(L, itemRenderer);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index itemRenderer on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_groupRenderer(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Action<int, GameObject> groupRenderer = ((UITree)obj).groupRenderer;
			ToLua.Push(L, groupRenderer);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index groupRenderer on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_selectedGroup(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int selectedGroup = ((UITree)obj).selectedGroup;
			LuaDLL.lua_pushinteger(L, selectedGroup);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index selectedGroup on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_selectedItem(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int selectedItem = ((UITree)obj).selectedItem;
			LuaDLL.lua_pushinteger(L, selectedItem);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index selectedItem on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_data(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UITreeData data = ((UITree)obj).data;
			ToLua.PushObject(L, data);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index data on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_itemSelectHandler(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UITree obj2 = (UITree)obj;
			Action<int, int, string, string> itemSelectHandler = (Action<int, int, string, string>)ToLua.CheckDelegate<Action<int, int, string, string>>(L, 2);
			obj2.itemSelectHandler = itemSelectHandler;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index itemSelectHandler on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_groupSelectHandler(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UITree obj2 = (UITree)obj;
			Action<int, int, string, string> groupSelectHandler = (Action<int, int, string, string>)ToLua.CheckDelegate<Action<int, int, string, string>>(L, 2);
			obj2.groupSelectHandler = groupSelectHandler;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index groupSelectHandler on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_itemRenderer(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UITree obj2 = (UITree)obj;
			Action<int, GameObject> itemRenderer = (Action<int, GameObject>)ToLua.CheckDelegate<Action<int, GameObject>>(L, 2);
			obj2.itemRenderer = itemRenderer;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index itemRenderer on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_groupRenderer(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UITree obj2 = (UITree)obj;
			Action<int, GameObject> groupRenderer = (Action<int, GameObject>)ToLua.CheckDelegate<Action<int, GameObject>>(L, 2);
			obj2.groupRenderer = groupRenderer;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index groupRenderer on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_selectedGroup(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UITree obj2 = (UITree)obj;
			int selectedGroup = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.selectedGroup = selectedGroup;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index selectedGroup on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_selectedItem(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UITree obj2 = (UITree)obj;
			int selectedItem = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.selectedItem = selectedItem;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index selectedItem on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_data(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UITree obj2 = (UITree)obj;
			UITreeData data = (UITreeData)ToLua.CheckObject<UITreeData>(L, 2);
			obj2.data = data;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index data on a nil value");
		}
	}
}
