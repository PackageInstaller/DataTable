using System;
using System.Collections.Generic;
using System.Xml;
using LuaInterface;
using RogoDigital.Lipsync;
using UnityEngine;
using UnityEngine.Events;

public class RogoDigital_Lipsync_LipSyncWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(LipSync), typeof(BlendSystemUser));
		L.RegFunction("SetEmotion", SetEmotion);
		L.RegFunction("ResetEmotion", ResetEmotion);
		L.RegFunction("Play", Play);
		L.RegFunction("PlayFromTime", PlayFromTime);
		L.RegFunction("Pause", Pause);
		L.RegFunction("Resume", Resume);
		L.RegFunction("Stop", Stop);
		L.RegFunction("PreviewAtTime", PreviewAtTime);
		L.RegFunction("DisplayEmotionPose", DisplayEmotionPose);
		L.RegFunction("ResetDisplayedEmotions", ResetDisplayedEmotions);
		L.RegFunction("PreviewAudioAtTime", PreviewAudioAtTime);
		L.RegFunction("TempLoad", TempLoad);
		L.RegFunction("ProcessData", ProcessData);
		L.RegFunction("ClearDataCache", ClearDataCache);
		L.RegFunction("SortTime", SortTime);
		L.RegFunction("ReadXML", ReadXML);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("lastEmotion", get_lastEmotion, set_lastEmotion);
		L.RegVar("audioSource", get_audioSource, set_audioSource);
		L.RegVar("useBones", get_useBones, set_useBones);
		L.RegVar("boneUpdateAnimation", get_boneUpdateAnimation, set_boneUpdateAnimation);
		L.RegVar("phonemes", get_phonemes, set_phonemes);
		L.RegVar("emotions", get_emotions, set_emotions);
		L.RegVar("playOnAwake", get_playOnAwake, set_playOnAwake);
		L.RegVar("loop", get_loop, set_loop);
		L.RegVar("defaultClip", get_defaultClip, set_defaultClip);
		L.RegVar("defaultDelay", get_defaultDelay, set_defaultDelay);
		L.RegVar("scaleAudioSpeed", get_scaleAudioSpeed, set_scaleAudioSpeed);
		L.RegVar("frameRate", get_frameRate, set_frameRate);
		L.RegVar("restTime", get_restTime, set_restTime);
		L.RegVar("restHoldTime", get_restHoldTime, set_restHoldTime);
		L.RegVar("phonemeCurveGenerationMode", get_phonemeCurveGenerationMode, set_phonemeCurveGenerationMode);
		L.RegVar("emotionCurveGenerationMode", get_emotionCurveGenerationMode, set_emotionCurveGenerationMode);
		L.RegVar("keepEmotionWhenFinished", get_keepEmotionWhenFinished, set_keepEmotionWhenFinished);
		L.RegVar("gesturesAnimator", get_gesturesAnimator, set_gesturesAnimator);
		L.RegVar("gesturesLayer", get_gesturesLayer, set_gesturesLayer);
		L.RegVar("gestures", get_gestures, set_gestures);
		L.RegVar("animCurves", get_animCurves, set_animCurves);
		L.RegVar("reset", get_reset, set_reset);
		L.RegVar("lastUsedVersion", get_lastUsedVersion, set_lastUsedVersion);
		L.RegVar("animationTimingMode", get_animationTimingMode, set_animationTimingMode);
		L.RegVar("IsPlaying", get_IsPlaying, null);
		L.RegVar("IsPaused", get_IsPaused, null);
		L.RegVar("IsStopping", get_IsStopping, null);
		L.RegVar("CurrentTime", get_CurrentTime, null);
		L.RegFunction("ResetDelegate", RogoDigital_Lipsync_LipSync_ResetDelegate);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetEmotion(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			LipSync obj = (LipSync)ToLua.CheckObject<LipSync>(L, 1);
			string emotion = ToLua.CheckString(L, 2);
			float blendTime = (float)LuaDLL.luaL_checknumber(L, 3);
			obj.SetEmotion(emotion, blendTime);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ResetEmotion(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			LipSync obj = (LipSync)ToLua.CheckObject<LipSync>(L, 1);
			float blendTime = (float)LuaDLL.luaL_checknumber(L, 2);
			obj.ResetEmotion(blendTime);
			return 0;
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
			int num = LuaDLL.lua_gettop(L);
			switch (num)
			{
			case 2:
			{
				LipSync obj2 = (LipSync)ToLua.CheckObject<LipSync>(L, 1);
				LipSyncData dataFile2 = (LipSyncData)ToLua.CheckObject<LipSyncData>(L, 2);
				obj2.Play(dataFile2);
				return 0;
			}
			case 3:
				if (TypeChecker.CheckTypes<LipSyncData, float>(L, 2))
				{
					LipSync obj = (LipSync)ToLua.CheckObject<LipSync>(L, 1);
					LipSyncData dataFile = (LipSyncData)ToLua.ToObject(L, 2);
					float delay = (float)LuaDLL.lua_tonumber(L, 3);
					obj.Play(dataFile, delay);
					return 0;
				}
				break;
			}
			if (num == 3 && TypeChecker.CheckTypes<TextAsset, AudioClip>(L, 2))
			{
				LipSync obj3 = (LipSync)ToLua.CheckObject<LipSync>(L, 1);
				TextAsset xmlFile = (TextAsset)ToLua.ToObject(L, 2);
				AudioClip clip = (AudioClip)ToLua.ToObject(L, 3);
				obj3.Play(xmlFile, clip);
				return 0;
			}
			if (num == 4)
			{
				LipSync obj4 = (LipSync)ToLua.CheckObject<LipSync>(L, 1);
				TextAsset xmlFile2 = (TextAsset)ToLua.CheckObject<TextAsset>(L, 2);
				AudioClip clip2 = (AudioClip)ToLua.CheckObject(L, 3, typeof(AudioClip));
				float delay2 = (float)LuaDLL.luaL_checknumber(L, 4);
				obj4.Play(xmlFile2, clip2, delay2);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: RogoDigital.Lipsync.LipSync.Play");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int PlayFromTime(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			switch (num)
			{
			case 3:
			{
				LipSync obj2 = (LipSync)ToLua.CheckObject<LipSync>(L, 1);
				LipSyncData dataFile2 = (LipSyncData)ToLua.CheckObject<LipSyncData>(L, 2);
				float time2 = (float)LuaDLL.luaL_checknumber(L, 3);
				obj2.PlayFromTime(dataFile2, time2);
				return 0;
			}
			case 4:
				if (TypeChecker.CheckTypes<LipSyncData, float, float>(L, 2))
				{
					LipSync obj = (LipSync)ToLua.CheckObject<LipSync>(L, 1);
					LipSyncData dataFile = (LipSyncData)ToLua.ToObject(L, 2);
					float delay = (float)LuaDLL.lua_tonumber(L, 3);
					float time = (float)LuaDLL.lua_tonumber(L, 4);
					obj.PlayFromTime(dataFile, delay, time);
					return 0;
				}
				break;
			}
			if (num == 4 && TypeChecker.CheckTypes<TextAsset, AudioClip, float>(L, 2))
			{
				LipSync obj3 = (LipSync)ToLua.CheckObject<LipSync>(L, 1);
				TextAsset xmlFile = (TextAsset)ToLua.ToObject(L, 2);
				AudioClip clip = (AudioClip)ToLua.ToObject(L, 3);
				float time3 = (float)LuaDLL.lua_tonumber(L, 4);
				obj3.PlayFromTime(xmlFile, clip, time3);
				return 0;
			}
			if (num == 5)
			{
				LipSync obj4 = (LipSync)ToLua.CheckObject<LipSync>(L, 1);
				TextAsset xmlFile2 = (TextAsset)ToLua.CheckObject<TextAsset>(L, 2);
				AudioClip clip2 = (AudioClip)ToLua.CheckObject(L, 3, typeof(AudioClip));
				float delay2 = (float)LuaDLL.luaL_checknumber(L, 4);
				float time4 = (float)LuaDLL.luaL_checknumber(L, 5);
				obj4.PlayFromTime(xmlFile2, clip2, delay2, time4);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: RogoDigital.Lipsync.LipSync.PlayFromTime");
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
			((LipSync)ToLua.CheckObject<LipSync>(L, 1)).Pause();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Resume(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((LipSync)ToLua.CheckObject<LipSync>(L, 1)).Resume();
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
			ToLua.CheckArgsCount(L, 2);
			LipSync obj = (LipSync)ToLua.CheckObject<LipSync>(L, 1);
			bool stopAudio = LuaDLL.luaL_checkboolean(L, 2);
			obj.Stop(stopAudio);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int PreviewAtTime(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			LipSync obj = (LipSync)ToLua.CheckObject<LipSync>(L, 1);
			float time = (float)LuaDLL.luaL_checknumber(L, 2);
			obj.PreviewAtTime(time);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int DisplayEmotionPose(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			LipSync obj = (LipSync)ToLua.CheckObject<LipSync>(L, 1);
			int emotion = (int)LuaDLL.luaL_checknumber(L, 2);
			float intensity = (float)LuaDLL.luaL_checknumber(L, 3);
			obj.DisplayEmotionPose(emotion, intensity);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ResetDisplayedEmotions(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((LipSync)ToLua.CheckObject<LipSync>(L, 1)).ResetDisplayedEmotions();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int PreviewAudioAtTime(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			LipSync obj = (LipSync)ToLua.CheckObject<LipSync>(L, 1);
			float time = (float)LuaDLL.luaL_checknumber(L, 2);
			float length = (float)LuaDLL.luaL_checknumber(L, 3);
			obj.PreviewAudioAtTime(time, length);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int TempLoad(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 5 && TypeChecker.CheckTypes<List<PhonemeMarker>, List<EmotionMarker>, AudioClip, float>(L, 2))
			{
				LipSync obj = (LipSync)ToLua.CheckObject<LipSync>(L, 1);
				List<PhonemeMarker> pData = (List<PhonemeMarker>)ToLua.ToObject(L, 2);
				List<EmotionMarker> eData = (List<EmotionMarker>)ToLua.ToObject(L, 3);
				AudioClip clip = (AudioClip)ToLua.ToObject(L, 4);
				float duration = (float)LuaDLL.lua_tonumber(L, 5);
				obj.TempLoad(pData, eData, clip, duration);
				return 0;
			}
			if (num == 5 && TypeChecker.CheckTypes<PhonemeMarker[], EmotionMarker[], AudioClip, float>(L, 2))
			{
				LipSync obj2 = (LipSync)ToLua.CheckObject<LipSync>(L, 1);
				PhonemeMarker[] pData2 = ToLua.ToObjectArray<PhonemeMarker>(L, 2);
				EmotionMarker[] eData2 = ToLua.ToObjectArray<EmotionMarker>(L, 3);
				AudioClip clip2 = (AudioClip)ToLua.ToObject(L, 4);
				float duration2 = (float)LuaDLL.lua_tonumber(L, 5);
				obj2.TempLoad(pData2, eData2, clip2, duration2);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: RogoDigital.Lipsync.LipSync.TempLoad");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ProcessData(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((LipSync)ToLua.CheckObject<LipSync>(L, 1)).ProcessData();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ClearDataCache(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((LipSync)ToLua.CheckObject<LipSync>(L, 1)).ClearDataCache();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SortTime(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 2 && TypeChecker.CheckTypes<PhonemeMarker, PhonemeMarker>(L, 1))
			{
				PhonemeMarker a = (PhonemeMarker)ToLua.ToObject(L, 1);
				PhonemeMarker b = (PhonemeMarker)ToLua.ToObject(L, 2);
				int n = LipSync.SortTime(a, b);
				LuaDLL.lua_pushinteger(L, n);
				return 1;
			}
			if (num == 2 && TypeChecker.CheckTypes<GestureMarker, GestureMarker>(L, 1))
			{
				GestureMarker a2 = (GestureMarker)ToLua.ToObject(L, 1);
				GestureMarker b2 = (GestureMarker)ToLua.ToObject(L, 2);
				int n2 = LipSync.SortTime(a2, b2);
				LuaDLL.lua_pushinteger(L, n2);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: RogoDigital.Lipsync.LipSync.SortTime");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ReadXML(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			XmlDocument xml = (XmlDocument)ToLua.CheckObject<XmlDocument>(L, 1);
			string parentElement = ToLua.CheckString(L, 2);
			string elementName = ToLua.CheckString(L, 3);
			string str = LipSync.ReadXML(xml, parentElement, elementName);
			LuaDLL.lua_pushstring(L, str);
			return 1;
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
	private static int get_lastEmotion(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string lastEmotion = ((LipSync)obj).lastEmotion;
			LuaDLL.lua_pushstring(L, lastEmotion);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index lastEmotion on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_audioSource(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			AudioSource audioSource = ((LipSync)obj).audioSource;
			ToLua.PushSealed(L, audioSource);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index audioSource on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_useBones(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool useBones = ((LipSync)obj).useBones;
			LuaDLL.lua_pushboolean(L, useBones);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index useBones on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_boneUpdateAnimation(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool boneUpdateAnimation = ((LipSync)obj).boneUpdateAnimation;
			LuaDLL.lua_pushboolean(L, boneUpdateAnimation);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index boneUpdateAnimation on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_phonemes(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<PhonemeShape> phonemes = ((LipSync)obj).phonemes;
			ToLua.PushSealed(L, phonemes);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index phonemes on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_emotions(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<EmotionShape> emotions = ((LipSync)obj).emotions;
			ToLua.PushSealed(L, emotions);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index emotions on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_playOnAwake(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool playOnAwake = ((LipSync)obj).playOnAwake;
			LuaDLL.lua_pushboolean(L, playOnAwake);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index playOnAwake on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_loop(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool loop = ((LipSync)obj).loop;
			LuaDLL.lua_pushboolean(L, loop);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index loop on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_defaultClip(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LipSyncData defaultClip = ((LipSync)obj).defaultClip;
			ToLua.Push(L, defaultClip);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index defaultClip on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_defaultDelay(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float defaultDelay = ((LipSync)obj).defaultDelay;
			LuaDLL.lua_pushnumber(L, defaultDelay);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index defaultDelay on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_scaleAudioSpeed(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool scaleAudioSpeed = ((LipSync)obj).scaleAudioSpeed;
			LuaDLL.lua_pushboolean(L, scaleAudioSpeed);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index scaleAudioSpeed on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_frameRate(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int frameRate = ((LipSync)obj).frameRate;
			LuaDLL.lua_pushinteger(L, frameRate);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index frameRate on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_restTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float restTime = ((LipSync)obj).restTime;
			LuaDLL.lua_pushnumber(L, restTime);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index restTime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_restHoldTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float restHoldTime = ((LipSync)obj).restHoldTime;
			LuaDLL.lua_pushnumber(L, restHoldTime);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index restHoldTime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_phonemeCurveGenerationMode(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LipSync.CurveGenerationMode phonemeCurveGenerationMode = ((LipSync)obj).phonemeCurveGenerationMode;
			ToLua.Push(L, phonemeCurveGenerationMode);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index phonemeCurveGenerationMode on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_emotionCurveGenerationMode(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LipSync.CurveGenerationMode emotionCurveGenerationMode = ((LipSync)obj).emotionCurveGenerationMode;
			ToLua.Push(L, emotionCurveGenerationMode);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index emotionCurveGenerationMode on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_keepEmotionWhenFinished(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool keepEmotionWhenFinished = ((LipSync)obj).keepEmotionWhenFinished;
			LuaDLL.lua_pushboolean(L, keepEmotionWhenFinished);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index keepEmotionWhenFinished on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_gesturesAnimator(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Animator gesturesAnimator = ((LipSync)obj).gesturesAnimator;
			ToLua.Push(L, gesturesAnimator);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index gesturesAnimator on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_gesturesLayer(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int gesturesLayer = ((LipSync)obj).gesturesLayer;
			LuaDLL.lua_pushinteger(L, gesturesLayer);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index gesturesLayer on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_gestures(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<GestureInstance> gestures = ((LipSync)obj).gestures;
			ToLua.PushSealed(L, gestures);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index gestures on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_onFinishedPlaying(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UnityEvent onFinishedPlaying = ((LipSync)obj).onFinishedPlaying;
			ToLua.PushObject(L, onFinishedPlaying);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index onFinishedPlaying on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_animCurves(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<AnimationCurve> animCurves = ((LipSync)obj).animCurves;
			ToLua.PushSealed(L, animCurves);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index animCurves on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_reset(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LipSync.ResetDelegate reset = ((LipSync)obj).reset;
			ToLua.Push(L, reset);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index reset on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_lastUsedVersion(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float lastUsedVersion = ((LipSync)obj).lastUsedVersion;
			LuaDLL.lua_pushnumber(L, lastUsedVersion);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index lastUsedVersion on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_animationTimingMode(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LipSync.AnimationTimingMode animationTimingMode = ((LipSync)obj).animationTimingMode;
			ToLua.Push(L, animationTimingMode);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index animationTimingMode on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_IsPlaying(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isPlaying = ((LipSync)obj).IsPlaying;
			LuaDLL.lua_pushboolean(L, isPlaying);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index IsPlaying on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_IsPaused(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isPaused = ((LipSync)obj).IsPaused;
			LuaDLL.lua_pushboolean(L, isPaused);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index IsPaused on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_IsStopping(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isStopping = ((LipSync)obj).IsStopping;
			LuaDLL.lua_pushboolean(L, isStopping);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index IsStopping on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_CurrentTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float currentTime = ((LipSync)obj).CurrentTime;
			LuaDLL.lua_pushnumber(L, currentTime);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index CurrentTime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_lastEmotion(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LipSync obj2 = (LipSync)obj;
			string lastEmotion = ToLua.CheckString(L, 2);
			obj2.lastEmotion = lastEmotion;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index lastEmotion on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_audioSource(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LipSync obj2 = (LipSync)obj;
			AudioSource audioSource = (AudioSource)ToLua.CheckObject(L, 2, typeof(AudioSource));
			obj2.audioSource = audioSource;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index audioSource on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_useBones(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LipSync obj2 = (LipSync)obj;
			bool useBones = LuaDLL.luaL_checkboolean(L, 2);
			obj2.useBones = useBones;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index useBones on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_boneUpdateAnimation(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LipSync obj2 = (LipSync)obj;
			bool boneUpdateAnimation = LuaDLL.luaL_checkboolean(L, 2);
			obj2.boneUpdateAnimation = boneUpdateAnimation;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index boneUpdateAnimation on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_phonemes(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LipSync obj2 = (LipSync)obj;
			List<PhonemeShape> phonemes = (List<PhonemeShape>)ToLua.CheckObject(L, 2, typeof(List<PhonemeShape>));
			obj2.phonemes = phonemes;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index phonemes on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_emotions(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LipSync obj2 = (LipSync)obj;
			List<EmotionShape> emotions = (List<EmotionShape>)ToLua.CheckObject(L, 2, typeof(List<EmotionShape>));
			obj2.emotions = emotions;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index emotions on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_playOnAwake(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LipSync obj2 = (LipSync)obj;
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
	private static int set_loop(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LipSync obj2 = (LipSync)obj;
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
	private static int set_defaultClip(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LipSync obj2 = (LipSync)obj;
			LipSyncData defaultClip = (LipSyncData)ToLua.CheckObject<LipSyncData>(L, 2);
			obj2.defaultClip = defaultClip;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index defaultClip on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_defaultDelay(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LipSync obj2 = (LipSync)obj;
			float defaultDelay = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.defaultDelay = defaultDelay;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index defaultDelay on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_scaleAudioSpeed(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LipSync obj2 = (LipSync)obj;
			bool scaleAudioSpeed = LuaDLL.luaL_checkboolean(L, 2);
			obj2.scaleAudioSpeed = scaleAudioSpeed;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index scaleAudioSpeed on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_frameRate(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LipSync obj2 = (LipSync)obj;
			int frameRate = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.frameRate = frameRate;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index frameRate on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_restTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LipSync obj2 = (LipSync)obj;
			float restTime = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.restTime = restTime;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index restTime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_restHoldTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LipSync obj2 = (LipSync)obj;
			float restHoldTime = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.restHoldTime = restHoldTime;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index restHoldTime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_phonemeCurveGenerationMode(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LipSync obj2 = (LipSync)obj;
			LipSync.CurveGenerationMode phonemeCurveGenerationMode = (LipSync.CurveGenerationMode)ToLua.CheckObject(L, 2, typeof(LipSync.CurveGenerationMode));
			obj2.phonemeCurveGenerationMode = phonemeCurveGenerationMode;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index phonemeCurveGenerationMode on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_emotionCurveGenerationMode(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LipSync obj2 = (LipSync)obj;
			LipSync.CurveGenerationMode emotionCurveGenerationMode = (LipSync.CurveGenerationMode)ToLua.CheckObject(L, 2, typeof(LipSync.CurveGenerationMode));
			obj2.emotionCurveGenerationMode = emotionCurveGenerationMode;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index emotionCurveGenerationMode on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_keepEmotionWhenFinished(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LipSync obj2 = (LipSync)obj;
			bool keepEmotionWhenFinished = LuaDLL.luaL_checkboolean(L, 2);
			obj2.keepEmotionWhenFinished = keepEmotionWhenFinished;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index keepEmotionWhenFinished on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_gesturesAnimator(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LipSync obj2 = (LipSync)obj;
			Animator gesturesAnimator = (Animator)ToLua.CheckObject<Animator>(L, 2);
			obj2.gesturesAnimator = gesturesAnimator;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index gesturesAnimator on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_gesturesLayer(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LipSync obj2 = (LipSync)obj;
			int gesturesLayer = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.gesturesLayer = gesturesLayer;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index gesturesLayer on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_gestures(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LipSync obj2 = (LipSync)obj;
			List<GestureInstance> gestures = (List<GestureInstance>)ToLua.CheckObject(L, 2, typeof(List<GestureInstance>));
			obj2.gestures = gestures;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index gestures on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_animCurves(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LipSync obj2 = (LipSync)obj;
			List<AnimationCurve> animCurves = (List<AnimationCurve>)ToLua.CheckObject(L, 2, typeof(List<AnimationCurve>));
			obj2.animCurves = animCurves;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index animCurves on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_reset(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LipSync obj2 = (LipSync)obj;
			LipSync.ResetDelegate reset = (LipSync.ResetDelegate)ToLua.CheckDelegate<LipSync.ResetDelegate>(L, 2);
			obj2.reset = reset;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index reset on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_lastUsedVersion(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LipSync obj2 = (LipSync)obj;
			float lastUsedVersion = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.lastUsedVersion = lastUsedVersion;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index lastUsedVersion on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_animationTimingMode(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LipSync obj2 = (LipSync)obj;
			LipSync.AnimationTimingMode animationTimingMode = (LipSync.AnimationTimingMode)ToLua.CheckObject(L, 2, typeof(LipSync.AnimationTimingMode));
			obj2.animationTimingMode = animationTimingMode;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index animationTimingMode on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RogoDigital_Lipsync_LipSync_ResetDelegate(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<LipSync.ResetDelegate>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<LipSync.ResetDelegate>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
