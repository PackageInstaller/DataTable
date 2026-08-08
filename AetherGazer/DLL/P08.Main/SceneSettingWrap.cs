using System;
using LuaInterface;
using UnityEngine;
using UnityEngine.Pipelines.SimPipeline;
using UnityEngine.Pipelines.SimPipeline.Scene;

public class SceneSettingWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(SceneSetting), typeof(MonoBehaviour));
		L.RegFunction("SetSettingActive", SetSettingActive);
		L.RegFunction("Invalidate", Invalidate);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("bakeReflectionTex", get_bakeReflectionTex, set_bakeReflectionTex);
		L.RegVar("Current", get_Current, set_Current);
		L.RegVar("innerScene", get_innerScene, null);
		L.RegVar("dynamicLightingEnabled", get_dynamicLightingEnabled, set_dynamicLightingEnabled);
		L.RegVar("tint", get_tint, set_tint);
		L.RegVar("fogColor", get_fogColor, set_fogColor);
		L.RegVar("fogMode", get_fogMode, set_fogMode);
		L.RegVar("fogDensity", get_fogDensity, set_fogDensity);
		L.RegVar("fogStart", get_fogStart, set_fogStart);
		L.RegVar("fogEnd", get_fogEnd, set_fogEnd);
		L.RegVar("fogHeight", get_fogHeight, set_fogHeight);
		L.RegVar("fogHeightGradient", get_fogHeightGradient, set_fogHeightGradient);
		L.RegVar("fogEnabled", get_fogEnabled, set_fogEnabled);
		L.RegVar("dynamicFogColor", get_dynamicFogColor, set_dynamicFogColor);
		L.RegVar("dynamicFogMode", get_dynamicFogMode, set_dynamicFogMode);
		L.RegVar("dynamicFogStart", get_dynamicFogStart, set_dynamicFogStart);
		L.RegVar("dynamicFogEnd", get_dynamicFogEnd, set_dynamicFogEnd);
		L.RegVar("dynamicFogDensity", get_dynamicFogDensity, set_dynamicFogDensity);
		L.RegVar("dynamicFogIntensity", get_dynamicFogIntensity, set_dynamicFogIntensity);
		L.RegVar("dynamicFogHeight", get_dynamicFogHeight, set_dynamicFogHeight);
		L.RegVar("dynamicFogHeightGradient", get_dynamicFogHeightGradient, set_dynamicFogHeightGradient);
		L.RegVar("skybox", get_skybox, set_skybox);
		L.RegVar("tonemapping", get_tonemapping, set_tonemapping);
		L.RegVar("contrast", get_contrast, set_contrast);
		L.RegVar("exposure", get_exposure, set_exposure);
		L.RegVar("threshold", get_threshold, set_threshold);
		L.RegVar("probeLightingBase", get_probeLightingBase, set_probeLightingBase);
		L.RegVar("probeLightingScale", get_probeLightingScale, set_probeLightingScale);
		L.RegVar("bakeReflection", get_bakeReflection, set_bakeReflection);
		L.RegVar("bakeReflectionScale", get_bakeReflectionScale, set_bakeReflectionScale);
		L.RegVar("realReflection", get_realReflection, set_realReflection);
		L.RegVar("realReflectionMode", get_realReflectionMode, null);
		L.RegVar("realReflectionScale", get_realReflectionScale, set_realReflectionScale);
		L.RegVar("waterSurfaceHeight", get_waterSurfaceHeight, set_waterSurfaceHeight);
		L.RegVar("invert", get_invert, set_invert);
		L.RegVar("grayness", get_grayness, set_grayness);
		L.RegVar("darkness", get_darkness, set_darkness);
		L.RegVar("splitSetting", get_splitSetting, null);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetSettingActive(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			SceneSetting obj = (SceneSetting)ToLua.CheckObject<SceneSetting>(L, 1);
			bool settingActive = LuaDLL.luaL_checkboolean(L, 2);
			obj.SetSettingActive(settingActive);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Invalidate(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((SceneSetting)ToLua.CheckObject<SceneSetting>(L, 1)).Invalidate();
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
	private static int get_bakeReflectionTex(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Cubemap bakeReflectionTex = ((SceneSetting)obj).bakeReflectionTex;
			ToLua.PushSealed(L, bakeReflectionTex);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index bakeReflectionTex on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Current(IntPtr L)
	{
		try
		{
			ToLua.Push(L, SceneSetting.Current);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_innerScene(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool innerScene = ((SceneSetting)obj).innerScene;
			LuaDLL.lua_pushboolean(L, innerScene);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index innerScene on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_dynamicLightingEnabled(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool dynamicLightingEnabled = ((SceneSetting)obj).dynamicLightingEnabled;
			LuaDLL.lua_pushboolean(L, dynamicLightingEnabled);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index dynamicLightingEnabled on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_tint(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Color tint = ((SceneSetting)obj).tint;
			ToLua.Push(L, tint);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index tint on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_fogColor(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Color fogColor = ((SceneSetting)obj).fogColor;
			ToLua.Push(L, fogColor);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index fogColor on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_fogMode(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			FogMode fogMode = ((SceneSetting)obj).fogMode;
			ToLua.Push(L, fogMode);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index fogMode on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_fogDensity(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float fogDensity = ((SceneSetting)obj).fogDensity;
			LuaDLL.lua_pushnumber(L, fogDensity);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index fogDensity on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_fogStart(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float fogStart = ((SceneSetting)obj).fogStart;
			LuaDLL.lua_pushnumber(L, fogStart);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index fogStart on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_fogEnd(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float fogEnd = ((SceneSetting)obj).fogEnd;
			LuaDLL.lua_pushnumber(L, fogEnd);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index fogEnd on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_fogHeight(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float fogHeight = ((SceneSetting)obj).fogHeight;
			LuaDLL.lua_pushnumber(L, fogHeight);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index fogHeight on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_fogHeightGradient(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float fogHeightGradient = ((SceneSetting)obj).fogHeightGradient;
			LuaDLL.lua_pushnumber(L, fogHeightGradient);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index fogHeightGradient on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_fogEnabled(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool fogEnabled = ((SceneSetting)obj).fogEnabled;
			LuaDLL.lua_pushboolean(L, fogEnabled);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index fogEnabled on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_dynamicFogColor(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Color dynamicFogColor = ((SceneSetting)obj).dynamicFogColor;
			ToLua.Push(L, dynamicFogColor);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index dynamicFogColor on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_dynamicFogMode(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			FogMode dynamicFogMode = ((SceneSetting)obj).dynamicFogMode;
			ToLua.Push(L, dynamicFogMode);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index dynamicFogMode on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_dynamicFogStart(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float dynamicFogStart = ((SceneSetting)obj).dynamicFogStart;
			LuaDLL.lua_pushnumber(L, dynamicFogStart);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index dynamicFogStart on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_dynamicFogEnd(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float dynamicFogEnd = ((SceneSetting)obj).dynamicFogEnd;
			LuaDLL.lua_pushnumber(L, dynamicFogEnd);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index dynamicFogEnd on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_dynamicFogDensity(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float dynamicFogDensity = ((SceneSetting)obj).dynamicFogDensity;
			LuaDLL.lua_pushnumber(L, dynamicFogDensity);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index dynamicFogDensity on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_dynamicFogIntensity(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float dynamicFogIntensity = ((SceneSetting)obj).dynamicFogIntensity;
			LuaDLL.lua_pushnumber(L, dynamicFogIntensity);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index dynamicFogIntensity on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_dynamicFogHeight(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float dynamicFogHeight = ((SceneSetting)obj).dynamicFogHeight;
			LuaDLL.lua_pushnumber(L, dynamicFogHeight);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index dynamicFogHeight on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_dynamicFogHeightGradient(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float dynamicFogHeightGradient = ((SceneSetting)obj).dynamicFogHeightGradient;
			LuaDLL.lua_pushnumber(L, dynamicFogHeightGradient);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index dynamicFogHeightGradient on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_skybox(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Material skybox = ((SceneSetting)obj).skybox;
			ToLua.Push(L, skybox);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index skybox on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_tonemapping(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool tonemapping = ((SceneSetting)obj).tonemapping;
			LuaDLL.lua_pushboolean(L, tonemapping);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index tonemapping on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_contrast(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float contrast = ((SceneSetting)obj).contrast;
			LuaDLL.lua_pushnumber(L, contrast);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index contrast on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_exposure(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float exposure = ((SceneSetting)obj).exposure;
			LuaDLL.lua_pushnumber(L, exposure);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index exposure on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_threshold(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float threshold = ((SceneSetting)obj).threshold;
			LuaDLL.lua_pushnumber(L, threshold);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index threshold on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_probeLightingBase(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Color probeLightingBase = ((SceneSetting)obj).probeLightingBase;
			ToLua.Push(L, probeLightingBase);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index probeLightingBase on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_probeLightingScale(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float probeLightingScale = ((SceneSetting)obj).probeLightingScale;
			LuaDLL.lua_pushnumber(L, probeLightingScale);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index probeLightingScale on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_bakeReflection(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool bakeReflection = ((SceneSetting)obj).bakeReflection;
			LuaDLL.lua_pushboolean(L, bakeReflection);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index bakeReflection on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_bakeReflectionScale(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float bakeReflectionScale = ((SceneSetting)obj).bakeReflectionScale;
			LuaDLL.lua_pushnumber(L, bakeReflectionScale);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index bakeReflectionScale on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_realReflection(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool realReflection = ((SceneSetting)obj).realReflection;
			LuaDLL.lua_pushboolean(L, realReflection);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index realReflection on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_realReflectionMode(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UnityEngine.Pipelines.SimPipeline.RenderSettings.RealReflectionMode realReflectionMode = ((SceneSetting)obj).realReflectionMode;
			ToLua.Push(L, realReflectionMode);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index realReflectionMode on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_realReflectionScale(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float realReflectionScale = ((SceneSetting)obj).realReflectionScale;
			LuaDLL.lua_pushnumber(L, realReflectionScale);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index realReflectionScale on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_waterSurfaceHeight(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float waterSurfaceHeight = ((SceneSetting)obj).waterSurfaceHeight;
			LuaDLL.lua_pushnumber(L, waterSurfaceHeight);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index waterSurfaceHeight on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_invert(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool invert = ((SceneSetting)obj).invert;
			LuaDLL.lua_pushboolean(L, invert);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index invert on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_grayness(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float grayness = ((SceneSetting)obj).grayness;
			LuaDLL.lua_pushnumber(L, grayness);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index grayness on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_darkness(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float darkness = ((SceneSetting)obj).darkness;
			LuaDLL.lua_pushnumber(L, darkness);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index darkness on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_splitSetting(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SceneSplitSetting splitSetting = ((SceneSetting)obj).splitSetting;
			ToLua.PushObject(L, splitSetting);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index splitSetting on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_bakeReflectionTex(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SceneSetting obj2 = (SceneSetting)obj;
			Cubemap bakeReflectionTex = (Cubemap)ToLua.CheckObject(L, 2, typeof(Cubemap));
			obj2.bakeReflectionTex = bakeReflectionTex;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index bakeReflectionTex on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_Current(IntPtr L)
	{
		try
		{
			SceneSetting.Current = (SceneSetting)ToLua.CheckObject<SceneSetting>(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_dynamicLightingEnabled(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SceneSetting obj2 = (SceneSetting)obj;
			bool dynamicLightingEnabled = LuaDLL.luaL_checkboolean(L, 2);
			obj2.dynamicLightingEnabled = dynamicLightingEnabled;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index dynamicLightingEnabled on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_tint(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SceneSetting obj2 = (SceneSetting)obj;
			Color tint = ToLua.ToColor(L, 2);
			obj2.tint = tint;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index tint on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_fogColor(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SceneSetting obj2 = (SceneSetting)obj;
			Color fogColor = ToLua.ToColor(L, 2);
			obj2.fogColor = fogColor;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index fogColor on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_fogMode(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SceneSetting obj2 = (SceneSetting)obj;
			FogMode fogMode = (FogMode)ToLua.CheckObject(L, 2, typeof(FogMode));
			obj2.fogMode = fogMode;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index fogMode on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_fogDensity(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SceneSetting obj2 = (SceneSetting)obj;
			float fogDensity = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.fogDensity = fogDensity;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index fogDensity on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_fogStart(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SceneSetting obj2 = (SceneSetting)obj;
			float fogStart = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.fogStart = fogStart;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index fogStart on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_fogEnd(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SceneSetting obj2 = (SceneSetting)obj;
			float fogEnd = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.fogEnd = fogEnd;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index fogEnd on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_fogHeight(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SceneSetting obj2 = (SceneSetting)obj;
			float fogHeight = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.fogHeight = fogHeight;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index fogHeight on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_fogHeightGradient(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SceneSetting obj2 = (SceneSetting)obj;
			float fogHeightGradient = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.fogHeightGradient = fogHeightGradient;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index fogHeightGradient on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_fogEnabled(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SceneSetting obj2 = (SceneSetting)obj;
			bool fogEnabled = LuaDLL.luaL_checkboolean(L, 2);
			obj2.fogEnabled = fogEnabled;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index fogEnabled on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_dynamicFogColor(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SceneSetting obj2 = (SceneSetting)obj;
			Color dynamicFogColor = ToLua.ToColor(L, 2);
			obj2.dynamicFogColor = dynamicFogColor;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index dynamicFogColor on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_dynamicFogMode(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SceneSetting obj2 = (SceneSetting)obj;
			FogMode dynamicFogMode = (FogMode)ToLua.CheckObject(L, 2, typeof(FogMode));
			obj2.dynamicFogMode = dynamicFogMode;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index dynamicFogMode on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_dynamicFogStart(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SceneSetting obj2 = (SceneSetting)obj;
			float dynamicFogStart = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.dynamicFogStart = dynamicFogStart;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index dynamicFogStart on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_dynamicFogEnd(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SceneSetting obj2 = (SceneSetting)obj;
			float dynamicFogEnd = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.dynamicFogEnd = dynamicFogEnd;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index dynamicFogEnd on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_dynamicFogDensity(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SceneSetting obj2 = (SceneSetting)obj;
			float dynamicFogDensity = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.dynamicFogDensity = dynamicFogDensity;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index dynamicFogDensity on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_dynamicFogIntensity(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SceneSetting obj2 = (SceneSetting)obj;
			float dynamicFogIntensity = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.dynamicFogIntensity = dynamicFogIntensity;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index dynamicFogIntensity on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_dynamicFogHeight(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SceneSetting obj2 = (SceneSetting)obj;
			float dynamicFogHeight = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.dynamicFogHeight = dynamicFogHeight;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index dynamicFogHeight on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_dynamicFogHeightGradient(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SceneSetting obj2 = (SceneSetting)obj;
			float dynamicFogHeightGradient = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.dynamicFogHeightGradient = dynamicFogHeightGradient;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index dynamicFogHeightGradient on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_skybox(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SceneSetting obj2 = (SceneSetting)obj;
			Material skybox = (Material)ToLua.CheckObject<Material>(L, 2);
			obj2.skybox = skybox;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index skybox on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_tonemapping(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SceneSetting obj2 = (SceneSetting)obj;
			bool tonemapping = LuaDLL.luaL_checkboolean(L, 2);
			obj2.tonemapping = tonemapping;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index tonemapping on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_contrast(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SceneSetting obj2 = (SceneSetting)obj;
			float contrast = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.contrast = contrast;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index contrast on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_exposure(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SceneSetting obj2 = (SceneSetting)obj;
			float exposure = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.exposure = exposure;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index exposure on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_threshold(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SceneSetting obj2 = (SceneSetting)obj;
			float threshold = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.threshold = threshold;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index threshold on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_probeLightingBase(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SceneSetting obj2 = (SceneSetting)obj;
			Color probeLightingBase = ToLua.ToColor(L, 2);
			obj2.probeLightingBase = probeLightingBase;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index probeLightingBase on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_probeLightingScale(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SceneSetting obj2 = (SceneSetting)obj;
			float probeLightingScale = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.probeLightingScale = probeLightingScale;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index probeLightingScale on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_bakeReflection(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SceneSetting obj2 = (SceneSetting)obj;
			bool bakeReflection = LuaDLL.luaL_checkboolean(L, 2);
			obj2.bakeReflection = bakeReflection;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index bakeReflection on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_bakeReflectionScale(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SceneSetting obj2 = (SceneSetting)obj;
			float bakeReflectionScale = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.bakeReflectionScale = bakeReflectionScale;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index bakeReflectionScale on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_realReflection(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SceneSetting obj2 = (SceneSetting)obj;
			bool realReflection = LuaDLL.luaL_checkboolean(L, 2);
			obj2.realReflection = realReflection;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index realReflection on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_realReflectionScale(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SceneSetting obj2 = (SceneSetting)obj;
			float realReflectionScale = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.realReflectionScale = realReflectionScale;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index realReflectionScale on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_waterSurfaceHeight(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SceneSetting obj2 = (SceneSetting)obj;
			float waterSurfaceHeight = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.waterSurfaceHeight = waterSurfaceHeight;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index waterSurfaceHeight on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_invert(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SceneSetting obj2 = (SceneSetting)obj;
			bool invert = LuaDLL.luaL_checkboolean(L, 2);
			obj2.invert = invert;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index invert on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_grayness(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SceneSetting obj2 = (SceneSetting)obj;
			float grayness = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.grayness = grayness;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index grayness on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_darkness(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SceneSetting obj2 = (SceneSetting)obj;
			float darkness = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.darkness = darkness;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index darkness on a nil value");
		}
	}
}
