using System;
using System.Collections.Generic;
using LuaInterface;
using UnityEngine;

public class UnityEngine_ParticleSystemWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(ParticleSystem), typeof(Component));
		L.RegFunction("SetCustomParticleData", SetCustomParticleData);
		L.RegFunction("GetCustomParticleData", GetCustomParticleData);
		L.RegFunction("TriggerSubEmitter", TriggerSubEmitter);
		L.RegFunction("SetParticles", SetParticles);
		L.RegFunction("GetParticles", GetParticles);
		L.RegFunction("Simulate", Simulate);
		L.RegFunction("Play", Play);
		L.RegFunction("Pause", Pause);
		L.RegFunction("Stop", Stop);
		L.RegFunction("Clear", Clear);
		L.RegFunction("IsAlive", IsAlive);
		L.RegFunction("Emit", Emit);
		L.RegFunction("ResetPreMappedBufferMemory", ResetPreMappedBufferMemory);
		L.RegFunction("New", _CreateUnityEngine_ParticleSystem);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("isPlaying", get_isPlaying, null);
		L.RegVar("isEmitting", get_isEmitting, null);
		L.RegVar("isStopped", get_isStopped, null);
		L.RegVar("isPaused", get_isPaused, null);
		L.RegVar("particleCount", get_particleCount, null);
		L.RegVar("time", get_time, set_time);
		L.RegVar("randomSeed", get_randomSeed, set_randomSeed);
		L.RegVar("useAutoRandomSeed", get_useAutoRandomSeed, set_useAutoRandomSeed);
		L.RegVar("proceduralSimulationSupported", get_proceduralSimulationSupported, null);
		L.RegVar("main", get_main, null);
		L.RegVar("emission", get_emission, null);
		L.RegVar("shape", get_shape, null);
		L.RegVar("velocityOverLifetime", get_velocityOverLifetime, null);
		L.RegVar("limitVelocityOverLifetime", get_limitVelocityOverLifetime, null);
		L.RegVar("inheritVelocity", get_inheritVelocity, null);
		L.RegVar("forceOverLifetime", get_forceOverLifetime, null);
		L.RegVar("colorOverLifetime", get_colorOverLifetime, null);
		L.RegVar("colorBySpeed", get_colorBySpeed, null);
		L.RegVar("sizeOverLifetime", get_sizeOverLifetime, null);
		L.RegVar("sizeBySpeed", get_sizeBySpeed, null);
		L.RegVar("rotationOverLifetime", get_rotationOverLifetime, null);
		L.RegVar("rotationBySpeed", get_rotationBySpeed, null);
		L.RegVar("externalForces", get_externalForces, null);
		L.RegVar("noise", get_noise, null);
		L.RegVar("collision", get_collision, null);
		L.RegVar("trigger", get_trigger, null);
		L.RegVar("subEmitters", get_subEmitters, null);
		L.RegVar("textureSheetAnimation", get_textureSheetAnimation, null);
		L.RegVar("lights", get_lights, null);
		L.RegVar("trails", get_trails, null);
		L.RegVar("customData", get_customData, null);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateUnityEngine_ParticleSystem(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				ParticleSystem o = new ParticleSystem();
				ToLua.PushSealed(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: UnityEngine.ParticleSystem.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetCustomParticleData(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			ParticleSystem obj = (ParticleSystem)ToLua.CheckObject(L, 1, typeof(ParticleSystem));
			List<Vector4> customData = (List<Vector4>)ToLua.CheckObject(L, 2, typeof(List<Vector4>));
			ParticleSystemCustomData streamIndex = (ParticleSystemCustomData)ToLua.CheckObject(L, 3, typeof(ParticleSystemCustomData));
			obj.SetCustomParticleData(customData, streamIndex);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetCustomParticleData(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			ParticleSystem obj = (ParticleSystem)ToLua.CheckObject(L, 1, typeof(ParticleSystem));
			List<Vector4> customData = (List<Vector4>)ToLua.CheckObject(L, 2, typeof(List<Vector4>));
			ParticleSystemCustomData streamIndex = (ParticleSystemCustomData)ToLua.CheckObject(L, 3, typeof(ParticleSystemCustomData));
			int customParticleData = obj.GetCustomParticleData(customData, streamIndex);
			LuaDLL.lua_pushinteger(L, customParticleData);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int TriggerSubEmitter(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			switch (num)
			{
			case 2:
			{
				ParticleSystem obj2 = (ParticleSystem)ToLua.CheckObject(L, 1, typeof(ParticleSystem));
				int subEmitterIndex2 = (int)LuaDLL.luaL_checknumber(L, 2);
				obj2.TriggerSubEmitter(subEmitterIndex2);
				return 0;
			}
			case 3:
				if (TypeChecker.CheckTypes<List<ParticleSystem.Particle>>(L, 3))
				{
					ParticleSystem obj = (ParticleSystem)ToLua.CheckObject(L, 1, typeof(ParticleSystem));
					int subEmitterIndex = (int)LuaDLL.luaL_checknumber(L, 2);
					List<ParticleSystem.Particle> particles = (List<ParticleSystem.Particle>)ToLua.ToObject(L, 3);
					obj.TriggerSubEmitter(subEmitterIndex, particles);
					return 0;
				}
				break;
			}
			if (num == 3 && TypeChecker.CheckTypes<ParticleSystem.Particle>(L, 3))
			{
				ParticleSystem obj3 = (ParticleSystem)ToLua.CheckObject(L, 1, typeof(ParticleSystem));
				int subEmitterIndex3 = (int)LuaDLL.luaL_checknumber(L, 2);
				ParticleSystem.Particle particle = StackTraits<ParticleSystem.Particle>.To(L, 3);
				obj3.TriggerSubEmitter(subEmitterIndex3, ref particle);
				ToLua.PushValue(L, particle);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.ParticleSystem.TriggerSubEmitter");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetParticles(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				ParticleSystem obj3 = (ParticleSystem)ToLua.CheckObject(L, 1, typeof(ParticleSystem));
				ParticleSystem.Particle[] particles3 = null;
				obj3.SetParticles(particles3);
				return 0;
			}
			case 3:
			{
				ParticleSystem obj2 = (ParticleSystem)ToLua.CheckObject(L, 1, typeof(ParticleSystem));
				ParticleSystem.Particle[] particles2 = null;
				int size2 = (int)LuaDLL.luaL_checknumber(L, 3);
				obj2.SetParticles(particles2, size2);
				return 0;
			}
			case 4:
			{
				ParticleSystem obj = (ParticleSystem)ToLua.CheckObject(L, 1, typeof(ParticleSystem));
				ParticleSystem.Particle[] particles = null;
				int size = (int)LuaDLL.luaL_checknumber(L, 3);
				int offset = (int)LuaDLL.luaL_checknumber(L, 4);
				obj.SetParticles(particles, size, offset);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.ParticleSystem.SetParticles");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetParticles(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				ParticleSystem obj3 = (ParticleSystem)ToLua.CheckObject(L, 1, typeof(ParticleSystem));
				ParticleSystem.Particle[] particles5 = null;
				int particles6 = obj3.GetParticles(particles5);
				LuaDLL.lua_pushinteger(L, particles6);
				return 1;
			}
			case 3:
			{
				ParticleSystem obj2 = (ParticleSystem)ToLua.CheckObject(L, 1, typeof(ParticleSystem));
				ParticleSystem.Particle[] particles3 = null;
				int size2 = (int)LuaDLL.luaL_checknumber(L, 3);
				int particles4 = obj2.GetParticles(particles3, size2);
				LuaDLL.lua_pushinteger(L, particles4);
				return 1;
			}
			case 4:
			{
				ParticleSystem obj = (ParticleSystem)ToLua.CheckObject(L, 1, typeof(ParticleSystem));
				ParticleSystem.Particle[] particles = null;
				int size = (int)LuaDLL.luaL_checknumber(L, 3);
				int offset = (int)LuaDLL.luaL_checknumber(L, 4);
				int particles2 = obj.GetParticles(particles, size, offset);
				LuaDLL.lua_pushinteger(L, particles2);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.ParticleSystem.GetParticles");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Simulate(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				ParticleSystem obj4 = (ParticleSystem)ToLua.CheckObject(L, 1, typeof(ParticleSystem));
				float t4 = (float)LuaDLL.luaL_checknumber(L, 2);
				obj4.Simulate(t4);
				return 0;
			}
			case 3:
			{
				ParticleSystem obj3 = (ParticleSystem)ToLua.CheckObject(L, 1, typeof(ParticleSystem));
				float t3 = (float)LuaDLL.luaL_checknumber(L, 2);
				bool withChildren3 = LuaDLL.luaL_checkboolean(L, 3);
				obj3.Simulate(t3, withChildren3);
				return 0;
			}
			case 4:
			{
				ParticleSystem obj2 = (ParticleSystem)ToLua.CheckObject(L, 1, typeof(ParticleSystem));
				float t2 = (float)LuaDLL.luaL_checknumber(L, 2);
				bool withChildren2 = LuaDLL.luaL_checkboolean(L, 3);
				bool restart2 = LuaDLL.luaL_checkboolean(L, 4);
				obj2.Simulate(t2, withChildren2, restart2);
				return 0;
			}
			case 5:
			{
				ParticleSystem obj = (ParticleSystem)ToLua.CheckObject(L, 1, typeof(ParticleSystem));
				float t = (float)LuaDLL.luaL_checknumber(L, 2);
				bool withChildren = LuaDLL.luaL_checkboolean(L, 3);
				bool restart = LuaDLL.luaL_checkboolean(L, 4);
				bool fixedTimeStep = LuaDLL.luaL_checkboolean(L, 5);
				obj.Simulate(t, withChildren, restart, fixedTimeStep);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.ParticleSystem.Simulate");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Play(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
				((ParticleSystem)ToLua.CheckObject(L, 1, typeof(ParticleSystem))).Play();
				return 0;
			case 2:
			{
				ParticleSystem obj = (ParticleSystem)ToLua.CheckObject(L, 1, typeof(ParticleSystem));
				bool withChildren = LuaDLL.luaL_checkboolean(L, 2);
				obj.Play(withChildren);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.ParticleSystem.Play");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Pause(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
				((ParticleSystem)ToLua.CheckObject(L, 1, typeof(ParticleSystem))).Pause();
				return 0;
			case 2:
			{
				ParticleSystem obj = (ParticleSystem)ToLua.CheckObject(L, 1, typeof(ParticleSystem));
				bool withChildren = LuaDLL.luaL_checkboolean(L, 2);
				obj.Pause(withChildren);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.ParticleSystem.Pause");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Stop(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
				((ParticleSystem)ToLua.CheckObject(L, 1, typeof(ParticleSystem))).Stop();
				return 0;
			case 2:
			{
				ParticleSystem obj2 = (ParticleSystem)ToLua.CheckObject(L, 1, typeof(ParticleSystem));
				bool withChildren2 = LuaDLL.luaL_checkboolean(L, 2);
				obj2.Stop(withChildren2);
				return 0;
			}
			case 3:
			{
				ParticleSystem obj = (ParticleSystem)ToLua.CheckObject(L, 1, typeof(ParticleSystem));
				bool withChildren = LuaDLL.luaL_checkboolean(L, 2);
				ParticleSystemStopBehavior stopBehavior = (ParticleSystemStopBehavior)ToLua.CheckObject(L, 3, typeof(ParticleSystemStopBehavior));
				obj.Stop(withChildren, stopBehavior);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.ParticleSystem.Stop");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Clear(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
				((ParticleSystem)ToLua.CheckObject(L, 1, typeof(ParticleSystem))).Clear();
				return 0;
			case 2:
			{
				ParticleSystem obj = (ParticleSystem)ToLua.CheckObject(L, 1, typeof(ParticleSystem));
				bool withChildren = LuaDLL.luaL_checkboolean(L, 2);
				obj.Clear(withChildren);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.ParticleSystem.Clear");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IsAlive(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
			{
				bool value2 = ((ParticleSystem)ToLua.CheckObject(L, 1, typeof(ParticleSystem))).IsAlive();
				LuaDLL.lua_pushboolean(L, value2);
				return 1;
			}
			case 2:
			{
				ParticleSystem obj = (ParticleSystem)ToLua.CheckObject(L, 1, typeof(ParticleSystem));
				bool withChildren = LuaDLL.luaL_checkboolean(L, 2);
				bool value = obj.IsAlive(withChildren);
				LuaDLL.lua_pushboolean(L, value);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.ParticleSystem.IsAlive");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Emit(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				ParticleSystem obj2 = (ParticleSystem)ToLua.CheckObject(L, 1, typeof(ParticleSystem));
				int count2 = (int)LuaDLL.luaL_checknumber(L, 2);
				obj2.Emit(count2);
				return 0;
			}
			case 3:
			{
				ParticleSystem obj = (ParticleSystem)ToLua.CheckObject(L, 1, typeof(ParticleSystem));
				ParticleSystem.EmitParams emitParams = StackTraits<ParticleSystem.EmitParams>.Check(L, 2);
				int count = (int)LuaDLL.luaL_checknumber(L, 3);
				obj.Emit(emitParams, count);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.ParticleSystem.Emit");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ResetPreMappedBufferMemory(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			ParticleSystem.ResetPreMappedBufferMemory();
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
	private static int get_isPlaying(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isPlaying = ((ParticleSystem)obj).isPlaying;
			LuaDLL.lua_pushboolean(L, isPlaying);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isPlaying on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isEmitting(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isEmitting = ((ParticleSystem)obj).isEmitting;
			LuaDLL.lua_pushboolean(L, isEmitting);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isEmitting on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isStopped(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isStopped = ((ParticleSystem)obj).isStopped;
			LuaDLL.lua_pushboolean(L, isStopped);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isStopped on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isPaused(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isPaused = ((ParticleSystem)obj).isPaused;
			LuaDLL.lua_pushboolean(L, isPaused);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isPaused on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_particleCount(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int particleCount = ((ParticleSystem)obj).particleCount;
			LuaDLL.lua_pushinteger(L, particleCount);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index particleCount on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_time(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float time = ((ParticleSystem)obj).time;
			LuaDLL.lua_pushnumber(L, time);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index time on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_randomSeed(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			uint randomSeed = ((ParticleSystem)obj).randomSeed;
			LuaDLL.lua_pushnumber(L, randomSeed);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index randomSeed on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_useAutoRandomSeed(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool useAutoRandomSeed = ((ParticleSystem)obj).useAutoRandomSeed;
			LuaDLL.lua_pushboolean(L, useAutoRandomSeed);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index useAutoRandomSeed on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_proceduralSimulationSupported(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool proceduralSimulationSupported = ((ParticleSystem)obj).proceduralSimulationSupported;
			LuaDLL.lua_pushboolean(L, proceduralSimulationSupported);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index proceduralSimulationSupported on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_main(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ParticleSystem.MainModule main = ((ParticleSystem)obj).main;
			ToLua.PushValue(L, main);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index main on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_emission(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ParticleSystem.EmissionModule emission = ((ParticleSystem)obj).emission;
			ToLua.PushValue(L, emission);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index emission on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_shape(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ParticleSystem.ShapeModule shape = ((ParticleSystem)obj).shape;
			ToLua.PushValue(L, shape);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index shape on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_velocityOverLifetime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ParticleSystem.VelocityOverLifetimeModule velocityOverLifetime = ((ParticleSystem)obj).velocityOverLifetime;
			ToLua.PushValue(L, velocityOverLifetime);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index velocityOverLifetime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_limitVelocityOverLifetime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ParticleSystem.LimitVelocityOverLifetimeModule limitVelocityOverLifetime = ((ParticleSystem)obj).limitVelocityOverLifetime;
			ToLua.PushValue(L, limitVelocityOverLifetime);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index limitVelocityOverLifetime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_inheritVelocity(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ParticleSystem.InheritVelocityModule inheritVelocity = ((ParticleSystem)obj).inheritVelocity;
			ToLua.PushValue(L, inheritVelocity);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index inheritVelocity on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_forceOverLifetime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ParticleSystem.ForceOverLifetimeModule forceOverLifetime = ((ParticleSystem)obj).forceOverLifetime;
			ToLua.PushValue(L, forceOverLifetime);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index forceOverLifetime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_colorOverLifetime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ParticleSystem.ColorOverLifetimeModule colorOverLifetime = ((ParticleSystem)obj).colorOverLifetime;
			ToLua.PushValue(L, colorOverLifetime);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index colorOverLifetime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_colorBySpeed(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ParticleSystem.ColorBySpeedModule colorBySpeed = ((ParticleSystem)obj).colorBySpeed;
			ToLua.PushValue(L, colorBySpeed);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index colorBySpeed on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_sizeOverLifetime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ParticleSystem.SizeOverLifetimeModule sizeOverLifetime = ((ParticleSystem)obj).sizeOverLifetime;
			ToLua.PushValue(L, sizeOverLifetime);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index sizeOverLifetime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_sizeBySpeed(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ParticleSystem.SizeBySpeedModule sizeBySpeed = ((ParticleSystem)obj).sizeBySpeed;
			ToLua.PushValue(L, sizeBySpeed);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index sizeBySpeed on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_rotationOverLifetime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ParticleSystem.RotationOverLifetimeModule rotationOverLifetime = ((ParticleSystem)obj).rotationOverLifetime;
			ToLua.PushValue(L, rotationOverLifetime);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index rotationOverLifetime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_rotationBySpeed(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ParticleSystem.RotationBySpeedModule rotationBySpeed = ((ParticleSystem)obj).rotationBySpeed;
			ToLua.PushValue(L, rotationBySpeed);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index rotationBySpeed on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_externalForces(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ParticleSystem.ExternalForcesModule externalForces = ((ParticleSystem)obj).externalForces;
			ToLua.PushValue(L, externalForces);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index externalForces on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_noise(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ParticleSystem.NoiseModule noise = ((ParticleSystem)obj).noise;
			ToLua.PushValue(L, noise);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index noise on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_collision(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ParticleSystem.CollisionModule collision = ((ParticleSystem)obj).collision;
			ToLua.PushValue(L, collision);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index collision on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_trigger(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ParticleSystem.TriggerModule trigger = ((ParticleSystem)obj).trigger;
			ToLua.PushValue(L, trigger);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index trigger on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_subEmitters(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ParticleSystem.SubEmittersModule subEmitters = ((ParticleSystem)obj).subEmitters;
			ToLua.PushValue(L, subEmitters);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index subEmitters on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_textureSheetAnimation(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ParticleSystem.TextureSheetAnimationModule textureSheetAnimation = ((ParticleSystem)obj).textureSheetAnimation;
			ToLua.PushValue(L, textureSheetAnimation);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index textureSheetAnimation on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_lights(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ParticleSystem.LightsModule lights = ((ParticleSystem)obj).lights;
			ToLua.PushValue(L, lights);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index lights on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_trails(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ParticleSystem.TrailModule trails = ((ParticleSystem)obj).trails;
			ToLua.PushValue(L, trails);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index trails on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_customData(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ParticleSystem.CustomDataModule customData = ((ParticleSystem)obj).customData;
			ToLua.PushValue(L, customData);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index customData on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_time(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ParticleSystem obj2 = (ParticleSystem)obj;
			float time = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.time = time;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index time on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_randomSeed(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ParticleSystem obj2 = (ParticleSystem)obj;
			uint randomSeed = (uint)LuaDLL.luaL_checknumber(L, 2);
			obj2.randomSeed = randomSeed;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index randomSeed on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_useAutoRandomSeed(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ParticleSystem obj2 = (ParticleSystem)obj;
			bool useAutoRandomSeed = LuaDLL.luaL_checkboolean(L, 2);
			obj2.useAutoRandomSeed = useAutoRandomSeed;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index useAutoRandomSeed on a nil value");
		}
	}
}
