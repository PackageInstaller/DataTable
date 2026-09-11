using System;
using LuaInterface;
using UnityEngine;
using UnityEngine.Audio;

public class UnityEngine_AudioSourceWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(AudioSource), typeof(AudioBehaviour));
		L.RegFunction("Play", Play);
		L.RegFunction("PlayDelayed", PlayDelayed);
		L.RegFunction("PlayScheduled", PlayScheduled);
		L.RegFunction("SetScheduledStartTime", SetScheduledStartTime);
		L.RegFunction("SetScheduledEndTime", SetScheduledEndTime);
		L.RegFunction("Stop", Stop);
		L.RegFunction("Pause", Pause);
		L.RegFunction("UnPause", UnPause);
		L.RegFunction("PlayOneShot", PlayOneShot);
		L.RegFunction("PlayClipAtPoint", PlayClipAtPoint);
		L.RegFunction("SetCustomCurve", SetCustomCurve);
		L.RegFunction("GetCustomCurve", GetCustomCurve);
		L.RegFunction("GetOutputData", GetOutputData);
		L.RegFunction("GetSpectrumData", GetSpectrumData);
		L.RegFunction("SetSpatializerFloat", SetSpatializerFloat);
		L.RegFunction("GetSpatializerFloat", GetSpatializerFloat);
		L.RegFunction("SetAmbisonicDecoderFloat", SetAmbisonicDecoderFloat);
		L.RegFunction("GetAmbisonicDecoderFloat", GetAmbisonicDecoderFloat);
		L.RegFunction("New", _CreateUnityEngine_AudioSource);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("volume", get_volume, set_volume);
		L.RegVar("pitch", get_pitch, set_pitch);
		L.RegVar("time", get_time, set_time);
		L.RegVar("timeSamples", get_timeSamples, set_timeSamples);
		L.RegVar("clip", get_clip, set_clip);
		L.RegVar("outputAudioMixerGroup", get_outputAudioMixerGroup, set_outputAudioMixerGroup);
		L.RegVar("isPlaying", get_isPlaying, null);
		L.RegVar("isVirtual", get_isVirtual, null);
		L.RegVar("loop", get_loop, set_loop);
		L.RegVar("ignoreListenerVolume", get_ignoreListenerVolume, set_ignoreListenerVolume);
		L.RegVar("playOnAwake", get_playOnAwake, set_playOnAwake);
		L.RegVar("ignoreListenerPause", get_ignoreListenerPause, set_ignoreListenerPause);
		L.RegVar("velocityUpdateMode", get_velocityUpdateMode, set_velocityUpdateMode);
		L.RegVar("panStereo", get_panStereo, set_panStereo);
		L.RegVar("spatialBlend", get_spatialBlend, set_spatialBlend);
		L.RegVar("spatialize", get_spatialize, set_spatialize);
		L.RegVar("spatializePostEffects", get_spatializePostEffects, set_spatializePostEffects);
		L.RegVar("reverbZoneMix", get_reverbZoneMix, set_reverbZoneMix);
		L.RegVar("bypassEffects", get_bypassEffects, set_bypassEffects);
		L.RegVar("bypassListenerEffects", get_bypassListenerEffects, set_bypassListenerEffects);
		L.RegVar("bypassReverbZones", get_bypassReverbZones, set_bypassReverbZones);
		L.RegVar("dopplerLevel", get_dopplerLevel, set_dopplerLevel);
		L.RegVar("spread", get_spread, set_spread);
		L.RegVar("priority", get_priority, set_priority);
		L.RegVar("mute", get_mute, set_mute);
		L.RegVar("minDistance", get_minDistance, set_minDistance);
		L.RegVar("maxDistance", get_maxDistance, set_maxDistance);
		L.RegVar("rolloffMode", get_rolloffMode, set_rolloffMode);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateUnityEngine_AudioSource(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				AudioSource o = new AudioSource();
				ToLua.PushSealed(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: UnityEngine.AudioSource.New");
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
				((AudioSource)ToLua.CheckObject(L, 1, typeof(AudioSource))).Play();
				return 0;
			case 2:
			{
				AudioSource obj = (AudioSource)ToLua.CheckObject(L, 1, typeof(AudioSource));
				ulong delay = LuaDLL.tolua_checkuint64(L, 2);
				obj.Play(delay);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.AudioSource.Play");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int PlayDelayed(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			AudioSource obj = (AudioSource)ToLua.CheckObject(L, 1, typeof(AudioSource));
			float delay = (float)LuaDLL.luaL_checknumber(L, 2);
			obj.PlayDelayed(delay);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int PlayScheduled(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			AudioSource obj = (AudioSource)ToLua.CheckObject(L, 1, typeof(AudioSource));
			double time = LuaDLL.luaL_checknumber(L, 2);
			obj.PlayScheduled(time);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetScheduledStartTime(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			AudioSource obj = (AudioSource)ToLua.CheckObject(L, 1, typeof(AudioSource));
			double scheduledStartTime = LuaDLL.luaL_checknumber(L, 2);
			obj.SetScheduledStartTime(scheduledStartTime);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetScheduledEndTime(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			AudioSource obj = (AudioSource)ToLua.CheckObject(L, 1, typeof(AudioSource));
			double scheduledEndTime = LuaDLL.luaL_checknumber(L, 2);
			obj.SetScheduledEndTime(scheduledEndTime);
			return 0;
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
			ToLua.CheckArgsCount(L, 1);
			((AudioSource)ToLua.CheckObject(L, 1, typeof(AudioSource))).Stop();
			return 0;
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
			ToLua.CheckArgsCount(L, 1);
			((AudioSource)ToLua.CheckObject(L, 1, typeof(AudioSource))).Pause();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UnPause(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((AudioSource)ToLua.CheckObject(L, 1, typeof(AudioSource))).UnPause();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int PlayOneShot(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				AudioSource obj2 = (AudioSource)ToLua.CheckObject(L, 1, typeof(AudioSource));
				AudioClip clip2 = (AudioClip)ToLua.CheckObject(L, 2, typeof(AudioClip));
				obj2.PlayOneShot(clip2);
				return 0;
			}
			case 3:
			{
				AudioSource obj = (AudioSource)ToLua.CheckObject(L, 1, typeof(AudioSource));
				AudioClip clip = (AudioClip)ToLua.CheckObject(L, 2, typeof(AudioClip));
				float volumeScale = (float)LuaDLL.luaL_checknumber(L, 3);
				obj.PlayOneShot(clip, volumeScale);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.AudioSource.PlayOneShot");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int PlayClipAtPoint(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				AudioClip clip2 = (AudioClip)ToLua.CheckObject(L, 1, typeof(AudioClip));
				Vector3 position2 = ToLua.ToVector3(L, 2);
				AudioSource.PlayClipAtPoint(clip2, position2);
				return 0;
			}
			case 3:
			{
				AudioClip clip = (AudioClip)ToLua.CheckObject(L, 1, typeof(AudioClip));
				Vector3 position = ToLua.ToVector3(L, 2);
				float volume = (float)LuaDLL.luaL_checknumber(L, 3);
				AudioSource.PlayClipAtPoint(clip, position, volume);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.AudioSource.PlayClipAtPoint");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetCustomCurve(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			AudioSource obj = (AudioSource)ToLua.CheckObject(L, 1, typeof(AudioSource));
			AudioSourceCurveType type = (AudioSourceCurveType)ToLua.CheckObject(L, 2, typeof(AudioSourceCurveType));
			AnimationCurve curve = (AnimationCurve)ToLua.CheckObject<AnimationCurve>(L, 3);
			obj.SetCustomCurve(type, curve);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetCustomCurve(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			AudioSource obj = (AudioSource)ToLua.CheckObject(L, 1, typeof(AudioSource));
			AudioSourceCurveType type = (AudioSourceCurveType)ToLua.CheckObject(L, 2, typeof(AudioSourceCurveType));
			AnimationCurve customCurve = obj.GetCustomCurve(type);
			ToLua.PushObject(L, customCurve);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetOutputData(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			AudioSource obj = (AudioSource)ToLua.CheckObject(L, 1, typeof(AudioSource));
			float[] samples = ToLua.CheckNumberArray<float>(L, 2);
			int channel = (int)LuaDLL.luaL_checknumber(L, 3);
			obj.GetOutputData(samples, channel);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetSpectrumData(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			AudioSource obj = (AudioSource)ToLua.CheckObject(L, 1, typeof(AudioSource));
			float[] samples = ToLua.CheckNumberArray<float>(L, 2);
			int channel = (int)LuaDLL.luaL_checknumber(L, 3);
			FFTWindow window = (FFTWindow)ToLua.CheckObject(L, 4, typeof(FFTWindow));
			obj.GetSpectrumData(samples, channel, window);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetSpatializerFloat(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			AudioSource obj = (AudioSource)ToLua.CheckObject(L, 1, typeof(AudioSource));
			int index = (int)LuaDLL.luaL_checknumber(L, 2);
			float value = (float)LuaDLL.luaL_checknumber(L, 3);
			bool value2 = obj.SetSpatializerFloat(index, value);
			LuaDLL.lua_pushboolean(L, value2);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetSpatializerFloat(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			AudioSource obj = (AudioSource)ToLua.CheckObject(L, 1, typeof(AudioSource));
			int index = (int)LuaDLL.luaL_checknumber(L, 2);
			bool spatializerFloat = obj.GetSpatializerFloat(index, out var value);
			LuaDLL.lua_pushboolean(L, spatializerFloat);
			LuaDLL.lua_pushnumber(L, value);
			return 2;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetAmbisonicDecoderFloat(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			AudioSource obj = (AudioSource)ToLua.CheckObject(L, 1, typeof(AudioSource));
			int index = (int)LuaDLL.luaL_checknumber(L, 2);
			float value = (float)LuaDLL.luaL_checknumber(L, 3);
			bool value2 = obj.SetAmbisonicDecoderFloat(index, value);
			LuaDLL.lua_pushboolean(L, value2);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetAmbisonicDecoderFloat(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			AudioSource obj = (AudioSource)ToLua.CheckObject(L, 1, typeof(AudioSource));
			int index = (int)LuaDLL.luaL_checknumber(L, 2);
			bool ambisonicDecoderFloat = obj.GetAmbisonicDecoderFloat(index, out var value);
			LuaDLL.lua_pushboolean(L, ambisonicDecoderFloat);
			LuaDLL.lua_pushnumber(L, value);
			return 2;
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
	private static int get_volume(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float volume = ((AudioSource)obj).volume;
			LuaDLL.lua_pushnumber(L, volume);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index volume on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_pitch(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float pitch = ((AudioSource)obj).pitch;
			LuaDLL.lua_pushnumber(L, pitch);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index pitch on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_time(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float time = ((AudioSource)obj).time;
			LuaDLL.lua_pushnumber(L, time);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index time on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_timeSamples(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int timeSamples = ((AudioSource)obj).timeSamples;
			LuaDLL.lua_pushinteger(L, timeSamples);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index timeSamples on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_clip(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			AudioClip clip = ((AudioSource)obj).clip;
			ToLua.PushSealed(L, clip);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index clip on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_outputAudioMixerGroup(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			AudioMixerGroup outputAudioMixerGroup = ((AudioSource)obj).outputAudioMixerGroup;
			ToLua.Push(L, outputAudioMixerGroup);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index outputAudioMixerGroup on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isPlaying(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isPlaying = ((AudioSource)obj).isPlaying;
			LuaDLL.lua_pushboolean(L, isPlaying);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isPlaying on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isVirtual(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isVirtual = ((AudioSource)obj).isVirtual;
			LuaDLL.lua_pushboolean(L, isVirtual);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isVirtual on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_loop(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool loop = ((AudioSource)obj).loop;
			LuaDLL.lua_pushboolean(L, loop);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index loop on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_ignoreListenerVolume(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool ignoreListenerVolume = ((AudioSource)obj).ignoreListenerVolume;
			LuaDLL.lua_pushboolean(L, ignoreListenerVolume);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index ignoreListenerVolume on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_playOnAwake(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool playOnAwake = ((AudioSource)obj).playOnAwake;
			LuaDLL.lua_pushboolean(L, playOnAwake);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index playOnAwake on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_ignoreListenerPause(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool ignoreListenerPause = ((AudioSource)obj).ignoreListenerPause;
			LuaDLL.lua_pushboolean(L, ignoreListenerPause);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index ignoreListenerPause on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_velocityUpdateMode(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			AudioVelocityUpdateMode velocityUpdateMode = ((AudioSource)obj).velocityUpdateMode;
			ToLua.Push(L, velocityUpdateMode);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index velocityUpdateMode on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_panStereo(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float panStereo = ((AudioSource)obj).panStereo;
			LuaDLL.lua_pushnumber(L, panStereo);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index panStereo on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_spatialBlend(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float spatialBlend = ((AudioSource)obj).spatialBlend;
			LuaDLL.lua_pushnumber(L, spatialBlend);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index spatialBlend on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_spatialize(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool spatialize = ((AudioSource)obj).spatialize;
			LuaDLL.lua_pushboolean(L, spatialize);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index spatialize on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_spatializePostEffects(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool spatializePostEffects = ((AudioSource)obj).spatializePostEffects;
			LuaDLL.lua_pushboolean(L, spatializePostEffects);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index spatializePostEffects on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_reverbZoneMix(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float reverbZoneMix = ((AudioSource)obj).reverbZoneMix;
			LuaDLL.lua_pushnumber(L, reverbZoneMix);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index reverbZoneMix on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_bypassEffects(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool bypassEffects = ((AudioSource)obj).bypassEffects;
			LuaDLL.lua_pushboolean(L, bypassEffects);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index bypassEffects on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_bypassListenerEffects(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool bypassListenerEffects = ((AudioSource)obj).bypassListenerEffects;
			LuaDLL.lua_pushboolean(L, bypassListenerEffects);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index bypassListenerEffects on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_bypassReverbZones(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool bypassReverbZones = ((AudioSource)obj).bypassReverbZones;
			LuaDLL.lua_pushboolean(L, bypassReverbZones);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index bypassReverbZones on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_dopplerLevel(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float dopplerLevel = ((AudioSource)obj).dopplerLevel;
			LuaDLL.lua_pushnumber(L, dopplerLevel);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index dopplerLevel on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_spread(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float spread = ((AudioSource)obj).spread;
			LuaDLL.lua_pushnumber(L, spread);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index spread on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_priority(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int priority = ((AudioSource)obj).priority;
			LuaDLL.lua_pushinteger(L, priority);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index priority on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_mute(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool mute = ((AudioSource)obj).mute;
			LuaDLL.lua_pushboolean(L, mute);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mute on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_minDistance(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float minDistance = ((AudioSource)obj).minDistance;
			LuaDLL.lua_pushnumber(L, minDistance);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index minDistance on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_maxDistance(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float maxDistance = ((AudioSource)obj).maxDistance;
			LuaDLL.lua_pushnumber(L, maxDistance);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index maxDistance on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_rolloffMode(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			AudioRolloffMode rolloffMode = ((AudioSource)obj).rolloffMode;
			ToLua.Push(L, rolloffMode);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index rolloffMode on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_volume(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			AudioSource obj2 = (AudioSource)obj;
			float volume = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.volume = volume;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index volume on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_pitch(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			AudioSource obj2 = (AudioSource)obj;
			float pitch = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.pitch = pitch;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index pitch on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_time(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			AudioSource obj2 = (AudioSource)obj;
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
	private static int set_timeSamples(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			AudioSource obj2 = (AudioSource)obj;
			int timeSamples = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.timeSamples = timeSamples;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index timeSamples on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_clip(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			AudioSource obj2 = (AudioSource)obj;
			AudioClip clip = (AudioClip)ToLua.CheckObject(L, 2, typeof(AudioClip));
			obj2.clip = clip;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index clip on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_outputAudioMixerGroup(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			AudioSource obj2 = (AudioSource)obj;
			AudioMixerGroup outputAudioMixerGroup = (AudioMixerGroup)ToLua.CheckObject<AudioMixerGroup>(L, 2);
			obj2.outputAudioMixerGroup = outputAudioMixerGroup;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index outputAudioMixerGroup on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_loop(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			AudioSource obj2 = (AudioSource)obj;
			bool loop = LuaDLL.luaL_checkboolean(L, 2);
			obj2.loop = loop;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index loop on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_ignoreListenerVolume(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			AudioSource obj2 = (AudioSource)obj;
			bool ignoreListenerVolume = LuaDLL.luaL_checkboolean(L, 2);
			obj2.ignoreListenerVolume = ignoreListenerVolume;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index ignoreListenerVolume on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_playOnAwake(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			AudioSource obj2 = (AudioSource)obj;
			bool playOnAwake = LuaDLL.luaL_checkboolean(L, 2);
			obj2.playOnAwake = playOnAwake;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index playOnAwake on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_ignoreListenerPause(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			AudioSource obj2 = (AudioSource)obj;
			bool ignoreListenerPause = LuaDLL.luaL_checkboolean(L, 2);
			obj2.ignoreListenerPause = ignoreListenerPause;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index ignoreListenerPause on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_velocityUpdateMode(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			AudioSource obj2 = (AudioSource)obj;
			AudioVelocityUpdateMode velocityUpdateMode = (AudioVelocityUpdateMode)ToLua.CheckObject(L, 2, typeof(AudioVelocityUpdateMode));
			obj2.velocityUpdateMode = velocityUpdateMode;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index velocityUpdateMode on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_panStereo(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			AudioSource obj2 = (AudioSource)obj;
			float panStereo = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.panStereo = panStereo;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index panStereo on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_spatialBlend(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			AudioSource obj2 = (AudioSource)obj;
			float spatialBlend = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.spatialBlend = spatialBlend;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index spatialBlend on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_spatialize(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			AudioSource obj2 = (AudioSource)obj;
			bool spatialize = LuaDLL.luaL_checkboolean(L, 2);
			obj2.spatialize = spatialize;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index spatialize on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_spatializePostEffects(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			AudioSource obj2 = (AudioSource)obj;
			bool spatializePostEffects = LuaDLL.luaL_checkboolean(L, 2);
			obj2.spatializePostEffects = spatializePostEffects;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index spatializePostEffects on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_reverbZoneMix(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			AudioSource obj2 = (AudioSource)obj;
			float reverbZoneMix = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.reverbZoneMix = reverbZoneMix;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index reverbZoneMix on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_bypassEffects(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			AudioSource obj2 = (AudioSource)obj;
			bool bypassEffects = LuaDLL.luaL_checkboolean(L, 2);
			obj2.bypassEffects = bypassEffects;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index bypassEffects on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_bypassListenerEffects(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			AudioSource obj2 = (AudioSource)obj;
			bool bypassListenerEffects = LuaDLL.luaL_checkboolean(L, 2);
			obj2.bypassListenerEffects = bypassListenerEffects;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index bypassListenerEffects on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_bypassReverbZones(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			AudioSource obj2 = (AudioSource)obj;
			bool bypassReverbZones = LuaDLL.luaL_checkboolean(L, 2);
			obj2.bypassReverbZones = bypassReverbZones;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index bypassReverbZones on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_dopplerLevel(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			AudioSource obj2 = (AudioSource)obj;
			float dopplerLevel = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.dopplerLevel = dopplerLevel;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index dopplerLevel on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_spread(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			AudioSource obj2 = (AudioSource)obj;
			float spread = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.spread = spread;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index spread on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_priority(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			AudioSource obj2 = (AudioSource)obj;
			int priority = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.priority = priority;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index priority on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_mute(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			AudioSource obj2 = (AudioSource)obj;
			bool mute = LuaDLL.luaL_checkboolean(L, 2);
			obj2.mute = mute;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mute on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_minDistance(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			AudioSource obj2 = (AudioSource)obj;
			float minDistance = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.minDistance = minDistance;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index minDistance on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_maxDistance(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			AudioSource obj2 = (AudioSource)obj;
			float maxDistance = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.maxDistance = maxDistance;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index maxDistance on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_rolloffMode(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			AudioSource obj2 = (AudioSource)obj;
			AudioRolloffMode rolloffMode = (AudioRolloffMode)ToLua.CheckObject(L, 2, typeof(AudioRolloffMode));
			obj2.rolloffMode = rolloffMode;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index rolloffMode on a nil value");
		}
	}
}
