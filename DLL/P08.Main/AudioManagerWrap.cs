using System;
using LuaInterface;
using UnityEngine;

public class AudioManagerWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(AudioManager), typeof(MonoBehaviour));
		L.RegFunction("UpdateUsedSheetList", UpdateUsedSheetList);
		L.RegFunction("RemoveUsedSheetList", RemoveUsedSheetList);
		L.RegFunction("Create", Create);
		L.RegFunction("SetListener", SetListener);
		L.RegFunction("SetVolume", SetVolume);
		L.RegFunction("GetVolume", GetVolume);
		L.RegFunction("AddCue", AddCue);
		L.RegFunction("RemoveCue", RemoveCue);
		L.RegFunction("HasVoiceFile", HasVoiceFile);
		L.RegFunction("Play", Play);
		L.RegFunction("SetStartTime", SetStartTime);
		L.RegFunction("PlayUIAudio", PlayUIAudio);
		L.RegFunction("Pause", Pause);
		L.RegFunction("PauseAll", PauseAll);
		L.RegFunction("Stop", Stop);
		L.RegFunction("StopImmediate", StopImmediate);
		L.RegFunction("StopAll", StopAll);
		L.RegFunction("IsStopped", IsStopped);
		L.RegFunction("CleanCriAtom", CleanCriAtom);
		L.RegFunction("DestoryCriAtom", DestoryCriAtom);
		L.RegFunction("DestoryPlayer", DestoryPlayer);
		L.RegFunction("CreateCriAtom", CreateCriAtom);
		L.RegFunction("TryGetCueInfo", TryGetCueInfo);
		L.RegFunction("GetCueInfoLength", GetCueInfoLength);
		L.RegFunction("LoadSoundPlayerConfig", LoadSoundPlayerConfig);
		L.RegFunction("GetPlayer", GetPlayer);
		L.RegFunction("SetVolumeOfCategory", SetVolumeOfCategory);
		L.RegFunction("SetAisacControl", SetAisacControl);
		L.RegFunction("ResetParameters", ResetParameters);
		L.RegFunction("SetAisacControlOfCategory", SetAisacControlOfCategory);
		L.RegFunction("SetSelectorLabel", SetSelectorLabel);
		L.RegFunction("ApplyDspBusSnapshot", ApplyDspBusSnapshot);
		L.RegFunction("OnSceneRestart", OnSceneRestart);
		L.RegFunction("SetAudioMasterMute", SetAudioMasterMute);
		L.RegFunction("GetAudioMasterMuteState", GetAudioMasterMuteState);
		L.RegFunction("SetLocalizationFlag", SetLocalizationFlag);
		L.RegFunction("GetLocalizationFlag", GetLocalizationFlag);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("MUSIC_KEY_NAME", get_MUSIC_KEY_NAME, null);
		L.RegVar("VOICE_KEY_NAME", get_VOICE_KEY_NAME, null);
		L.RegVar("EFFECT_KEY_NAME", get_EFFECT_KEY_NAME, null);
		L.RegVar("VICTORY_SELECTOR_NAME", get_VICTORY_SELECTOR_NAME, null);
		L.RegVar("VICTORY_SELECTOR_LAEBL_SINGLE", get_VICTORY_SELECTOR_LAEBL_SINGLE, null);
		L.RegVar("VICTORY_SELECTOR_LAEBL_DOUBLE", get_VICTORY_SELECTOR_LAEBL_DOUBLE, null);
		L.RegVar("VICTORY_SELECTOR_LAEBL_TRIPLE", get_VICTORY_SELECTOR_LAEBL_TRIPLE, null);
		L.RegVar("VICTORY_SELECTOR_LABEL_NONE", get_VICTORY_SELECTOR_LABEL_NONE, null);
		L.RegVar("MUSIC_CATEGORY_NAME", get_MUSIC_CATEGORY_NAME, null);
		L.RegVar("JINGLE_CATEGORY_NAME", get_JINGLE_CATEGORY_NAME, null);
		L.RegVar("VOICE_CATEGORY_NAME", get_VOICE_CATEGORY_NAME, null);
		L.RegVar("EFFECT_CATEGORY_NAME", get_EFFECT_CATEGORY_NAME, null);
		L.RegVar("VOICE_LANGUAGE_KEY", get_VOICE_LANGUAGE_KEY, null);
		L.RegVar("BattleTeammateVoiceSwitch", get_BattleTeammateVoiceSwitch, set_BattleTeammateVoiceSwitch);
		L.RegVar("mInstance", get_mInstance, set_mInstance);
		L.RegVar("mListener", get_mListener, set_mListener);
		L.RegVar("mCriAtom", get_mCriAtom, set_mCriAtom);
		L.RegVar("mAcfFile", get_mAcfFile, set_mAcfFile);
		L.RegVar("Instance", get_Instance, null);
		L.RegVar("MusicVolume", get_MusicVolume, set_MusicVolume);
		L.RegVar("EffectVolume", get_EffectVolume, set_EffectVolume);
		L.RegVar("VoiceVolume", get_VoiceVolume, set_VoiceVolume);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UpdateUsedSheetList(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			AudioManager obj = (AudioManager)ToLua.CheckObject<AudioManager>(L, 1);
			string key = ToLua.CheckString(L, 2);
			string sheetName = ToLua.CheckString(L, 3);
			obj.UpdateUsedSheetList(key, sheetName);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RemoveUsedSheetList(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			AudioManager obj = (AudioManager)ToLua.CheckObject<AudioManager>(L, 1);
			string key = ToLua.CheckString(L, 2);
			obj.RemoveUsedSheetList(key);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Create(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			AudioManager.Create();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetListener(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				AudioManager obj2 = (AudioManager)ToLua.CheckObject<AudioManager>(L, 1);
				GameObject listener2 = (GameObject)ToLua.CheckObject(L, 2, typeof(GameObject));
				obj2.SetListener(listener2);
				return 0;
			}
			case 3:
			{
				AudioManager obj = (AudioManager)ToLua.CheckObject<AudioManager>(L, 1);
				GameObject listener = (GameObject)ToLua.CheckObject(L, 2, typeof(GameObject));
				bool isActive = LuaDLL.luaL_checkboolean(L, 3);
				obj.SetListener(listener, isActive);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: AudioManager.SetListener");
			}
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
			ToLua.CheckArgsCount(L, 3);
			AudioManager obj = (AudioManager)ToLua.CheckObject<AudioManager>(L, 1);
			string key = ToLua.CheckString(L, 2);
			float volume = (float)LuaDLL.luaL_checknumber(L, 3);
			obj.SetVolume(key, volume);
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
			ToLua.CheckArgsCount(L, 2);
			AudioManager obj = (AudioManager)ToLua.CheckObject<AudioManager>(L, 1);
			string key = ToLua.CheckString(L, 2);
			float volume = obj.GetVolume(key);
			LuaDLL.lua_pushnumber(L, volume);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int AddCue(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			AudioManager obj = (AudioManager)ToLua.CheckObject<AudioManager>(L, 1);
			string key = ToLua.CheckString(L, 2);
			string name = ToLua.CheckString(L, 3);
			bool useStream = LuaDLL.luaL_checkboolean(L, 4);
			obj.AddCue(key, name, useStream);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RemoveCue(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			AudioManager obj = (AudioManager)ToLua.CheckObject<AudioManager>(L, 1);
			string name = ToLua.CheckString(L, 2);
			obj.RemoveCue(name);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int HasVoiceFile(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			AudioManager obj = (AudioManager)ToLua.CheckObject<AudioManager>(L, 1);
			string cueSheetName = ToLua.CheckString(L, 2);
			bool value = obj.HasVoiceFile(cueSheetName);
			LuaDLL.lua_pushboolean(L, value);
			return 1;
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
			ToLua.CheckArgsCount(L, 5);
			AudioManager obj = (AudioManager)ToLua.CheckObject<AudioManager>(L, 1);
			string key = ToLua.CheckString(L, 2);
			string cueSheetName = ToLua.CheckString(L, 3);
			string cueName = ToLua.CheckString(L, 4);
			bool useStream = LuaDLL.luaL_checkboolean(L, 5);
			CriAtomExPlayback v = obj.Play(key, cueSheetName, cueName, useStream);
			ToLua.PushValue(L, v);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetStartTime(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			AudioManager obj = (AudioManager)ToLua.CheckObject<AudioManager>(L, 1);
			string key = ToLua.CheckString(L, 2);
			long time = LuaDLL.tolua_checkint64(L, 3);
			obj.SetStartTime(key, time);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int PlayUIAudio(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			AudioManager obj = (AudioManager)ToLua.CheckObject<AudioManager>(L, 1);
			int id = (int)LuaDLL.luaL_checknumber(L, 2);
			obj.PlayUIAudio(id);
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
			ToLua.CheckArgsCount(L, 3);
			AudioManager obj = (AudioManager)ToLua.CheckObject<AudioManager>(L, 1);
			string key = ToLua.CheckString(L, 2);
			bool isPaused = LuaDLL.luaL_checkboolean(L, 3);
			obj.Pause(key, isPaused);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int PauseAll(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			AudioManager obj = (AudioManager)ToLua.CheckObject<AudioManager>(L, 1);
			bool isPaused = LuaDLL.luaL_checkboolean(L, 2);
			obj.PauseAll(isPaused);
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
			AudioManager obj = (AudioManager)ToLua.CheckObject<AudioManager>(L, 1);
			string key = ToLua.CheckString(L, 2);
			obj.Stop(key);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int StopImmediate(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			AudioManager obj = (AudioManager)ToLua.CheckObject<AudioManager>(L, 1);
			string key = ToLua.CheckString(L, 2);
			obj.StopImmediate(key);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int StopAll(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((AudioManager)ToLua.CheckObject<AudioManager>(L, 1)).StopAll();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IsStopped(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			AudioManager obj = (AudioManager)ToLua.CheckObject<AudioManager>(L, 1);
			string key = ToLua.CheckString(L, 2);
			bool value = obj.IsStopped(key);
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CleanCriAtom(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((AudioManager)ToLua.CheckObject<AudioManager>(L, 1)).CleanCriAtom();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int DestoryCriAtom(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((AudioManager)ToLua.CheckObject<AudioManager>(L, 1)).DestoryCriAtom();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int DestoryPlayer(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			AudioManager obj = (AudioManager)ToLua.CheckObject<AudioManager>(L, 1);
			string key = ToLua.CheckString(L, 2);
			obj.DestoryPlayer(key);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CreateCriAtom(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
				((AudioManager)ToLua.CheckObject<AudioManager>(L, 1)).CreateCriAtom();
				return 0;
			case 2:
			{
				AudioManager obj = (AudioManager)ToLua.CheckObject<AudioManager>(L, 1);
				string acf = ToLua.CheckString(L, 2);
				obj.CreateCriAtom(acf);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: AudioManager.CreateCriAtom");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int TryGetCueInfo(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 6);
			AudioManager obj = (AudioManager)ToLua.CheckObject<AudioManager>(L, 1);
			string key = ToLua.CheckString(L, 2);
			string cueSheetName = ToLua.CheckString(L, 3);
			string cueName = ToLua.CheckString(L, 4);
			bool useStream = LuaDLL.luaL_checkboolean(L, 5);
			bool value = obj.TryGetCueInfo(key, cueSheetName, cueName, useStream, out var cueInfo);
			LuaDLL.lua_pushboolean(L, value);
			ToLua.PushValue(L, cueInfo);
			return 2;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetCueInfoLength(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 5);
			AudioManager obj = (AudioManager)ToLua.CheckObject<AudioManager>(L, 1);
			string key = ToLua.CheckString(L, 2);
			string cueSheetName = ToLua.CheckString(L, 3);
			string cueName = ToLua.CheckString(L, 4);
			bool useStream = LuaDLL.luaL_checkboolean(L, 5);
			int cueInfoLength = obj.GetCueInfoLength(key, cueSheetName, cueName, useStream);
			LuaDLL.lua_pushinteger(L, cueInfoLength);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LoadSoundPlayerConfig(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((AudioManager)ToLua.CheckObject<AudioManager>(L, 1)).LoadSoundPlayerConfig();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetPlayer(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			AudioManager obj = (AudioManager)ToLua.CheckObject<AudioManager>(L, 1);
			string key = ToLua.CheckString(L, 2);
			CriAtomSource player = obj.GetPlayer(key);
			ToLua.Push(L, player);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetVolumeOfCategory(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			AudioManager obj = (AudioManager)ToLua.CheckObject<AudioManager>(L, 1);
			string pName = ToLua.CheckString(L, 2);
			float pValue = (float)LuaDLL.luaL_checknumber(L, 3);
			obj.SetVolumeOfCategory(pName, pValue);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetAisacControl(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			AudioManager obj = (AudioManager)ToLua.CheckObject<AudioManager>(L, 1);
			string pKey = ToLua.CheckString(L, 2);
			string pControlName = ToLua.CheckString(L, 3);
			float pValue = (float)LuaDLL.luaL_checknumber(L, 4);
			obj.SetAisacControl(pKey, pControlName, pValue);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ResetParameters(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			AudioManager obj = (AudioManager)ToLua.CheckObject<AudioManager>(L, 1);
			string pKey = ToLua.CheckString(L, 2);
			obj.ResetParameters(pKey);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetAisacControlOfCategory(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			AudioManager obj = (AudioManager)ToLua.CheckObject<AudioManager>(L, 1);
			string pName = ToLua.CheckString(L, 2);
			string pControlName = ToLua.CheckString(L, 3);
			float pValue = (float)LuaDLL.luaL_checknumber(L, 4);
			obj.SetAisacControlOfCategory(pName, pControlName, pValue);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetSelectorLabel(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			AudioManager obj = (AudioManager)ToLua.CheckObject<AudioManager>(L, 1);
			string pKey = ToLua.CheckString(L, 2);
			string pSelector = ToLua.CheckString(L, 3);
			string pLabel = ToLua.CheckString(L, 4);
			obj.SetSelectorLabel(pKey, pSelector, pLabel);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ApplyDspBusSnapshot(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			AudioManager obj = (AudioManager)ToLua.CheckObject<AudioManager>(L, 1);
			string pSnapshotName = ToLua.CheckString(L, 2);
			int pTimeMS = (int)LuaDLL.luaL_checknumber(L, 3);
			obj.ApplyDspBusSnapshot(pSnapshotName, pTimeMS);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OnSceneRestart(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((AudioManager)ToLua.CheckObject<AudioManager>(L, 1)).OnSceneRestart();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetAudioMasterMute(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			AudioManager obj = (AudioManager)ToLua.CheckObject<AudioManager>(L, 1);
			bool audioMasterMute = LuaDLL.luaL_checkboolean(L, 2);
			obj.SetAudioMasterMute(audioMasterMute);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetAudioMasterMuteState(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool audioMasterMuteState = ((AudioManager)ToLua.CheckObject<AudioManager>(L, 1)).GetAudioMasterMuteState();
			LuaDLL.lua_pushboolean(L, audioMasterMuteState);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetLocalizationFlag(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			AudioManager obj = (AudioManager)ToLua.CheckObject<AudioManager>(L, 1);
			string localizationFlag = ToLua.CheckString(L, 2);
			obj.SetLocalizationFlag(localizationFlag);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetLocalizationFlag(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			string localizationFlag = ((AudioManager)ToLua.CheckObject<AudioManager>(L, 1)).GetLocalizationFlag();
			LuaDLL.lua_pushstring(L, localizationFlag);
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
	private static int get_MUSIC_KEY_NAME(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushstring(L, "music");
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_VOICE_KEY_NAME(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushstring(L, "voice");
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_EFFECT_KEY_NAME(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushstring(L, "effect");
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_VICTORY_SELECTOR_NAME(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushstring(L, "Count");
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_VICTORY_SELECTOR_LAEBL_SINGLE(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushstring(L, "single");
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_VICTORY_SELECTOR_LAEBL_DOUBLE(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushstring(L, "double");
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_VICTORY_SELECTOR_LAEBL_TRIPLE(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushstring(L, "triple");
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_VICTORY_SELECTOR_LABEL_NONE(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushstring(L, "nocount");
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_MUSIC_CATEGORY_NAME(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushstring(L, "music");
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_JINGLE_CATEGORY_NAME(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushstring(L, "jingle");
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_VOICE_CATEGORY_NAME(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushstring(L, "vocal");
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_EFFECT_CATEGORY_NAME(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushstring(L, "sfx");
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_VOICE_LANGUAGE_KEY(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushstring(L, "voice_language");
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_BattleTeammateVoiceSwitch(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, AudioManager.BattleTeammateVoiceSwitch);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_mInstance(IntPtr L)
	{
		try
		{
			ToLua.Push(L, AudioManager.mInstance);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_mListener(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CriAtomListener mListener = ((AudioManager)obj).mListener;
			ToLua.Push(L, mListener);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mListener on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_mCriAtom(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CriAtom mCriAtom = ((AudioManager)obj).mCriAtom;
			ToLua.Push(L, mCriAtom);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mCriAtom on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_mAcfFile(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string mAcfFile = ((AudioManager)obj).mAcfFile;
			LuaDLL.lua_pushstring(L, mAcfFile);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mAcfFile on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Instance(IntPtr L)
	{
		try
		{
			ToLua.Push(L, AudioManager.Instance);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_MusicVolume(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float musicVolume = ((AudioManager)obj).MusicVolume;
			LuaDLL.lua_pushnumber(L, musicVolume);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index MusicVolume on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_EffectVolume(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float effectVolume = ((AudioManager)obj).EffectVolume;
			LuaDLL.lua_pushnumber(L, effectVolume);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index EffectVolume on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_VoiceVolume(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float voiceVolume = ((AudioManager)obj).VoiceVolume;
			LuaDLL.lua_pushnumber(L, voiceVolume);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index VoiceVolume on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_BattleTeammateVoiceSwitch(IntPtr L)
	{
		try
		{
			AudioManager.BattleTeammateVoiceSwitch = LuaDLL.luaL_checkboolean(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_mInstance(IntPtr L)
	{
		try
		{
			AudioManager.mInstance = (AudioManager)ToLua.CheckObject<AudioManager>(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_mListener(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			AudioManager obj2 = (AudioManager)obj;
			CriAtomListener mListener = (CriAtomListener)ToLua.CheckObject<CriAtomListener>(L, 2);
			obj2.mListener = mListener;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mListener on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_mCriAtom(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			AudioManager obj2 = (AudioManager)obj;
			CriAtom mCriAtom = (CriAtom)ToLua.CheckObject<CriAtom>(L, 2);
			obj2.mCriAtom = mCriAtom;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mCriAtom on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_mAcfFile(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			AudioManager obj2 = (AudioManager)obj;
			string mAcfFile = ToLua.CheckString(L, 2);
			obj2.mAcfFile = mAcfFile;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mAcfFile on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_MusicVolume(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			AudioManager obj2 = (AudioManager)obj;
			float musicVolume = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.MusicVolume = musicVolume;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index MusicVolume on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_EffectVolume(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			AudioManager obj2 = (AudioManager)obj;
			float effectVolume = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.EffectVolume = effectVolume;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index EffectVolume on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_VoiceVolume(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			AudioManager obj2 = (AudioManager)obj;
			float voiceVolume = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.VoiceVolume = voiceVolume;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index VoiceVolume on a nil value");
		}
	}
}
