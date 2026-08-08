using System;
using LuaInterface;
using UnityEngine;

public class UnityEngine_ParticleSystem_MainModuleWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(ParticleSystem.MainModule), null);
		L.RegFunction("New", _CreateUnityEngine_ParticleSystem_MainModule);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("duration", get_duration, set_duration);
		L.RegVar("loop", get_loop, set_loop);
		L.RegVar("prewarm", get_prewarm, set_prewarm);
		L.RegVar("startDelay", get_startDelay, set_startDelay);
		L.RegVar("startDelayMultiplier", get_startDelayMultiplier, set_startDelayMultiplier);
		L.RegVar("startLifetime", get_startLifetime, set_startLifetime);
		L.RegVar("startLifetimeMultiplier", get_startLifetimeMultiplier, set_startLifetimeMultiplier);
		L.RegVar("startSpeed", get_startSpeed, set_startSpeed);
		L.RegVar("startSpeedMultiplier", get_startSpeedMultiplier, set_startSpeedMultiplier);
		L.RegVar("startSize3D", get_startSize3D, set_startSize3D);
		L.RegVar("startSize", get_startSize, set_startSize);
		L.RegVar("startSizeMultiplier", get_startSizeMultiplier, set_startSizeMultiplier);
		L.RegVar("startSizeX", get_startSizeX, set_startSizeX);
		L.RegVar("startSizeXMultiplier", get_startSizeXMultiplier, set_startSizeXMultiplier);
		L.RegVar("startSizeY", get_startSizeY, set_startSizeY);
		L.RegVar("startSizeYMultiplier", get_startSizeYMultiplier, set_startSizeYMultiplier);
		L.RegVar("startSizeZ", get_startSizeZ, set_startSizeZ);
		L.RegVar("startSizeZMultiplier", get_startSizeZMultiplier, set_startSizeZMultiplier);
		L.RegVar("startRotation3D", get_startRotation3D, set_startRotation3D);
		L.RegVar("startRotation", get_startRotation, set_startRotation);
		L.RegVar("startRotationMultiplier", get_startRotationMultiplier, set_startRotationMultiplier);
		L.RegVar("startRotationX", get_startRotationX, set_startRotationX);
		L.RegVar("startRotationXMultiplier", get_startRotationXMultiplier, set_startRotationXMultiplier);
		L.RegVar("startRotationY", get_startRotationY, set_startRotationY);
		L.RegVar("startRotationYMultiplier", get_startRotationYMultiplier, set_startRotationYMultiplier);
		L.RegVar("startRotationZ", get_startRotationZ, set_startRotationZ);
		L.RegVar("startRotationZMultiplier", get_startRotationZMultiplier, set_startRotationZMultiplier);
		L.RegVar("flipRotation", get_flipRotation, set_flipRotation);
		L.RegVar("startColor", get_startColor, set_startColor);
		L.RegVar("gravityModifier", get_gravityModifier, set_gravityModifier);
		L.RegVar("gravityModifierMultiplier", get_gravityModifierMultiplier, set_gravityModifierMultiplier);
		L.RegVar("simulationSpace", get_simulationSpace, set_simulationSpace);
		L.RegVar("customSimulationSpace", get_customSimulationSpace, set_customSimulationSpace);
		L.RegVar("simulationSpeed", get_simulationSpeed, set_simulationSpeed);
		L.RegVar("useUnscaledTime", get_useUnscaledTime, set_useUnscaledTime);
		L.RegVar("scalingMode", get_scalingMode, set_scalingMode);
		L.RegVar("playOnAwake", get_playOnAwake, set_playOnAwake);
		L.RegVar("maxParticles", get_maxParticles, set_maxParticles);
		L.RegVar("emitterVelocityMode", get_emitterVelocityMode, set_emitterVelocityMode);
		L.RegVar("stopAction", get_stopAction, set_stopAction);
		L.RegVar("cullingMode", get_cullingMode, set_cullingMode);
		L.RegVar("ringBufferMode", get_ringBufferMode, set_ringBufferMode);
		L.RegVar("ringBufferLoopRange", get_ringBufferLoopRange, set_ringBufferLoopRange);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateUnityEngine_ParticleSystem_MainModule(IntPtr L)
	{
		ToLua.PushValue(L, default(ParticleSystem.MainModule));
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_duration(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float duration = ((ParticleSystem.MainModule)obj).duration;
			LuaDLL.lua_pushnumber(L, duration);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index duration on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_loop(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool loop = ((ParticleSystem.MainModule)obj).loop;
			LuaDLL.lua_pushboolean(L, loop);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index loop on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_prewarm(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool prewarm = ((ParticleSystem.MainModule)obj).prewarm;
			LuaDLL.lua_pushboolean(L, prewarm);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index prewarm on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_startDelay(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ParticleSystem.MinMaxCurve startDelay = ((ParticleSystem.MainModule)obj).startDelay;
			ToLua.PushValue(L, startDelay);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index startDelay on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_startDelayMultiplier(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float startDelayMultiplier = ((ParticleSystem.MainModule)obj).startDelayMultiplier;
			LuaDLL.lua_pushnumber(L, startDelayMultiplier);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index startDelayMultiplier on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_startLifetime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ParticleSystem.MinMaxCurve startLifetime = ((ParticleSystem.MainModule)obj).startLifetime;
			ToLua.PushValue(L, startLifetime);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index startLifetime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_startLifetimeMultiplier(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float startLifetimeMultiplier = ((ParticleSystem.MainModule)obj).startLifetimeMultiplier;
			LuaDLL.lua_pushnumber(L, startLifetimeMultiplier);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index startLifetimeMultiplier on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_startSpeed(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ParticleSystem.MinMaxCurve startSpeed = ((ParticleSystem.MainModule)obj).startSpeed;
			ToLua.PushValue(L, startSpeed);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index startSpeed on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_startSpeedMultiplier(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float startSpeedMultiplier = ((ParticleSystem.MainModule)obj).startSpeedMultiplier;
			LuaDLL.lua_pushnumber(L, startSpeedMultiplier);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index startSpeedMultiplier on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_startSize3D(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool startSize3D = ((ParticleSystem.MainModule)obj).startSize3D;
			LuaDLL.lua_pushboolean(L, startSize3D);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index startSize3D on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_startSize(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ParticleSystem.MinMaxCurve startSize = ((ParticleSystem.MainModule)obj).startSize;
			ToLua.PushValue(L, startSize);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index startSize on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_startSizeMultiplier(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float startSizeMultiplier = ((ParticleSystem.MainModule)obj).startSizeMultiplier;
			LuaDLL.lua_pushnumber(L, startSizeMultiplier);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index startSizeMultiplier on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_startSizeX(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ParticleSystem.MinMaxCurve startSizeX = ((ParticleSystem.MainModule)obj).startSizeX;
			ToLua.PushValue(L, startSizeX);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index startSizeX on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_startSizeXMultiplier(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float startSizeXMultiplier = ((ParticleSystem.MainModule)obj).startSizeXMultiplier;
			LuaDLL.lua_pushnumber(L, startSizeXMultiplier);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index startSizeXMultiplier on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_startSizeY(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ParticleSystem.MinMaxCurve startSizeY = ((ParticleSystem.MainModule)obj).startSizeY;
			ToLua.PushValue(L, startSizeY);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index startSizeY on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_startSizeYMultiplier(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float startSizeYMultiplier = ((ParticleSystem.MainModule)obj).startSizeYMultiplier;
			LuaDLL.lua_pushnumber(L, startSizeYMultiplier);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index startSizeYMultiplier on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_startSizeZ(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ParticleSystem.MinMaxCurve startSizeZ = ((ParticleSystem.MainModule)obj).startSizeZ;
			ToLua.PushValue(L, startSizeZ);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index startSizeZ on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_startSizeZMultiplier(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float startSizeZMultiplier = ((ParticleSystem.MainModule)obj).startSizeZMultiplier;
			LuaDLL.lua_pushnumber(L, startSizeZMultiplier);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index startSizeZMultiplier on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_startRotation3D(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool startRotation3D = ((ParticleSystem.MainModule)obj).startRotation3D;
			LuaDLL.lua_pushboolean(L, startRotation3D);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index startRotation3D on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_startRotation(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ParticleSystem.MinMaxCurve startRotation = ((ParticleSystem.MainModule)obj).startRotation;
			ToLua.PushValue(L, startRotation);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index startRotation on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_startRotationMultiplier(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float startRotationMultiplier = ((ParticleSystem.MainModule)obj).startRotationMultiplier;
			LuaDLL.lua_pushnumber(L, startRotationMultiplier);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index startRotationMultiplier on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_startRotationX(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ParticleSystem.MinMaxCurve startRotationX = ((ParticleSystem.MainModule)obj).startRotationX;
			ToLua.PushValue(L, startRotationX);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index startRotationX on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_startRotationXMultiplier(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float startRotationXMultiplier = ((ParticleSystem.MainModule)obj).startRotationXMultiplier;
			LuaDLL.lua_pushnumber(L, startRotationXMultiplier);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index startRotationXMultiplier on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_startRotationY(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ParticleSystem.MinMaxCurve startRotationY = ((ParticleSystem.MainModule)obj).startRotationY;
			ToLua.PushValue(L, startRotationY);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index startRotationY on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_startRotationYMultiplier(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float startRotationYMultiplier = ((ParticleSystem.MainModule)obj).startRotationYMultiplier;
			LuaDLL.lua_pushnumber(L, startRotationYMultiplier);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index startRotationYMultiplier on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_startRotationZ(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ParticleSystem.MinMaxCurve startRotationZ = ((ParticleSystem.MainModule)obj).startRotationZ;
			ToLua.PushValue(L, startRotationZ);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index startRotationZ on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_startRotationZMultiplier(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float startRotationZMultiplier = ((ParticleSystem.MainModule)obj).startRotationZMultiplier;
			LuaDLL.lua_pushnumber(L, startRotationZMultiplier);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index startRotationZMultiplier on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_flipRotation(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float flipRotation = ((ParticleSystem.MainModule)obj).flipRotation;
			LuaDLL.lua_pushnumber(L, flipRotation);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index flipRotation on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_startColor(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ParticleSystem.MinMaxGradient startColor = ((ParticleSystem.MainModule)obj).startColor;
			ToLua.PushValue(L, startColor);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index startColor on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_gravityModifier(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ParticleSystem.MinMaxCurve gravityModifier = ((ParticleSystem.MainModule)obj).gravityModifier;
			ToLua.PushValue(L, gravityModifier);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index gravityModifier on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_gravityModifierMultiplier(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float gravityModifierMultiplier = ((ParticleSystem.MainModule)obj).gravityModifierMultiplier;
			LuaDLL.lua_pushnumber(L, gravityModifierMultiplier);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index gravityModifierMultiplier on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_simulationSpace(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ParticleSystemSimulationSpace simulationSpace = ((ParticleSystem.MainModule)obj).simulationSpace;
			ToLua.Push(L, simulationSpace);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index simulationSpace on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_customSimulationSpace(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Transform customSimulationSpace = ((ParticleSystem.MainModule)obj).customSimulationSpace;
			ToLua.Push(L, customSimulationSpace);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index customSimulationSpace on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_simulationSpeed(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float simulationSpeed = ((ParticleSystem.MainModule)obj).simulationSpeed;
			LuaDLL.lua_pushnumber(L, simulationSpeed);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index simulationSpeed on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_useUnscaledTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool useUnscaledTime = ((ParticleSystem.MainModule)obj).useUnscaledTime;
			LuaDLL.lua_pushboolean(L, useUnscaledTime);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index useUnscaledTime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_scalingMode(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ParticleSystemScalingMode scalingMode = ((ParticleSystem.MainModule)obj).scalingMode;
			ToLua.Push(L, scalingMode);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index scalingMode on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_playOnAwake(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool playOnAwake = ((ParticleSystem.MainModule)obj).playOnAwake;
			LuaDLL.lua_pushboolean(L, playOnAwake);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index playOnAwake on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_maxParticles(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int maxParticles = ((ParticleSystem.MainModule)obj).maxParticles;
			LuaDLL.lua_pushinteger(L, maxParticles);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index maxParticles on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_emitterVelocityMode(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ParticleSystemEmitterVelocityMode emitterVelocityMode = ((ParticleSystem.MainModule)obj).emitterVelocityMode;
			ToLua.Push(L, emitterVelocityMode);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index emitterVelocityMode on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_stopAction(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ParticleSystemStopAction stopAction = ((ParticleSystem.MainModule)obj).stopAction;
			ToLua.Push(L, stopAction);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index stopAction on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_cullingMode(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ParticleSystemCullingMode cullingMode = ((ParticleSystem.MainModule)obj).cullingMode;
			ToLua.Push(L, cullingMode);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index cullingMode on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_ringBufferMode(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ParticleSystemRingBufferMode ringBufferMode = ((ParticleSystem.MainModule)obj).ringBufferMode;
			ToLua.Push(L, ringBufferMode);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index ringBufferMode on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_ringBufferLoopRange(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector2 ringBufferLoopRange = ((ParticleSystem.MainModule)obj).ringBufferLoopRange;
			ToLua.Push(L, ringBufferLoopRange);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index ringBufferLoopRange on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_duration(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ParticleSystem.MainModule mainModule = (ParticleSystem.MainModule)obj;
			float duration = (float)LuaDLL.luaL_checknumber(L, 2);
			mainModule.duration = duration;
			ToLua.SetBack(L, 1, mainModule);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index duration on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_loop(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ParticleSystem.MainModule mainModule = (ParticleSystem.MainModule)obj;
			bool loop = LuaDLL.luaL_checkboolean(L, 2);
			mainModule.loop = loop;
			ToLua.SetBack(L, 1, mainModule);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index loop on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_prewarm(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ParticleSystem.MainModule mainModule = (ParticleSystem.MainModule)obj;
			bool prewarm = LuaDLL.luaL_checkboolean(L, 2);
			mainModule.prewarm = prewarm;
			ToLua.SetBack(L, 1, mainModule);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index prewarm on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_startDelay(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ParticleSystem.MainModule mainModule = (ParticleSystem.MainModule)obj;
			ParticleSystem.MinMaxCurve startDelay = StackTraits<ParticleSystem.MinMaxCurve>.Check(L, 2);
			mainModule.startDelay = startDelay;
			ToLua.SetBack(L, 1, mainModule);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index startDelay on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_startDelayMultiplier(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ParticleSystem.MainModule mainModule = (ParticleSystem.MainModule)obj;
			float startDelayMultiplier = (float)LuaDLL.luaL_checknumber(L, 2);
			mainModule.startDelayMultiplier = startDelayMultiplier;
			ToLua.SetBack(L, 1, mainModule);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index startDelayMultiplier on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_startLifetime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ParticleSystem.MainModule mainModule = (ParticleSystem.MainModule)obj;
			ParticleSystem.MinMaxCurve startLifetime = StackTraits<ParticleSystem.MinMaxCurve>.Check(L, 2);
			mainModule.startLifetime = startLifetime;
			ToLua.SetBack(L, 1, mainModule);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index startLifetime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_startLifetimeMultiplier(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ParticleSystem.MainModule mainModule = (ParticleSystem.MainModule)obj;
			float startLifetimeMultiplier = (float)LuaDLL.luaL_checknumber(L, 2);
			mainModule.startLifetimeMultiplier = startLifetimeMultiplier;
			ToLua.SetBack(L, 1, mainModule);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index startLifetimeMultiplier on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_startSpeed(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ParticleSystem.MainModule mainModule = (ParticleSystem.MainModule)obj;
			ParticleSystem.MinMaxCurve startSpeed = StackTraits<ParticleSystem.MinMaxCurve>.Check(L, 2);
			mainModule.startSpeed = startSpeed;
			ToLua.SetBack(L, 1, mainModule);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index startSpeed on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_startSpeedMultiplier(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ParticleSystem.MainModule mainModule = (ParticleSystem.MainModule)obj;
			float startSpeedMultiplier = (float)LuaDLL.luaL_checknumber(L, 2);
			mainModule.startSpeedMultiplier = startSpeedMultiplier;
			ToLua.SetBack(L, 1, mainModule);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index startSpeedMultiplier on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_startSize3D(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ParticleSystem.MainModule mainModule = (ParticleSystem.MainModule)obj;
			bool startSize3D = LuaDLL.luaL_checkboolean(L, 2);
			mainModule.startSize3D = startSize3D;
			ToLua.SetBack(L, 1, mainModule);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index startSize3D on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_startSize(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ParticleSystem.MainModule mainModule = (ParticleSystem.MainModule)obj;
			ParticleSystem.MinMaxCurve startSize = StackTraits<ParticleSystem.MinMaxCurve>.Check(L, 2);
			mainModule.startSize = startSize;
			ToLua.SetBack(L, 1, mainModule);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index startSize on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_startSizeMultiplier(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ParticleSystem.MainModule mainModule = (ParticleSystem.MainModule)obj;
			float startSizeMultiplier = (float)LuaDLL.luaL_checknumber(L, 2);
			mainModule.startSizeMultiplier = startSizeMultiplier;
			ToLua.SetBack(L, 1, mainModule);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index startSizeMultiplier on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_startSizeX(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ParticleSystem.MainModule mainModule = (ParticleSystem.MainModule)obj;
			ParticleSystem.MinMaxCurve startSizeX = StackTraits<ParticleSystem.MinMaxCurve>.Check(L, 2);
			mainModule.startSizeX = startSizeX;
			ToLua.SetBack(L, 1, mainModule);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index startSizeX on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_startSizeXMultiplier(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ParticleSystem.MainModule mainModule = (ParticleSystem.MainModule)obj;
			float startSizeXMultiplier = (float)LuaDLL.luaL_checknumber(L, 2);
			mainModule.startSizeXMultiplier = startSizeXMultiplier;
			ToLua.SetBack(L, 1, mainModule);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index startSizeXMultiplier on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_startSizeY(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ParticleSystem.MainModule mainModule = (ParticleSystem.MainModule)obj;
			ParticleSystem.MinMaxCurve startSizeY = StackTraits<ParticleSystem.MinMaxCurve>.Check(L, 2);
			mainModule.startSizeY = startSizeY;
			ToLua.SetBack(L, 1, mainModule);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index startSizeY on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_startSizeYMultiplier(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ParticleSystem.MainModule mainModule = (ParticleSystem.MainModule)obj;
			float startSizeYMultiplier = (float)LuaDLL.luaL_checknumber(L, 2);
			mainModule.startSizeYMultiplier = startSizeYMultiplier;
			ToLua.SetBack(L, 1, mainModule);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index startSizeYMultiplier on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_startSizeZ(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ParticleSystem.MainModule mainModule = (ParticleSystem.MainModule)obj;
			ParticleSystem.MinMaxCurve startSizeZ = StackTraits<ParticleSystem.MinMaxCurve>.Check(L, 2);
			mainModule.startSizeZ = startSizeZ;
			ToLua.SetBack(L, 1, mainModule);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index startSizeZ on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_startSizeZMultiplier(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ParticleSystem.MainModule mainModule = (ParticleSystem.MainModule)obj;
			float startSizeZMultiplier = (float)LuaDLL.luaL_checknumber(L, 2);
			mainModule.startSizeZMultiplier = startSizeZMultiplier;
			ToLua.SetBack(L, 1, mainModule);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index startSizeZMultiplier on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_startRotation3D(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ParticleSystem.MainModule mainModule = (ParticleSystem.MainModule)obj;
			bool startRotation3D = LuaDLL.luaL_checkboolean(L, 2);
			mainModule.startRotation3D = startRotation3D;
			ToLua.SetBack(L, 1, mainModule);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index startRotation3D on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_startRotation(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ParticleSystem.MainModule mainModule = (ParticleSystem.MainModule)obj;
			ParticleSystem.MinMaxCurve startRotation = StackTraits<ParticleSystem.MinMaxCurve>.Check(L, 2);
			mainModule.startRotation = startRotation;
			ToLua.SetBack(L, 1, mainModule);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index startRotation on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_startRotationMultiplier(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ParticleSystem.MainModule mainModule = (ParticleSystem.MainModule)obj;
			float startRotationMultiplier = (float)LuaDLL.luaL_checknumber(L, 2);
			mainModule.startRotationMultiplier = startRotationMultiplier;
			ToLua.SetBack(L, 1, mainModule);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index startRotationMultiplier on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_startRotationX(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ParticleSystem.MainModule mainModule = (ParticleSystem.MainModule)obj;
			ParticleSystem.MinMaxCurve startRotationX = StackTraits<ParticleSystem.MinMaxCurve>.Check(L, 2);
			mainModule.startRotationX = startRotationX;
			ToLua.SetBack(L, 1, mainModule);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index startRotationX on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_startRotationXMultiplier(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ParticleSystem.MainModule mainModule = (ParticleSystem.MainModule)obj;
			float startRotationXMultiplier = (float)LuaDLL.luaL_checknumber(L, 2);
			mainModule.startRotationXMultiplier = startRotationXMultiplier;
			ToLua.SetBack(L, 1, mainModule);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index startRotationXMultiplier on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_startRotationY(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ParticleSystem.MainModule mainModule = (ParticleSystem.MainModule)obj;
			ParticleSystem.MinMaxCurve startRotationY = StackTraits<ParticleSystem.MinMaxCurve>.Check(L, 2);
			mainModule.startRotationY = startRotationY;
			ToLua.SetBack(L, 1, mainModule);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index startRotationY on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_startRotationYMultiplier(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ParticleSystem.MainModule mainModule = (ParticleSystem.MainModule)obj;
			float startRotationYMultiplier = (float)LuaDLL.luaL_checknumber(L, 2);
			mainModule.startRotationYMultiplier = startRotationYMultiplier;
			ToLua.SetBack(L, 1, mainModule);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index startRotationYMultiplier on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_startRotationZ(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ParticleSystem.MainModule mainModule = (ParticleSystem.MainModule)obj;
			ParticleSystem.MinMaxCurve startRotationZ = StackTraits<ParticleSystem.MinMaxCurve>.Check(L, 2);
			mainModule.startRotationZ = startRotationZ;
			ToLua.SetBack(L, 1, mainModule);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index startRotationZ on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_startRotationZMultiplier(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ParticleSystem.MainModule mainModule = (ParticleSystem.MainModule)obj;
			float startRotationZMultiplier = (float)LuaDLL.luaL_checknumber(L, 2);
			mainModule.startRotationZMultiplier = startRotationZMultiplier;
			ToLua.SetBack(L, 1, mainModule);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index startRotationZMultiplier on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_flipRotation(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ParticleSystem.MainModule mainModule = (ParticleSystem.MainModule)obj;
			float flipRotation = (float)LuaDLL.luaL_checknumber(L, 2);
			mainModule.flipRotation = flipRotation;
			ToLua.SetBack(L, 1, mainModule);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index flipRotation on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_startColor(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ParticleSystem.MainModule mainModule = (ParticleSystem.MainModule)obj;
			ParticleSystem.MinMaxGradient startColor = StackTraits<ParticleSystem.MinMaxGradient>.Check(L, 2);
			mainModule.startColor = startColor;
			ToLua.SetBack(L, 1, mainModule);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index startColor on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_gravityModifier(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ParticleSystem.MainModule mainModule = (ParticleSystem.MainModule)obj;
			ParticleSystem.MinMaxCurve gravityModifier = StackTraits<ParticleSystem.MinMaxCurve>.Check(L, 2);
			mainModule.gravityModifier = gravityModifier;
			ToLua.SetBack(L, 1, mainModule);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index gravityModifier on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_gravityModifierMultiplier(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ParticleSystem.MainModule mainModule = (ParticleSystem.MainModule)obj;
			float gravityModifierMultiplier = (float)LuaDLL.luaL_checknumber(L, 2);
			mainModule.gravityModifierMultiplier = gravityModifierMultiplier;
			ToLua.SetBack(L, 1, mainModule);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index gravityModifierMultiplier on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_simulationSpace(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ParticleSystem.MainModule mainModule = (ParticleSystem.MainModule)obj;
			ParticleSystemSimulationSpace simulationSpace = (ParticleSystemSimulationSpace)ToLua.CheckObject(L, 2, typeof(ParticleSystemSimulationSpace));
			mainModule.simulationSpace = simulationSpace;
			ToLua.SetBack(L, 1, mainModule);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index simulationSpace on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_customSimulationSpace(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ParticleSystem.MainModule mainModule = (ParticleSystem.MainModule)obj;
			Transform customSimulationSpace = (Transform)ToLua.CheckObject<Transform>(L, 2);
			mainModule.customSimulationSpace = customSimulationSpace;
			ToLua.SetBack(L, 1, mainModule);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index customSimulationSpace on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_simulationSpeed(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ParticleSystem.MainModule mainModule = (ParticleSystem.MainModule)obj;
			float simulationSpeed = (float)LuaDLL.luaL_checknumber(L, 2);
			mainModule.simulationSpeed = simulationSpeed;
			ToLua.SetBack(L, 1, mainModule);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index simulationSpeed on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_useUnscaledTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ParticleSystem.MainModule mainModule = (ParticleSystem.MainModule)obj;
			bool useUnscaledTime = LuaDLL.luaL_checkboolean(L, 2);
			mainModule.useUnscaledTime = useUnscaledTime;
			ToLua.SetBack(L, 1, mainModule);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index useUnscaledTime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_scalingMode(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ParticleSystem.MainModule mainModule = (ParticleSystem.MainModule)obj;
			ParticleSystemScalingMode scalingMode = (ParticleSystemScalingMode)ToLua.CheckObject(L, 2, typeof(ParticleSystemScalingMode));
			mainModule.scalingMode = scalingMode;
			ToLua.SetBack(L, 1, mainModule);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index scalingMode on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_playOnAwake(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ParticleSystem.MainModule mainModule = (ParticleSystem.MainModule)obj;
			bool playOnAwake = LuaDLL.luaL_checkboolean(L, 2);
			mainModule.playOnAwake = playOnAwake;
			ToLua.SetBack(L, 1, mainModule);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index playOnAwake on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_maxParticles(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ParticleSystem.MainModule mainModule = (ParticleSystem.MainModule)obj;
			int maxParticles = (int)LuaDLL.luaL_checknumber(L, 2);
			mainModule.maxParticles = maxParticles;
			ToLua.SetBack(L, 1, mainModule);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index maxParticles on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_emitterVelocityMode(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ParticleSystem.MainModule mainModule = (ParticleSystem.MainModule)obj;
			ParticleSystemEmitterVelocityMode emitterVelocityMode = (ParticleSystemEmitterVelocityMode)ToLua.CheckObject(L, 2, typeof(ParticleSystemEmitterVelocityMode));
			mainModule.emitterVelocityMode = emitterVelocityMode;
			ToLua.SetBack(L, 1, mainModule);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index emitterVelocityMode on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_stopAction(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ParticleSystem.MainModule mainModule = (ParticleSystem.MainModule)obj;
			ParticleSystemStopAction stopAction = (ParticleSystemStopAction)ToLua.CheckObject(L, 2, typeof(ParticleSystemStopAction));
			mainModule.stopAction = stopAction;
			ToLua.SetBack(L, 1, mainModule);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index stopAction on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_cullingMode(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ParticleSystem.MainModule mainModule = (ParticleSystem.MainModule)obj;
			ParticleSystemCullingMode cullingMode = (ParticleSystemCullingMode)ToLua.CheckObject(L, 2, typeof(ParticleSystemCullingMode));
			mainModule.cullingMode = cullingMode;
			ToLua.SetBack(L, 1, mainModule);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index cullingMode on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_ringBufferMode(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ParticleSystem.MainModule mainModule = (ParticleSystem.MainModule)obj;
			ParticleSystemRingBufferMode ringBufferMode = (ParticleSystemRingBufferMode)ToLua.CheckObject(L, 2, typeof(ParticleSystemRingBufferMode));
			mainModule.ringBufferMode = ringBufferMode;
			ToLua.SetBack(L, 1, mainModule);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index ringBufferMode on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_ringBufferLoopRange(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ParticleSystem.MainModule mainModule = (ParticleSystem.MainModule)obj;
			Vector2 ringBufferLoopRange = ToLua.ToVector2(L, 2);
			mainModule.ringBufferLoopRange = ringBufferLoopRange;
			ToLua.SetBack(L, 1, mainModule);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index ringBufferLoopRange on a nil value");
		}
	}
}
