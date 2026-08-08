using System;
using LuaInterface;
using UnityEngine;
using UnityEngine.Video;

public class UnityEngine_Video_VideoPlayerWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(VideoPlayer), typeof(Behaviour));
		L.RegFunction("Prepare", Prepare);
		L.RegFunction("Play", Play);
		L.RegFunction("Pause", Pause);
		L.RegFunction("Stop", Stop);
		L.RegFunction("StepForward", StepForward);
		L.RegFunction("GetAudioLanguageCode", GetAudioLanguageCode);
		L.RegFunction("GetAudioChannelCount", GetAudioChannelCount);
		L.RegFunction("GetAudioSampleRate", GetAudioSampleRate);
		L.RegFunction("EnableAudioTrack", EnableAudioTrack);
		L.RegFunction("IsAudioTrackEnabled", IsAudioTrackEnabled);
		L.RegFunction("GetDirectAudioVolume", GetDirectAudioVolume);
		L.RegFunction("SetDirectAudioVolume", SetDirectAudioVolume);
		L.RegFunction("GetDirectAudioMute", GetDirectAudioMute);
		L.RegFunction("SetDirectAudioMute", SetDirectAudioMute);
		L.RegFunction("GetTargetAudioSource", GetTargetAudioSource);
		L.RegFunction("SetTargetAudioSource", SetTargetAudioSource);
		L.RegFunction("New", _CreateUnityEngine_Video_VideoPlayer);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("source", get_source, set_source);
		L.RegVar("url", get_url, set_url);
		L.RegVar("clip", get_clip, set_clip);
		L.RegVar("renderMode", get_renderMode, set_renderMode);
		L.RegVar("targetCamera", get_targetCamera, set_targetCamera);
		L.RegVar("targetTexture", get_targetTexture, set_targetTexture);
		L.RegVar("targetMaterialRenderer", get_targetMaterialRenderer, set_targetMaterialRenderer);
		L.RegVar("targetMaterialProperty", get_targetMaterialProperty, set_targetMaterialProperty);
		L.RegVar("aspectRatio", get_aspectRatio, set_aspectRatio);
		L.RegVar("targetCameraAlpha", get_targetCameraAlpha, set_targetCameraAlpha);
		L.RegVar("targetCamera3DLayout", get_targetCamera3DLayout, set_targetCamera3DLayout);
		L.RegVar("texture", get_texture, null);
		L.RegVar("isPrepared", get_isPrepared, null);
		L.RegVar("waitForFirstFrame", get_waitForFirstFrame, set_waitForFirstFrame);
		L.RegVar("playOnAwake", get_playOnAwake, set_playOnAwake);
		L.RegVar("isPlaying", get_isPlaying, null);
		L.RegVar("isPaused", get_isPaused, null);
		L.RegVar("canSetTime", get_canSetTime, null);
		L.RegVar("time", get_time, set_time);
		L.RegVar("frame", get_frame, set_frame);
		L.RegVar("clockTime", get_clockTime, null);
		L.RegVar("canStep", get_canStep, null);
		L.RegVar("canSetPlaybackSpeed", get_canSetPlaybackSpeed, null);
		L.RegVar("playbackSpeed", get_playbackSpeed, set_playbackSpeed);
		L.RegVar("isLooping", get_isLooping, set_isLooping);
		L.RegVar("canSetTimeSource", get_canSetTimeSource, null);
		L.RegVar("timeSource", get_timeSource, set_timeSource);
		L.RegVar("timeReference", get_timeReference, set_timeReference);
		L.RegVar("externalReferenceTime", get_externalReferenceTime, set_externalReferenceTime);
		L.RegVar("canSetSkipOnDrop", get_canSetSkipOnDrop, null);
		L.RegVar("skipOnDrop", get_skipOnDrop, set_skipOnDrop);
		L.RegVar("frameCount", get_frameCount, null);
		L.RegVar("frameRate", get_frameRate, null);
		L.RegVar("length", get_length, null);
		L.RegVar("width", get_width, null);
		L.RegVar("height", get_height, null);
		L.RegVar("pixelAspectRatioNumerator", get_pixelAspectRatioNumerator, null);
		L.RegVar("pixelAspectRatioDenominator", get_pixelAspectRatioDenominator, null);
		L.RegVar("audioTrackCount", get_audioTrackCount, null);
		L.RegVar("controlledAudioTrackMaxCount", get_controlledAudioTrackMaxCount, null);
		L.RegVar("controlledAudioTrackCount", get_controlledAudioTrackCount, set_controlledAudioTrackCount);
		L.RegVar("audioOutputMode", get_audioOutputMode, set_audioOutputMode);
		L.RegVar("canSetDirectAudioVolume", get_canSetDirectAudioVolume, null);
		L.RegVar("sendFrameReadyEvents", get_sendFrameReadyEvents, set_sendFrameReadyEvents);
		L.RegVar("prepareCompleted", get_prepareCompleted, set_prepareCompleted);
		L.RegVar("loopPointReached", get_loopPointReached, set_loopPointReached);
		L.RegVar("started", get_started, set_started);
		L.RegVar("frameDropped", get_frameDropped, set_frameDropped);
		L.RegVar("errorReceived", get_errorReceived, set_errorReceived);
		L.RegVar("seekCompleted", get_seekCompleted, set_seekCompleted);
		L.RegVar("clockResyncOccurred", get_clockResyncOccurred, set_clockResyncOccurred);
		L.RegVar("frameReady", get_frameReady, set_frameReady);
		L.RegFunction("FrameReadyEventHandler", UnityEngine_Video_VideoPlayer_FrameReadyEventHandler);
		L.RegFunction("TimeEventHandler", UnityEngine_Video_VideoPlayer_TimeEventHandler);
		L.RegFunction("EventHandler", UnityEngine_Video_VideoPlayer_EventHandler);
		L.RegFunction("ErrorEventHandler", UnityEngine_Video_VideoPlayer_ErrorEventHandler);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateUnityEngine_Video_VideoPlayer(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				VideoPlayer o = new VideoPlayer();
				ToLua.PushSealed(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: UnityEngine.Video.VideoPlayer.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Prepare(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((VideoPlayer)ToLua.CheckObject(L, 1, typeof(VideoPlayer))).Prepare();
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
			ToLua.CheckArgsCount(L, 1);
			((VideoPlayer)ToLua.CheckObject(L, 1, typeof(VideoPlayer))).Play();
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
			((VideoPlayer)ToLua.CheckObject(L, 1, typeof(VideoPlayer))).Pause();
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
			((VideoPlayer)ToLua.CheckObject(L, 1, typeof(VideoPlayer))).Stop();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int StepForward(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((VideoPlayer)ToLua.CheckObject(L, 1, typeof(VideoPlayer))).StepForward();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetAudioLanguageCode(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			VideoPlayer obj = (VideoPlayer)ToLua.CheckObject(L, 1, typeof(VideoPlayer));
			ushort trackIndex = (ushort)LuaDLL.luaL_checknumber(L, 2);
			string audioLanguageCode = obj.GetAudioLanguageCode(trackIndex);
			LuaDLL.lua_pushstring(L, audioLanguageCode);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetAudioChannelCount(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			VideoPlayer obj = (VideoPlayer)ToLua.CheckObject(L, 1, typeof(VideoPlayer));
			ushort trackIndex = (ushort)LuaDLL.luaL_checknumber(L, 2);
			ushort audioChannelCount = obj.GetAudioChannelCount(trackIndex);
			LuaDLL.lua_pushnumber(L, (int)audioChannelCount);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetAudioSampleRate(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			VideoPlayer obj = (VideoPlayer)ToLua.CheckObject(L, 1, typeof(VideoPlayer));
			ushort trackIndex = (ushort)LuaDLL.luaL_checknumber(L, 2);
			uint audioSampleRate = obj.GetAudioSampleRate(trackIndex);
			LuaDLL.lua_pushnumber(L, audioSampleRate);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int EnableAudioTrack(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			VideoPlayer obj = (VideoPlayer)ToLua.CheckObject(L, 1, typeof(VideoPlayer));
			ushort trackIndex = (ushort)LuaDLL.luaL_checknumber(L, 2);
			bool enabled = LuaDLL.luaL_checkboolean(L, 3);
			obj.EnableAudioTrack(trackIndex, enabled);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IsAudioTrackEnabled(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			VideoPlayer obj = (VideoPlayer)ToLua.CheckObject(L, 1, typeof(VideoPlayer));
			ushort trackIndex = (ushort)LuaDLL.luaL_checknumber(L, 2);
			bool value = obj.IsAudioTrackEnabled(trackIndex);
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetDirectAudioVolume(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			VideoPlayer obj = (VideoPlayer)ToLua.CheckObject(L, 1, typeof(VideoPlayer));
			ushort trackIndex = (ushort)LuaDLL.luaL_checknumber(L, 2);
			float directAudioVolume = obj.GetDirectAudioVolume(trackIndex);
			LuaDLL.lua_pushnumber(L, directAudioVolume);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetDirectAudioVolume(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			VideoPlayer obj = (VideoPlayer)ToLua.CheckObject(L, 1, typeof(VideoPlayer));
			ushort trackIndex = (ushort)LuaDLL.luaL_checknumber(L, 2);
			float volume = (float)LuaDLL.luaL_checknumber(L, 3);
			obj.SetDirectAudioVolume(trackIndex, volume);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetDirectAudioMute(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			VideoPlayer obj = (VideoPlayer)ToLua.CheckObject(L, 1, typeof(VideoPlayer));
			ushort trackIndex = (ushort)LuaDLL.luaL_checknumber(L, 2);
			bool directAudioMute = obj.GetDirectAudioMute(trackIndex);
			LuaDLL.lua_pushboolean(L, directAudioMute);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetDirectAudioMute(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			VideoPlayer obj = (VideoPlayer)ToLua.CheckObject(L, 1, typeof(VideoPlayer));
			ushort trackIndex = (ushort)LuaDLL.luaL_checknumber(L, 2);
			bool mute = LuaDLL.luaL_checkboolean(L, 3);
			obj.SetDirectAudioMute(trackIndex, mute);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetTargetAudioSource(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			VideoPlayer obj = (VideoPlayer)ToLua.CheckObject(L, 1, typeof(VideoPlayer));
			ushort trackIndex = (ushort)LuaDLL.luaL_checknumber(L, 2);
			AudioSource targetAudioSource = obj.GetTargetAudioSource(trackIndex);
			ToLua.PushSealed(L, targetAudioSource);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetTargetAudioSource(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			VideoPlayer obj = (VideoPlayer)ToLua.CheckObject(L, 1, typeof(VideoPlayer));
			ushort trackIndex = (ushort)LuaDLL.luaL_checknumber(L, 2);
			AudioSource source = (AudioSource)ToLua.CheckObject(L, 3, typeof(AudioSource));
			obj.SetTargetAudioSource(trackIndex, source);
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
	private static int get_source(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			VideoSource source = ((VideoPlayer)obj).source;
			ToLua.Push(L, source);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index source on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_url(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string url = ((VideoPlayer)obj).url;
			LuaDLL.lua_pushstring(L, url);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index url on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_clip(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			VideoClip clip = ((VideoPlayer)obj).clip;
			ToLua.PushSealed(L, clip);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index clip on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_renderMode(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			VideoRenderMode renderMode = ((VideoPlayer)obj).renderMode;
			ToLua.Push(L, renderMode);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index renderMode on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_targetCamera(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Camera targetCamera = ((VideoPlayer)obj).targetCamera;
			ToLua.PushSealed(L, targetCamera);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index targetCamera on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_targetTexture(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RenderTexture targetTexture = ((VideoPlayer)obj).targetTexture;
			ToLua.Push(L, targetTexture);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index targetTexture on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_targetMaterialRenderer(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Renderer targetMaterialRenderer = ((VideoPlayer)obj).targetMaterialRenderer;
			ToLua.Push(L, targetMaterialRenderer);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index targetMaterialRenderer on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_targetMaterialProperty(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string targetMaterialProperty = ((VideoPlayer)obj).targetMaterialProperty;
			LuaDLL.lua_pushstring(L, targetMaterialProperty);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index targetMaterialProperty on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_aspectRatio(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			VideoAspectRatio aspectRatio = ((VideoPlayer)obj).aspectRatio;
			ToLua.Push(L, aspectRatio);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index aspectRatio on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_targetCameraAlpha(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float targetCameraAlpha = ((VideoPlayer)obj).targetCameraAlpha;
			LuaDLL.lua_pushnumber(L, targetCameraAlpha);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index targetCameraAlpha on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_targetCamera3DLayout(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Video3DLayout targetCamera3DLayout = ((VideoPlayer)obj).targetCamera3DLayout;
			ToLua.Push(L, targetCamera3DLayout);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index targetCamera3DLayout on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_texture(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Texture texture = ((VideoPlayer)obj).texture;
			ToLua.Push(L, texture);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index texture on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isPrepared(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isPrepared = ((VideoPlayer)obj).isPrepared;
			LuaDLL.lua_pushboolean(L, isPrepared);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isPrepared on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_waitForFirstFrame(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool waitForFirstFrame = ((VideoPlayer)obj).waitForFirstFrame;
			LuaDLL.lua_pushboolean(L, waitForFirstFrame);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index waitForFirstFrame on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_playOnAwake(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool playOnAwake = ((VideoPlayer)obj).playOnAwake;
			LuaDLL.lua_pushboolean(L, playOnAwake);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index playOnAwake on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isPlaying(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isPlaying = ((VideoPlayer)obj).isPlaying;
			LuaDLL.lua_pushboolean(L, isPlaying);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isPlaying on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isPaused(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isPaused = ((VideoPlayer)obj).isPaused;
			LuaDLL.lua_pushboolean(L, isPaused);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isPaused on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_canSetTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool canSetTime = ((VideoPlayer)obj).canSetTime;
			LuaDLL.lua_pushboolean(L, canSetTime);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index canSetTime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_time(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			double time = ((VideoPlayer)obj).time;
			LuaDLL.lua_pushnumber(L, time);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index time on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_frame(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			long frame = ((VideoPlayer)obj).frame;
			LuaDLL.tolua_pushint64(L, frame);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index frame on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_clockTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			double clockTime = ((VideoPlayer)obj).clockTime;
			LuaDLL.lua_pushnumber(L, clockTime);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index clockTime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_canStep(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool canStep = ((VideoPlayer)obj).canStep;
			LuaDLL.lua_pushboolean(L, canStep);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index canStep on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_canSetPlaybackSpeed(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool canSetPlaybackSpeed = ((VideoPlayer)obj).canSetPlaybackSpeed;
			LuaDLL.lua_pushboolean(L, canSetPlaybackSpeed);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index canSetPlaybackSpeed on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_playbackSpeed(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float playbackSpeed = ((VideoPlayer)obj).playbackSpeed;
			LuaDLL.lua_pushnumber(L, playbackSpeed);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index playbackSpeed on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isLooping(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isLooping = ((VideoPlayer)obj).isLooping;
			LuaDLL.lua_pushboolean(L, isLooping);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isLooping on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_canSetTimeSource(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool canSetTimeUpdateMode = ((VideoPlayer)obj).canSetTimeUpdateMode;
			LuaDLL.lua_pushboolean(L, canSetTimeUpdateMode);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index canSetTimeSource on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_timeSource(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			VideoTimeUpdateMode timeUpdateMode = ((VideoPlayer)obj).timeUpdateMode;
			ToLua.Push(L, timeUpdateMode);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index timeSource on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_timeReference(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			VideoTimeReference timeReference = ((VideoPlayer)obj).timeReference;
			ToLua.Push(L, timeReference);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index timeReference on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_externalReferenceTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			double externalReferenceTime = ((VideoPlayer)obj).externalReferenceTime;
			LuaDLL.lua_pushnumber(L, externalReferenceTime);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index externalReferenceTime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_canSetSkipOnDrop(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool canSetSkipOnDrop = ((VideoPlayer)obj).canSetSkipOnDrop;
			LuaDLL.lua_pushboolean(L, canSetSkipOnDrop);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index canSetSkipOnDrop on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_skipOnDrop(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool skipOnDrop = ((VideoPlayer)obj).skipOnDrop;
			LuaDLL.lua_pushboolean(L, skipOnDrop);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index skipOnDrop on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_frameCount(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ulong frameCount = ((VideoPlayer)obj).frameCount;
			LuaDLL.tolua_pushuint64(L, frameCount);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index frameCount on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_frameRate(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float frameRate = ((VideoPlayer)obj).frameRate;
			LuaDLL.lua_pushnumber(L, frameRate);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index frameRate on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_length(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			double length = ((VideoPlayer)obj).length;
			LuaDLL.lua_pushnumber(L, length);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index length on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_width(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			uint width = ((VideoPlayer)obj).width;
			LuaDLL.lua_pushnumber(L, width);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index width on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_height(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			uint height = ((VideoPlayer)obj).height;
			LuaDLL.lua_pushnumber(L, height);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index height on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_pixelAspectRatioNumerator(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			uint pixelAspectRatioNumerator = ((VideoPlayer)obj).pixelAspectRatioNumerator;
			LuaDLL.lua_pushnumber(L, pixelAspectRatioNumerator);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index pixelAspectRatioNumerator on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_pixelAspectRatioDenominator(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			uint pixelAspectRatioDenominator = ((VideoPlayer)obj).pixelAspectRatioDenominator;
			LuaDLL.lua_pushnumber(L, pixelAspectRatioDenominator);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index pixelAspectRatioDenominator on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_audioTrackCount(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ushort audioTrackCount = ((VideoPlayer)obj).audioTrackCount;
			LuaDLL.lua_pushnumber(L, (int)audioTrackCount);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index audioTrackCount on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_controlledAudioTrackMaxCount(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushnumber(L, (int)VideoPlayer.controlledAudioTrackMaxCount);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_controlledAudioTrackCount(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ushort controlledAudioTrackCount = ((VideoPlayer)obj).controlledAudioTrackCount;
			LuaDLL.lua_pushnumber(L, (int)controlledAudioTrackCount);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index controlledAudioTrackCount on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_audioOutputMode(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			VideoAudioOutputMode audioOutputMode = ((VideoPlayer)obj).audioOutputMode;
			ToLua.Push(L, audioOutputMode);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index audioOutputMode on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_canSetDirectAudioVolume(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool canSetDirectAudioVolume = ((VideoPlayer)obj).canSetDirectAudioVolume;
			LuaDLL.lua_pushboolean(L, canSetDirectAudioVolume);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index canSetDirectAudioVolume on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_sendFrameReadyEvents(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool sendFrameReadyEvents = ((VideoPlayer)obj).sendFrameReadyEvents;
			LuaDLL.lua_pushboolean(L, sendFrameReadyEvents);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index sendFrameReadyEvents on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_prepareCompleted(IntPtr L)
	{
		ToLua.Push(L, new EventObject(typeof(VideoPlayer.EventHandler)));
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_loopPointReached(IntPtr L)
	{
		ToLua.Push(L, new EventObject(typeof(VideoPlayer.EventHandler)));
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_started(IntPtr L)
	{
		ToLua.Push(L, new EventObject(typeof(VideoPlayer.EventHandler)));
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_frameDropped(IntPtr L)
	{
		ToLua.Push(L, new EventObject(typeof(VideoPlayer.EventHandler)));
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_errorReceived(IntPtr L)
	{
		ToLua.Push(L, new EventObject(typeof(VideoPlayer.ErrorEventHandler)));
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_seekCompleted(IntPtr L)
	{
		ToLua.Push(L, new EventObject(typeof(VideoPlayer.EventHandler)));
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_clockResyncOccurred(IntPtr L)
	{
		ToLua.Push(L, new EventObject(typeof(VideoPlayer.TimeEventHandler)));
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_frameReady(IntPtr L)
	{
		ToLua.Push(L, new EventObject(typeof(VideoPlayer.FrameReadyEventHandler)));
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_source(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			VideoPlayer obj2 = (VideoPlayer)obj;
			VideoSource source = (VideoSource)ToLua.CheckObject(L, 2, typeof(VideoSource));
			obj2.source = source;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index source on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_url(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			VideoPlayer obj2 = (VideoPlayer)obj;
			string url = ToLua.CheckString(L, 2);
			obj2.url = url;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index url on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_clip(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			VideoPlayer obj2 = (VideoPlayer)obj;
			VideoClip clip = (VideoClip)ToLua.CheckObject(L, 2, typeof(VideoClip));
			obj2.clip = clip;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index clip on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_renderMode(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			VideoPlayer obj2 = (VideoPlayer)obj;
			VideoRenderMode renderMode = (VideoRenderMode)ToLua.CheckObject(L, 2, typeof(VideoRenderMode));
			obj2.renderMode = renderMode;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index renderMode on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_targetCamera(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			VideoPlayer obj2 = (VideoPlayer)obj;
			Camera targetCamera = (Camera)ToLua.CheckObject(L, 2, typeof(Camera));
			obj2.targetCamera = targetCamera;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index targetCamera on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_targetTexture(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			VideoPlayer obj2 = (VideoPlayer)obj;
			RenderTexture targetTexture = (RenderTexture)ToLua.CheckObject<RenderTexture>(L, 2);
			obj2.targetTexture = targetTexture;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index targetTexture on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_targetMaterialRenderer(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			VideoPlayer obj2 = (VideoPlayer)obj;
			Renderer targetMaterialRenderer = (Renderer)ToLua.CheckObject<Renderer>(L, 2);
			obj2.targetMaterialRenderer = targetMaterialRenderer;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index targetMaterialRenderer on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_targetMaterialProperty(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			VideoPlayer obj2 = (VideoPlayer)obj;
			string targetMaterialProperty = ToLua.CheckString(L, 2);
			obj2.targetMaterialProperty = targetMaterialProperty;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index targetMaterialProperty on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_aspectRatio(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			VideoPlayer obj2 = (VideoPlayer)obj;
			VideoAspectRatio aspectRatio = (VideoAspectRatio)ToLua.CheckObject(L, 2, typeof(VideoAspectRatio));
			obj2.aspectRatio = aspectRatio;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index aspectRatio on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_targetCameraAlpha(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			VideoPlayer obj2 = (VideoPlayer)obj;
			float targetCameraAlpha = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.targetCameraAlpha = targetCameraAlpha;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index targetCameraAlpha on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_targetCamera3DLayout(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			VideoPlayer obj2 = (VideoPlayer)obj;
			Video3DLayout targetCamera3DLayout = (Video3DLayout)ToLua.CheckObject(L, 2, typeof(Video3DLayout));
			obj2.targetCamera3DLayout = targetCamera3DLayout;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index targetCamera3DLayout on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_waitForFirstFrame(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			VideoPlayer obj2 = (VideoPlayer)obj;
			bool waitForFirstFrame = LuaDLL.luaL_checkboolean(L, 2);
			obj2.waitForFirstFrame = waitForFirstFrame;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index waitForFirstFrame on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_playOnAwake(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			VideoPlayer obj2 = (VideoPlayer)obj;
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
	private static int set_time(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			VideoPlayer obj2 = (VideoPlayer)obj;
			double time = LuaDLL.luaL_checknumber(L, 2);
			obj2.time = time;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index time on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_frame(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			VideoPlayer obj2 = (VideoPlayer)obj;
			long frame = LuaDLL.tolua_checkint64(L, 2);
			obj2.frame = frame;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index frame on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_playbackSpeed(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			VideoPlayer obj2 = (VideoPlayer)obj;
			float playbackSpeed = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.playbackSpeed = playbackSpeed;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index playbackSpeed on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_isLooping(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			VideoPlayer obj2 = (VideoPlayer)obj;
			bool isLooping = LuaDLL.luaL_checkboolean(L, 2);
			obj2.isLooping = isLooping;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isLooping on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_timeSource(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			VideoPlayer obj2 = (VideoPlayer)obj;
			VideoTimeUpdateMode timeUpdateMode = (VideoTimeUpdateMode)ToLua.CheckObject(L, 2, typeof(VideoTimeUpdateMode));
			obj2.timeUpdateMode = timeUpdateMode;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index timeSource on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_timeReference(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			VideoPlayer obj2 = (VideoPlayer)obj;
			VideoTimeReference timeReference = (VideoTimeReference)ToLua.CheckObject(L, 2, typeof(VideoTimeReference));
			obj2.timeReference = timeReference;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index timeReference on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_externalReferenceTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			VideoPlayer obj2 = (VideoPlayer)obj;
			double externalReferenceTime = LuaDLL.luaL_checknumber(L, 2);
			obj2.externalReferenceTime = externalReferenceTime;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index externalReferenceTime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_skipOnDrop(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			VideoPlayer obj2 = (VideoPlayer)obj;
			bool skipOnDrop = LuaDLL.luaL_checkboolean(L, 2);
			obj2.skipOnDrop = skipOnDrop;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index skipOnDrop on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_controlledAudioTrackCount(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			VideoPlayer obj2 = (VideoPlayer)obj;
			ushort controlledAudioTrackCount = (ushort)LuaDLL.luaL_checknumber(L, 2);
			obj2.controlledAudioTrackCount = controlledAudioTrackCount;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index controlledAudioTrackCount on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_audioOutputMode(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			VideoPlayer obj2 = (VideoPlayer)obj;
			VideoAudioOutputMode audioOutputMode = (VideoAudioOutputMode)ToLua.CheckObject(L, 2, typeof(VideoAudioOutputMode));
			obj2.audioOutputMode = audioOutputMode;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index audioOutputMode on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_sendFrameReadyEvents(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			VideoPlayer obj2 = (VideoPlayer)obj;
			bool sendFrameReadyEvents = LuaDLL.luaL_checkboolean(L, 2);
			obj2.sendFrameReadyEvents = sendFrameReadyEvents;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index sendFrameReadyEvents on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_prepareCompleted(IntPtr L)
	{
		try
		{
			VideoPlayer videoPlayer = (VideoPlayer)ToLua.CheckObject(L, 1, typeof(VideoPlayer));
			EventObject eventObject = null;
			if (LuaDLL.lua_isuserdata(L, 2) != 0)
			{
				eventObject = (EventObject)ToLua.ToObject(L, 2);
				if (eventObject.op == EventOp.Add)
				{
					VideoPlayer.EventHandler value = (VideoPlayer.EventHandler)eventObject.func;
					videoPlayer.prepareCompleted += value;
				}
				else if (eventObject.op == EventOp.Sub)
				{
					VideoPlayer.EventHandler value2 = (VideoPlayer.EventHandler)eventObject.func;
					videoPlayer.prepareCompleted -= value2;
				}
				return 0;
			}
			return LuaDLL.luaL_throw(L, "The event 'UnityEngine.Video.VideoPlayer.prepareCompleted' can only appear on the left hand side of += or -= when used outside of the type 'UnityEngine.Video.VideoPlayer'");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_loopPointReached(IntPtr L)
	{
		try
		{
			VideoPlayer videoPlayer = (VideoPlayer)ToLua.CheckObject(L, 1, typeof(VideoPlayer));
			EventObject eventObject = null;
			if (LuaDLL.lua_isuserdata(L, 2) != 0)
			{
				eventObject = (EventObject)ToLua.ToObject(L, 2);
				if (eventObject.op == EventOp.Add)
				{
					VideoPlayer.EventHandler value = (VideoPlayer.EventHandler)eventObject.func;
					videoPlayer.loopPointReached += value;
				}
				else if (eventObject.op == EventOp.Sub)
				{
					VideoPlayer.EventHandler value2 = (VideoPlayer.EventHandler)eventObject.func;
					videoPlayer.loopPointReached -= value2;
				}
				return 0;
			}
			return LuaDLL.luaL_throw(L, "The event 'UnityEngine.Video.VideoPlayer.loopPointReached' can only appear on the left hand side of += or -= when used outside of the type 'UnityEngine.Video.VideoPlayer'");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_started(IntPtr L)
	{
		try
		{
			VideoPlayer videoPlayer = (VideoPlayer)ToLua.CheckObject(L, 1, typeof(VideoPlayer));
			EventObject eventObject = null;
			if (LuaDLL.lua_isuserdata(L, 2) != 0)
			{
				eventObject = (EventObject)ToLua.ToObject(L, 2);
				if (eventObject.op == EventOp.Add)
				{
					VideoPlayer.EventHandler value = (VideoPlayer.EventHandler)eventObject.func;
					videoPlayer.started += value;
				}
				else if (eventObject.op == EventOp.Sub)
				{
					VideoPlayer.EventHandler value2 = (VideoPlayer.EventHandler)eventObject.func;
					videoPlayer.started -= value2;
				}
				return 0;
			}
			return LuaDLL.luaL_throw(L, "The event 'UnityEngine.Video.VideoPlayer.started' can only appear on the left hand side of += or -= when used outside of the type 'UnityEngine.Video.VideoPlayer'");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_frameDropped(IntPtr L)
	{
		try
		{
			VideoPlayer videoPlayer = (VideoPlayer)ToLua.CheckObject(L, 1, typeof(VideoPlayer));
			EventObject eventObject = null;
			if (LuaDLL.lua_isuserdata(L, 2) != 0)
			{
				eventObject = (EventObject)ToLua.ToObject(L, 2);
				if (eventObject.op == EventOp.Add)
				{
					VideoPlayer.EventHandler value = (VideoPlayer.EventHandler)eventObject.func;
					videoPlayer.frameDropped += value;
				}
				else if (eventObject.op == EventOp.Sub)
				{
					VideoPlayer.EventHandler value2 = (VideoPlayer.EventHandler)eventObject.func;
					videoPlayer.frameDropped -= value2;
				}
				return 0;
			}
			return LuaDLL.luaL_throw(L, "The event 'UnityEngine.Video.VideoPlayer.frameDropped' can only appear on the left hand side of += or -= when used outside of the type 'UnityEngine.Video.VideoPlayer'");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_errorReceived(IntPtr L)
	{
		try
		{
			VideoPlayer videoPlayer = (VideoPlayer)ToLua.CheckObject(L, 1, typeof(VideoPlayer));
			EventObject eventObject = null;
			if (LuaDLL.lua_isuserdata(L, 2) != 0)
			{
				eventObject = (EventObject)ToLua.ToObject(L, 2);
				if (eventObject.op == EventOp.Add)
				{
					VideoPlayer.ErrorEventHandler value = (VideoPlayer.ErrorEventHandler)eventObject.func;
					videoPlayer.errorReceived += value;
				}
				else if (eventObject.op == EventOp.Sub)
				{
					VideoPlayer.ErrorEventHandler value2 = (VideoPlayer.ErrorEventHandler)eventObject.func;
					videoPlayer.errorReceived -= value2;
				}
				return 0;
			}
			return LuaDLL.luaL_throw(L, "The event 'UnityEngine.Video.VideoPlayer.errorReceived' can only appear on the left hand side of += or -= when used outside of the type 'UnityEngine.Video.VideoPlayer'");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_seekCompleted(IntPtr L)
	{
		try
		{
			VideoPlayer videoPlayer = (VideoPlayer)ToLua.CheckObject(L, 1, typeof(VideoPlayer));
			EventObject eventObject = null;
			if (LuaDLL.lua_isuserdata(L, 2) != 0)
			{
				eventObject = (EventObject)ToLua.ToObject(L, 2);
				if (eventObject.op == EventOp.Add)
				{
					VideoPlayer.EventHandler value = (VideoPlayer.EventHandler)eventObject.func;
					videoPlayer.seekCompleted += value;
				}
				else if (eventObject.op == EventOp.Sub)
				{
					VideoPlayer.EventHandler value2 = (VideoPlayer.EventHandler)eventObject.func;
					videoPlayer.seekCompleted -= value2;
				}
				return 0;
			}
			return LuaDLL.luaL_throw(L, "The event 'UnityEngine.Video.VideoPlayer.seekCompleted' can only appear on the left hand side of += or -= when used outside of the type 'UnityEngine.Video.VideoPlayer'");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_clockResyncOccurred(IntPtr L)
	{
		try
		{
			VideoPlayer videoPlayer = (VideoPlayer)ToLua.CheckObject(L, 1, typeof(VideoPlayer));
			EventObject eventObject = null;
			if (LuaDLL.lua_isuserdata(L, 2) != 0)
			{
				eventObject = (EventObject)ToLua.ToObject(L, 2);
				if (eventObject.op == EventOp.Add)
				{
					VideoPlayer.TimeEventHandler value = (VideoPlayer.TimeEventHandler)eventObject.func;
					videoPlayer.clockResyncOccurred += value;
				}
				else if (eventObject.op == EventOp.Sub)
				{
					VideoPlayer.TimeEventHandler value2 = (VideoPlayer.TimeEventHandler)eventObject.func;
					videoPlayer.clockResyncOccurred -= value2;
				}
				return 0;
			}
			return LuaDLL.luaL_throw(L, "The event 'UnityEngine.Video.VideoPlayer.clockResyncOccurred' can only appear on the left hand side of += or -= when used outside of the type 'UnityEngine.Video.VideoPlayer'");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_frameReady(IntPtr L)
	{
		try
		{
			VideoPlayer videoPlayer = (VideoPlayer)ToLua.CheckObject(L, 1, typeof(VideoPlayer));
			EventObject eventObject = null;
			if (LuaDLL.lua_isuserdata(L, 2) != 0)
			{
				eventObject = (EventObject)ToLua.ToObject(L, 2);
				if (eventObject.op == EventOp.Add)
				{
					VideoPlayer.FrameReadyEventHandler value = (VideoPlayer.FrameReadyEventHandler)eventObject.func;
					videoPlayer.frameReady += value;
				}
				else if (eventObject.op == EventOp.Sub)
				{
					VideoPlayer.FrameReadyEventHandler value2 = (VideoPlayer.FrameReadyEventHandler)eventObject.func;
					videoPlayer.frameReady -= value2;
				}
				return 0;
			}
			return LuaDLL.luaL_throw(L, "The event 'UnityEngine.Video.VideoPlayer.frameReady' can only appear on the left hand side of += or -= when used outside of the type 'UnityEngine.Video.VideoPlayer'");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UnityEngine_Video_VideoPlayer_FrameReadyEventHandler(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<VideoPlayer.FrameReadyEventHandler>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<VideoPlayer.FrameReadyEventHandler>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UnityEngine_Video_VideoPlayer_TimeEventHandler(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<VideoPlayer.TimeEventHandler>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<VideoPlayer.TimeEventHandler>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UnityEngine_Video_VideoPlayer_EventHandler(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<VideoPlayer.EventHandler>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<VideoPlayer.EventHandler>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UnityEngine_Video_VideoPlayer_ErrorEventHandler(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<VideoPlayer.ErrorEventHandler>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<VideoPlayer.ErrorEventHandler>.Create(func, self);
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
