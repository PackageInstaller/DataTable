using System;
using LuaInterface;
using UnityEngine;

public class UnityEngine_CanvasGroupWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(CanvasGroup), typeof(Behaviour));
		L.RegFunction("IsRaycastLocationValid", IsRaycastLocationValid);
		L.RegFunction("ShowHideByScale", ShowHideByScale);
		L.RegFunction("SetHorizontalOrVerticalLayoutGroupSpacing", SetHorizontalOrVerticalLayoutGroupSpacing);
		L.RegFunction("GetHorizontalOrVerticalLayoutGroupSpacing", GetHorizontalOrVerticalLayoutGroupSpacing);
		L.RegFunction("GetLayoutGroupPaddingTop", GetLayoutGroupPaddingTop);
		L.RegFunction("SetShadowsColor", SetShadowsColor);
		L.RegFunction("GetCanvasGroupAlpha", GetCanvasGroupAlpha);
		L.RegFunction("SetCanvasGroupAlpha", SetCanvasGroupAlpha);
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
		L.RegFunction("New", _CreateUnityEngine_CanvasGroup);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("alpha", get_alpha, set_alpha);
		L.RegVar("interactable", get_interactable, set_interactable);
		L.RegVar("blocksRaycasts", get_blocksRaycasts, set_blocksRaycasts);
		L.RegVar("ignoreParentGroups", get_ignoreParentGroups, set_ignoreParentGroups);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateUnityEngine_CanvasGroup(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				CanvasGroup o = new CanvasGroup();
				ToLua.PushSealed(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: UnityEngine.CanvasGroup.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IsRaycastLocationValid(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			CanvasGroup obj = (CanvasGroup)ToLua.CheckObject(L, 1, typeof(CanvasGroup));
			Vector2 sp = ToLua.ToVector2(L, 2);
			Camera eventCamera = (Camera)ToLua.CheckObject(L, 3, typeof(Camera));
			bool value = obj.IsRaycastLocationValid(sp, eventCamera);
			LuaDLL.lua_pushboolean(L, value);
			return 1;
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
			CanvasGroup cmpt = (CanvasGroup)ToLua.CheckObject(L, 1, typeof(CanvasGroup));
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
			CanvasGroup cmpt = (CanvasGroup)ToLua.CheckObject(L, 1, typeof(CanvasGroup));
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
			float horizontalOrVerticalLayoutGroupSpacing = ((CanvasGroup)ToLua.CheckObject(L, 1, typeof(CanvasGroup))).GetHorizontalOrVerticalLayoutGroupSpacing();
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
			int layoutGroupPaddingTop = ((CanvasGroup)ToLua.CheckObject(L, 1, typeof(CanvasGroup))).GetLayoutGroupPaddingTop();
			LuaDLL.lua_pushinteger(L, layoutGroupPaddingTop);
			return 1;
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
			CanvasGroup cmpt = (CanvasGroup)ToLua.CheckObject(L, 1, typeof(CanvasGroup));
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
	private static int GetCanvasGroupAlpha(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			float canvasGroupAlpha = ((CanvasGroup)ToLua.CheckObject(L, 1, typeof(CanvasGroup))).GetCanvasGroupAlpha();
			LuaDLL.lua_pushnumber(L, canvasGroupAlpha);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetCanvasGroupAlpha(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			CanvasGroup canvasGroup = (CanvasGroup)ToLua.CheckObject(L, 1, typeof(CanvasGroup));
			float a = (float)LuaDLL.luaL_checknumber(L, 2);
			canvasGroup.SetCanvasGroupAlpha(a);
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
			CanvasGroup cmpt = (CanvasGroup)ToLua.CheckObject(L, 1, typeof(CanvasGroup));
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
			CanvasGroup cmpt = (CanvasGroup)ToLua.CheckObject(L, 1, typeof(CanvasGroup));
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
			CanvasGroup cmpt = (CanvasGroup)ToLua.CheckObject(L, 1, typeof(CanvasGroup));
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
			((CanvasGroup)ToLua.CheckObject(L, 1, typeof(CanvasGroup))).GetRectSize(out var width, out var height);
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
			((CanvasGroup)ToLua.CheckObject(L, 1, typeof(CanvasGroup))).GetRectHeight(out var height);
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
			float rectWidth = ((CanvasGroup)ToLua.CheckObject(L, 1, typeof(CanvasGroup))).GetRectWidth();
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
			CanvasGroup cmpt = (CanvasGroup)ToLua.CheckObject(L, 1, typeof(CanvasGroup));
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
			CanvasGroup cmpt = (CanvasGroup)ToLua.CheckObject(L, 1, typeof(CanvasGroup));
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
			CanvasGroup cmpt = (CanvasGroup)ToLua.CheckObject(L, 1, typeof(CanvasGroup));
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
			CanvasGroup cmpt = (CanvasGroup)ToLua.CheckObject(L, 1, typeof(CanvasGroup));
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
			((CanvasGroup)ToLua.CheckObject(L, 1, typeof(CanvasGroup))).GetAnchoredPositionY(out var y);
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
			((CanvasGroup)ToLua.CheckObject(L, 1, typeof(CanvasGroup))).GetAnchoredPositionX(out var x);
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
			((CanvasGroup)ToLua.CheckObject(L, 1, typeof(CanvasGroup))).GetAnchoredPosition(out var x, out var y);
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
			((CanvasGroup)ToLua.CheckObject(L, 1, typeof(CanvasGroup))).GetSizeDeltaY(out var y);
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
			((CanvasGroup)ToLua.CheckObject(L, 1, typeof(CanvasGroup))).GetSizeDeltaX(out var x);
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
			((CanvasGroup)ToLua.CheckObject(L, 1, typeof(CanvasGroup))).GetSizeDeltaEx(out var x, out var y);
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
			CanvasGroup cmpt = (CanvasGroup)ToLua.CheckObject(L, 1, typeof(CanvasGroup));
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
			CanvasGroup cmpt = (CanvasGroup)ToLua.CheckObject(L, 1, typeof(CanvasGroup));
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
			CanvasGroup cmpt = (CanvasGroup)ToLua.CheckObject(L, 1, typeof(CanvasGroup));
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
			CanvasGroup cmpt = (CanvasGroup)ToLua.CheckObject(L, 1, typeof(CanvasGroup));
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
				CanvasGroup cmpt2 = (CanvasGroup)ToLua.CheckObject(L, 1, typeof(CanvasGroup));
				float y2 = (float)LuaDLL.luaL_checknumber(L, 2);
				cmpt2.RotateAxisY(y2);
				return 0;
			}
			case 3:
			{
				CanvasGroup cmpt = (CanvasGroup)ToLua.CheckObject(L, 1, typeof(CanvasGroup));
				float y = (float)LuaDLL.luaL_checknumber(L, 2);
				Space relativeTo = (Space)ToLua.CheckObject(L, 3, typeof(Space));
				cmpt.RotateAxisY(y, relativeTo);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.CanvasGroup.RotateAxisY");
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
			float localEulerAngleZ = ((CanvasGroup)ToLua.CheckObject(L, 1, typeof(CanvasGroup))).GetLocalEulerAngleZ();
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
			float localEulerAngleY = ((CanvasGroup)ToLua.CheckObject(L, 1, typeof(CanvasGroup))).GetLocalEulerAngleY();
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
			float localEulerAngleX = ((CanvasGroup)ToLua.CheckObject(L, 1, typeof(CanvasGroup))).GetLocalEulerAngleX();
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
			float eulerAngleY = ((CanvasGroup)ToLua.CheckObject(L, 1, typeof(CanvasGroup))).GetEulerAngleY();
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
			Vector3 eulerAngle = ((CanvasGroup)ToLua.CheckObject(L, 1, typeof(CanvasGroup))).GetEulerAngle();
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
			((CanvasGroup)ToLua.CheckObject(L, 1, typeof(CanvasGroup))).GetLocalEulerAngle(out var x, out var y, out var z);
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
			Vector3 localEulerAngleOrigin = ((CanvasGroup)ToLua.CheckObject(L, 1, typeof(CanvasGroup))).GetLocalEulerAngleOrigin();
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
			CanvasGroup cmpt = (CanvasGroup)ToLua.CheckObject(L, 1, typeof(CanvasGroup));
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
			CanvasGroup cmpt = (CanvasGroup)ToLua.CheckObject(L, 1, typeof(CanvasGroup));
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
			CanvasGroup cmpt = (CanvasGroup)ToLua.CheckObject(L, 1, typeof(CanvasGroup));
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
			CanvasGroup cmpt = (CanvasGroup)ToLua.CheckObject(L, 1, typeof(CanvasGroup));
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
			((CanvasGroup)ToLua.CheckObject(L, 1, typeof(CanvasGroup))).SetLocalRotationOne();
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
			float localScaleX = ((CanvasGroup)ToLua.CheckObject(L, 1, typeof(CanvasGroup))).GetLocalScaleX();
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
			((CanvasGroup)ToLua.CheckObject(L, 1, typeof(CanvasGroup))).GetLocalScaleEx(out var x, out var y, out var z);
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
			Vector3 localScale = ((CanvasGroup)ToLua.CheckObject(L, 1, typeof(CanvasGroup))).GetLocalScale();
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
			CanvasGroup cmpt = (CanvasGroup)ToLua.CheckObject(L, 1, typeof(CanvasGroup));
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
			CanvasGroup cmpt = (CanvasGroup)ToLua.CheckObject(L, 1, typeof(CanvasGroup));
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
			CanvasGroup cmpt = (CanvasGroup)ToLua.CheckObject(L, 1, typeof(CanvasGroup));
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
			CanvasGroup cmpt = (CanvasGroup)ToLua.CheckObject(L, 1, typeof(CanvasGroup));
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
			CanvasGroup cmpt = (CanvasGroup)ToLua.CheckObject(L, 1, typeof(CanvasGroup));
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
			CanvasGroup cmpt = (CanvasGroup)ToLua.CheckObject(L, 1, typeof(CanvasGroup));
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
			((CanvasGroup)ToLua.CheckObject(L, 1, typeof(CanvasGroup))).SetLocalScaleOne();
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
			((CanvasGroup)ToLua.CheckObject(L, 1, typeof(CanvasGroup))).SetLocalScaleZero();
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
			((CanvasGroup)ToLua.CheckObject(L, 1, typeof(CanvasGroup))).GetPositionEx(out var x, out var y, out var z);
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
			float positionY = ((CanvasGroup)ToLua.CheckObject(L, 1, typeof(CanvasGroup))).GetPositionY();
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
			float positionX = ((CanvasGroup)ToLua.CheckObject(L, 1, typeof(CanvasGroup))).GetPositionX();
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
			Vector3 position = ((CanvasGroup)ToLua.CheckObject(L, 1, typeof(CanvasGroup))).GetPosition();
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
			CanvasGroup cmpt = (CanvasGroup)ToLua.CheckObject(L, 1, typeof(CanvasGroup));
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
			CanvasGroup cmpt = (CanvasGroup)ToLua.CheckObject(L, 1, typeof(CanvasGroup));
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
			CanvasGroup cmpt = (CanvasGroup)ToLua.CheckObject(L, 1, typeof(CanvasGroup));
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
			CanvasGroup cmpt = (CanvasGroup)ToLua.CheckObject(L, 1, typeof(CanvasGroup));
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
			CanvasGroup cmpt = (CanvasGroup)ToLua.CheckObject(L, 1, typeof(CanvasGroup));
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
			CanvasGroup cmpt = (CanvasGroup)ToLua.CheckObject(L, 1, typeof(CanvasGroup));
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
			((CanvasGroup)ToLua.CheckObject(L, 1, typeof(CanvasGroup))).SetPostionZero();
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
			float localPositionY = ((CanvasGroup)ToLua.CheckObject(L, 1, typeof(CanvasGroup))).GetLocalPositionY();
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
			float localPositionX = ((CanvasGroup)ToLua.CheckObject(L, 1, typeof(CanvasGroup))).GetLocalPositionX();
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
			((CanvasGroup)ToLua.CheckObject(L, 1, typeof(CanvasGroup))).GetLocalPositionEx(out var x, out var y, out var z);
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
			Vector3 localPosition = ((CanvasGroup)ToLua.CheckObject(L, 1, typeof(CanvasGroup))).GetLocalPosition();
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
			CanvasGroup cmpt = (CanvasGroup)ToLua.CheckObject(L, 1, typeof(CanvasGroup));
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
			CanvasGroup cmpt = (CanvasGroup)ToLua.CheckObject(L, 1, typeof(CanvasGroup));
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
			CanvasGroup cmpt = (CanvasGroup)ToLua.CheckObject(L, 1, typeof(CanvasGroup));
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
			CanvasGroup cmpt = (CanvasGroup)ToLua.CheckObject(L, 1, typeof(CanvasGroup));
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
			CanvasGroup cmpt = (CanvasGroup)ToLua.CheckObject(L, 1, typeof(CanvasGroup));
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
			CanvasGroup cmpt = (CanvasGroup)ToLua.CheckObject(L, 1, typeof(CanvasGroup));
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
			((CanvasGroup)ToLua.CheckObject(L, 1, typeof(CanvasGroup))).SetLocalPositionZero();
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
			CanvasGroup cmpt = (CanvasGroup)ToLua.CheckObject(L, 1, typeof(CanvasGroup));
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
			CanvasGroup cmpt = (CanvasGroup)ToLua.CheckObject(L, 1, typeof(CanvasGroup));
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
			CanvasGroup cmpt = (CanvasGroup)ToLua.CheckObject(L, 1, typeof(CanvasGroup));
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
			((CanvasGroup)ToLua.CheckObject(L, 1, typeof(CanvasGroup))).InitTransform();
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
	private static int get_alpha(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float alpha = ((CanvasGroup)obj).alpha;
			LuaDLL.lua_pushnumber(L, alpha);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index alpha on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_interactable(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool interactable = ((CanvasGroup)obj).interactable;
			LuaDLL.lua_pushboolean(L, interactable);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index interactable on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_blocksRaycasts(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool blocksRaycasts = ((CanvasGroup)obj).blocksRaycasts;
			LuaDLL.lua_pushboolean(L, blocksRaycasts);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index blocksRaycasts on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_ignoreParentGroups(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool ignoreParentGroups = ((CanvasGroup)obj).ignoreParentGroups;
			LuaDLL.lua_pushboolean(L, ignoreParentGroups);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index ignoreParentGroups on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_alpha(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CanvasGroup obj2 = (CanvasGroup)obj;
			float alpha = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.alpha = alpha;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index alpha on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_interactable(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CanvasGroup obj2 = (CanvasGroup)obj;
			bool interactable = LuaDLL.luaL_checkboolean(L, 2);
			obj2.interactable = interactable;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index interactable on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_blocksRaycasts(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CanvasGroup obj2 = (CanvasGroup)obj;
			bool blocksRaycasts = LuaDLL.luaL_checkboolean(L, 2);
			obj2.blocksRaycasts = blocksRaycasts;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index blocksRaycasts on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_ignoreParentGroups(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CanvasGroup obj2 = (CanvasGroup)obj;
			bool ignoreParentGroups = LuaDLL.luaL_checkboolean(L, 2);
			obj2.ignoreParentGroups = ignoreParentGroups;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index ignoreParentGroups on a nil value");
		}
	}
}
