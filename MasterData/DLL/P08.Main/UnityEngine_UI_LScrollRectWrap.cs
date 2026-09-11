using System;
using LuaInterface;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

public class UnityEngine_UI_LScrollRectWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(LScrollRect), typeof(UIBehaviour));
		L.RegFunction("AddContentPosition", AddContentPosition);
		L.RegFunction("GetViewBounds", GetViewBounds);
		L.RegFunction("GetContentBounds", GetContentBounds);
		L.RegFunction("Rebuild", Rebuild);
		L.RegFunction("LayoutComplete", LayoutComplete);
		L.RegFunction("GraphicUpdateComplete", GraphicUpdateComplete);
		L.RegFunction("IsActive", IsActive);
		L.RegFunction("StopMovement", StopMovement);
		L.RegFunction("OnScroll", OnScroll);
		L.RegFunction("OnInitializePotentialDrag", OnInitializePotentialDrag);
		L.RegFunction("OnBeginDrag", OnBeginDrag);
		L.RegFunction("OnEndDrag", OnEndDrag);
		L.RegFunction("OnDrag", OnDrag);
		L.RegFunction("CalculateLayoutInputHorizontal", CalculateLayoutInputHorizontal);
		L.RegFunction("CalculateLayoutInputVertical", CalculateLayoutInputVertical);
		L.RegFunction("SetLayoutHorizontal", SetLayoutHorizontal);
		L.RegFunction("SetLayoutVertical", SetLayoutVertical);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("onUpdateItems", get_onUpdateItems, set_onUpdateItems);
		L.RegVar("content", get_content, set_content);
		L.RegVar("horizontal", get_horizontal, set_horizontal);
		L.RegVar("vertical", get_vertical, set_vertical);
		L.RegVar("movementType", get_movementType, set_movementType);
		L.RegVar("elasticity", get_elasticity, set_elasticity);
		L.RegVar("inertia", get_inertia, set_inertia);
		L.RegVar("decelerationRate", get_decelerationRate, set_decelerationRate);
		L.RegVar("scrollSensitivity", get_scrollSensitivity, set_scrollSensitivity);
		L.RegVar("viewport", get_viewport, set_viewport);
		L.RegVar("horizontalScrollbar", get_horizontalScrollbar, set_horizontalScrollbar);
		L.RegVar("verticalScrollbar", get_verticalScrollbar, set_verticalScrollbar);
		L.RegVar("horizontalScrollbarVisibility", get_horizontalScrollbarVisibility, set_horizontalScrollbarVisibility);
		L.RegVar("verticalScrollbarVisibility", get_verticalScrollbarVisibility, set_verticalScrollbarVisibility);
		L.RegVar("horizontalScrollbarSpacing", get_horizontalScrollbarSpacing, set_horizontalScrollbarSpacing);
		L.RegVar("verticalScrollbarSpacing", get_verticalScrollbarSpacing, set_verticalScrollbarSpacing);
		L.RegVar("onValueChanged", get_onValueChanged, set_onValueChanged);
		L.RegVar("velocity", get_velocity, set_velocity);
		L.RegVar("normalizedPosition", get_normalizedPosition, set_normalizedPosition);
		L.RegVar("horizontalNormalizedPosition", get_horizontalNormalizedPosition, set_horizontalNormalizedPosition);
		L.RegVar("verticalNormalizedPosition", get_verticalNormalizedPosition, set_verticalNormalizedPosition);
		L.RegVar("minWidth", get_minWidth, null);
		L.RegVar("preferredWidth", get_preferredWidth, null);
		L.RegVar("flexibleWidth", get_flexibleWidth, null);
		L.RegVar("minHeight", get_minHeight, null);
		L.RegVar("preferredHeight", get_preferredHeight, null);
		L.RegVar("flexibleHeight", get_flexibleHeight, null);
		L.RegVar("layoutPriority", get_layoutPriority, null);
		L.RegFunction("UpdateItems", UnityEngine_UI_LScrollRect_UpdateItems);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int AddContentPosition(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			LScrollRect obj = (LScrollRect)ToLua.CheckObject<LScrollRect>(L, 1);
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
	private static int GetViewBounds(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			Bounds viewBounds = ((LScrollRect)ToLua.CheckObject<LScrollRect>(L, 1)).GetViewBounds();
			ToLua.Push(L, viewBounds);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetContentBounds(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			Bounds contentBounds = ((LScrollRect)ToLua.CheckObject<LScrollRect>(L, 1)).GetContentBounds();
			ToLua.Push(L, contentBounds);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Rebuild(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			LScrollRect obj = (LScrollRect)ToLua.CheckObject<LScrollRect>(L, 1);
			CanvasUpdate executing = (CanvasUpdate)ToLua.CheckObject(L, 2, typeof(CanvasUpdate));
			obj.Rebuild(executing);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LayoutComplete(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((LScrollRect)ToLua.CheckObject<LScrollRect>(L, 1)).LayoutComplete();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GraphicUpdateComplete(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((LScrollRect)ToLua.CheckObject<LScrollRect>(L, 1)).GraphicUpdateComplete();
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
			bool value = ((LScrollRect)ToLua.CheckObject<LScrollRect>(L, 1)).IsActive();
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int StopMovement(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((LScrollRect)ToLua.CheckObject<LScrollRect>(L, 1)).StopMovement();
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
			LScrollRect obj = (LScrollRect)ToLua.CheckObject<LScrollRect>(L, 1);
			PointerEventData data = (PointerEventData)ToLua.CheckObject<PointerEventData>(L, 2);
			obj.OnScroll(data);
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
			LScrollRect obj = (LScrollRect)ToLua.CheckObject<LScrollRect>(L, 1);
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
	private static int OnBeginDrag(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			LScrollRect obj = (LScrollRect)ToLua.CheckObject<LScrollRect>(L, 1);
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
	private static int OnEndDrag(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			LScrollRect obj = (LScrollRect)ToLua.CheckObject<LScrollRect>(L, 1);
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
	private static int OnDrag(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			LScrollRect obj = (LScrollRect)ToLua.CheckObject<LScrollRect>(L, 1);
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
	private static int CalculateLayoutInputHorizontal(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((LScrollRect)ToLua.CheckObject<LScrollRect>(L, 1)).CalculateLayoutInputHorizontal();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CalculateLayoutInputVertical(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((LScrollRect)ToLua.CheckObject<LScrollRect>(L, 1)).CalculateLayoutInputVertical();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetLayoutHorizontal(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((LScrollRect)ToLua.CheckObject<LScrollRect>(L, 1)).SetLayoutHorizontal();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetLayoutVertical(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((LScrollRect)ToLua.CheckObject<LScrollRect>(L, 1)).SetLayoutVertical();
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
	private static int get_onUpdateItems(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LScrollRect.UpdateItems onUpdateItems = ((LScrollRect)obj).onUpdateItems;
			ToLua.Push(L, onUpdateItems);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index onUpdateItems on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_content(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RectTransform content = ((LScrollRect)obj).content;
			ToLua.PushSealed(L, content);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index content on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_horizontal(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool horizontal = ((LScrollRect)obj).horizontal;
			LuaDLL.lua_pushboolean(L, horizontal);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index horizontal on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_vertical(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool vertical = ((LScrollRect)obj).vertical;
			LuaDLL.lua_pushboolean(L, vertical);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index vertical on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_movementType(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LScrollRect.MovementType movementType = ((LScrollRect)obj).movementType;
			ToLua.Push(L, movementType);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index movementType on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_elasticity(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float elasticity = ((LScrollRect)obj).elasticity;
			LuaDLL.lua_pushnumber(L, elasticity);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index elasticity on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_inertia(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool inertia = ((LScrollRect)obj).inertia;
			LuaDLL.lua_pushboolean(L, inertia);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index inertia on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_decelerationRate(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float decelerationRate = ((LScrollRect)obj).decelerationRate;
			LuaDLL.lua_pushnumber(L, decelerationRate);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index decelerationRate on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_scrollSensitivity(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float scrollSensitivity = ((LScrollRect)obj).scrollSensitivity;
			LuaDLL.lua_pushnumber(L, scrollSensitivity);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index scrollSensitivity on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_viewport(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RectTransform viewport = ((LScrollRect)obj).viewport;
			ToLua.PushSealed(L, viewport);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index viewport on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_horizontalScrollbar(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Scrollbar horizontalScrollbar = ((LScrollRect)obj).horizontalScrollbar;
			ToLua.Push(L, horizontalScrollbar);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index horizontalScrollbar on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_verticalScrollbar(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Scrollbar verticalScrollbar = ((LScrollRect)obj).verticalScrollbar;
			ToLua.Push(L, verticalScrollbar);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index verticalScrollbar on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_horizontalScrollbarVisibility(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LScrollRect.ScrollbarVisibility horizontalScrollbarVisibility = ((LScrollRect)obj).horizontalScrollbarVisibility;
			ToLua.Push(L, horizontalScrollbarVisibility);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index horizontalScrollbarVisibility on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_verticalScrollbarVisibility(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LScrollRect.ScrollbarVisibility verticalScrollbarVisibility = ((LScrollRect)obj).verticalScrollbarVisibility;
			ToLua.Push(L, verticalScrollbarVisibility);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index verticalScrollbarVisibility on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_horizontalScrollbarSpacing(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float horizontalScrollbarSpacing = ((LScrollRect)obj).horizontalScrollbarSpacing;
			LuaDLL.lua_pushnumber(L, horizontalScrollbarSpacing);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index horizontalScrollbarSpacing on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_verticalScrollbarSpacing(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float verticalScrollbarSpacing = ((LScrollRect)obj).verticalScrollbarSpacing;
			LuaDLL.lua_pushnumber(L, verticalScrollbarSpacing);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index verticalScrollbarSpacing on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_onValueChanged(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LScrollRect.ScrollRectEvent onValueChanged = ((LScrollRect)obj).onValueChanged;
			ToLua.PushObject(L, onValueChanged);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index onValueChanged on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_velocity(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector2 velocity = ((LScrollRect)obj).velocity;
			ToLua.Push(L, velocity);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index velocity on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_normalizedPosition(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector2 normalizedPosition = ((LScrollRect)obj).normalizedPosition;
			ToLua.Push(L, normalizedPosition);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index normalizedPosition on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_horizontalNormalizedPosition(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float horizontalNormalizedPosition = ((LScrollRect)obj).horizontalNormalizedPosition;
			LuaDLL.lua_pushnumber(L, horizontalNormalizedPosition);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index horizontalNormalizedPosition on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_verticalNormalizedPosition(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float verticalNormalizedPosition = ((LScrollRect)obj).verticalNormalizedPosition;
			LuaDLL.lua_pushnumber(L, verticalNormalizedPosition);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index verticalNormalizedPosition on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_minWidth(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float minWidth = ((LScrollRect)obj).minWidth;
			LuaDLL.lua_pushnumber(L, minWidth);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index minWidth on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_preferredWidth(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float preferredWidth = ((LScrollRect)obj).preferredWidth;
			LuaDLL.lua_pushnumber(L, preferredWidth);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index preferredWidth on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_flexibleWidth(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float flexibleWidth = ((LScrollRect)obj).flexibleWidth;
			LuaDLL.lua_pushnumber(L, flexibleWidth);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index flexibleWidth on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_minHeight(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float minHeight = ((LScrollRect)obj).minHeight;
			LuaDLL.lua_pushnumber(L, minHeight);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index minHeight on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_preferredHeight(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float preferredHeight = ((LScrollRect)obj).preferredHeight;
			LuaDLL.lua_pushnumber(L, preferredHeight);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index preferredHeight on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_flexibleHeight(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float flexibleHeight = ((LScrollRect)obj).flexibleHeight;
			LuaDLL.lua_pushnumber(L, flexibleHeight);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index flexibleHeight on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_layoutPriority(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int layoutPriority = ((LScrollRect)obj).layoutPriority;
			LuaDLL.lua_pushinteger(L, layoutPriority);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index layoutPriority on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_onUpdateItems(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LScrollRect obj2 = (LScrollRect)obj;
			LScrollRect.UpdateItems onUpdateItems = (LScrollRect.UpdateItems)ToLua.CheckDelegate<LScrollRect.UpdateItems>(L, 2);
			obj2.onUpdateItems = onUpdateItems;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index onUpdateItems on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_content(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LScrollRect obj2 = (LScrollRect)obj;
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
	private static int set_horizontal(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LScrollRect obj2 = (LScrollRect)obj;
			bool horizontal = LuaDLL.luaL_checkboolean(L, 2);
			obj2.horizontal = horizontal;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index horizontal on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_vertical(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LScrollRect obj2 = (LScrollRect)obj;
			bool vertical = LuaDLL.luaL_checkboolean(L, 2);
			obj2.vertical = vertical;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index vertical on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_movementType(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LScrollRect obj2 = (LScrollRect)obj;
			LScrollRect.MovementType movementType = (LScrollRect.MovementType)ToLua.CheckObject(L, 2, typeof(LScrollRect.MovementType));
			obj2.movementType = movementType;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index movementType on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_elasticity(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LScrollRect obj2 = (LScrollRect)obj;
			float elasticity = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.elasticity = elasticity;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index elasticity on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_inertia(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LScrollRect obj2 = (LScrollRect)obj;
			bool inertia = LuaDLL.luaL_checkboolean(L, 2);
			obj2.inertia = inertia;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index inertia on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_decelerationRate(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LScrollRect obj2 = (LScrollRect)obj;
			float decelerationRate = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.decelerationRate = decelerationRate;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index decelerationRate on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_scrollSensitivity(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LScrollRect obj2 = (LScrollRect)obj;
			float scrollSensitivity = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.scrollSensitivity = scrollSensitivity;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index scrollSensitivity on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_viewport(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LScrollRect obj2 = (LScrollRect)obj;
			RectTransform viewport = (RectTransform)ToLua.CheckObject(L, 2, typeof(RectTransform));
			obj2.viewport = viewport;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index viewport on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_horizontalScrollbar(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LScrollRect obj2 = (LScrollRect)obj;
			Scrollbar horizontalScrollbar = (Scrollbar)ToLua.CheckObject<Scrollbar>(L, 2);
			obj2.horizontalScrollbar = horizontalScrollbar;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index horizontalScrollbar on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_verticalScrollbar(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LScrollRect obj2 = (LScrollRect)obj;
			Scrollbar verticalScrollbar = (Scrollbar)ToLua.CheckObject<Scrollbar>(L, 2);
			obj2.verticalScrollbar = verticalScrollbar;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index verticalScrollbar on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_horizontalScrollbarVisibility(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LScrollRect obj2 = (LScrollRect)obj;
			LScrollRect.ScrollbarVisibility horizontalScrollbarVisibility = (LScrollRect.ScrollbarVisibility)ToLua.CheckObject(L, 2, typeof(LScrollRect.ScrollbarVisibility));
			obj2.horizontalScrollbarVisibility = horizontalScrollbarVisibility;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index horizontalScrollbarVisibility on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_verticalScrollbarVisibility(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LScrollRect obj2 = (LScrollRect)obj;
			LScrollRect.ScrollbarVisibility verticalScrollbarVisibility = (LScrollRect.ScrollbarVisibility)ToLua.CheckObject(L, 2, typeof(LScrollRect.ScrollbarVisibility));
			obj2.verticalScrollbarVisibility = verticalScrollbarVisibility;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index verticalScrollbarVisibility on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_horizontalScrollbarSpacing(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LScrollRect obj2 = (LScrollRect)obj;
			float horizontalScrollbarSpacing = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.horizontalScrollbarSpacing = horizontalScrollbarSpacing;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index horizontalScrollbarSpacing on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_verticalScrollbarSpacing(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LScrollRect obj2 = (LScrollRect)obj;
			float verticalScrollbarSpacing = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.verticalScrollbarSpacing = verticalScrollbarSpacing;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index verticalScrollbarSpacing on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_onValueChanged(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LScrollRect obj2 = (LScrollRect)obj;
			LScrollRect.ScrollRectEvent onValueChanged = (LScrollRect.ScrollRectEvent)ToLua.CheckObject<LScrollRect.ScrollRectEvent>(L, 2);
			obj2.onValueChanged = onValueChanged;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index onValueChanged on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_velocity(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LScrollRect obj2 = (LScrollRect)obj;
			Vector2 velocity = ToLua.ToVector2(L, 2);
			obj2.velocity = velocity;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index velocity on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_normalizedPosition(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LScrollRect obj2 = (LScrollRect)obj;
			Vector2 normalizedPosition = ToLua.ToVector2(L, 2);
			obj2.normalizedPosition = normalizedPosition;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index normalizedPosition on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_horizontalNormalizedPosition(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LScrollRect obj2 = (LScrollRect)obj;
			float horizontalNormalizedPosition = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.horizontalNormalizedPosition = horizontalNormalizedPosition;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index horizontalNormalizedPosition on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_verticalNormalizedPosition(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LScrollRect obj2 = (LScrollRect)obj;
			float verticalNormalizedPosition = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.verticalNormalizedPosition = verticalNormalizedPosition;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index verticalNormalizedPosition on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UnityEngine_UI_LScrollRect_UpdateItems(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<LScrollRect.UpdateItems>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<LScrollRect.UpdateItems>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
