using System;
using LuaInterface;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Events;
using UnityEngine.UI;

public class UnityEngine_UI_ToggleWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(Toggle), typeof(Selectable));
		L.RegFunction("Rebuild", Rebuild);
		L.RegFunction("LayoutComplete", LayoutComplete);
		L.RegFunction("GraphicUpdateComplete", GraphicUpdateComplete);
		L.RegFunction("SetIsOnWithoutNotify", SetIsOnWithoutNotify);
		L.RegFunction("OnPointerClick", OnPointerClick);
		L.RegFunction("OnSubmit", OnSubmit);
		L.RegFunction("ShowHideByScale", ShowHideByScale);
		L.RegFunction("SetHorizontalOrVerticalLayoutGroupSpacing", SetHorizontalOrVerticalLayoutGroupSpacing);
		L.RegFunction("GetHorizontalOrVerticalLayoutGroupSpacing", GetHorizontalOrVerticalLayoutGroupSpacing);
		L.RegFunction("GetLayoutGroupPaddingTop", GetLayoutGroupPaddingTop);
		L.RegFunction("AddValueChange", AddValueChange);
		L.RegFunction("SetShadowsColor", SetShadowsColor);
		L.RegFunction("SetRaycastTarget", SetRaycastTarget);
		L.RegFunction("SetAlpha", SetAlpha);
		L.RegFunction("SetColor", SetColor);
		L.RegFunction("GetRectSize", GetRectSize);
		L.RegFunction("GetRectHeight", GetRectHeight);
		L.RegFunction("GetRectWidth", GetRectWidth);
		L.RegFunction("SetAnchoredPositionY", SetAnchoredPositionY);
		L.RegFunction("SetAnchoredPositionX", SetAnchoredPositionX);
		L.RegFunction("SetAnchoredPositionEx", SetAnchoredPositionEx);
		L.RegFunction("SetAnchoredPosition", SetAnchoredPosition);
		L.RegFunction("GetAnchoredPositionY", GetAnchoredPositionY);
		L.RegFunction("GetAnchoredPositionX", GetAnchoredPositionX);
		L.RegFunction("GetAnchoredPosition", GetAnchoredPosition);
		L.RegFunction("GetSizeDeltaY", GetSizeDeltaY);
		L.RegFunction("GetSizeDeltaX", GetSizeDeltaX);
		L.RegFunction("GetSizeDeltaEx", GetSizeDeltaEx);
		L.RegFunction("SetSizeDeltaY", SetSizeDeltaY);
		L.RegFunction("SetSizeDeltaX", SetSizeDeltaX);
		L.RegFunction("SetSizeDeltaEx", SetSizeDeltaEx);
		L.RegFunction("SetSizeDelta", SetSizeDelta);
		L.RegFunction("RotateAxisY", RotateAxisY);
		L.RegFunction("GetLocalEulerAngleZ", GetLocalEulerAngleZ);
		L.RegFunction("GetLocalEulerAngleY", GetLocalEulerAngleY);
		L.RegFunction("GetLocalEulerAngleX", GetLocalEulerAngleX);
		L.RegFunction("GetEulerAngleY", GetEulerAngleY);
		L.RegFunction("GetEulerAngle", GetEulerAngle);
		L.RegFunction("GetLocalEulerAngle", GetLocalEulerAngle);
		L.RegFunction("GetLocalEulerAngleOrigin", GetLocalEulerAngleOrigin);
		L.RegFunction("SetLocalEulerAngleY", SetLocalEulerAngleY);
		L.RegFunction("SetLocalEulerAngleZ", SetLocalEulerAngleZ);
		L.RegFunction("SetLocalEulerAngleOrigin", SetLocalEulerAngleOrigin);
		L.RegFunction("SetLocalEulerAngle", SetLocalEulerAngle);
		L.RegFunction("SetLocalRotationOne", SetLocalRotationOne);
		L.RegFunction("GetLocalScaleX", GetLocalScaleX);
		L.RegFunction("GetLocalScaleEx", GetLocalScaleEx);
		L.RegFunction("GetLocalScale", GetLocalScale);
		L.RegFunction("SetLocalScaleZ", SetLocalScaleZ);
		L.RegFunction("SetLocalScaleX", SetLocalScaleX);
		L.RegFunction("SetLocalScaleY", SetLocalScaleY);
		L.RegFunction("SetLocalScaleVal", SetLocalScaleVal);
		L.RegFunction("SetLocalScale", SetLocalScale);
		L.RegFunction("SetLocalScaleEx", SetLocalScaleEx);
		L.RegFunction("SetLocalScaleOne", SetLocalScaleOne);
		L.RegFunction("SetLocalScaleZero", SetLocalScaleZero);
		L.RegFunction("GetPositionEx", GetPositionEx);
		L.RegFunction("GetPositionY", GetPositionY);
		L.RegFunction("GetPositionX", GetPositionX);
		L.RegFunction("GetPosition", GetPosition);
		L.RegFunction("SetPositionFromTarget", SetPositionFromTarget);
		L.RegFunction("SetPositionZ", SetPositionZ);
		L.RegFunction("SetPositionY", SetPositionY);
		L.RegFunction("SetPositionX", SetPositionX);
		L.RegFunction("SetPosition", SetPosition);
		L.RegFunction("SetPositionEx", SetPositionEx);
		L.RegFunction("SetPostionZero", SetPostionZero);
		L.RegFunction("GetLocalPositionY", GetLocalPositionY);
		L.RegFunction("GetLocalPositionX", GetLocalPositionX);
		L.RegFunction("GetLocalPositionEx", GetLocalPositionEx);
		L.RegFunction("GetLocalPosition", GetLocalPosition);
		L.RegFunction("SetLocalPositionFromTarget", SetLocalPositionFromTarget);
		L.RegFunction("SetLocalPositionZ", SetLocalPositionZ);
		L.RegFunction("SetLocalPositionY", SetLocalPositionY);
		L.RegFunction("SetLocalPositionX", SetLocalPositionX);
		L.RegFunction("SetLocalPosition", SetLocalPosition);
		L.RegFunction("SetLocalPositionEx", SetLocalPositionEx);
		L.RegFunction("SetLocalPositionZero", SetLocalPositionZero);
		L.RegFunction("SetParentPure", SetParentPure);
		L.RegFunction("SetParentAndInitTrans", SetParentAndInitTrans);
		L.RegFunction("SetActive", SetActive);
		L.RegFunction("InitTransform", InitTransform);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("toggleTransition", get_toggleTransition, set_toggleTransition);
		L.RegVar("graphic", get_graphic, set_graphic);
		L.RegVar("onValueChanged", get_onValueChanged, set_onValueChanged);
		L.RegVar("group", get_group, set_group);
		L.RegVar("isOn", get_isOn, set_isOn);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Rebuild(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Toggle obj = (Toggle)ToLua.CheckObject<Toggle>(L, 1);
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
			((Toggle)ToLua.CheckObject<Toggle>(L, 1)).LayoutComplete();
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
			((Toggle)ToLua.CheckObject<Toggle>(L, 1)).GraphicUpdateComplete();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetIsOnWithoutNotify(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Toggle obj = (Toggle)ToLua.CheckObject<Toggle>(L, 1);
			bool isOnWithoutNotify = LuaDLL.luaL_checkboolean(L, 2);
			obj.SetIsOnWithoutNotify(isOnWithoutNotify);
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
			Toggle obj = (Toggle)ToLua.CheckObject<Toggle>(L, 1);
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
	private static int OnSubmit(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Toggle obj = (Toggle)ToLua.CheckObject<Toggle>(L, 1);
			BaseEventData eventData = (BaseEventData)ToLua.CheckObject<BaseEventData>(L, 2);
			obj.OnSubmit(eventData);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ShowHideByScale(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Toggle cmpt = (Toggle)ToLua.CheckObject<Toggle>(L, 1);
			bool isShow = LuaDLL.luaL_checkboolean(L, 2);
			cmpt.ShowHideByScale(isShow);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetHorizontalOrVerticalLayoutGroupSpacing(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Toggle cmpt = (Toggle)ToLua.CheckObject<Toggle>(L, 1);
			float spacing = (float)LuaDLL.luaL_checknumber(L, 2);
			cmpt.SetHorizontalOrVerticalLayoutGroupSpacing(spacing);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetHorizontalOrVerticalLayoutGroupSpacing(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			float horizontalOrVerticalLayoutGroupSpacing = ((Toggle)ToLua.CheckObject<Toggle>(L, 1)).GetHorizontalOrVerticalLayoutGroupSpacing();
			LuaDLL.lua_pushnumber(L, horizontalOrVerticalLayoutGroupSpacing);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetLayoutGroupPaddingTop(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			int layoutGroupPaddingTop = ((Toggle)ToLua.CheckObject<Toggle>(L, 1)).GetLayoutGroupPaddingTop();
			LuaDLL.lua_pushinteger(L, layoutGroupPaddingTop);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int AddValueChange(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Toggle tog = (Toggle)ToLua.CheckObject<Toggle>(L, 1);
			UnityAction<bool> action = (UnityAction<bool>)ToLua.CheckDelegate<UnityAction<bool>>(L, 2);
			tog.AddValueChange(action);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetShadowsColor(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Toggle cmpt = (Toggle)ToLua.CheckObject<Toggle>(L, 1);
			Color color = ToLua.ToColor(L, 2);
			cmpt.SetShadowsColor(color);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetRaycastTarget(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Toggle cmpt = (Toggle)ToLua.CheckObject<Toggle>(L, 1);
			bool isTarget = LuaDLL.luaL_checkboolean(L, 2);
			cmpt.SetRaycastTarget(isTarget);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetAlpha(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Toggle cmpt = (Toggle)ToLua.CheckObject<Toggle>(L, 1);
			float a = (float)LuaDLL.luaL_checknumber(L, 2);
			cmpt.SetAlpha(a);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetColor(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Toggle cmpt = (Toggle)ToLua.CheckObject<Toggle>(L, 1);
			Color c = ToLua.ToColor(L, 2);
			cmpt.SetColor(c);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetRectSize(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			((Toggle)ToLua.CheckObject<Toggle>(L, 1)).GetRectSize(out var width, out var height);
			LuaDLL.lua_pushnumber(L, width);
			LuaDLL.lua_pushnumber(L, height);
			return 2;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetRectHeight(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			((Toggle)ToLua.CheckObject<Toggle>(L, 1)).GetRectHeight(out var height);
			LuaDLL.lua_pushnumber(L, height);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetRectWidth(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			float rectWidth = ((Toggle)ToLua.CheckObject<Toggle>(L, 1)).GetRectWidth();
			LuaDLL.lua_pushnumber(L, rectWidth);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetAnchoredPositionY(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Toggle cmpt = (Toggle)ToLua.CheckObject<Toggle>(L, 1);
			float y = (float)LuaDLL.luaL_checknumber(L, 2);
			cmpt.SetAnchoredPositionY(y);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetAnchoredPositionX(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Toggle cmpt = (Toggle)ToLua.CheckObject<Toggle>(L, 1);
			float x = (float)LuaDLL.luaL_checknumber(L, 2);
			cmpt.SetAnchoredPositionX(x);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetAnchoredPositionEx(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			Toggle cmpt = (Toggle)ToLua.CheckObject<Toggle>(L, 1);
			float x = (float)LuaDLL.luaL_checknumber(L, 2);
			float y = (float)LuaDLL.luaL_checknumber(L, 3);
			cmpt.SetAnchoredPositionEx(x, y);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetAnchoredPosition(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Toggle cmpt = (Toggle)ToLua.CheckObject<Toggle>(L, 1);
			Vector2 pos = ToLua.ToVector2(L, 2);
			cmpt.SetAnchoredPosition(pos);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetAnchoredPositionY(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			((Toggle)ToLua.CheckObject<Toggle>(L, 1)).GetAnchoredPositionY(out var y);
			LuaDLL.lua_pushnumber(L, y);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetAnchoredPositionX(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			((Toggle)ToLua.CheckObject<Toggle>(L, 1)).GetAnchoredPositionX(out var x);
			LuaDLL.lua_pushnumber(L, x);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetAnchoredPosition(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			((Toggle)ToLua.CheckObject<Toggle>(L, 1)).GetAnchoredPosition(out var x, out var y);
			LuaDLL.lua_pushnumber(L, x);
			LuaDLL.lua_pushnumber(L, y);
			return 2;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetSizeDeltaY(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			((Toggle)ToLua.CheckObject<Toggle>(L, 1)).GetSizeDeltaY(out var y);
			LuaDLL.lua_pushnumber(L, y);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetSizeDeltaX(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			((Toggle)ToLua.CheckObject<Toggle>(L, 1)).GetSizeDeltaX(out var x);
			LuaDLL.lua_pushnumber(L, x);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetSizeDeltaEx(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			((Toggle)ToLua.CheckObject<Toggle>(L, 1)).GetSizeDeltaEx(out var x, out var y);
			LuaDLL.lua_pushnumber(L, x);
			LuaDLL.lua_pushnumber(L, y);
			return 2;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetSizeDeltaY(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Toggle cmpt = (Toggle)ToLua.CheckObject<Toggle>(L, 1);
			float y = (float)LuaDLL.luaL_checknumber(L, 2);
			cmpt.SetSizeDeltaY(y);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetSizeDeltaX(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Toggle cmpt = (Toggle)ToLua.CheckObject<Toggle>(L, 1);
			float x = (float)LuaDLL.luaL_checknumber(L, 2);
			cmpt.SetSizeDeltaX(x);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetSizeDeltaEx(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			Toggle cmpt = (Toggle)ToLua.CheckObject<Toggle>(L, 1);
			float x = (float)LuaDLL.luaL_checknumber(L, 2);
			float y = (float)LuaDLL.luaL_checknumber(L, 3);
			cmpt.SetSizeDeltaEx(x, y);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetSizeDelta(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Toggle cmpt = (Toggle)ToLua.CheckObject<Toggle>(L, 1);
			Vector2 size = ToLua.ToVector2(L, 2);
			cmpt.SetSizeDelta(size);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RotateAxisY(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				Toggle cmpt2 = (Toggle)ToLua.CheckObject<Toggle>(L, 1);
				float y2 = (float)LuaDLL.luaL_checknumber(L, 2);
				cmpt2.RotateAxisY(y2);
				return 0;
			}
			case 3:
			{
				Toggle cmpt = (Toggle)ToLua.CheckObject<Toggle>(L, 1);
				float y = (float)LuaDLL.luaL_checknumber(L, 2);
				Space relativeTo = (Space)ToLua.CheckObject(L, 3, typeof(Space));
				cmpt.RotateAxisY(y, relativeTo);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.UI.Toggle.RotateAxisY");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetLocalEulerAngleZ(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			float localEulerAngleZ = ((Toggle)ToLua.CheckObject<Toggle>(L, 1)).GetLocalEulerAngleZ();
			LuaDLL.lua_pushnumber(L, localEulerAngleZ);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetLocalEulerAngleY(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			float localEulerAngleY = ((Toggle)ToLua.CheckObject<Toggle>(L, 1)).GetLocalEulerAngleY();
			LuaDLL.lua_pushnumber(L, localEulerAngleY);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetLocalEulerAngleX(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			float localEulerAngleX = ((Toggle)ToLua.CheckObject<Toggle>(L, 1)).GetLocalEulerAngleX();
			LuaDLL.lua_pushnumber(L, localEulerAngleX);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetEulerAngleY(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			float eulerAngleY = ((Toggle)ToLua.CheckObject<Toggle>(L, 1)).GetEulerAngleY();
			LuaDLL.lua_pushnumber(L, eulerAngleY);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetEulerAngle(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			Vector3 eulerAngle = ((Toggle)ToLua.CheckObject<Toggle>(L, 1)).GetEulerAngle();
			ToLua.Push(L, eulerAngle);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetLocalEulerAngle(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			((Toggle)ToLua.CheckObject<Toggle>(L, 1)).GetLocalEulerAngle(out var x, out var y, out var z);
			LuaDLL.lua_pushnumber(L, x);
			LuaDLL.lua_pushnumber(L, y);
			LuaDLL.lua_pushnumber(L, z);
			return 3;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetLocalEulerAngleOrigin(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			Vector3 localEulerAngleOrigin = ((Toggle)ToLua.CheckObject<Toggle>(L, 1)).GetLocalEulerAngleOrigin();
			ToLua.Push(L, localEulerAngleOrigin);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetLocalEulerAngleY(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Toggle cmpt = (Toggle)ToLua.CheckObject<Toggle>(L, 1);
			float y = (float)LuaDLL.luaL_checknumber(L, 2);
			cmpt.SetLocalEulerAngleY(y);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetLocalEulerAngleZ(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Toggle cmpt = (Toggle)ToLua.CheckObject<Toggle>(L, 1);
			float z = (float)LuaDLL.luaL_checknumber(L, 2);
			cmpt.SetLocalEulerAngleZ(z);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetLocalEulerAngleOrigin(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Toggle cmpt = (Toggle)ToLua.CheckObject<Toggle>(L, 1);
			Vector3 v = ToLua.ToVector3(L, 2);
			cmpt.SetLocalEulerAngleOrigin(v);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetLocalEulerAngle(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			Toggle cmpt = (Toggle)ToLua.CheckObject<Toggle>(L, 1);
			float x = (float)LuaDLL.luaL_checknumber(L, 2);
			float y = (float)LuaDLL.luaL_checknumber(L, 3);
			float z = (float)LuaDLL.luaL_checknumber(L, 4);
			cmpt.SetLocalEulerAngle(x, y, z);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetLocalRotationOne(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((Toggle)ToLua.CheckObject<Toggle>(L, 1)).SetLocalRotationOne();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetLocalScaleX(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			float localScaleX = ((Toggle)ToLua.CheckObject<Toggle>(L, 1)).GetLocalScaleX();
			LuaDLL.lua_pushnumber(L, localScaleX);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetLocalScaleEx(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			((Toggle)ToLua.CheckObject<Toggle>(L, 1)).GetLocalScaleEx(out var x, out var y, out var z);
			LuaDLL.lua_pushnumber(L, x);
			LuaDLL.lua_pushnumber(L, y);
			LuaDLL.lua_pushnumber(L, z);
			return 3;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetLocalScale(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			Vector3 localScale = ((Toggle)ToLua.CheckObject<Toggle>(L, 1)).GetLocalScale();
			ToLua.Push(L, localScale);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetLocalScaleZ(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Toggle cmpt = (Toggle)ToLua.CheckObject<Toggle>(L, 1);
			float z = (float)LuaDLL.luaL_checknumber(L, 2);
			cmpt.SetLocalScaleZ(z);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetLocalScaleX(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Toggle cmpt = (Toggle)ToLua.CheckObject<Toggle>(L, 1);
			float x = (float)LuaDLL.luaL_checknumber(L, 2);
			cmpt.SetLocalScaleX(x);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetLocalScaleY(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Toggle cmpt = (Toggle)ToLua.CheckObject<Toggle>(L, 1);
			float y = (float)LuaDLL.luaL_checknumber(L, 2);
			cmpt.SetLocalScaleY(y);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetLocalScaleVal(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Toggle cmpt = (Toggle)ToLua.CheckObject<Toggle>(L, 1);
			float val = (float)LuaDLL.luaL_checknumber(L, 2);
			cmpt.SetLocalScaleVal(val);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetLocalScale(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Toggle cmpt = (Toggle)ToLua.CheckObject<Toggle>(L, 1);
			Vector3 scale = ToLua.ToVector3(L, 2);
			cmpt.SetLocalScale(scale);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetLocalScaleEx(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			Toggle cmpt = (Toggle)ToLua.CheckObject<Toggle>(L, 1);
			float x = (float)LuaDLL.luaL_checknumber(L, 2);
			float y = (float)LuaDLL.luaL_checknumber(L, 3);
			float z = (float)LuaDLL.luaL_checknumber(L, 4);
			cmpt.SetLocalScaleEx(x, y, z);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetLocalScaleOne(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((Toggle)ToLua.CheckObject<Toggle>(L, 1)).SetLocalScaleOne();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetLocalScaleZero(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((Toggle)ToLua.CheckObject<Toggle>(L, 1)).SetLocalScaleZero();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetPositionEx(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			((Toggle)ToLua.CheckObject<Toggle>(L, 1)).GetPositionEx(out var x, out var y, out var z);
			LuaDLL.lua_pushnumber(L, x);
			LuaDLL.lua_pushnumber(L, y);
			LuaDLL.lua_pushnumber(L, z);
			return 3;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetPositionY(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			float positionY = ((Toggle)ToLua.CheckObject<Toggle>(L, 1)).GetPositionY();
			LuaDLL.lua_pushnumber(L, positionY);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetPositionX(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			float positionX = ((Toggle)ToLua.CheckObject<Toggle>(L, 1)).GetPositionX();
			LuaDLL.lua_pushnumber(L, positionX);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetPosition(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			Vector3 position = ((Toggle)ToLua.CheckObject<Toggle>(L, 1)).GetPosition();
			ToLua.Push(L, position);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetPositionFromTarget(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Toggle cmpt = (Toggle)ToLua.CheckObject<Toggle>(L, 1);
			Transform target = (Transform)ToLua.CheckObject<Transform>(L, 2);
			cmpt.SetPositionFromTarget(target);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetPositionZ(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Toggle cmpt = (Toggle)ToLua.CheckObject<Toggle>(L, 1);
			float z = (float)LuaDLL.luaL_checknumber(L, 2);
			cmpt.SetPositionZ(z);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetPositionY(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Toggle cmpt = (Toggle)ToLua.CheckObject<Toggle>(L, 1);
			float y = (float)LuaDLL.luaL_checknumber(L, 2);
			cmpt.SetPositionY(y);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetPositionX(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Toggle cmpt = (Toggle)ToLua.CheckObject<Toggle>(L, 1);
			float x = (float)LuaDLL.luaL_checknumber(L, 2);
			cmpt.SetPositionX(x);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetPosition(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Toggle cmpt = (Toggle)ToLua.CheckObject<Toggle>(L, 1);
			Vector3 pos = ToLua.ToVector3(L, 2);
			cmpt.SetPosition(pos);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetPositionEx(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			Toggle cmpt = (Toggle)ToLua.CheckObject<Toggle>(L, 1);
			float x = (float)LuaDLL.luaL_checknumber(L, 2);
			float y = (float)LuaDLL.luaL_checknumber(L, 3);
			float z = (float)LuaDLL.luaL_checknumber(L, 4);
			cmpt.SetPositionEx(x, y, z);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetPostionZero(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((Toggle)ToLua.CheckObject<Toggle>(L, 1)).SetPostionZero();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetLocalPositionY(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			float localPositionY = ((Toggle)ToLua.CheckObject<Toggle>(L, 1)).GetLocalPositionY();
			LuaDLL.lua_pushnumber(L, localPositionY);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetLocalPositionX(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			float localPositionX = ((Toggle)ToLua.CheckObject<Toggle>(L, 1)).GetLocalPositionX();
			LuaDLL.lua_pushnumber(L, localPositionX);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetLocalPositionEx(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			((Toggle)ToLua.CheckObject<Toggle>(L, 1)).GetLocalPositionEx(out var x, out var y, out var z);
			LuaDLL.lua_pushnumber(L, x);
			LuaDLL.lua_pushnumber(L, y);
			LuaDLL.lua_pushnumber(L, z);
			return 3;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetLocalPosition(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			Vector3 localPosition = ((Toggle)ToLua.CheckObject<Toggle>(L, 1)).GetLocalPosition();
			ToLua.Push(L, localPosition);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetLocalPositionFromTarget(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Toggle cmpt = (Toggle)ToLua.CheckObject<Toggle>(L, 1);
			Transform target = (Transform)ToLua.CheckObject<Transform>(L, 2);
			cmpt.SetLocalPositionFromTarget(target);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetLocalPositionZ(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Toggle cmpt = (Toggle)ToLua.CheckObject<Toggle>(L, 1);
			float z = (float)LuaDLL.luaL_checknumber(L, 2);
			cmpt.SetLocalPositionZ(z);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetLocalPositionY(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Toggle cmpt = (Toggle)ToLua.CheckObject<Toggle>(L, 1);
			float y = (float)LuaDLL.luaL_checknumber(L, 2);
			cmpt.SetLocalPositionY(y);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetLocalPositionX(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Toggle cmpt = (Toggle)ToLua.CheckObject<Toggle>(L, 1);
			float x = (float)LuaDLL.luaL_checknumber(L, 2);
			cmpt.SetLocalPositionX(x);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetLocalPosition(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Toggle cmpt = (Toggle)ToLua.CheckObject<Toggle>(L, 1);
			Vector3 pos = ToLua.ToVector3(L, 2);
			cmpt.SetLocalPosition(pos);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetLocalPositionEx(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			Toggle cmpt = (Toggle)ToLua.CheckObject<Toggle>(L, 1);
			float x = (float)LuaDLL.luaL_checknumber(L, 2);
			float y = (float)LuaDLL.luaL_checknumber(L, 3);
			float z = (float)LuaDLL.luaL_checknumber(L, 4);
			cmpt.SetLocalPositionEx(x, y, z);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetLocalPositionZero(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((Toggle)ToLua.CheckObject<Toggle>(L, 1)).SetLocalPositionZero();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetParentPure(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Toggle cmpt = (Toggle)ToLua.CheckObject<Toggle>(L, 1);
			Component parent = (Component)ToLua.CheckObject<Component>(L, 2);
			cmpt.SetParentPure(parent);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetParentAndInitTrans(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Toggle cmpt = (Toggle)ToLua.CheckObject<Toggle>(L, 1);
			Component parent = (Component)ToLua.CheckObject<Component>(L, 2);
			cmpt.SetParentAndInitTrans(parent);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetActive(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Toggle cmpt = (Toggle)ToLua.CheckObject<Toggle>(L, 1);
			bool bActive = LuaDLL.luaL_checkboolean(L, 2);
			cmpt.SetActive(bActive);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int InitTransform(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((Toggle)ToLua.CheckObject<Toggle>(L, 1)).InitTransform();
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
	private static int get_toggleTransition(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Toggle.ToggleTransition toggleTransition = ((Toggle)obj).toggleTransition;
			ToLua.Push(L, toggleTransition);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index toggleTransition on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_graphic(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Graphic graphic = ((Toggle)obj).graphic;
			ToLua.Push(L, graphic);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index graphic on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_onValueChanged(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Toggle.ToggleEvent onValueChanged = ((Toggle)obj).onValueChanged;
			ToLua.PushObject(L, onValueChanged);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index onValueChanged on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_group(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ToggleGroup obj2 = ((Toggle)obj).group;
			ToLua.Push(L, obj2);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index group on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isOn(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isOn = ((Toggle)obj).isOn;
			LuaDLL.lua_pushboolean(L, isOn);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isOn on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_toggleTransition(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Toggle obj2 = (Toggle)obj;
			Toggle.ToggleTransition toggleTransition = (Toggle.ToggleTransition)ToLua.CheckObject(L, 2, typeof(Toggle.ToggleTransition));
			obj2.toggleTransition = toggleTransition;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index toggleTransition on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_graphic(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Toggle obj2 = (Toggle)obj;
			Graphic graphic = (Graphic)ToLua.CheckObject<Graphic>(L, 2);
			obj2.graphic = graphic;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index graphic on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_onValueChanged(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Toggle obj2 = (Toggle)obj;
			Toggle.ToggleEvent onValueChanged = (Toggle.ToggleEvent)ToLua.CheckObject<Toggle.ToggleEvent>(L, 2);
			obj2.onValueChanged = onValueChanged;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index onValueChanged on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_group(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Toggle obj2 = (Toggle)obj;
			ToggleGroup toggleGroup = (ToggleGroup)ToLua.CheckObject<ToggleGroup>(L, 2);
			obj2.group = toggleGroup;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index group on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_isOn(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Toggle obj2 = (Toggle)obj;
			bool isOn = LuaDLL.luaL_checkboolean(L, 2);
			obj2.isOn = isOn;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isOn on a nil value");
		}
	}
}
