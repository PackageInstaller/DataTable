using System;
using System.Collections.Generic;
using LuaInterface;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

public class UIScrollerWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(UIScroller), typeof(UIBehaviour));
		L.RegFunction("OnScroll", OnScroll);
		L.RegFunction("SetNumItems", SetNumItems);
		L.RegFunction("ScrollToIndex", ScrollToIndex);
		L.RegFunction("SetScrolledPosition", SetScrolledPosition);
		L.RegFunction("GetScrolledPosition", GetScrolledPosition);
		L.RegFunction("UpdateList", UpdateList);
		L.RegFunction("RenderItem", RenderItem);
		L.RegFunction("SetItemRenderer", SetItemRenderer);
		L.RegFunction("GetHeadAndTail", GetHeadAndTail);
		L.RegFunction("ShowBlock", ShowBlock);
		L.RegFunction("HideBlock", HideBlock);
		L.RegFunction("RemoveTween", RemoveTween);
		L.RegFunction("UpdateProp", UpdateProp);
		L.RegFunction("UpdateProgressBar", UpdateProgressBar);
		L.RegFunction("SetItemActive", SetItemActive);
		L.RegFunction("IsVertical", IsVertical);
		L.RegFunction("IsHorizontal", IsHorizontal);
		L.RegFunction("GetContentRect", GetContentRect);
		L.RegFunction("AddOrExecuteCommand", AddOrExecuteCommand);
		L.RegFunction("ExecuteAllCommands", ExecuteAllCommands);
		L.RegFunction("StopRender", StopRender);
		L.RegFunction("DebugCreateItem", DebugCreateItem);
		L.RegFunction("DebugClearItems", DebugClearItems);
		L.RegFunction("Validate", Validate);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("OUT_OF_BOUND_POSITION", get_OUT_OF_BOUND_POSITION, set_OUT_OF_BOUND_POSITION);
		L.RegVar("ItemPrefab", get_ItemPrefab, set_ItemPrefab);
		L.RegVar("content", get_content, set_content);
		L.RegVar("_viewport", get__viewport, set__viewport);
		L.RegVar("Orientation", get_Orientation, set_Orientation);
		L.RegVar("AppearType", get_AppearType, set_AppearType);
		L.RegVar("_itemNum", get__itemNum, set__itemNum);
		L.RegVar("SplitTime", get_SplitTime, set_SplitTime);
		L.RegVar("scrollRect", get_scrollRect, set_scrollRect);
		L.RegVar("_itemDic", get__itemDic, set__itemDic);
		L.RegVar("_itemRenderer", get__itemRenderer, set__itemRenderer);
		L.RegVar("_itemRecycleHandler", get__itemRecycleHandler, set__itemRecycleHandler);
		L.RegVar("_headTailChangeHandler", get__headTailChangeHandler, set__headTailChangeHandler);
		L.RegVar("_pageChangeHandler", get__pageChangeHandler, set__pageChangeHandler);
		L.RegVar("_uilistCommands", get__uilistCommands, set__uilistCommands);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OnScroll(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			UIScroller obj = (UIScroller)ToLua.CheckObject<UIScroller>(L, 1);
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
	private static int SetNumItems(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				UIScroller obj2 = (UIScroller)ToLua.CheckObject<UIScroller>(L, 1);
				int value2 = (int)LuaDLL.luaL_checknumber(L, 2);
				obj2.SetNumItems(value2);
				return 0;
			}
			case 3:
			{
				UIScroller obj = (UIScroller)ToLua.CheckObject<UIScroller>(L, 1);
				int value = (int)LuaDLL.luaL_checknumber(L, 2);
				bool quite = LuaDLL.luaL_checkboolean(L, 3);
				obj.SetNumItems(value, quite);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UIScroller.SetNumItems");
			}
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
				UIScroller obj4 = (UIScroller)ToLua.CheckObject<UIScroller>(L, 1);
				int index4 = (int)LuaDLL.luaL_checknumber(L, 2);
				obj4.ScrollToIndex(index4);
				return 0;
			}
			case 3:
			{
				UIScroller obj3 = (UIScroller)ToLua.CheckObject<UIScroller>(L, 1);
				int index3 = (int)LuaDLL.luaL_checknumber(L, 2);
				bool atCenter3 = LuaDLL.luaL_checkboolean(L, 3);
				obj3.ScrollToIndex(index3, atCenter3);
				return 0;
			}
			case 4:
			{
				UIScroller obj2 = (UIScroller)ToLua.CheckObject<UIScroller>(L, 1);
				int index2 = (int)LuaDLL.luaL_checknumber(L, 2);
				bool atCenter2 = LuaDLL.luaL_checkboolean(L, 3);
				bool anim2 = LuaDLL.luaL_checkboolean(L, 4);
				obj2.ScrollToIndex(index2, atCenter2, anim2);
				return 0;
			}
			case 5:
			{
				UIScroller obj = (UIScroller)ToLua.CheckObject<UIScroller>(L, 1);
				int index = (int)LuaDLL.luaL_checknumber(L, 2);
				bool atCenter = LuaDLL.luaL_checkboolean(L, 3);
				bool anim = LuaDLL.luaL_checkboolean(L, 4);
				float time = (float)LuaDLL.luaL_checknumber(L, 5);
				obj.ScrollToIndex(index, atCenter, anim, time);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UIScroller.ScrollToIndex");
			}
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
			UIScroller obj = (UIScroller)ToLua.CheckObject<UIScroller>(L, 1);
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
	private static int GetScrolledPosition(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			Vector2 scrolledPosition = ((UIScroller)ToLua.CheckObject<UIScroller>(L, 1)).GetScrolledPosition();
			ToLua.Push(L, scrolledPosition);
			return 1;
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
			((UIScroller)ToLua.CheckObject<UIScroller>(L, 1)).UpdateList();
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
			UIScroller obj = (UIScroller)ToLua.CheckObject<UIScroller>(L, 1);
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
	private static int SetItemRenderer(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			UIScroller obj = (UIScroller)ToLua.CheckObject<UIScroller>(L, 1);
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
	private static int GetHeadAndTail(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			Vector2 headAndTail = ((UIScroller)ToLua.CheckObject<UIScroller>(L, 1)).GetHeadAndTail();
			ToLua.Push(L, headAndTail);
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
			((UIScroller)ToLua.CheckObject<UIScroller>(L, 1)).ShowBlock();
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
			((UIScroller)ToLua.CheckObject<UIScroller>(L, 1)).HideBlock();
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
			((UIScroller)ToLua.CheckObject<UIScroller>(L, 1)).RemoveTween();
			return 0;
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
				((UIScroller)ToLua.CheckObject<UIScroller>(L, 1)).UpdateProp();
				return 0;
			case 2:
			{
				UIScroller obj = (UIScroller)ToLua.CheckObject<UIScroller>(L, 1);
				bool playing = LuaDLL.luaL_checkboolean(L, 2);
				obj.UpdateProp(playing);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UIScroller.UpdateProp");
			}
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
			((UIScroller)ToLua.CheckObject<UIScroller>(L, 1)).UpdateProgressBar();
			return 0;
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
			UIScroller obj = (UIScroller)ToLua.CheckObject<UIScroller>(L, 1);
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
	private static int IsVertical(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = ((UIScroller)ToLua.CheckObject<UIScroller>(L, 1)).IsVertical();
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
			bool value = ((UIScroller)ToLua.CheckObject<UIScroller>(L, 1)).IsHorizontal();
			LuaDLL.lua_pushboolean(L, value);
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
			Rect contentRect = ((UIScroller)ToLua.CheckObject<UIScroller>(L, 1)).GetContentRect();
			ToLua.PushValue(L, contentRect);
			return 1;
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
			UIScroller obj = (UIScroller)ToLua.CheckObject<UIScroller>(L, 1);
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
			((UIScroller)ToLua.CheckObject<UIScroller>(L, 1)).ExecuteAllCommands();
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
			((UIScroller)ToLua.CheckObject<UIScroller>(L, 1)).StopRender();
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
			GameObject o = ((UIScroller)ToLua.CheckObject<UIScroller>(L, 1)).DebugCreateItem();
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
			bool value = ((UIScroller)ToLua.CheckObject<UIScroller>(L, 1)).DebugClearItems();
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
			((UIScroller)ToLua.CheckObject<UIScroller>(L, 1)).Validate();
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
			ToLua.Push(L, UIScroller.OUT_OF_BOUND_POSITION);
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
			GameObject itemPrefab = ((UIScroller)obj).ItemPrefab;
			ToLua.PushSealed(L, itemPrefab);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index ItemPrefab on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_content(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RectTransform content = ((UIScroller)obj).content;
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
			RectTransform viewport = ((UIScroller)obj)._viewport;
			ToLua.PushSealed(L, viewport);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index _viewport on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Orientation(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UIScrollerOrientation orientation = ((UIScroller)obj).Orientation;
			ToLua.Push(L, orientation);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index Orientation on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_AppearType(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UIScrollerAppearType appearType = ((UIScroller)obj).AppearType;
			ToLua.Push(L, appearType);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index AppearType on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get__itemNum(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int itemNum = ((UIScroller)obj)._itemNum;
			LuaDLL.lua_pushinteger(L, itemNum);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index _itemNum on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_SplitTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float splitTime = ((UIScroller)obj).SplitTime;
			LuaDLL.lua_pushnumber(L, splitTime);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index SplitTime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_scrollRect(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ScrollRect scrollRect = ((UIScroller)obj).scrollRect;
			ToLua.Push(L, scrollRect);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index scrollRect on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get__itemDic(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Dictionary<int, GameObject> itemDic = ((UIScroller)obj)._itemDic;
			ToLua.PushSealed(L, itemDic);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index _itemDic on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get__itemRenderer(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Action<int, GameObject> itemRenderer = ((UIScroller)obj)._itemRenderer;
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
			Action<int, GameObject> itemRecycleHandler = ((UIScroller)obj)._itemRecycleHandler;
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
			Action<int, int> headTailChangeHandler = ((UIScroller)obj)._headTailChangeHandler;
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
			Action<int> pageChangeHandler = ((UIScroller)obj)._pageChangeHandler;
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
			List<UIListCommand> uilistCommands = ((UIScroller)obj)._uilistCommands;
			ToLua.PushSealed(L, uilistCommands);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index _uilistCommands on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_OUT_OF_BOUND_POSITION(IntPtr L)
	{
		try
		{
			UIScroller.OUT_OF_BOUND_POSITION = ToLua.ToVector3(L, 2);
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
			UIScroller obj2 = (UIScroller)obj;
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
	private static int set_content(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UIScroller obj2 = (UIScroller)obj;
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
			UIScroller obj2 = (UIScroller)obj;
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
	private static int set_Orientation(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UIScroller obj2 = (UIScroller)obj;
			UIScrollerOrientation orientation = (UIScrollerOrientation)ToLua.CheckObject(L, 2, typeof(UIScrollerOrientation));
			obj2.Orientation = orientation;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index Orientation on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_AppearType(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UIScroller obj2 = (UIScroller)obj;
			UIScrollerAppearType appearType = (UIScrollerAppearType)ToLua.CheckObject(L, 2, typeof(UIScrollerAppearType));
			obj2.AppearType = appearType;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index AppearType on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set__itemNum(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UIScroller obj2 = (UIScroller)obj;
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
	private static int set_SplitTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UIScroller obj2 = (UIScroller)obj;
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
	private static int set_scrollRect(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UIScroller obj2 = (UIScroller)obj;
			ScrollRect scrollRect = (ScrollRect)ToLua.CheckObject<ScrollRect>(L, 2);
			obj2.scrollRect = scrollRect;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index scrollRect on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set__itemDic(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UIScroller obj2 = (UIScroller)obj;
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
	private static int set__itemRenderer(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UIScroller obj2 = (UIScroller)obj;
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
			UIScroller obj2 = (UIScroller)obj;
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
			UIScroller obj2 = (UIScroller)obj;
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
			UIScroller obj2 = (UIScroller)obj;
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
			UIScroller obj2 = (UIScroller)obj;
			List<UIListCommand> uilistCommands = (List<UIListCommand>)ToLua.CheckObject(L, 2, typeof(List<UIListCommand>));
			obj2._uilistCommands = uilistCommands;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index _uilistCommands on a nil value");
		}
	}
}
