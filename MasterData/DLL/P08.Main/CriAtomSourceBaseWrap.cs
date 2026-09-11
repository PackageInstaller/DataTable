using System;
using LuaInterface;
using UnityEngine;

public class CriAtomSourceBaseWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(CriAtomSourceBase), typeof(CriMonoBehaviour));
		L.RegFunction("CriInternalUpdate", CriInternalUpdate);
		L.RegFunction("CriInternalLateUpdate", CriInternalLateUpdate);
		L.RegFunction("Play", Play);
		L.RegFunction("Stop", Stop);
		L.RegFunction("Pause", Pause);
		L.RegFunction("IsPaused", IsPaused);
		L.RegFunction("SetBusSendLevel", SetBusSendLevel);
		L.RegFunction("SetBusSendLevelOffset", SetBusSendLevelOffset);
		L.RegFunction("SetAisacControl", SetAisacControl);
		L.RegFunction("AttachToAnalyzer", AttachToAnalyzer);
		L.RegFunction("DetachFromAnalyzer", DetachFromAnalyzer);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("player", get_player, null);
		L.RegVar("source", get_source, null);
		L.RegVar("playOnStart", get_playOnStart, set_playOnStart);
		L.RegVar("use3dPositioning", get_use3dPositioning, set_use3dPositioning);
		L.RegVar("freezeOrientation", get_freezeOrientation, set_freezeOrientation);
		L.RegVar("use3dRandomization", get_use3dRandomization, set_use3dRandomization);
		L.RegVar("randomPositionListMaxLength", get_randomPositionListMaxLength, set_randomPositionListMaxLength);
		L.RegVar("region3d", get_region3d, set_region3d);
		L.RegVar("listener", get_listener, set_listener);
		L.RegVar("regionOnStart", get_regionOnStart, set_regionOnStart);
		L.RegVar("listenerOnStart", get_listenerOnStart, set_listenerOnStart);
		L.RegVar("loop", get_loop, set_loop);
		L.RegVar("volume", get_volume, set_volume);
		L.RegVar("pitch", get_pitch, set_pitch);
		L.RegVar("pan3dAngle", get_pan3dAngle, set_pan3dAngle);
		L.RegVar("pan3dDistance", get_pan3dDistance, set_pan3dDistance);
		L.RegVar("startTime", get_startTime, set_startTime);
		L.RegVar("time", get_time, null);
		L.RegVar("status", get_status, null);
		L.RegVar("attenuationDistanceSetting", get_attenuationDistanceSetting, set_attenuationDistanceSetting);
		L.RegVar("androidUseLowLatencyVoicePool", get_androidUseLowLatencyVoicePool, set_androidUseLowLatencyVoicePool);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CriInternalUpdate(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((CriAtomSourceBase)ToLua.CheckObject<CriAtomSourceBase>(L, 1)).CriInternalUpdate();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CriInternalLateUpdate(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((CriAtomSourceBase)ToLua.CheckObject<CriAtomSourceBase>(L, 1)).CriInternalLateUpdate();
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
			case 1:
			{
				CriAtomExPlayback v2 = ((CriAtomSourceBase)ToLua.CheckObject<CriAtomSourceBase>(L, 1)).Play();
				ToLua.PushValue(L, v2);
				return 1;
			}
			case 2:
				if (TypeChecker.CheckTypes<string>(L, 2))
				{
					CriAtomSourceBase obj = (CriAtomSourceBase)ToLua.CheckObject<CriAtomSourceBase>(L, 1);
					string cueName = ToLua.ToString(L, 2);
					CriAtomExPlayback v = obj.Play(cueName);
					ToLua.PushValue(L, v);
					return 1;
				}
				break;
			}
			if (num == 2 && TypeChecker.CheckTypes<int>(L, 2))
			{
				CriAtomSourceBase obj2 = (CriAtomSourceBase)ToLua.CheckObject<CriAtomSourceBase>(L, 1);
				int cueId = (int)LuaDLL.lua_tonumber(L, 2);
				CriAtomExPlayback v3 = obj2.Play(cueId);
				ToLua.PushValue(L, v3);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: CriAtomSourceBase.Play");
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
			((CriAtomSourceBase)ToLua.CheckObject<CriAtomSourceBase>(L, 1)).Stop();
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
			CriAtomSourceBase obj = (CriAtomSourceBase)ToLua.CheckObject<CriAtomSourceBase>(L, 1);
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
			bool value = ((CriAtomSourceBase)ToLua.CheckObject<CriAtomSourceBase>(L, 1)).IsPaused();
			LuaDLL.lua_pushboolean(L, value);
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
			CriAtomSourceBase obj = (CriAtomSourceBase)ToLua.CheckObject<CriAtomSourceBase>(L, 1);
			string busName = ToLua.CheckString(L, 2);
			float level = (float)LuaDLL.luaL_checknumber(L, 3);
			obj.SetBusSendLevel(busName, level);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetBusSendLevelOffset(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			CriAtomSourceBase obj = (CriAtomSourceBase)ToLua.CheckObject<CriAtomSourceBase>(L, 1);
			string busName = ToLua.CheckString(L, 2);
			float levelOffset = (float)LuaDLL.luaL_checknumber(L, 3);
			obj.SetBusSendLevelOffset(busName, levelOffset);
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
			int num = LuaDLL.lua_gettop(L);
			if (num == 3 && TypeChecker.CheckTypes<string, float>(L, 2))
			{
				CriAtomSourceBase obj = (CriAtomSourceBase)ToLua.CheckObject<CriAtomSourceBase>(L, 1);
				string controlName = ToLua.ToString(L, 2);
				float value = (float)LuaDLL.lua_tonumber(L, 3);
				obj.SetAisacControl(controlName, value);
				return 0;
			}
			if (num == 3 && TypeChecker.CheckTypes<uint, float>(L, 2))
			{
				CriAtomSourceBase obj2 = (CriAtomSourceBase)ToLua.CheckObject<CriAtomSourceBase>(L, 1);
				uint controlId = (uint)LuaDLL.lua_tonumber(L, 2);
				float value2 = (float)LuaDLL.lua_tonumber(L, 3);
				obj2.SetAisacControl(controlId, value2);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: CriAtomSourceBase.SetAisacControl");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int AttachToAnalyzer(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			CriAtomSourceBase obj = (CriAtomSourceBase)ToLua.CheckObject<CriAtomSourceBase>(L, 1);
			CriAtomExOutputAnalyzer analyzer = (CriAtomExOutputAnalyzer)ToLua.CheckObject<CriAtomExOutputAnalyzer>(L, 2);
			obj.AttachToAnalyzer(analyzer);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int DetachFromAnalyzer(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			CriAtomSourceBase obj = (CriAtomSourceBase)ToLua.CheckObject<CriAtomSourceBase>(L, 1);
			CriAtomExOutputAnalyzer analyzer = (CriAtomExOutputAnalyzer)ToLua.CheckObject<CriAtomExOutputAnalyzer>(L, 2);
			obj.DetachFromAnalyzer(analyzer);
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
	private static int get_player(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CriAtomExPlayer player = ((CriAtomSourceBase)obj).player;
			ToLua.PushObject(L, player);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index player on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_source(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CriAtomEx3dSource source = ((CriAtomSourceBase)obj).source;
			ToLua.PushObject(L, source);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index source on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_playOnStart(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool playOnStart = ((CriAtomSourceBase)obj).playOnStart;
			LuaDLL.lua_pushboolean(L, playOnStart);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index playOnStart on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_use3dPositioning(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool use3dPositioning = ((CriAtomSourceBase)obj).use3dPositioning;
			LuaDLL.lua_pushboolean(L, use3dPositioning);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index use3dPositioning on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_freezeOrientation(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool freezeOrientation = ((CriAtomSourceBase)obj).freezeOrientation;
			LuaDLL.lua_pushboolean(L, freezeOrientation);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index freezeOrientation on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_use3dRandomization(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool use3dRandomization = ((CriAtomSourceBase)obj).use3dRandomization;
			LuaDLL.lua_pushboolean(L, use3dRandomization);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index use3dRandomization on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_randomPositionListMaxLength(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			uint randomPositionListMaxLength = ((CriAtomSourceBase)obj).randomPositionListMaxLength;
			LuaDLL.lua_pushnumber(L, randomPositionListMaxLength);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index randomPositionListMaxLength on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_region3d(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CriAtomRegion region3d = ((CriAtomSourceBase)obj).region3d;
			ToLua.Push(L, region3d);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index region3d on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_listener(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CriAtomListener listener = ((CriAtomSourceBase)obj).listener;
			ToLua.Push(L, listener);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index listener on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_regionOnStart(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CriAtomRegion regionOnStart = ((CriAtomSourceBase)obj).regionOnStart;
			ToLua.Push(L, regionOnStart);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index regionOnStart on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_listenerOnStart(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CriAtomListener listenerOnStart = ((CriAtomSourceBase)obj).listenerOnStart;
			ToLua.Push(L, listenerOnStart);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index listenerOnStart on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_loop(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool loop = ((CriAtomSourceBase)obj).loop;
			LuaDLL.lua_pushboolean(L, loop);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index loop on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_volume(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float volume = ((CriAtomSourceBase)obj).volume;
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
			float pitch = ((CriAtomSourceBase)obj).pitch;
			LuaDLL.lua_pushnumber(L, pitch);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index pitch on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_pan3dAngle(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float pan3dAngle = ((CriAtomSourceBase)obj).pan3dAngle;
			LuaDLL.lua_pushnumber(L, pan3dAngle);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index pan3dAngle on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_pan3dDistance(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float pan3dDistance = ((CriAtomSourceBase)obj).pan3dDistance;
			LuaDLL.lua_pushnumber(L, pan3dDistance);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index pan3dDistance on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_startTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int startTime = ((CriAtomSourceBase)obj).startTime;
			LuaDLL.lua_pushinteger(L, startTime);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index startTime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_time(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			long time = ((CriAtomSourceBase)obj).time;
			LuaDLL.tolua_pushint64(L, time);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index time on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_status(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CriAtomSourceBase.Status status = ((CriAtomSourceBase)obj).status;
			ToLua.Push(L, status);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index status on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_attenuationDistanceSetting(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool attenuationDistanceSetting = ((CriAtomSourceBase)obj).attenuationDistanceSetting;
			LuaDLL.lua_pushboolean(L, attenuationDistanceSetting);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index attenuationDistanceSetting on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_androidUseLowLatencyVoicePool(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool androidUseLowLatencyVoicePool = ((CriAtomSourceBase)obj).androidUseLowLatencyVoicePool;
			LuaDLL.lua_pushboolean(L, androidUseLowLatencyVoicePool);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index androidUseLowLatencyVoicePool on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_playOnStart(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CriAtomSourceBase obj2 = (CriAtomSourceBase)obj;
			bool playOnStart = LuaDLL.luaL_checkboolean(L, 2);
			obj2.playOnStart = playOnStart;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index playOnStart on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_use3dPositioning(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CriAtomSourceBase obj2 = (CriAtomSourceBase)obj;
			bool use3dPositioning = LuaDLL.luaL_checkboolean(L, 2);
			obj2.use3dPositioning = use3dPositioning;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index use3dPositioning on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_freezeOrientation(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CriAtomSourceBase obj2 = (CriAtomSourceBase)obj;
			bool freezeOrientation = LuaDLL.luaL_checkboolean(L, 2);
			obj2.freezeOrientation = freezeOrientation;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index freezeOrientation on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_use3dRandomization(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CriAtomSourceBase obj2 = (CriAtomSourceBase)obj;
			bool use3dRandomization = LuaDLL.luaL_checkboolean(L, 2);
			obj2.use3dRandomization = use3dRandomization;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index use3dRandomization on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_randomPositionListMaxLength(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CriAtomSourceBase obj2 = (CriAtomSourceBase)obj;
			uint randomPositionListMaxLength = (uint)LuaDLL.luaL_checknumber(L, 2);
			obj2.randomPositionListMaxLength = randomPositionListMaxLength;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index randomPositionListMaxLength on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_region3d(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CriAtomSourceBase obj2 = (CriAtomSourceBase)obj;
			CriAtomRegion region3d = (CriAtomRegion)ToLua.CheckObject<CriAtomRegion>(L, 2);
			obj2.region3d = region3d;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index region3d on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_listener(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CriAtomSourceBase obj2 = (CriAtomSourceBase)obj;
			CriAtomListener listener = (CriAtomListener)ToLua.CheckObject<CriAtomListener>(L, 2);
			obj2.listener = listener;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index listener on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_regionOnStart(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CriAtomSourceBase obj2 = (CriAtomSourceBase)obj;
			CriAtomRegion regionOnStart = (CriAtomRegion)ToLua.CheckObject<CriAtomRegion>(L, 2);
			obj2.regionOnStart = regionOnStart;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index regionOnStart on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_listenerOnStart(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CriAtomSourceBase obj2 = (CriAtomSourceBase)obj;
			CriAtomListener listenerOnStart = (CriAtomListener)ToLua.CheckObject<CriAtomListener>(L, 2);
			obj2.listenerOnStart = listenerOnStart;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index listenerOnStart on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_loop(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CriAtomSourceBase obj2 = (CriAtomSourceBase)obj;
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
	private static int set_volume(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CriAtomSourceBase obj2 = (CriAtomSourceBase)obj;
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
			CriAtomSourceBase obj2 = (CriAtomSourceBase)obj;
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
	private static int set_pan3dAngle(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CriAtomSourceBase obj2 = (CriAtomSourceBase)obj;
			float pan3dAngle = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.pan3dAngle = pan3dAngle;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index pan3dAngle on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_pan3dDistance(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CriAtomSourceBase obj2 = (CriAtomSourceBase)obj;
			float pan3dDistance = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.pan3dDistance = pan3dDistance;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index pan3dDistance on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_startTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CriAtomSourceBase obj2 = (CriAtomSourceBase)obj;
			int startTime = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.startTime = startTime;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index startTime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_attenuationDistanceSetting(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CriAtomSourceBase obj2 = (CriAtomSourceBase)obj;
			bool attenuationDistanceSetting = LuaDLL.luaL_checkboolean(L, 2);
			obj2.attenuationDistanceSetting = attenuationDistanceSetting;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index attenuationDistanceSetting on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_androidUseLowLatencyVoicePool(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CriAtomSourceBase obj2 = (CriAtomSourceBase)obj;
			bool androidUseLowLatencyVoicePool = LuaDLL.luaL_checkboolean(L, 2);
			obj2.androidUseLowLatencyVoicePool = androidUseLowLatencyVoicePool;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index androidUseLowLatencyVoicePool on a nil value");
		}
	}
}
