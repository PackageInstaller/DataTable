using System;
using System.Collections.Generic;
using LuaInterface;
using UnityEngine;
using UnityEngine.Pipelines.SimPipeline.Character;

public class CharacterEffectWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(CharacterEffect), typeof(MonoBehaviour));
		L.RegFunction("GetMaterials", GetMaterials);
		L.RegFunction("ForceUpdate", ForceUpdate);
		L.RegFunction("DisableRenders", DisableRenders);
		L.RegFunction("EnableRenders", EnableRenders);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("_fillRatio", get__fillRatio, set__fillRatio);
		L.RegVar("furRendererList", get_furRendererList, set_furRendererList);
		L.RegVar("rendererList", get_rendererList, set_rendererList);
		L.RegVar("focused", get_focused, set_focused);
		L.RegVar("allOverriderDatas", get_allOverriderDatas, null);
		L.RegVar("allRenderers", get_allRenderers, null);
		L.RegVar("shareMaterial", get_shareMaterial, set_shareMaterial);
		L.RegVar("fillInner", get_fillInner, set_fillInner);
		L.RegVar("fillOuter", get_fillOuter, set_fillOuter);
		L.RegVar("fillColor", get_fillColor, set_fillColor);
		L.RegVar("fillFlat", get_fillFlat, set_fillFlat);
		L.RegVar("fillRatio", get_fillRatio, set_fillRatio);
		L.RegVar("fillSoft", get_fillSoft, set_fillSoft);
		L.RegVar("dissolveFactor", get_dissolveFactor, set_dissolveFactor);
		L.RegVar("ditherAlpha", get_ditherAlpha, set_ditherAlpha);
		L.RegVar("furEnabled", get_furEnabled, set_furEnabled);
		L.RegVar("shadowEnabled", get_shadowEnabled, set_shadowEnabled);
		L.RegVar("shadowHeight", get_shadowHeight, set_shadowHeight);
		L.RegVar("lightInclination", get_lightInclination, set_lightInclination);
		L.RegVar("lightAzimuth", get_lightAzimuth, set_lightAzimuth);
		L.RegVar("UIlightInclination", get_UIlightInclination, set_UIlightInclination);
		L.RegVar("UIlightAzimuth", get_UIlightAzimuth, set_UIlightAzimuth);
		L.RegVar("characterLayer", get_characterLayer, set_characterLayer);
		L.RegVar("rotateSpeed", get_rotateSpeed, set_rotateSpeed);
		L.RegVar("selectedOutline", get_selectedOutline, set_selectedOutline);
		L.RegVar("skipDof", get_skipDof, set_skipDof);
		L.RegVar("imageEffect", get_imageEffect, null);
		L.RegVar("ghostEffect", get_ghostEffect, null);
		L.RegVar("ditherEffect", get_ditherEffect, null);
		L.RegVar("sliceEffect", get_sliceEffect, null);
		L.RegVar("interferenceEffect", get_interferenceEffect, null);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetMaterials(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			CharacterEffect obj = (CharacterEffect)ToLua.CheckObject<CharacterEffect>(L, 1);
			Renderer render = (Renderer)ToLua.CheckObject<Renderer>(L, 2);
			bool isShared = LuaDLL.luaL_checkboolean(L, 3);
			List<Material> materials = obj.GetMaterials(render, isShared);
			ToLua.PushSealed(L, materials);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ForceUpdate(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((CharacterEffect)ToLua.CheckObject<CharacterEffect>(L, 1)).ForceUpdate();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int DisableRenders(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((CharacterEffect)ToLua.CheckObject<CharacterEffect>(L, 1)).DisableRenders();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int EnableRenders(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((CharacterEffect)ToLua.CheckObject<CharacterEffect>(L, 1)).EnableRenders();
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
	private static int get__fillRatio(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float fillRatio = ((CharacterEffect)obj)._fillRatio;
			LuaDLL.lua_pushnumber(L, fillRatio);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index _fillRatio on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_furRendererList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<Renderer> furRendererList = ((CharacterEffect)obj).furRendererList;
			ToLua.PushSealed(L, furRendererList);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index furRendererList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_rendererList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<GroundShadowSystem.RendererInfo> rendererList = ((CharacterEffect)obj).rendererList;
			ToLua.PushSealed(L, rendererList);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index rendererList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_focused(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool focused = ((CharacterEffect)obj).focused;
			LuaDLL.lua_pushboolean(L, focused);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index focused on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_allOverriderDatas(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<CharacterEffect.CharacterEffectOverriderData> allOverriderDatas = ((CharacterEffect)obj).allOverriderDatas;
			ToLua.PushSealed(L, allOverriderDatas);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index allOverriderDatas on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_allRenderers(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<Renderer> allRenderers = ((CharacterEffect)obj).allRenderers;
			ToLua.PushSealed(L, allRenderers);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index allRenderers on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_shareMaterial(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool shareMaterial = ((CharacterEffect)obj).shareMaterial;
			LuaDLL.lua_pushboolean(L, shareMaterial);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index shareMaterial on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_fillInner(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Color fillInner = ((CharacterEffect)obj).fillInner;
			ToLua.Push(L, fillInner);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index fillInner on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_fillOuter(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Color fillOuter = ((CharacterEffect)obj).fillOuter;
			ToLua.Push(L, fillOuter);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index fillOuter on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_fillColor(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Color fillColor = ((CharacterEffect)obj).fillColor;
			ToLua.Push(L, fillColor);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index fillColor on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_fillFlat(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool fillFlat = ((CharacterEffect)obj).fillFlat;
			LuaDLL.lua_pushboolean(L, fillFlat);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index fillFlat on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_fillRatio(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float fillRatio = ((CharacterEffect)obj).fillRatio;
			LuaDLL.lua_pushnumber(L, fillRatio);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index fillRatio on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_fillSoft(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float fillSoft = ((CharacterEffect)obj).fillSoft;
			LuaDLL.lua_pushnumber(L, fillSoft);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index fillSoft on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_dissolveFactor(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float dissolveFactor = ((CharacterEffect)obj).dissolveFactor;
			LuaDLL.lua_pushnumber(L, dissolveFactor);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index dissolveFactor on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_ditherAlpha(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float ditherAlpha = ((CharacterEffect)obj).ditherAlpha;
			LuaDLL.lua_pushnumber(L, ditherAlpha);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index ditherAlpha on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_furEnabled(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool furEnabled = ((CharacterEffect)obj).furEnabled;
			LuaDLL.lua_pushboolean(L, furEnabled);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index furEnabled on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_shadowEnabled(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool shadowEnabled = ((CharacterEffect)obj).shadowEnabled;
			LuaDLL.lua_pushboolean(L, shadowEnabled);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index shadowEnabled on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_shadowHeight(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float shadowHeight = ((CharacterEffect)obj).shadowHeight;
			LuaDLL.lua_pushnumber(L, shadowHeight);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index shadowHeight on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_lightInclination(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float lightInclination = ((CharacterEffect)obj).lightInclination;
			LuaDLL.lua_pushnumber(L, lightInclination);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index lightInclination on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_lightAzimuth(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float lightAzimuth = ((CharacterEffect)obj).lightAzimuth;
			LuaDLL.lua_pushnumber(L, lightAzimuth);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index lightAzimuth on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_UIlightInclination(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float uIlightInclination = ((CharacterEffect)obj).UIlightInclination;
			LuaDLL.lua_pushnumber(L, uIlightInclination);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index UIlightInclination on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_UIlightAzimuth(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float uIlightAzimuth = ((CharacterEffect)obj).UIlightAzimuth;
			LuaDLL.lua_pushnumber(L, uIlightAzimuth);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index UIlightAzimuth on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_characterLayer(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int characterLayer = ((CharacterEffect)obj).characterLayer;
			LuaDLL.lua_pushinteger(L, characterLayer);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index characterLayer on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_rotateSpeed(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float rotateSpeed = ((CharacterEffect)obj).rotateSpeed;
			LuaDLL.lua_pushnumber(L, rotateSpeed);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index rotateSpeed on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_selectedOutline(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool selectedOutline = ((CharacterEffect)obj).selectedOutline;
			LuaDLL.lua_pushboolean(L, selectedOutline);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index selectedOutline on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_skipDof(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool skipDof = ((CharacterEffect)obj).skipDof;
			LuaDLL.lua_pushboolean(L, skipDof);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index skipDof on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_imageEffect(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ImageEffect imageEffect = ((CharacterEffect)obj).imageEffect;
			ToLua.PushObject(L, imageEffect);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index imageEffect on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_ghostEffect(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GhostEffect ghostEffect = ((CharacterEffect)obj).ghostEffect;
			ToLua.PushObject(L, ghostEffect);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index ghostEffect on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_ditherEffect(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			DitherEffect ditherEffect = ((CharacterEffect)obj).ditherEffect;
			ToLua.PushObject(L, ditherEffect);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index ditherEffect on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_sliceEffect(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SliceEffect sliceEffect = ((CharacterEffect)obj).sliceEffect;
			ToLua.PushObject(L, sliceEffect);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index sliceEffect on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_interferenceEffect(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			InterferenceEffect interferenceEffect = ((CharacterEffect)obj).interferenceEffect;
			ToLua.PushObject(L, interferenceEffect);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index interferenceEffect on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set__fillRatio(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CharacterEffect obj2 = (CharacterEffect)obj;
			float fillRatio = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2._fillRatio = fillRatio;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index _fillRatio on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_furRendererList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CharacterEffect obj2 = (CharacterEffect)obj;
			List<Renderer> furRendererList = (List<Renderer>)ToLua.CheckObject(L, 2, typeof(List<Renderer>));
			obj2.furRendererList = furRendererList;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index furRendererList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_rendererList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CharacterEffect obj2 = (CharacterEffect)obj;
			List<GroundShadowSystem.RendererInfo> rendererList = (List<GroundShadowSystem.RendererInfo>)ToLua.CheckObject(L, 2, typeof(List<GroundShadowSystem.RendererInfo>));
			obj2.rendererList = rendererList;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index rendererList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_focused(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CharacterEffect obj2 = (CharacterEffect)obj;
			bool focused = LuaDLL.luaL_checkboolean(L, 2);
			obj2.focused = focused;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index focused on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_shareMaterial(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CharacterEffect obj2 = (CharacterEffect)obj;
			bool shareMaterial = LuaDLL.luaL_checkboolean(L, 2);
			obj2.shareMaterial = shareMaterial;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index shareMaterial on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_fillInner(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CharacterEffect obj2 = (CharacterEffect)obj;
			Color fillInner = ToLua.ToColor(L, 2);
			obj2.fillInner = fillInner;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index fillInner on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_fillOuter(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CharacterEffect obj2 = (CharacterEffect)obj;
			Color fillOuter = ToLua.ToColor(L, 2);
			obj2.fillOuter = fillOuter;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index fillOuter on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_fillColor(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CharacterEffect obj2 = (CharacterEffect)obj;
			Color fillColor = ToLua.ToColor(L, 2);
			obj2.fillColor = fillColor;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index fillColor on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_fillFlat(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CharacterEffect obj2 = (CharacterEffect)obj;
			bool fillFlat = LuaDLL.luaL_checkboolean(L, 2);
			obj2.fillFlat = fillFlat;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index fillFlat on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_fillRatio(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CharacterEffect obj2 = (CharacterEffect)obj;
			float fillRatio = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.fillRatio = fillRatio;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index fillRatio on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_fillSoft(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CharacterEffect obj2 = (CharacterEffect)obj;
			float fillSoft = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.fillSoft = fillSoft;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index fillSoft on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_dissolveFactor(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CharacterEffect obj2 = (CharacterEffect)obj;
			float dissolveFactor = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.dissolveFactor = dissolveFactor;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index dissolveFactor on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_ditherAlpha(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CharacterEffect obj2 = (CharacterEffect)obj;
			float ditherAlpha = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.ditherAlpha = ditherAlpha;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index ditherAlpha on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_furEnabled(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CharacterEffect obj2 = (CharacterEffect)obj;
			bool furEnabled = LuaDLL.luaL_checkboolean(L, 2);
			obj2.furEnabled = furEnabled;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index furEnabled on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_shadowEnabled(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CharacterEffect obj2 = (CharacterEffect)obj;
			bool shadowEnabled = LuaDLL.luaL_checkboolean(L, 2);
			obj2.shadowEnabled = shadowEnabled;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index shadowEnabled on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_shadowHeight(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CharacterEffect obj2 = (CharacterEffect)obj;
			float shadowHeight = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.shadowHeight = shadowHeight;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index shadowHeight on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_lightInclination(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CharacterEffect obj2 = (CharacterEffect)obj;
			float lightInclination = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.lightInclination = lightInclination;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index lightInclination on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_lightAzimuth(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CharacterEffect obj2 = (CharacterEffect)obj;
			float lightAzimuth = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.lightAzimuth = lightAzimuth;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index lightAzimuth on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_UIlightInclination(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CharacterEffect obj2 = (CharacterEffect)obj;
			float uIlightInclination = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.UIlightInclination = uIlightInclination;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index UIlightInclination on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_UIlightAzimuth(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CharacterEffect obj2 = (CharacterEffect)obj;
			float uIlightAzimuth = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.UIlightAzimuth = uIlightAzimuth;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index UIlightAzimuth on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_characterLayer(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CharacterEffect obj2 = (CharacterEffect)obj;
			int characterLayer = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.characterLayer = characterLayer;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index characterLayer on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_rotateSpeed(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CharacterEffect obj2 = (CharacterEffect)obj;
			float rotateSpeed = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.rotateSpeed = rotateSpeed;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index rotateSpeed on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_selectedOutline(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CharacterEffect obj2 = (CharacterEffect)obj;
			bool selectedOutline = LuaDLL.luaL_checkboolean(L, 2);
			obj2.selectedOutline = selectedOutline;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index selectedOutline on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_skipDof(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CharacterEffect obj2 = (CharacterEffect)obj;
			bool skipDof = LuaDLL.luaL_checkboolean(L, 2);
			obj2.skipDof = skipDof;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index skipDof on a nil value");
		}
	}
}
