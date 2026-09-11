using System;
using LuaInterface;
using UnityEngine;
using UnityEngine.UI;

public class UnityEngine_UI_ImageWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(Image), typeof(MaskableGraphic));
		L.RegFunction("DisableSpriteOptimizations", DisableSpriteOptimizations);
		L.RegFunction("OnBeforeSerialize", OnBeforeSerialize);
		L.RegFunction("OnAfterDeserialize", OnAfterDeserialize);
		L.RegFunction("SetNativeSize", SetNativeSize);
		L.RegFunction("CalculateLayoutInputHorizontal", CalculateLayoutInputHorizontal);
		L.RegFunction("CalculateLayoutInputVertical", CalculateLayoutInputVertical);
		L.RegFunction("IsRaycastLocationValid", IsRaycastLocationValid);
		L.RegFunction("ShowHideByScale", ShowHideByScale);
		L.RegFunction("SetHorizontalOrVerticalLayoutGroupSpacing", SetHorizontalOrVerticalLayoutGroupSpacing);
		L.RegFunction("GetHorizontalOrVerticalLayoutGroupSpacing", GetHorizontalOrVerticalLayoutGroupSpacing);
		L.RegFunction("GetLayoutGroupPaddingTop", GetLayoutGroupPaddingTop);
		L.RegFunction("SetImageRectEx", SetImageRectEx);
		L.RegFunction("SetImageColor", SetImageColor);
		L.RegFunction("SetShadowsColor", SetShadowsColor);
		L.RegFunction("SetActive", SetActive);
		L.RegFunction("SetRaycastTarget", SetRaycastTarget);
		L.RegFunction("SetAlpha", SetAlpha);
		L.RegFunction("SetGraphicAlpha", SetGraphicAlpha);
		L.RegFunction("SetGraphicColor", SetGraphicColor);
		L.RegFunction("SetColor", SetColor);
		L.RegFunction("SetGraphicWhite", SetGraphicWhite);
		L.RegFunction("SetGraphicGray", SetGraphicGray);
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
		L.RegFunction("SetLocalPositionDeltaZ", SetLocalPositionDeltaZ);
		L.RegFunction("SetLocalPositionDeltaY", SetLocalPositionDeltaY);
		L.RegFunction("SetLocalPositionDeltaX", SetLocalPositionDeltaX);
		L.RegFunction("SetLocalPositionDelta", SetLocalPositionDelta);
		L.RegFunction("SetLocalPositionZ", SetLocalPositionZ);
		L.RegFunction("SetLocalPositionY", SetLocalPositionY);
		L.RegFunction("SetLocalPositionX", SetLocalPositionX);
		L.RegFunction("SetLocalPosition", SetLocalPosition);
		L.RegFunction("SetLocalPositionEx", SetLocalPositionEx);
		L.RegFunction("SetLocalPositionZero", SetLocalPositionZero);
		L.RegFunction("SetParentPure", SetParentPure);
		L.RegFunction("SetParentAndInitTrans", SetParentAndInitTrans);
		L.RegFunction("InitTransform", InitTransform);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("sprite", get_sprite, set_sprite);
		L.RegVar("overrideSprite", get_overrideSprite, set_overrideSprite);
		L.RegVar("type", get_type, set_type);
		L.RegVar("preserveAspect", get_preserveAspect, set_preserveAspect);
		L.RegVar("fillCenter", get_fillCenter, set_fillCenter);
		L.RegVar("fillMethod", get_fillMethod, set_fillMethod);
		L.RegVar("fillAmount", get_fillAmount, set_fillAmount);
		L.RegVar("fillClockwise", get_fillClockwise, set_fillClockwise);
		L.RegVar("fillOrigin", get_fillOrigin, set_fillOrigin);
		L.RegVar("alphaHitTestMinimumThreshold", get_alphaHitTestMinimumThreshold, set_alphaHitTestMinimumThreshold);
		L.RegVar("useSpriteMesh", get_useSpriteMesh, set_useSpriteMesh);
		L.RegVar("defaultETC1GraphicMaterial", get_defaultETC1GraphicMaterial, null);
		L.RegVar("mainTexture", get_mainTexture, null);
		L.RegVar("hasBorder", get_hasBorder, null);
		L.RegVar("pixelsPerUnitMultiplier", get_pixelsPerUnitMultiplier, set_pixelsPerUnitMultiplier);
		L.RegVar("pixelsPerUnit", get_pixelsPerUnit, null);
		L.RegVar("material", get_material, set_material);
		L.RegVar("minWidth", get_minWidth, null);
		L.RegVar("preferredWidth", get_preferredWidth, null);
		L.RegVar("flexibleWidth", get_flexibleWidth, null);
		L.RegVar("minHeight", get_minHeight, null);
		L.RegVar("preferredHeight", get_preferredHeight, null);
		L.RegVar("flexibleHeight", get_flexibleHeight, null);
		L.RegVar("layoutPriority", get_layoutPriority, null);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int DisableSpriteOptimizations(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((Image)ToLua.CheckObject<Image>(L, 1)).DisableSpriteOptimizations();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OnBeforeSerialize(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((Image)ToLua.CheckObject<Image>(L, 1)).OnBeforeSerialize();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OnAfterDeserialize(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((Image)ToLua.CheckObject<Image>(L, 1)).OnAfterDeserialize();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetNativeSize(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((Image)ToLua.CheckObject<Image>(L, 1)).SetNativeSize();
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
			((Image)ToLua.CheckObject<Image>(L, 1)).CalculateLayoutInputHorizontal();
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
			((Image)ToLua.CheckObject<Image>(L, 1)).CalculateLayoutInputVertical();
			return 0;
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
			Image obj = (Image)ToLua.CheckObject<Image>(L, 1);
			Vector2 screenPoint = ToLua.ToVector2(L, 2);
			Camera eventCamera = (Camera)ToLua.CheckObject(L, 3, typeof(Camera));
			bool value = obj.IsRaycastLocationValid(screenPoint, eventCamera);
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
			Image cmpt = (Image)ToLua.CheckObject<Image>(L, 1);
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
			Image cmpt = (Image)ToLua.CheckObject<Image>(L, 1);
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
			float horizontalOrVerticalLayoutGroupSpacing = ((Image)ToLua.CheckObject<Image>(L, 1)).GetHorizontalOrVerticalLayoutGroupSpacing();
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
			int layoutGroupPaddingTop = ((Image)ToLua.CheckObject<Image>(L, 1)).GetLayoutGroupPaddingTop();
			LuaDLL.lua_pushinteger(L, layoutGroupPaddingTop);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetImageRectEx(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Image img = (Image)ToLua.CheckObject<Image>(L, 1);
			float preferredSizeScale = (float)LuaDLL.luaL_checknumber(L, 2);
			img.SetImageRectEx(preferredSizeScale);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetImageColor(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Image image = (Image)ToLua.CheckObject<Image>(L, 1);
			Color color = ToLua.ToColor(L, 2);
			image.SetImageColor(color);
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
			Image cmpt = (Image)ToLua.CheckObject<Image>(L, 1);
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
	private static int SetActive(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 2 && TypeChecker.CheckTypes<Image, bool>(L, 1))
			{
				Image img = (Image)ToLua.ToObject(L, 1);
				bool bActive = LuaDLL.lua_toboolean(L, 2);
				img.SetActive(bActive);
				return 0;
			}
			if (num == 2 && TypeChecker.CheckTypes<Component, bool>(L, 1))
			{
				Image img2 = (Image)ToLua.ToObject(L, 1);
				bool bActive2 = LuaDLL.lua_toboolean(L, 2);
				img2.SetActive(bActive2);
				return 0;
			}
			if (num == 3)
			{
				Image img3 = (Image)ToLua.CheckObject<Image>(L, 1);
				bool bActive3 = LuaDLL.luaL_checkboolean(L, 2);
				bool isRealActive = LuaDLL.luaL_checkboolean(L, 3);
				img3.SetActive(bActive3, isRealActive);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.UI.Image.SetActive");
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
			Image cmpt = (Image)ToLua.CheckObject<Image>(L, 1);
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
			Image cmpt = (Image)ToLua.CheckObject<Image>(L, 1);
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
	private static int SetGraphicAlpha(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Image gp = (Image)ToLua.CheckObject<Image>(L, 1);
			float a = (float)LuaDLL.luaL_checknumber(L, 2);
			gp.SetGraphicAlpha(a);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetGraphicColor(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 5);
			Image graphic = (Image)ToLua.CheckObject<Image>(L, 1);
			float r = (float)LuaDLL.luaL_checknumber(L, 2);
			float g = (float)LuaDLL.luaL_checknumber(L, 3);
			float b = (float)LuaDLL.luaL_checknumber(L, 4);
			float a = (float)LuaDLL.luaL_checknumber(L, 5);
			graphic.SetGraphicColor(r, g, b, a);
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
			Image cmpt = (Image)ToLua.CheckObject<Image>(L, 1);
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
	private static int SetGraphicWhite(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((Image)ToLua.CheckObject<Image>(L, 1)).SetGraphicWhite();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetGraphicGray(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((Image)ToLua.CheckObject<Image>(L, 1)).SetGraphicGray();
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
			((Image)ToLua.CheckObject<Image>(L, 1)).GetRectSize(out var width, out var height);
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
			((Image)ToLua.CheckObject<Image>(L, 1)).GetRectHeight(out var height);
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
			float rectWidth = ((Image)ToLua.CheckObject<Image>(L, 1)).GetRectWidth();
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
			Image cmpt = (Image)ToLua.CheckObject<Image>(L, 1);
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
			Image cmpt = (Image)ToLua.CheckObject<Image>(L, 1);
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
			Image cmpt = (Image)ToLua.CheckObject<Image>(L, 1);
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
			Image cmpt = (Image)ToLua.CheckObject<Image>(L, 1);
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
			((Image)ToLua.CheckObject<Image>(L, 1)).GetAnchoredPositionY(out var y);
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
			((Image)ToLua.CheckObject<Image>(L, 1)).GetAnchoredPositionX(out var x);
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
			((Image)ToLua.CheckObject<Image>(L, 1)).GetAnchoredPosition(out var x, out var y);
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
			((Image)ToLua.CheckObject<Image>(L, 1)).GetSizeDeltaY(out var y);
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
			((Image)ToLua.CheckObject<Image>(L, 1)).GetSizeDeltaX(out var x);
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
			((Image)ToLua.CheckObject<Image>(L, 1)).GetSizeDeltaEx(out var x, out var y);
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
			Image cmpt = (Image)ToLua.CheckObject<Image>(L, 1);
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
			Image cmpt = (Image)ToLua.CheckObject<Image>(L, 1);
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
			Image cmpt = (Image)ToLua.CheckObject<Image>(L, 1);
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
			Image cmpt = (Image)ToLua.CheckObject<Image>(L, 1);
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
				Image cmpt2 = (Image)ToLua.CheckObject<Image>(L, 1);
				float y2 = (float)LuaDLL.luaL_checknumber(L, 2);
				cmpt2.RotateAxisY(y2);
				return 0;
			}
			case 3:
			{
				Image cmpt = (Image)ToLua.CheckObject<Image>(L, 1);
				float y = (float)LuaDLL.luaL_checknumber(L, 2);
				Space relativeTo = (Space)ToLua.CheckObject(L, 3, typeof(Space));
				cmpt.RotateAxisY(y, relativeTo);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.UI.Image.RotateAxisY");
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
			float localEulerAngleZ = ((Image)ToLua.CheckObject<Image>(L, 1)).GetLocalEulerAngleZ();
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
			float localEulerAngleY = ((Image)ToLua.CheckObject<Image>(L, 1)).GetLocalEulerAngleY();
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
			float localEulerAngleX = ((Image)ToLua.CheckObject<Image>(L, 1)).GetLocalEulerAngleX();
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
			float eulerAngleY = ((Image)ToLua.CheckObject<Image>(L, 1)).GetEulerAngleY();
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
			Vector3 eulerAngle = ((Image)ToLua.CheckObject<Image>(L, 1)).GetEulerAngle();
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
			((Image)ToLua.CheckObject<Image>(L, 1)).GetLocalEulerAngle(out var x, out var y, out var z);
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
			Vector3 localEulerAngleOrigin = ((Image)ToLua.CheckObject<Image>(L, 1)).GetLocalEulerAngleOrigin();
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
			Image cmpt = (Image)ToLua.CheckObject<Image>(L, 1);
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
			Image cmpt = (Image)ToLua.CheckObject<Image>(L, 1);
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
			Image cmpt = (Image)ToLua.CheckObject<Image>(L, 1);
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
			Image cmpt = (Image)ToLua.CheckObject<Image>(L, 1);
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
			((Image)ToLua.CheckObject<Image>(L, 1)).SetLocalRotationOne();
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
			float localScaleX = ((Image)ToLua.CheckObject<Image>(L, 1)).GetLocalScaleX();
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
			((Image)ToLua.CheckObject<Image>(L, 1)).GetLocalScaleEx(out var x, out var y, out var z);
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
			Vector3 localScale = ((Image)ToLua.CheckObject<Image>(L, 1)).GetLocalScale();
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
			Image cmpt = (Image)ToLua.CheckObject<Image>(L, 1);
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
			Image cmpt = (Image)ToLua.CheckObject<Image>(L, 1);
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
			Image cmpt = (Image)ToLua.CheckObject<Image>(L, 1);
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
			Image cmpt = (Image)ToLua.CheckObject<Image>(L, 1);
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
			Image cmpt = (Image)ToLua.CheckObject<Image>(L, 1);
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
			Image cmpt = (Image)ToLua.CheckObject<Image>(L, 1);
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
			((Image)ToLua.CheckObject<Image>(L, 1)).SetLocalScaleOne();
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
			((Image)ToLua.CheckObject<Image>(L, 1)).SetLocalScaleZero();
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
			((Image)ToLua.CheckObject<Image>(L, 1)).GetPositionEx(out var x, out var y, out var z);
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
			float positionY = ((Image)ToLua.CheckObject<Image>(L, 1)).GetPositionY();
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
			float positionX = ((Image)ToLua.CheckObject<Image>(L, 1)).GetPositionX();
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
			Vector3 position = ((Image)ToLua.CheckObject<Image>(L, 1)).GetPosition();
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
			Image cmpt = (Image)ToLua.CheckObject<Image>(L, 1);
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
			Image cmpt = (Image)ToLua.CheckObject<Image>(L, 1);
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
			Image cmpt = (Image)ToLua.CheckObject<Image>(L, 1);
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
			Image cmpt = (Image)ToLua.CheckObject<Image>(L, 1);
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
			Image cmpt = (Image)ToLua.CheckObject<Image>(L, 1);
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
			Image cmpt = (Image)ToLua.CheckObject<Image>(L, 1);
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
			((Image)ToLua.CheckObject<Image>(L, 1)).SetPostionZero();
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
			float localPositionY = ((Image)ToLua.CheckObject<Image>(L, 1)).GetLocalPositionY();
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
			float localPositionX = ((Image)ToLua.CheckObject<Image>(L, 1)).GetLocalPositionX();
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
			((Image)ToLua.CheckObject<Image>(L, 1)).GetLocalPositionEx(out var x, out var y, out var z);
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
			Vector3 localPosition = ((Image)ToLua.CheckObject<Image>(L, 1)).GetLocalPosition();
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
			Image cmpt = (Image)ToLua.CheckObject<Image>(L, 1);
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
	private static int SetLocalPositionDeltaZ(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Image cmpt = (Image)ToLua.CheckObject<Image>(L, 1);
			float deltaZ = (float)LuaDLL.luaL_checknumber(L, 2);
			cmpt.SetLocalPositionDeltaZ(deltaZ);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetLocalPositionDeltaY(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Image cmpt = (Image)ToLua.CheckObject<Image>(L, 1);
			float deltaY = (float)LuaDLL.luaL_checknumber(L, 2);
			cmpt.SetLocalPositionDeltaY(deltaY);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetLocalPositionDeltaX(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Image cmpt = (Image)ToLua.CheckObject<Image>(L, 1);
			float deltaX = (float)LuaDLL.luaL_checknumber(L, 2);
			cmpt.SetLocalPositionDeltaX(deltaX);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetLocalPositionDelta(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			Image cmpt = (Image)ToLua.CheckObject<Image>(L, 1);
			float deltaX = (float)LuaDLL.luaL_checknumber(L, 2);
			float deltaY = (float)LuaDLL.luaL_checknumber(L, 3);
			float deltaZ = (float)LuaDLL.luaL_checknumber(L, 4);
			cmpt.SetLocalPositionDelta(deltaX, deltaY, deltaZ);
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
			Image cmpt = (Image)ToLua.CheckObject<Image>(L, 1);
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
			Image cmpt = (Image)ToLua.CheckObject<Image>(L, 1);
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
			Image cmpt = (Image)ToLua.CheckObject<Image>(L, 1);
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
			Image cmpt = (Image)ToLua.CheckObject<Image>(L, 1);
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
			Image cmpt = (Image)ToLua.CheckObject<Image>(L, 1);
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
			((Image)ToLua.CheckObject<Image>(L, 1)).SetLocalPositionZero();
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
			Image cmpt = (Image)ToLua.CheckObject<Image>(L, 1);
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
			Image cmpt = (Image)ToLua.CheckObject<Image>(L, 1);
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
	private static int InitTransform(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((Image)ToLua.CheckObject<Image>(L, 1)).InitTransform();
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
	private static int get_sprite(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Sprite sprite = ((Image)obj).sprite;
			ToLua.PushSealed(L, sprite);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index sprite on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_overrideSprite(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Sprite overrideSprite = ((Image)obj).overrideSprite;
			ToLua.PushSealed(L, overrideSprite);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index overrideSprite on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_type(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Image.Type type = ((Image)obj).type;
			ToLua.Push(L, type);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index type on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_preserveAspect(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool preserveAspect = ((Image)obj).preserveAspect;
			LuaDLL.lua_pushboolean(L, preserveAspect);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index preserveAspect on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_fillCenter(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool fillCenter = ((Image)obj).fillCenter;
			LuaDLL.lua_pushboolean(L, fillCenter);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index fillCenter on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_fillMethod(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Image.FillMethod fillMethod = ((Image)obj).fillMethod;
			ToLua.Push(L, fillMethod);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index fillMethod on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_fillAmount(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float fillAmount = ((Image)obj).fillAmount;
			LuaDLL.lua_pushnumber(L, fillAmount);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index fillAmount on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_fillClockwise(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool fillClockwise = ((Image)obj).fillClockwise;
			LuaDLL.lua_pushboolean(L, fillClockwise);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index fillClockwise on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_fillOrigin(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int fillOrigin = ((Image)obj).fillOrigin;
			LuaDLL.lua_pushinteger(L, fillOrigin);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index fillOrigin on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_alphaHitTestMinimumThreshold(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float alphaHitTestMinimumThreshold = ((Image)obj).alphaHitTestMinimumThreshold;
			LuaDLL.lua_pushnumber(L, alphaHitTestMinimumThreshold);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index alphaHitTestMinimumThreshold on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_useSpriteMesh(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool useSpriteMesh = ((Image)obj).useSpriteMesh;
			LuaDLL.lua_pushboolean(L, useSpriteMesh);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index useSpriteMesh on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_defaultETC1GraphicMaterial(IntPtr L)
	{
		try
		{
			ToLua.Push(L, Image.defaultETC1GraphicMaterial);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_mainTexture(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Texture mainTexture = ((Image)obj).mainTexture;
			ToLua.Push(L, mainTexture);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mainTexture on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_hasBorder(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool hasBorder = ((Image)obj).hasBorder;
			LuaDLL.lua_pushboolean(L, hasBorder);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index hasBorder on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_pixelsPerUnitMultiplier(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float pixelsPerUnitMultiplier = ((Image)obj).pixelsPerUnitMultiplier;
			LuaDLL.lua_pushnumber(L, pixelsPerUnitMultiplier);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index pixelsPerUnitMultiplier on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_pixelsPerUnit(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float pixelsPerUnit = ((Image)obj).pixelsPerUnit;
			LuaDLL.lua_pushnumber(L, pixelsPerUnit);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index pixelsPerUnit on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_material(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Material material = ((Image)obj).material;
			ToLua.Push(L, material);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index material on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_minWidth(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float minWidth = ((Image)obj).minWidth;
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
			float preferredWidth = ((Image)obj).preferredWidth;
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
			float flexibleWidth = ((Image)obj).flexibleWidth;
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
			float minHeight = ((Image)obj).minHeight;
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
			float preferredHeight = ((Image)obj).preferredHeight;
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
			float flexibleHeight = ((Image)obj).flexibleHeight;
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
			int layoutPriority = ((Image)obj).layoutPriority;
			LuaDLL.lua_pushinteger(L, layoutPriority);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index layoutPriority on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_sprite(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Image image = (Image)obj;
			if (TypeChecker.CheckType(L, typeof(string), 2))
			{
				string text = ToLua.ToString(L, 2);
				if (text == null)
				{
					image.sprite = null;
				}
				else
				{
					AtlasManager.GetSpriteWithoutAtlas(image, text);
				}
			}
			else if (TypeChecker.CheckType(L, typeof(Sprite), 2))
			{
				Sprite sprite = (Sprite)ToLua.CheckObject(L, 2, typeof(Sprite));
				image.sprite = sprite;
			}
			else
			{
				image.sprite = null;
			}
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index sprite on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_overrideSprite(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Image obj2 = (Image)obj;
			Sprite overrideSprite = (Sprite)ToLua.CheckObject(L, 2, typeof(Sprite));
			obj2.overrideSprite = overrideSprite;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index overrideSprite on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_type(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Image obj2 = (Image)obj;
			Image.Type type = (Image.Type)ToLua.CheckObject(L, 2, typeof(Image.Type));
			obj2.type = type;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index type on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_preserveAspect(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Image obj2 = (Image)obj;
			bool preserveAspect = LuaDLL.luaL_checkboolean(L, 2);
			obj2.preserveAspect = preserveAspect;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index preserveAspect on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_fillCenter(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Image obj2 = (Image)obj;
			bool fillCenter = LuaDLL.luaL_checkboolean(L, 2);
			obj2.fillCenter = fillCenter;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index fillCenter on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_fillMethod(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Image obj2 = (Image)obj;
			Image.FillMethod fillMethod = (Image.FillMethod)ToLua.CheckObject(L, 2, typeof(Image.FillMethod));
			obj2.fillMethod = fillMethod;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index fillMethod on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_fillAmount(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Image obj2 = (Image)obj;
			float fillAmount = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.fillAmount = fillAmount;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index fillAmount on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_fillClockwise(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Image obj2 = (Image)obj;
			bool fillClockwise = LuaDLL.luaL_checkboolean(L, 2);
			obj2.fillClockwise = fillClockwise;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index fillClockwise on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_fillOrigin(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Image obj2 = (Image)obj;
			int fillOrigin = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.fillOrigin = fillOrigin;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index fillOrigin on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_alphaHitTestMinimumThreshold(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Image obj2 = (Image)obj;
			float alphaHitTestMinimumThreshold = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.alphaHitTestMinimumThreshold = alphaHitTestMinimumThreshold;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index alphaHitTestMinimumThreshold on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_useSpriteMesh(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Image obj2 = (Image)obj;
			bool useSpriteMesh = LuaDLL.luaL_checkboolean(L, 2);
			obj2.useSpriteMesh = useSpriteMesh;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index useSpriteMesh on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_pixelsPerUnitMultiplier(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Image obj2 = (Image)obj;
			float pixelsPerUnitMultiplier = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.pixelsPerUnitMultiplier = pixelsPerUnitMultiplier;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index pixelsPerUnitMultiplier on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_material(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Image obj2 = (Image)obj;
			Material material = (Material)ToLua.CheckObject<Material>(L, 2);
			obj2.material = material;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index material on a nil value");
		}
	}
}
