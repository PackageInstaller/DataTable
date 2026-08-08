using System;
using CriMana;
using LuaInterface;
using UnityEngine;

public class CriMana_PlayerWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(Player), typeof(CriDisposable));
		L.RegFunction("Dispose", Dispose);
		L.RegFunction("CreateRendererResource", CreateRendererResource);
		L.RegFunction("DisposeRendererResource", DisposeRendererResource);
		L.RegFunction("Prepare", Prepare);
		L.RegFunction("PrepareForRendering", PrepareForRendering);
		L.RegFunction("Start", Start);
		L.RegFunction("Stop", Stop);
		L.RegFunction("StopForSeek", StopForSeek);
		L.RegFunction("Pause", Pause);
		L.RegFunction("IsPaused", IsPaused);
		L.RegFunction("SetFile", SetFile);
		L.RegFunction("SetData", SetData);
		L.RegFunction("SetContentId", SetContentId);
		L.RegFunction("SetFileRange", SetFileRange);
		L.RegFunction("Loop", Loop);
		L.RegFunction("SetMasterTimerType", SetMasterTimerType);
		L.RegFunction("SetSeekPosition", SetSeekPosition);
		L.RegFunction("SetMovieEventSyncMode", SetMovieEventSyncMode);
		L.RegFunction("SetSpeed", SetSpeed);
		L.RegFunction("SetMaxPictureDataSize", SetMaxPictureDataSize);
		L.RegFunction("SetBufferingTime", SetBufferingTime);
		L.RegFunction("SetMinBufferSize", SetMinBufferSize);
		L.RegFunction("SetAudioTrack", SetAudioTrack);
		L.RegFunction("SetSubAudioTrack", SetSubAudioTrack);
		L.RegFunction("SetExtraAudioTrack", SetExtraAudioTrack);
		L.RegFunction("SetVolume", SetVolume);
		L.RegFunction("GetVolume", GetVolume);
		L.RegFunction("SetSubAudioVolume", SetSubAudioVolume);
		L.RegFunction("GetSubAudioVolume", GetSubAudioVolume);
		L.RegFunction("SetExtraAudioVolume", SetExtraAudioVolume);
		L.RegFunction("GetExtraAudioVolume", GetExtraAudioVolume);
		L.RegFunction("SetBusSendLevel", SetBusSendLevel);
		L.RegFunction("SetSubAudioBusSendLevel", SetSubAudioBusSendLevel);
		L.RegFunction("SetExtraAudioBusSendLevel", SetExtraAudioBusSendLevel);
		L.RegFunction("SetSubtitleChannel", SetSubtitleChannel);
		L.RegFunction("SetShaderDispatchCallback", SetShaderDispatchCallback);
		L.RegFunction("GetTime", GetTime);
		L.RegFunction("GetDisplayedFrameNo", GetDisplayedFrameNo);
		L.RegFunction("HasRenderedNewFrame", HasRenderedNewFrame);
		L.RegFunction("SetAsrRackId", SetAsrRackId);
		L.RegFunction("UpdateWithUserTime", UpdateWithUserTime);
		L.RegFunction("SetManualTimerUnit", SetManualTimerUnit);
		L.RegFunction("UpdateWithManualTimeAdvanced", UpdateWithManualTimeAdvanced);
		L.RegFunction("Update", Update);
		L.RegFunction("OnWillRenderObject", OnWillRenderObject);
		L.RegFunction("UpdateMaterial", UpdateMaterial);
		L.RegFunction("IssuePluginEvent", IssuePluginEvent);
		L.RegFunction("New", _CreateCriMana_Player);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("cuePointCallback", get_cuePointCallback, set_cuePointCallback);
		L.RegVar("statusChangeCallback", get_statusChangeCallback, set_statusChangeCallback);
		L.RegVar("additiveMode", get_additiveMode, set_additiveMode);
		L.RegVar("maxFrameDrop", get_maxFrameDrop, set_maxFrameDrop);
		L.RegVar("applyTargetAlpha", get_applyTargetAlpha, set_applyTargetAlpha);
		L.RegVar("uiRenderMode", get_uiRenderMode, set_uiRenderMode);
		L.RegVar("isFrameAvailable", get_isFrameAvailable, null);
		L.RegVar("movieInfo", get_movieInfo, null);
		L.RegVar("frameInfo", get_frameInfo, null);
		L.RegVar("status", get_status, null);
		L.RegVar("nativeStatus", get_nativeStatus, null);
		L.RegVar("numberOfEntries", get_numberOfEntries, null);
		L.RegVar("subtitleBuffer", get_subtitleBuffer, null);
		L.RegVar("subtitleSize", get_subtitleSize, null);
		L.RegVar("atomExPlayer", get_atomExPlayer, null);
		L.RegVar("atomEx3DsourceForAmbisonics", get_atomEx3DsourceForAmbisonics, null);
		L.RegVar("timerType", get_timerType, null);
		L.RegVar("playerHolder", get_playerHolder, set_playerHolder);
		L.RegVar("isAlive", get_isAlive, null);
		L.RegVar("OnSubtitleChanged", get_OnSubtitleChanged, set_OnSubtitleChanged);
		L.RegFunction("ShaderDispatchCallback", CriMana_Player_ShaderDispatchCallback);
		L.RegFunction("StatusChangeCallback", CriMana_Player_StatusChangeCallback);
		L.RegFunction("CuePointCallback", CriMana_Player_CuePointCallback);
		L.RegFunction("SubtitleChangeCallback", CriMana_Player_SubtitleChangeCallback);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateCriMana_Player(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 0:
			{
				Player o2 = new Player();
				ToLua.PushObject(L, o2);
				return 1;
			}
			case 3:
			{
				bool advanced_audio_mode = LuaDLL.luaL_checkboolean(L, 1);
				bool ambisonics_mode = LuaDLL.luaL_checkboolean(L, 2);
				uint max_path_length = (uint)LuaDLL.luaL_checknumber(L, 3);
				Player o = new Player(advanced_audio_mode, ambisonics_mode, max_path_length);
				ToLua.PushObject(L, o);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: CriMana.Player.New");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Dispose(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((Player)ToLua.CheckObject<Player>(L, 1)).Dispose();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CreateRendererResource(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			Player obj = (Player)ToLua.CheckObject<Player>(L, 1);
			int width = (int)LuaDLL.luaL_checknumber(L, 2);
			int height = (int)LuaDLL.luaL_checknumber(L, 3);
			bool alpha = LuaDLL.luaL_checkboolean(L, 4);
			obj.CreateRendererResource(width, height, alpha);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int DisposeRendererResource(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((Player)ToLua.CheckObject<Player>(L, 1)).DisposeRendererResource();
			return 0;
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
			((Player)ToLua.CheckObject<Player>(L, 1)).Prepare();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int PrepareForRendering(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((Player)ToLua.CheckObject<Player>(L, 1)).PrepareForRendering();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Start(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((Player)ToLua.CheckObject<Player>(L, 1)).Start();
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
			((Player)ToLua.CheckObject<Player>(L, 1)).Stop();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int StopForSeek(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((Player)ToLua.CheckObject<Player>(L, 1)).StopForSeek();
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
			ToLua.CheckArgsCount(L, 2);
			Player obj = (Player)ToLua.CheckObject<Player>(L, 1);
			bool sw = LuaDLL.luaL_checkboolean(L, 2);
			obj.Pause(sw);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IsPaused(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = ((Player)ToLua.CheckObject<Player>(L, 1)).IsPaused();
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetFile(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 3:
			{
				Player obj2 = (Player)ToLua.CheckObject<Player>(L, 1);
				CriFsBinder binder2 = (CriFsBinder)ToLua.CheckObject<CriFsBinder>(L, 2);
				string moviePath2 = ToLua.CheckString(L, 3);
				bool value2 = obj2.SetFile(binder2, moviePath2);
				LuaDLL.lua_pushboolean(L, value2);
				return 1;
			}
			case 4:
			{
				Player obj = (Player)ToLua.CheckObject<Player>(L, 1);
				CriFsBinder binder = (CriFsBinder)ToLua.CheckObject<CriFsBinder>(L, 2);
				string moviePath = ToLua.CheckString(L, 3);
				Player.SetMode setMode = (Player.SetMode)ToLua.CheckObject(L, 4, typeof(Player.SetMode));
				bool value = obj.SetFile(binder, moviePath, setMode);
				LuaDLL.lua_pushboolean(L, value);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: CriMana.Player.SetFile");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetData(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 3:
			{
				Player obj2 = (Player)ToLua.CheckObject<Player>(L, 1);
				IntPtr data2 = ToLua.CheckIntPtr(L, 2);
				long dataSize2 = LuaDLL.tolua_checkint64(L, 3);
				bool value2 = obj2.SetData(data2, dataSize2);
				LuaDLL.lua_pushboolean(L, value2);
				return 1;
			}
			case 4:
			{
				Player obj = (Player)ToLua.CheckObject<Player>(L, 1);
				IntPtr data = ToLua.CheckIntPtr(L, 2);
				long dataSize = LuaDLL.tolua_checkint64(L, 3);
				Player.SetMode setMode = (Player.SetMode)ToLua.CheckObject(L, 4, typeof(Player.SetMode));
				bool value = obj.SetData(data, dataSize, setMode);
				LuaDLL.lua_pushboolean(L, value);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: CriMana.Player.SetData");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetContentId(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 3:
			{
				Player obj2 = (Player)ToLua.CheckObject<Player>(L, 1);
				CriFsBinder binder2 = (CriFsBinder)ToLua.CheckObject<CriFsBinder>(L, 2);
				int contentId2 = (int)LuaDLL.luaL_checknumber(L, 3);
				bool value2 = obj2.SetContentId(binder2, contentId2);
				LuaDLL.lua_pushboolean(L, value2);
				return 1;
			}
			case 4:
			{
				Player obj = (Player)ToLua.CheckObject<Player>(L, 1);
				CriFsBinder binder = (CriFsBinder)ToLua.CheckObject<CriFsBinder>(L, 2);
				int contentId = (int)LuaDLL.luaL_checknumber(L, 3);
				Player.SetMode setMode = (Player.SetMode)ToLua.CheckObject(L, 4, typeof(Player.SetMode));
				bool value = obj.SetContentId(binder, contentId, setMode);
				LuaDLL.lua_pushboolean(L, value);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: CriMana.Player.SetContentId");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetFileRange(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 4:
			{
				Player obj2 = (Player)ToLua.CheckObject<Player>(L, 1);
				string filePath2 = ToLua.CheckString(L, 2);
				ulong offset2 = LuaDLL.tolua_checkuint64(L, 3);
				long range2 = LuaDLL.tolua_checkint64(L, 4);
				bool value2 = obj2.SetFileRange(filePath2, offset2, range2);
				LuaDLL.lua_pushboolean(L, value2);
				return 1;
			}
			case 5:
			{
				Player obj = (Player)ToLua.CheckObject<Player>(L, 1);
				string filePath = ToLua.CheckString(L, 2);
				ulong offset = LuaDLL.tolua_checkuint64(L, 3);
				long range = LuaDLL.tolua_checkint64(L, 4);
				Player.SetMode setMode = (Player.SetMode)ToLua.CheckObject(L, 5, typeof(Player.SetMode));
				bool value = obj.SetFileRange(filePath, offset, range, setMode);
				LuaDLL.lua_pushboolean(L, value);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: CriMana.Player.SetFileRange");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Loop(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Player obj = (Player)ToLua.CheckObject<Player>(L, 1);
			bool sw = LuaDLL.luaL_checkboolean(L, 2);
			obj.Loop(sw);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetMasterTimerType(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Player obj = (Player)ToLua.CheckObject<Player>(L, 1);
			Player.TimerType masterTimerType = (Player.TimerType)ToLua.CheckObject(L, 2, typeof(Player.TimerType));
			obj.SetMasterTimerType(masterTimerType);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetSeekPosition(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Player obj = (Player)ToLua.CheckObject<Player>(L, 1);
			int seekPosition = (int)LuaDLL.luaL_checknumber(L, 2);
			obj.SetSeekPosition(seekPosition);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetMovieEventSyncMode(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Player obj = (Player)ToLua.CheckObject<Player>(L, 1);
			Player.MovieEventSyncMode movieEventSyncMode = (Player.MovieEventSyncMode)ToLua.CheckObject(L, 2, typeof(Player.MovieEventSyncMode));
			obj.SetMovieEventSyncMode(movieEventSyncMode);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetSpeed(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Player obj = (Player)ToLua.CheckObject<Player>(L, 1);
			float speed = (float)LuaDLL.luaL_checknumber(L, 2);
			obj.SetSpeed(speed);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetMaxPictureDataSize(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Player obj = (Player)ToLua.CheckObject<Player>(L, 1);
			uint maxPictureDataSize = (uint)LuaDLL.luaL_checknumber(L, 2);
			obj.SetMaxPictureDataSize(maxPictureDataSize);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetBufferingTime(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Player obj = (Player)ToLua.CheckObject<Player>(L, 1);
			float bufferingTime = (float)LuaDLL.luaL_checknumber(L, 2);
			obj.SetBufferingTime(bufferingTime);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetMinBufferSize(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Player obj = (Player)ToLua.CheckObject<Player>(L, 1);
			int minBufferSize = (int)LuaDLL.luaL_checknumber(L, 2);
			obj.SetMinBufferSize(minBufferSize);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetAudioTrack(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 2 && TypeChecker.CheckTypes<int>(L, 2))
			{
				Player obj = (Player)ToLua.CheckObject<Player>(L, 1);
				int audioTrack = (int)LuaDLL.lua_tonumber(L, 2);
				obj.SetAudioTrack(audioTrack);
				return 0;
			}
			if (num == 2 && TypeChecker.CheckTypes<Player.AudioTrack>(L, 2))
			{
				Player obj2 = (Player)ToLua.CheckObject<Player>(L, 1);
				Player.AudioTrack audioTrack2 = (Player.AudioTrack)ToLua.ToObject(L, 2);
				obj2.SetAudioTrack(audioTrack2);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: CriMana.Player.SetAudioTrack");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetSubAudioTrack(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 2 && TypeChecker.CheckTypes<int>(L, 2))
			{
				Player obj = (Player)ToLua.CheckObject<Player>(L, 1);
				int subAudioTrack = (int)LuaDLL.lua_tonumber(L, 2);
				obj.SetSubAudioTrack(subAudioTrack);
				return 0;
			}
			if (num == 2 && TypeChecker.CheckTypes<Player.AudioTrack>(L, 2))
			{
				Player obj2 = (Player)ToLua.CheckObject<Player>(L, 1);
				Player.AudioTrack subAudioTrack2 = (Player.AudioTrack)ToLua.ToObject(L, 2);
				obj2.SetSubAudioTrack(subAudioTrack2);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: CriMana.Player.SetSubAudioTrack");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetExtraAudioTrack(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 2 && TypeChecker.CheckTypes<int>(L, 2))
			{
				Player obj = (Player)ToLua.CheckObject<Player>(L, 1);
				int extraAudioTrack = (int)LuaDLL.lua_tonumber(L, 2);
				obj.SetExtraAudioTrack(extraAudioTrack);
				return 0;
			}
			if (num == 2 && TypeChecker.CheckTypes<Player.AudioTrack>(L, 2))
			{
				Player obj2 = (Player)ToLua.CheckObject<Player>(L, 1);
				Player.AudioTrack extraAudioTrack2 = (Player.AudioTrack)ToLua.ToObject(L, 2);
				obj2.SetExtraAudioTrack(extraAudioTrack2);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: CriMana.Player.SetExtraAudioTrack");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetVolume(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Player obj = (Player)ToLua.CheckObject<Player>(L, 1);
			float volume = (float)LuaDLL.luaL_checknumber(L, 2);
			obj.SetVolume(volume);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetVolume(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			float volume = ((Player)ToLua.CheckObject<Player>(L, 1)).GetVolume();
			LuaDLL.lua_pushnumber(L, volume);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetSubAudioVolume(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Player obj = (Player)ToLua.CheckObject<Player>(L, 1);
			float subAudioVolume = (float)LuaDLL.luaL_checknumber(L, 2);
			obj.SetSubAudioVolume(subAudioVolume);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetSubAudioVolume(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			float subAudioVolume = ((Player)ToLua.CheckObject<Player>(L, 1)).GetSubAudioVolume();
			LuaDLL.lua_pushnumber(L, subAudioVolume);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetExtraAudioVolume(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Player obj = (Player)ToLua.CheckObject<Player>(L, 1);
			float extraAudioVolume = (float)LuaDLL.luaL_checknumber(L, 2);
			obj.SetExtraAudioVolume(extraAudioVolume);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetExtraAudioVolume(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			float extraAudioVolume = ((Player)ToLua.CheckObject<Player>(L, 1)).GetExtraAudioVolume();
			LuaDLL.lua_pushnumber(L, extraAudioVolume);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetBusSendLevel(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			Player obj = (Player)ToLua.CheckObject<Player>(L, 1);
			string bus_name = ToLua.CheckString(L, 2);
			float level = (float)LuaDLL.luaL_checknumber(L, 3);
			obj.SetBusSendLevel(bus_name, level);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetSubAudioBusSendLevel(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			Player obj = (Player)ToLua.CheckObject<Player>(L, 1);
			string bus_name = ToLua.CheckString(L, 2);
			float volume = (float)LuaDLL.luaL_checknumber(L, 3);
			obj.SetSubAudioBusSendLevel(bus_name, volume);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetExtraAudioBusSendLevel(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			Player obj = (Player)ToLua.CheckObject<Player>(L, 1);
			string bus_name = ToLua.CheckString(L, 2);
			float volume = (float)LuaDLL.luaL_checknumber(L, 3);
			obj.SetExtraAudioBusSendLevel(bus_name, volume);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetSubtitleChannel(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Player obj = (Player)ToLua.CheckObject<Player>(L, 1);
			int subtitleChannel = (int)LuaDLL.luaL_checknumber(L, 2);
			obj.SetSubtitleChannel(subtitleChannel);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetShaderDispatchCallback(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Player obj = (Player)ToLua.CheckObject<Player>(L, 1);
			Player.ShaderDispatchCallback shaderDispatchCallback = (Player.ShaderDispatchCallback)ToLua.CheckDelegate<Player.ShaderDispatchCallback>(L, 2);
			obj.SetShaderDispatchCallback(shaderDispatchCallback);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetTime(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			long time = ((Player)ToLua.CheckObject<Player>(L, 1)).GetTime();
			LuaDLL.tolua_pushint64(L, time);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetDisplayedFrameNo(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			int displayedFrameNo = ((Player)ToLua.CheckObject<Player>(L, 1)).GetDisplayedFrameNo();
			LuaDLL.lua_pushinteger(L, displayedFrameNo);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int HasRenderedNewFrame(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = ((Player)ToLua.CheckObject<Player>(L, 1)).HasRenderedNewFrame();
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetAsrRackId(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Player obj = (Player)ToLua.CheckObject<Player>(L, 1);
			int asrRackId = (int)LuaDLL.luaL_checknumber(L, 2);
			obj.SetAsrRackId(asrRackId);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UpdateWithUserTime(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			Player obj = (Player)ToLua.CheckObject<Player>(L, 1);
			ulong timeCount = LuaDLL.tolua_checkuint64(L, 2);
			ulong timeUnit = LuaDLL.tolua_checkuint64(L, 3);
			obj.UpdateWithUserTime(timeCount, timeUnit);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetManualTimerUnit(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			Player obj = (Player)ToLua.CheckObject<Player>(L, 1);
			ulong timeUnitN = LuaDLL.tolua_checkuint64(L, 2);
			ulong timeUnitD = LuaDLL.tolua_checkuint64(L, 3);
			obj.SetManualTimerUnit(timeUnitN, timeUnitD);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UpdateWithManualTimeAdvanced(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((Player)ToLua.CheckObject<Player>(L, 1)).UpdateWithManualTimeAdvanced();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Update(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((Player)ToLua.CheckObject<Player>(L, 1)).Update();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OnWillRenderObject(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Player obj = (Player)ToLua.CheckObject<Player>(L, 1);
			CriManaMovieMaterial sender = (CriManaMovieMaterial)ToLua.CheckObject<CriManaMovieMaterial>(L, 2);
			obj.OnWillRenderObject(sender);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UpdateMaterial(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Player obj = (Player)ToLua.CheckObject<Player>(L, 1);
			Material material = (Material)ToLua.CheckObject<Material>(L, 2);
			bool value = obj.UpdateMaterial(material);
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IssuePluginEvent(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Player obj = (Player)ToLua.CheckObject<Player>(L, 1);
			Player.CriManaUnityPlayer_RenderEventAction renderEventAction = (Player.CriManaUnityPlayer_RenderEventAction)ToLua.CheckObject(L, 2, typeof(Player.CriManaUnityPlayer_RenderEventAction));
			obj.IssuePluginEvent(renderEventAction);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_cuePointCallback(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Player.CuePointCallback cuePointCallback = ((Player)obj).cuePointCallback;
			ToLua.Push(L, cuePointCallback);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index cuePointCallback on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_statusChangeCallback(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Player.StatusChangeCallback statusChangeCallback = ((Player)obj).statusChangeCallback;
			ToLua.Push(L, statusChangeCallback);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index statusChangeCallback on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_additiveMode(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool additiveMode = ((Player)obj).additiveMode;
			LuaDLL.lua_pushboolean(L, additiveMode);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index additiveMode on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_maxFrameDrop(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int maxFrameDrop = ((Player)obj).maxFrameDrop;
			LuaDLL.lua_pushinteger(L, maxFrameDrop);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index maxFrameDrop on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_applyTargetAlpha(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool applyTargetAlpha = ((Player)obj).applyTargetAlpha;
			LuaDLL.lua_pushboolean(L, applyTargetAlpha);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index applyTargetAlpha on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_uiRenderMode(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool uiRenderMode = ((Player)obj).uiRenderMode;
			LuaDLL.lua_pushboolean(L, uiRenderMode);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index uiRenderMode on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isFrameAvailable(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isFrameAvailable = ((Player)obj).isFrameAvailable;
			LuaDLL.lua_pushboolean(L, isFrameAvailable);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isFrameAvailable on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_movieInfo(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			MovieInfo movieInfo = ((Player)obj).movieInfo;
			ToLua.PushObject(L, movieInfo);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index movieInfo on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_frameInfo(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			FrameInfo frameInfo = ((Player)obj).frameInfo;
			ToLua.PushObject(L, frameInfo);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index frameInfo on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_status(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Player.Status status = ((Player)obj).status;
			ToLua.Push(L, status);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index status on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_nativeStatus(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Player.Status nativeStatus = ((Player)obj).nativeStatus;
			ToLua.Push(L, nativeStatus);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index nativeStatus on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_numberOfEntries(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int numberOfEntries = ((Player)obj).numberOfEntries;
			LuaDLL.lua_pushinteger(L, numberOfEntries);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index numberOfEntries on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_subtitleBuffer(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			IntPtr subtitleBuffer = ((Player)obj).subtitleBuffer;
			LuaDLL.lua_pushlightuserdata(L, subtitleBuffer);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index subtitleBuffer on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_subtitleSize(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int subtitleSize = ((Player)obj).subtitleSize;
			LuaDLL.lua_pushinteger(L, subtitleSize);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index subtitleSize on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_atomExPlayer(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CriAtomExPlayer atomExPlayer = ((Player)obj).atomExPlayer;
			ToLua.PushObject(L, atomExPlayer);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index atomExPlayer on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_atomEx3DsourceForAmbisonics(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CriAtomEx3dSource atomEx3DsourceForAmbisonics = ((Player)obj).atomEx3DsourceForAmbisonics;
			ToLua.PushObject(L, atomEx3DsourceForAmbisonics);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index atomEx3DsourceForAmbisonics on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_timerType(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Player.TimerType timerType = ((Player)obj).timerType;
			ToLua.Push(L, timerType);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index timerType on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_playerHolder(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CriManaMoviePlayerHolder playerHolder = ((Player)obj).playerHolder;
			ToLua.Push(L, playerHolder);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index playerHolder on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isAlive(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isAlive = ((Player)obj).isAlive;
			LuaDLL.lua_pushboolean(L, isAlive);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isAlive on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_OnSubtitleChanged(IntPtr L)
	{
		ToLua.Push(L, new EventObject(typeof(Player.SubtitleChangeCallback)));
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_cuePointCallback(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Player obj2 = (Player)obj;
			Player.CuePointCallback cuePointCallback = (Player.CuePointCallback)ToLua.CheckDelegate<Player.CuePointCallback>(L, 2);
			obj2.cuePointCallback = cuePointCallback;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index cuePointCallback on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_statusChangeCallback(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Player obj2 = (Player)obj;
			Player.StatusChangeCallback statusChangeCallback = (Player.StatusChangeCallback)ToLua.CheckDelegate<Player.StatusChangeCallback>(L, 2);
			obj2.statusChangeCallback = statusChangeCallback;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index statusChangeCallback on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_additiveMode(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Player obj2 = (Player)obj;
			bool additiveMode = LuaDLL.luaL_checkboolean(L, 2);
			obj2.additiveMode = additiveMode;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index additiveMode on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_maxFrameDrop(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Player obj2 = (Player)obj;
			int maxFrameDrop = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.maxFrameDrop = maxFrameDrop;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index maxFrameDrop on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_applyTargetAlpha(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Player obj2 = (Player)obj;
			bool applyTargetAlpha = LuaDLL.luaL_checkboolean(L, 2);
			obj2.applyTargetAlpha = applyTargetAlpha;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index applyTargetAlpha on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_uiRenderMode(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Player obj2 = (Player)obj;
			bool uiRenderMode = LuaDLL.luaL_checkboolean(L, 2);
			obj2.uiRenderMode = uiRenderMode;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index uiRenderMode on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_playerHolder(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Player obj2 = (Player)obj;
			CriManaMoviePlayerHolder playerHolder = (CriManaMoviePlayerHolder)ToLua.CheckObject<CriManaMoviePlayerHolder>(L, 2);
			obj2.playerHolder = playerHolder;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index playerHolder on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_OnSubtitleChanged(IntPtr L)
	{
		try
		{
			Player player = (Player)ToLua.CheckObject(L, 1, typeof(Player));
			EventObject eventObject = null;
			if (LuaDLL.lua_isuserdata(L, 2) != 0)
			{
				eventObject = (EventObject)ToLua.ToObject(L, 2);
				if (eventObject.op == EventOp.Add)
				{
					Player.SubtitleChangeCallback value = (Player.SubtitleChangeCallback)eventObject.func;
					player.OnSubtitleChanged += value;
				}
				else if (eventObject.op == EventOp.Sub)
				{
					Player.SubtitleChangeCallback value2 = (Player.SubtitleChangeCallback)eventObject.func;
					player.OnSubtitleChanged -= value2;
				}
				return 0;
			}
			return LuaDLL.luaL_throw(L, "The event 'CriMana.Player.OnSubtitleChanged' can only appear on the left hand side of += or -= when used outside of the type 'CriMana.Player'");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CriMana_Player_ShaderDispatchCallback(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<Player.ShaderDispatchCallback>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<Player.ShaderDispatchCallback>.Create(func, self);
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
	private static int CriMana_Player_StatusChangeCallback(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<Player.StatusChangeCallback>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<Player.StatusChangeCallback>.Create(func, self);
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
	private static int CriMana_Player_CuePointCallback(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<Player.CuePointCallback>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<Player.CuePointCallback>.Create(func, self);
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
	private static int CriMana_Player_SubtitleChangeCallback(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<Player.SubtitleChangeCallback>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<Player.SubtitleChangeCallback>.Create(func, self);
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
