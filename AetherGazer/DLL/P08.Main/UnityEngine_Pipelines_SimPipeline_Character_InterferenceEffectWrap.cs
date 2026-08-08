using System;
using LuaInterface;
using UnityEngine;
using UnityEngine.Pipelines.SimPipeline.Character;

public class UnityEngine_Pipelines_SimPipeline_Character_InterferenceEffectWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(InterferenceEffect), typeof(EffectBase));
		L.RegFunction("New", _CreateUnityEngine_Pipelines_SimPipeline_Character_InterferenceEffect);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("noise", get_noise, set_noise);
		L.RegVar("geometryOutlineColor", get_geometryOutlineColor, set_geometryOutlineColor);
		L.RegVar("simTimeScale", get_simTimeScale, set_simTimeScale);
		L.RegVar("enabled", get_enabled, set_enabled);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateUnityEngine_Pipelines_SimPipeline_Character_InterferenceEffect(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				InterferenceEffect o = new InterferenceEffect();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: UnityEngine.Pipelines.SimPipeline.Character.InterferenceEffect.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_noise(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float noise = ((InterferenceEffect)obj).noise;
			LuaDLL.lua_pushnumber(L, noise);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index noise on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_geometryOutlineColor(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Color geometryOutlineColor = ((InterferenceEffect)obj).geometryOutlineColor;
			ToLua.Push(L, geometryOutlineColor);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index geometryOutlineColor on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_simTimeScale(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float simTimeScale = ((InterferenceEffect)obj).simTimeScale;
			LuaDLL.lua_pushnumber(L, simTimeScale);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index simTimeScale on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_enabled(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool enabled = ((InterferenceEffect)obj).enabled;
			LuaDLL.lua_pushboolean(L, enabled);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index enabled on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_noise(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			InterferenceEffect obj2 = (InterferenceEffect)obj;
			float noise = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.noise = noise;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index noise on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_geometryOutlineColor(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			InterferenceEffect obj2 = (InterferenceEffect)obj;
			Color geometryOutlineColor = ToLua.ToColor(L, 2);
			obj2.geometryOutlineColor = geometryOutlineColor;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index geometryOutlineColor on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_simTimeScale(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			InterferenceEffect obj2 = (InterferenceEffect)obj;
			float simTimeScale = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.simTimeScale = simTimeScale;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index simTimeScale on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_enabled(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			InterferenceEffect obj2 = (InterferenceEffect)obj;
			bool enabled = LuaDLL.luaL_checkboolean(L, 2);
			obj2.enabled = enabled;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index enabled on a nil value");
		}
	}
}
