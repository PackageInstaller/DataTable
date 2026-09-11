using System;
using System.Collections.Generic;
using LuaInterface;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

public class UIListWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(UIList), typeof(UIBehaviour));
		L.RegFunction("SetItemRenderer", SetItemRenderer);
		L.RegFunction("SetItemRecycleHandler", SetItemRecycleHandler);
		L.RegFunction("SetHeadTailChangeHandler", SetHeadTailChangeHandler);
		L.RegFunction("SetAppearType", SetAppearType);
		L.RegFunction("SetNumItems", SetNumItems);
		L.RegFunction("Refresh", Refresh);
		L.RegFunction("SetAlignment", SetAlignment);
		L.RegFunction("SetOrientation", SetOrientation);
		L.RegFunction("OnScroll", OnScroll);
		L.RegFunction("UpdateList", UpdateList);
		L.RegFunction("RenderItem", RenderItem);
		L.RegFunction("RecycleAllItems", RecycleAllItems);
		L.RegFunction("UpdateLayout", UpdateLayout);
		L.RegFunction("UpdateProgressBar", UpdateProgressBar);
		L.RegFunction("RemoveTween", RemoveTween);
		L.RegFunction("ScrollToIndex", ScrollToIndex);
		L.RegFunction("SetItemActive", SetItemActive);
		L.RegFunction("AddOrExecuteCommand", AddOrExecuteCommand);
		L.RegFunction("ExecuteAllCommands", ExecuteAllCommands);
		L.RegFunction("GetHeadAndTail", GetHeadAndTail);
		L.RegFunction("GetScrolledPosition", GetScrolledPosition);
		L.RegFunction("SetScrolledPosition", SetScrolledPosition);
		L.RegFunction("IsVertical", IsVertical);
		L.RegFunction("IsHorizontal", IsHorizontal);
		L.RegFunction("GetChildCount", GetChildCount);
		L.RegFunction("GetContentRect", GetContentRect);
		L.RegFunction("UpdateProp", UpdateProp);
		L.RegFunction("SetPageChangeHandler", SetPageChangeHandler);
		L.RegFunction("OnBeginDrag", OnBeginDrag);
		L.RegFunction("SetLimitMaxDragCount", SetLimitMaxDragCount);
		L.RegFunction("OnEndDrag", OnEndDrag);
		L.RegFunction("SwitchToPageIndex", SwitchToPageIndex);
		L.RegFunction("StopRender", StopRender);
		L.RegFunction("IsActive", IsActive);
		L.RegFunction("ShowBlock", ShowBlock);
		L.RegFunction("HideBlock", HideBlock);
		L.RegFunction("DebugCreateItem", DebugCreateItem);
		L.RegFunction("DebugClearItems", DebugClearItems);
		L.RegFunction("Validate", Validate);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("OUT_OF_BOUND_POSITION", get_OUT_OF_BOUND_POSITION, set_OUT_OF_BOUND_POSITION);
		L.RegVar("ItemPrefab", get_ItemPrefab, set_ItemPrefab);
		L.RegVar("_spacing", get__spacing, set__spacing);
		L.RegVar("_padding", get__padding, set__padding);
		L.RegVar("content", get_content, set_content);
		L.RegVar("_viewport", get__viewport, set__viewport);
		L.RegVar("moveSeconds", get_moveSeconds, set_moveSeconds);
		L.RegVar("Orientation", get_Orientation, set_Orientation);
		L.RegVar("uiListAlignment", get_uiListAlignment, set_uiListAlignment);
		L.RegVar("uiListAlignmentWhenLess", get_uiListAlignmentWhenLess, set_uiListAlignmentWhenLess);
		L.RegVar("AdapterType", get_AdapterType, set_AdapterType);
		L.RegVar("FixColOrRowCount", get_FixColOrRowCount, set_FixColOrRowCount);
		L.RegVar("IsVirtual", get_IsVirtual, set_IsVirtual);
		L.RegVar("AppearType", get_AppearType, set_AppearType);
		L.RegVar("SplitTime", get_SplitTime, set_SplitTime);
		L.RegVar("AutoSplit", get_AutoSplit, set_AutoSplit);
		L.RegVar("SingleRowColAutoSplit", get_SingleRowColAutoSplit, set_SingleRowColAutoSplit);
		L.RegVar("PageMode", get_PageMode, set_PageMode);
		L.RegVar("AlwaysPageCenter", get_AlwaysPageCenter, set_AlwaysPageCenter);
		L.RegVar("SingleRowColFitItemSize", get_SingleRowColFitItemSize, set_SingleRowColFitItemSize);
		L.RegVar("drag_threshold", get_drag_threshold, set_drag_threshold);
		L.RegVar("_pool", get__pool, set__pool);
		L.RegVar("_scrollRect", get__scrollRect, set__scrollRect);
		L.RegVar("_itemDic", get__itemDic, set__itemDic);
		L.RegVar("_itemNum", get__itemNum, set__itemNum);
		L.RegVar("_itemRenderer", get__itemRenderer, set__itemRenderer);
		L.RegVar("_itemRecycleHandler", get__itemRecycleHandler, set__itemRecycleHandler);
		L.RegVar("_headTailChangeHandler", get__headTailChangeHandler, set__headTailChangeHandler);
		L.RegVar("_pageChangeHandler", get__pageChangeHandler, set__pageChangeHandler);
		L.RegVar("_uilistCommands", get__uilistCommands, set__uilistCommands);
		L.RegVar("_colLimit", get__colLimit, set__colLimit);
		L.RegVar("_rowLimit", get__rowLimit, set__rowLimit);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetItemRenderer(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			UIList obj = (UIList)ToLua.CheckObject<UIList>(L, 1);
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
	private static int SetItemRecycleHandler(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			UIList obj = (UIList)ToLua.CheckObject<UIList>(L, 1);
			Action<int, GameObject> itemRecycleHandler = (Action<int, GameObject>)ToLua.CheckDelegate<Action<int, GameObject>>(L, 2);
			obj.SetItemRecycleHandler(itemRecycleHandler);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetHeadTailChangeHandler(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			UIList obj = (UIList)ToLua.CheckObject<UIList>(L, 1);
			Action<int, int> headTailChangeHandler = (Action<int, int>)ToLua.CheckDelegate<Action<int, int>>(L, 2);
			obj.SetHeadTailChangeHandler(headTailChangeHandler);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetAppearType(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			UIList obj = (UIList)ToLua.CheckObject<UIList>(L, 1);
			int appearType = (int)LuaDLL.luaL_checknumber(L, 2);
			obj.SetAppearType(appearType);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetNumItems(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				UIList obj2 = (UIList)ToLua.CheckObject<UIList>(L, 1);
				int value2 = (int)LuaDLL.luaL_checknumber(L, 2);
				obj2.SetNumItems(value2);
				return 0;
			}
			case 3:
			{
				UIList obj = (UIList)ToLua.CheckObject<UIList>(L, 1);
				int value = (int)LuaDLL.luaL_checknumber(L, 2);
				bool quite = LuaDLL.luaL_checkboolean(L, 3);
				obj.SetNumItems(value, quite);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UIList.SetNumItems");
			}
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
			((UIList)ToLua.CheckObject<UIList>(L, 1)).Refresh();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetAlignment(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			UIList obj = (UIList)ToLua.CheckObject<UIList>(L, 1);
			UIListAlignment alignment = (UIListAlignment)ToLua.CheckObject(L, 2, typeof(UIListAlignment));
			obj.SetAlignment(alignment);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetOrientation(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			UIList obj = (UIList)ToLua.CheckObject<UIList>(L, 1);
			Orientation orientation = (Orientation)ToLua.CheckObject(L, 2, typeof(Orientation));
			obj.SetOrientation(orientation);
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
			UIList obj = (UIList)ToLua.CheckObject<UIList>(L, 1);
			Vector2 value = ToLua.ToVector2(L, 2);
			obj.OnScroll(value);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UpdateList(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((UIList)ToLua.CheckObject<UIList>(L, 1)).UpdateList();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RenderItem(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			UIList obj = (UIList)ToLua.CheckObject<UIList>(L, 1);
			int index = (int)LuaDLL.luaL_checknumber(L, 2);
			GameObject o = obj.RenderItem(index);
			ToLua.PushSealed(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RecycleAllItems(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((UIList)ToLua.CheckObject<UIList>(L, 1)).RecycleAllItems();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UpdateLayout(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((UIList)ToLua.CheckObject<UIList>(L, 1)).UpdateLayout();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UpdateProgressBar(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((UIList)ToLua.CheckObject<UIList>(L, 1)).UpdateProgressBar();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RemoveTween(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((UIList)ToLua.CheckObject<UIList>(L, 1)).RemoveTween();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ScrollToIndex(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				UIList obj4 = (UIList)ToLua.CheckObject<UIList>(L, 1);
				int index4 = (int)LuaDLL.luaL_checknumber(L, 2);
				obj4.ScrollToIndex(index4);
				return 0;
			}
			case 3:
			{
				UIList obj3 = (UIList)ToLua.CheckObject<UIList>(L, 1);
				int index3 = (int)LuaDLL.luaL_checknumber(L, 2);
				bool atCenter3 = LuaDLL.luaL_checkboolean(L, 3);
				obj3.ScrollToIndex(index3, atCenter3);
				return 0;
			}
			case 4:
			{
				UIList obj2 = (UIList)ToLua.CheckObject<UIList>(L, 1);
				int index2 = (int)LuaDLL.luaL_checknumber(L, 2);
				bool atCenter2 = LuaDLL.luaL_checkboolean(L, 3);
				bool anim2 = LuaDLL.luaL_checkboolean(L, 4);
				obj2.ScrollToIndex(index2, atCenter2, anim2);
				return 0;
			}
			case 5:
			{
				UIList obj = (UIList)ToLua.CheckObject<UIList>(L, 1);
				int index = (int)LuaDLL.luaL_checknumber(L, 2);
				bool atCenter = LuaDLL.luaL_checkboolean(L, 3);
				bool anim = LuaDLL.luaL_checkboolean(L, 4);
				float time = (float)LuaDLL.luaL_checknumber(L, 5);
				obj.ScrollToIndex(index, atCenter, anim, time);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UIList.ScrollToIndex");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetItemActive(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			UIList obj = (UIList)ToLua.CheckObject<UIList>(L, 1);
			GameObject go = (GameObject)ToLua.CheckObject(L, 2, typeof(GameObject));
			bool value = LuaDLL.luaL_checkboolean(L, 3);
			obj.SetItemActive(go, value);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int AddOrExecuteCommand(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			UIList obj = (UIList)ToLua.CheckObject<UIList>(L, 1);
			Action action = (Action)ToLua.CheckDelegate<Action>(L, 2);
			obj.AddOrExecuteCommand(action);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ExecuteAllCommands(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((UIList)ToLua.CheckObject<UIList>(L, 1)).ExecuteAllCommands();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetHeadAndTail(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			Vector2 headAndTail = ((UIList)ToLua.CheckObject<UIList>(L, 1)).GetHeadAndTail();
			ToLua.Push(L, headAndTail);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetScrolledPosition(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			Vector2 scrolledPosition = ((UIList)ToLua.CheckObject<UIList>(L, 1)).GetScrolledPosition();
			ToLua.Push(L, scrolledPosition);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetScrolledPosition(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			UIList obj = (UIList)ToLua.CheckObject<UIList>(L, 1);
			Vector2 scrolledPosition = ToLua.ToVector2(L, 2);
			obj.SetScrolledPosition(scrolledPosition);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IsVertical(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = ((UIList)ToLua.CheckObject<UIList>(L, 1)).IsVertical();
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IsHorizontal(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = ((UIList)ToLua.CheckObject<UIList>(L, 1)).IsHorizontal();
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetChildCount(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			int childCount = ((UIList)ToLua.CheckObject<UIList>(L, 1)).GetChildCount();
			LuaDLL.lua_pushinteger(L, childCount);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetContentRect(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			Rect contentRect = ((UIList)ToLua.CheckObject<UIList>(L, 1)).GetContentRect();
			ToLua.PushValue(L, contentRect);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UpdateProp(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
				((UIList)ToLua.CheckObject<UIList>(L, 1)).UpdateProp();
				return 0;
			case 2:
			{
				UIList obj = (UIList)ToLua.CheckObject<UIList>(L, 1);
				bool playing = LuaDLL.luaL_checkboolean(L, 2);
				obj.UpdateProp(playing);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UIList.UpdateProp");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetPageChangeHandler(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			UIList obj = (UIList)ToLua.CheckObject<UIList>(L, 1);
			Action<int> pageChangeHandler = (Action<int>)ToLua.CheckDelegate<Action<int>>(L, 2);
			obj.SetPageChangeHandler(pageChangeHandler);
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
			UIList obj = (UIList)ToLua.CheckObject<UIList>(L, 1);
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
	private static int SetLimitMaxDragCount(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			UIList obj = (UIList)ToLua.CheckObject<UIList>(L, 1);
			int limitMaxDragCount = (int)LuaDLL.luaL_checknumber(L, 2);
			obj.SetLimitMaxDragCount(limitMaxDragCount);
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
			UIList obj = (UIList)ToLua.CheckObject<UIList>(L, 1);
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
	private static int SwitchToPageIndex(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			UIList obj = (UIList)ToLua.CheckObject<UIList>(L, 1);
			int index = (int)LuaDLL.luaL_checknumber(L, 2);
			obj.SwitchToPageIndex(index);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int StopRender(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((UIList)ToLua.CheckObject<UIList>(L, 1)).StopRender();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IsActive(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = ((UIList)ToLua.CheckObject<UIList>(L, 1)).IsActive();
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ShowBlock(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((UIList)ToLua.CheckObject<UIList>(L, 1)).ShowBlock();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int HideBlock(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((UIList)ToLua.CheckObject<UIList>(L, 1)).HideBlock();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int DebugCreateItem(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			GameObject o = ((UIList)ToLua.CheckObject<UIList>(L, 1)).DebugCreateItem();
			ToLua.PushSealed(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int DebugClearItems(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = ((UIList)ToLua.CheckObject<UIList>(L, 1)).DebugClearItems();
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Validate(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((UIList)ToLua.CheckObject<UIList>(L, 1)).Validate();
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
	private static int get_OUT_OF_BOUND_POSITION(IntPtr L)
	{
		try
		{
			ToLua.Push(L, UIList.OUT_OF_BOUND_POSITION);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_ItemPrefab(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GameObject itemPrefab = ((UIList)obj).ItemPrefab;
			ToLua.PushSealed(L, itemPrefab);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index ItemPrefab on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get__spacing(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector2 spacing = ((UIList)obj)._spacing;
			ToLua.Push(L, spacing);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index _spacing on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get__padding(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RectOffset padding = ((UIList)obj)._padding;
			ToLua.PushObject(L, padding);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index _padding on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_content(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RectTransform content = ((UIList)obj).content;
			ToLua.PushSealed(L, content);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index content on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get__viewport(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RectTransform viewport = ((UIList)obj)._viewport;
			ToLua.PushSealed(L, viewport);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index _viewport on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_moveSeconds(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float moveSeconds = ((UIList)obj).moveSeconds;
			LuaDLL.lua_pushnumber(L, moveSeconds);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index moveSeconds on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Orientation(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Orientation orientation = ((UIList)obj).Orientation;
			ToLua.Push(L, orientation);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index Orientation on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_uiListAlignment(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UIListAlignment uiListAlignment = ((UIList)obj).uiListAlignment;
			ToLua.Push(L, uiListAlignment);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index uiListAlignment on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_uiListAlignmentWhenLess(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UIListAlignmentWhenLess uiListAlignmentWhenLess = ((UIList)obj).uiListAlignmentWhenLess;
			ToLua.Push(L, uiListAlignmentWhenLess);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index uiListAlignmentWhenLess on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_AdapterType(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			AdapterType adapterType = ((UIList)obj).AdapterType;
			ToLua.Push(L, adapterType);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index AdapterType on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_FixColOrRowCount(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int fixColOrRowCount = ((UIList)obj).FixColOrRowCount;
			LuaDLL.lua_pushinteger(L, fixColOrRowCount);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index FixColOrRowCount on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_IsVirtual(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isVirtual = ((UIList)obj).IsVirtual;
			LuaDLL.lua_pushboolean(L, isVirtual);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index IsVirtual on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_AppearType(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UIListAppearType appearType = ((UIList)obj).AppearType;
			ToLua.Push(L, appearType);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index AppearType on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_SplitTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float splitTime = ((UIList)obj).SplitTime;
			LuaDLL.lua_pushnumber(L, splitTime);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index SplitTime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_AutoSplit(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool autoSplit = ((UIList)obj).AutoSplit;
			LuaDLL.lua_pushboolean(L, autoSplit);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index AutoSplit on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_SingleRowColAutoSplit(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool singleRowColAutoSplit = ((UIList)obj).SingleRowColAutoSplit;
			LuaDLL.lua_pushboolean(L, singleRowColAutoSplit);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index SingleRowColAutoSplit on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_PageMode(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool pageMode = ((UIList)obj).PageMode;
			LuaDLL.lua_pushboolean(L, pageMode);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index PageMode on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_AlwaysPageCenter(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool alwaysPageCenter = ((UIList)obj).AlwaysPageCenter;
			LuaDLL.lua_pushboolean(L, alwaysPageCenter);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index AlwaysPageCenter on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_SingleRowColFitItemSize(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool singleRowColFitItemSize = ((UIList)obj).SingleRowColFitItemSize;
			LuaDLL.lua_pushboolean(L, singleRowColFitItemSize);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index SingleRowColFitItemSize on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_drag_threshold(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float drag_threshold = ((UIList)obj).drag_threshold;
			LuaDLL.lua_pushnumber(L, drag_threshold);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index drag_threshold on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get__pool(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UIListPool pool = ((UIList)obj)._pool;
			ToLua.PushObject(L, pool);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index _pool on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get__scrollRect(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ScrollRect scrollRect = ((UIList)obj)._scrollRect;
			ToLua.Push(L, scrollRect);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index _scrollRect on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get__itemDic(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Dictionary<int, GameObject> itemDic = ((UIList)obj)._itemDic;
			ToLua.PushSealed(L, itemDic);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index _itemDic on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get__itemNum(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int itemNum = ((UIList)obj)._itemNum;
			LuaDLL.lua_pushinteger(L, itemNum);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index _itemNum on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get__itemRenderer(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Action<int, GameObject> itemRenderer = ((UIList)obj)._itemRenderer;
			ToLua.Push(L, itemRenderer);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index _itemRenderer on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get__itemRecycleHandler(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Action<int, GameObject> itemRecycleHandler = ((UIList)obj)._itemRecycleHandler;
			ToLua.Push(L, itemRecycleHandler);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index _itemRecycleHandler on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get__headTailChangeHandler(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Action<int, int> headTailChangeHandler = ((UIList)obj)._headTailChangeHandler;
			ToLua.Push(L, headTailChangeHandler);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index _headTailChangeHandler on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get__pageChangeHandler(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Action<int> pageChangeHandler = ((UIList)obj)._pageChangeHandler;
			ToLua.Push(L, pageChangeHandler);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index _pageChangeHandler on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get__uilistCommands(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<UIListCommand> uilistCommands = ((UIList)obj)._uilistCommands;
			ToLua.PushSealed(L, uilistCommands);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index _uilistCommands on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get__colLimit(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int colLimit = ((UIList)obj)._colLimit;
			LuaDLL.lua_pushinteger(L, colLimit);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index _colLimit on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get__rowLimit(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int rowLimit = ((UIList)obj)._rowLimit;
			LuaDLL.lua_pushinteger(L, rowLimit);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index _rowLimit on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_OUT_OF_BOUND_POSITION(IntPtr L)
	{
		try
		{
			UIList.OUT_OF_BOUND_POSITION = ToLua.ToVector3(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_ItemPrefab(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UIList obj2 = (UIList)obj;
			GameObject itemPrefab = (GameObject)ToLua.CheckObject(L, 2, typeof(GameObject));
			obj2.ItemPrefab = itemPrefab;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index ItemPrefab on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set__spacing(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UIList obj2 = (UIList)obj;
			Vector2 spacing = ToLua.ToVector2(L, 2);
			obj2._spacing = spacing;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index _spacing on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set__padding(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UIList obj2 = (UIList)obj;
			RectOffset padding = (RectOffset)ToLua.CheckObject<RectOffset>(L, 2);
			obj2._padding = padding;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index _padding on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_content(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UIList obj2 = (UIList)obj;
			RectTransform content = (RectTransform)ToLua.CheckObject(L, 2, typeof(RectTransform));
			obj2.content = content;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index content on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set__viewport(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UIList obj2 = (UIList)obj;
			RectTransform viewport = (RectTransform)ToLua.CheckObject(L, 2, typeof(RectTransform));
			obj2._viewport = viewport;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index _viewport on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_moveSeconds(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UIList obj2 = (UIList)obj;
			float moveSeconds = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.moveSeconds = moveSeconds;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index moveSeconds on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_Orientation(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UIList obj2 = (UIList)obj;
			Orientation orientation = (Orientation)ToLua.CheckObject(L, 2, typeof(Orientation));
			obj2.Orientation = orientation;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index Orientation on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_uiListAlignment(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UIList obj2 = (UIList)obj;
			UIListAlignment uiListAlignment = (UIListAlignment)ToLua.CheckObject(L, 2, typeof(UIListAlignment));
			obj2.uiListAlignment = uiListAlignment;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index uiListAlignment on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_uiListAlignmentWhenLess(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UIList obj2 = (UIList)obj;
			UIListAlignmentWhenLess uiListAlignmentWhenLess = (UIListAlignmentWhenLess)ToLua.CheckObject(L, 2, typeof(UIListAlignmentWhenLess));
			obj2.uiListAlignmentWhenLess = uiListAlignmentWhenLess;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index uiListAlignmentWhenLess on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_AdapterType(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UIList obj2 = (UIList)obj;
			AdapterType adapterType = (AdapterType)ToLua.CheckObject(L, 2, typeof(AdapterType));
			obj2.AdapterType = adapterType;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index AdapterType on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_FixColOrRowCount(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UIList obj2 = (UIList)obj;
			int fixColOrRowCount = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.FixColOrRowCount = fixColOrRowCount;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index FixColOrRowCount on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_IsVirtual(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UIList obj2 = (UIList)obj;
			bool isVirtual = LuaDLL.luaL_checkboolean(L, 2);
			obj2.IsVirtual = isVirtual;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index IsVirtual on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_AppearType(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UIList obj2 = (UIList)obj;
			UIListAppearType appearType = (UIListAppearType)ToLua.CheckObject(L, 2, typeof(UIListAppearType));
			obj2.AppearType = appearType;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index AppearType on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_SplitTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UIList obj2 = (UIList)obj;
			float splitTime = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.SplitTime = splitTime;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index SplitTime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_AutoSplit(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UIList obj2 = (UIList)obj;
			bool autoSplit = LuaDLL.luaL_checkboolean(L, 2);
			obj2.AutoSplit = autoSplit;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index AutoSplit on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_SingleRowColAutoSplit(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UIList obj2 = (UIList)obj;
			bool singleRowColAutoSplit = LuaDLL.luaL_checkboolean(L, 2);
			obj2.SingleRowColAutoSplit = singleRowColAutoSplit;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index SingleRowColAutoSplit on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_PageMode(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UIList obj2 = (UIList)obj;
			bool pageMode = LuaDLL.luaL_checkboolean(L, 2);
			obj2.PageMode = pageMode;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index PageMode on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_AlwaysPageCenter(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UIList obj2 = (UIList)obj;
			bool alwaysPageCenter = LuaDLL.luaL_checkboolean(L, 2);
			obj2.AlwaysPageCenter = alwaysPageCenter;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index AlwaysPageCenter on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_SingleRowColFitItemSize(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UIList obj2 = (UIList)obj;
			bool singleRowColFitItemSize = LuaDLL.luaL_checkboolean(L, 2);
			obj2.SingleRowColFitItemSize = singleRowColFitItemSize;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index SingleRowColFitItemSize on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_drag_threshold(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UIList obj2 = (UIList)obj;
			float drag_threshold = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.drag_threshold = drag_threshold;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index drag_threshold on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set__pool(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UIList obj2 = (UIList)obj;
			UIListPool pool = (UIListPool)ToLua.CheckObject<UIListPool>(L, 2);
			obj2._pool = pool;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index _pool on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set__scrollRect(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UIList obj2 = (UIList)obj;
			ScrollRect scrollRect = (ScrollRect)ToLua.CheckObject<ScrollRect>(L, 2);
			obj2._scrollRect = scrollRect;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index _scrollRect on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set__itemDic(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UIList obj2 = (UIList)obj;
			Dictionary<int, GameObject> itemDic = (Dictionary<int, GameObject>)ToLua.CheckObject(L, 2, typeof(Dictionary<int, GameObject>));
			obj2._itemDic = itemDic;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index _itemDic on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set__itemNum(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UIList obj2 = (UIList)obj;
			int itemNum = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2._itemNum = itemNum;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index _itemNum on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set__itemRenderer(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UIList obj2 = (UIList)obj;
			Action<int, GameObject> itemRenderer = (Action<int, GameObject>)ToLua.CheckDelegate<Action<int, GameObject>>(L, 2);
			obj2._itemRenderer = itemRenderer;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index _itemRenderer on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set__itemRecycleHandler(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UIList obj2 = (UIList)obj;
			Action<int, GameObject> itemRecycleHandler = (Action<int, GameObject>)ToLua.CheckDelegate<Action<int, GameObject>>(L, 2);
			obj2._itemRecycleHandler = itemRecycleHandler;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index _itemRecycleHandler on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set__headTailChangeHandler(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UIList obj2 = (UIList)obj;
			Action<int, int> headTailChangeHandler = (Action<int, int>)ToLua.CheckDelegate<Action<int, int>>(L, 2);
			obj2._headTailChangeHandler = headTailChangeHandler;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index _headTailChangeHandler on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set__pageChangeHandler(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UIList obj2 = (UIList)obj;
			Action<int> pageChangeHandler = (Action<int>)ToLua.CheckDelegate<Action<int>>(L, 2);
			obj2._pageChangeHandler = pageChangeHandler;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index _pageChangeHandler on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set__uilistCommands(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UIList obj2 = (UIList)obj;
			List<UIListCommand> uilistCommands = (List<UIListCommand>)ToLua.CheckObject(L, 2, typeof(List<UIListCommand>));
			obj2._uilistCommands = uilistCommands;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index _uilistCommands on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set__colLimit(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UIList obj2 = (UIList)obj;
			int colLimit = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2._colLimit = colLimit;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index _colLimit on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set__rowLimit(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UIList obj2 = (UIList)obj;
			int rowLimit = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2._rowLimit = rowLimit;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index _rowLimit on a nil value");
		}
	}
}
