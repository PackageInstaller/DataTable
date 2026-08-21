using System;
using LuaInterface;
using UnityEngine;
using UnityEngine.Rendering;

public class UnityEngine_RenderSettingsWrap
{
	public static void Register(LuaState L)
	{
		L.BeginStaticLibs("RenderSettings");
		L.RegFunction("__eq", op_Equality);
		L.RegVar("fog", get_fog, set_fog);
		L.RegVar("fogStartDistance", get_fogStartDistance, set_fogStartDistance);
		L.RegVar("fogEndDistance", get_fogEndDistance, set_fogEndDistance);
		L.RegVar("fogMode", get_fogMode, set_fogMode);
		L.RegVar("fogColor", get_fogColor, set_fogColor);
		L.RegVar("fogDensity", get_fogDensity, set_fogDensity);
		L.RegVar("ambientMode", get_ambientMode, set_ambientMode);
		L.RegVar("ambientSkyColor", get_ambientSkyColor, set_ambientSkyColor);
		L.RegVar("ambientEquatorColor", get_ambientEquatorColor, set_ambientEquatorColor);
		L.RegVar("ambientGroundColor", get_ambientGroundColor, set_ambientGroundColor);
		L.RegVar("ambientIntensity", get_ambientIntensity, set_ambientIntensity);
		L.RegVar("ambientLight", get_ambientLight, set_ambientLight);
		L.RegVar("subtractiveShadowColor", get_subtractiveShadowColor, set_subtractiveShadowColor);
		L.RegVar("skybox", get_skybox, set_skybox);
		L.RegVar("sun", get_sun, set_sun);
		L.RegVar("ambientProbe", get_ambientProbe, set_ambientProbe);
		L.RegVar("customReflection", get_customReflection, set_customReflection);
		L.RegVar("reflectionIntensity", get_reflectionIntensity, set_reflectionIntensity);
		L.RegVar("reflectionBounces", get_reflectionBounces, set_reflectionBounces);
		L.RegVar("defaultReflectionMode", get_defaultReflectionMode, set_defaultReflectionMode);
		L.RegVar("defaultReflectionResolution", get_defaultReflectionResolution, set_defaultReflectionResolution);
		L.RegVar("haloStrength", get_haloStrength, set_haloStrength);
		L.RegVar("flareStrength", get_flareStrength, set_flareStrength);
		L.RegVar("flareFadeSpeed", get_flareFadeSpeed, set_flareFadeSpeed);
		L.EndStaticLibs();
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
	private static int get_fog(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, RenderSettings.fog);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_fogStartDistance(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushnumber(L, RenderSettings.fogStartDistance);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_fogEndDistance(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushnumber(L, RenderSettings.fogEndDistance);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_fogMode(IntPtr L)
	{
		try
		{
			ToLua.Push(L, RenderSettings.fogMode);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_fogColor(IntPtr L)
	{
		try
		{
			ToLua.Push(L, RenderSettings.fogColor);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_fogDensity(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushnumber(L, RenderSettings.fogDensity);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_ambientMode(IntPtr L)
	{
		try
		{
			ToLua.Push(L, RenderSettings.ambientMode);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_ambientSkyColor(IntPtr L)
	{
		try
		{
			ToLua.Push(L, RenderSettings.ambientSkyColor);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_ambientEquatorColor(IntPtr L)
	{
		try
		{
			ToLua.Push(L, RenderSettings.ambientEquatorColor);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_ambientGroundColor(IntPtr L)
	{
		try
		{
			ToLua.Push(L, RenderSettings.ambientGroundColor);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_ambientIntensity(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushnumber(L, RenderSettings.ambientIntensity);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_ambientLight(IntPtr L)
	{
		try
		{
			ToLua.Push(L, RenderSettings.ambientLight);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_subtractiveShadowColor(IntPtr L)
	{
		try
		{
			ToLua.Push(L, RenderSettings.subtractiveShadowColor);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_skybox(IntPtr L)
	{
		try
		{
			ToLua.Push(L, RenderSettings.skybox);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_sun(IntPtr L)
	{
		try
		{
			ToLua.PushSealed(L, RenderSettings.sun);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_ambientProbe(IntPtr L)
	{
		try
		{
			ToLua.PushValue(L, RenderSettings.ambientProbe);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_customReflection(IntPtr L)
	{
		try
		{
			ToLua.PushSealed(L, RenderSettings.customReflection);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_reflectionIntensity(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushnumber(L, RenderSettings.reflectionIntensity);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_reflectionBounces(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushinteger(L, RenderSettings.reflectionBounces);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_defaultReflectionMode(IntPtr L)
	{
		try
		{
			ToLua.Push(L, RenderSettings.defaultReflectionMode);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_defaultReflectionResolution(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushinteger(L, RenderSettings.defaultReflectionResolution);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_haloStrength(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushnumber(L, RenderSettings.haloStrength);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_flareStrength(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushnumber(L, RenderSettings.flareStrength);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_flareFadeSpeed(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushnumber(L, RenderSettings.flareFadeSpeed);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_fog(IntPtr L)
	{
		try
		{
			RenderSettings.fog = LuaDLL.luaL_checkboolean(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_fogStartDistance(IntPtr L)
	{
		try
		{
			RenderSettings.fogStartDistance = (float)LuaDLL.luaL_checknumber(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_fogEndDistance(IntPtr L)
	{
		try
		{
			RenderSettings.fogEndDistance = (float)LuaDLL.luaL_checknumber(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_fogMode(IntPtr L)
	{
		try
		{
			RenderSettings.fogMode = (FogMode)ToLua.CheckObject(L, 2, typeof(FogMode));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_fogColor(IntPtr L)
	{
		try
		{
			RenderSettings.fogColor = ToLua.ToColor(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_fogDensity(IntPtr L)
	{
		try
		{
			RenderSettings.fogDensity = (float)LuaDLL.luaL_checknumber(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_ambientMode(IntPtr L)
	{
		try
		{
			RenderSettings.ambientMode = (AmbientMode)ToLua.CheckObject(L, 2, typeof(AmbientMode));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_ambientSkyColor(IntPtr L)
	{
		try
		{
			RenderSettings.ambientSkyColor = ToLua.ToColor(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_ambientEquatorColor(IntPtr L)
	{
		try
		{
			RenderSettings.ambientEquatorColor = ToLua.ToColor(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_ambientGroundColor(IntPtr L)
	{
		try
		{
			RenderSettings.ambientGroundColor = ToLua.ToColor(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_ambientIntensity(IntPtr L)
	{
		try
		{
			RenderSettings.ambientIntensity = (float)LuaDLL.luaL_checknumber(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_ambientLight(IntPtr L)
	{
		try
		{
			RenderSettings.ambientLight = ToLua.ToColor(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_subtractiveShadowColor(IntPtr L)
	{
		try
		{
			RenderSettings.subtractiveShadowColor = ToLua.ToColor(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_skybox(IntPtr L)
	{
		try
		{
			RenderSettings.skybox = (Material)ToLua.CheckObject<Material>(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_sun(IntPtr L)
	{
		try
		{
			RenderSettings.sun = (Light)ToLua.CheckObject(L, 2, typeof(Light));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_ambientProbe(IntPtr L)
	{
		try
		{
			RenderSettings.ambientProbe = StackTraits<SphericalHarmonicsL2>.Check(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_customReflection(IntPtr L)
	{
		try
		{
			RenderSettings.customReflection = (Cubemap)ToLua.CheckObject(L, 2, typeof(Cubemap));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_reflectionIntensity(IntPtr L)
	{
		try
		{
			RenderSettings.reflectionIntensity = (float)LuaDLL.luaL_checknumber(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_reflectionBounces(IntPtr L)
	{
		try
		{
			RenderSettings.reflectionBounces = (int)LuaDLL.luaL_checknumber(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_defaultReflectionMode(IntPtr L)
	{
		try
		{
			RenderSettings.defaultReflectionMode = (DefaultReflectionMode)ToLua.CheckObject(L, 2, typeof(DefaultReflectionMode));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_defaultReflectionResolution(IntPtr L)
	{
		try
		{
			RenderSettings.defaultReflectionResolution = (int)LuaDLL.luaL_checknumber(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_haloStrength(IntPtr L)
	{
		try
		{
			RenderSettings.haloStrength = (float)LuaDLL.luaL_checknumber(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_flareStrength(IntPtr L)
	{
		try
		{
			RenderSettings.flareStrength = (float)LuaDLL.luaL_checknumber(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_flareFadeSpeed(IntPtr L)
	{
		try
		{
			RenderSettings.flareFadeSpeed = (float)LuaDLL.luaL_checknumber(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
