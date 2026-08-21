using System;
using LuaInterface;

public class CriAtomExPlaybackWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(CriAtomExPlayback), null);
		L.RegFunction("Stop", Stop);
		L.RegFunction("Pause", Pause);
		L.RegFunction("Resume", Resume);
		L.RegFunction("IsPaused", IsPaused);
		L.RegFunction("GetFormatInfo", GetFormatInfo);
		L.RegFunction("GetStatus", GetStatus);
		L.RegFunction("GetTime", GetTime);
		L.RegFunction("GetTimeSyncedWithAudio", GetTimeSyncedWithAudio);
		L.RegFunction("GetNumPlayedSamples", GetNumPlayedSamples);
		L.RegFunction("GetSequencePosition", GetSequencePosition);
		L.RegFunction("GetCurrentBlockIndex", GetCurrentBlockIndex);
		L.RegFunction("GetTrackInfo", GetTrackInfo);
		L.RegFunction("GetBeatSyncInfo", GetBeatSyncInfo);
		L.RegFunction("SetNextBlockIndex", SetNextBlockIndex);
		L.RegFunction("StopWithoutReleaseTime", StopWithoutReleaseTime);
		L.RegFunction("New", _CreateCriAtomExPlayback);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegConstant("invalidId", 4294967295.0);
		L.RegVar("id", get_id, null);
		L.RegVar("status", get_status, null);
		L.RegVar("time", get_time, null);
		L.RegVar("timeSyncedWithAudio", get_timeSyncedWithAudio, null);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateCriAtomExPlayback(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
			{
				uint id = (uint)LuaDLL.luaL_checknumber(L, 1);
				CriAtomExPlayback v = new CriAtomExPlayback(id);
				ToLua.PushValue(L, v);
				return 1;
			}
			case 0:
				ToLua.PushValue(L, default(CriAtomExPlayback));
				return 1;
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: CriAtomExPlayback.New");
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
			{
				CriAtomExPlayback criAtomExPlayback2 = (CriAtomExPlayback)ToLua.CheckObject(L, 1, typeof(CriAtomExPlayback));
				criAtomExPlayback2.Stop();
				ToLua.SetBack(L, 1, criAtomExPlayback2);
				return 0;
			}
			case 2:
			{
				CriAtomExPlayback criAtomExPlayback = (CriAtomExPlayback)ToLua.CheckObject(L, 1, typeof(CriAtomExPlayback));
				bool ignoresReleaseTime = LuaDLL.luaL_checkboolean(L, 2);
				criAtomExPlayback.Stop(ignoresReleaseTime);
				ToLua.SetBack(L, 1, criAtomExPlayback);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: CriAtomExPlayback.Stop");
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
			{
				CriAtomExPlayback criAtomExPlayback2 = (CriAtomExPlayback)ToLua.CheckObject(L, 1, typeof(CriAtomExPlayback));
				criAtomExPlayback2.Pause();
				ToLua.SetBack(L, 1, criAtomExPlayback2);
				return 0;
			}
			case 2:
			{
				CriAtomExPlayback criAtomExPlayback = (CriAtomExPlayback)ToLua.CheckObject(L, 1, typeof(CriAtomExPlayback));
				bool sw = LuaDLL.luaL_checkboolean(L, 2);
				criAtomExPlayback.Pause(sw);
				ToLua.SetBack(L, 1, criAtomExPlayback);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: CriAtomExPlayback.Pause");
			}
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
			ToLua.CheckArgsCount(L, 2);
			CriAtomExPlayback criAtomExPlayback = (CriAtomExPlayback)ToLua.CheckObject(L, 1, typeof(CriAtomExPlayback));
			CriAtomEx.ResumeMode mode = (CriAtomEx.ResumeMode)ToLua.CheckObject(L, 2, typeof(CriAtomEx.ResumeMode));
			criAtomExPlayback.Resume(mode);
			ToLua.SetBack(L, 1, criAtomExPlayback);
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
			CriAtomExPlayback criAtomExPlayback = (CriAtomExPlayback)ToLua.CheckObject(L, 1, typeof(CriAtomExPlayback));
			bool value = criAtomExPlayback.IsPaused();
			LuaDLL.lua_pushboolean(L, value);
			ToLua.SetBack(L, 1, criAtomExPlayback);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetFormatInfo(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			CriAtomExPlayback criAtomExPlayback = (CriAtomExPlayback)ToLua.CheckObject(L, 1, typeof(CriAtomExPlayback));
			bool formatInfo = criAtomExPlayback.GetFormatInfo(out var info);
			LuaDLL.lua_pushboolean(L, formatInfo);
			ToLua.PushValue(L, info);
			ToLua.SetBack(L, 1, criAtomExPlayback);
			return 2;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetStatus(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			CriAtomExPlayback criAtomExPlayback = (CriAtomExPlayback)ToLua.CheckObject(L, 1, typeof(CriAtomExPlayback));
			CriAtomExPlayback.Status status = criAtomExPlayback.GetStatus();
			ToLua.Push(L, status);
			ToLua.SetBack(L, 1, criAtomExPlayback);
			return 1;
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
			CriAtomExPlayback criAtomExPlayback = (CriAtomExPlayback)ToLua.CheckObject(L, 1, typeof(CriAtomExPlayback));
			long time = criAtomExPlayback.GetTime();
			LuaDLL.tolua_pushint64(L, time);
			ToLua.SetBack(L, 1, criAtomExPlayback);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetTimeSyncedWithAudio(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			CriAtomExPlayback criAtomExPlayback = (CriAtomExPlayback)ToLua.CheckObject(L, 1, typeof(CriAtomExPlayback));
			long timeSyncedWithAudio = criAtomExPlayback.GetTimeSyncedWithAudio();
			LuaDLL.tolua_pushint64(L, timeSyncedWithAudio);
			ToLua.SetBack(L, 1, criAtomExPlayback);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetNumPlayedSamples(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			CriAtomExPlayback criAtomExPlayback = (CriAtomExPlayback)ToLua.CheckObject(L, 1, typeof(CriAtomExPlayback));
			bool numPlayedSamples = criAtomExPlayback.GetNumPlayedSamples(out var numSamples, out var samplingRate);
			LuaDLL.lua_pushboolean(L, numPlayedSamples);
			LuaDLL.tolua_pushint64(L, numSamples);
			LuaDLL.lua_pushinteger(L, samplingRate);
			ToLua.SetBack(L, 1, criAtomExPlayback);
			return 3;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetSequencePosition(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			CriAtomExPlayback criAtomExPlayback = (CriAtomExPlayback)ToLua.CheckObject(L, 1, typeof(CriAtomExPlayback));
			long sequencePosition = criAtomExPlayback.GetSequencePosition();
			LuaDLL.tolua_pushint64(L, sequencePosition);
			ToLua.SetBack(L, 1, criAtomExPlayback);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetCurrentBlockIndex(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			CriAtomExPlayback criAtomExPlayback = (CriAtomExPlayback)ToLua.CheckObject(L, 1, typeof(CriAtomExPlayback));
			int currentBlockIndex = criAtomExPlayback.GetCurrentBlockIndex();
			LuaDLL.lua_pushinteger(L, currentBlockIndex);
			ToLua.SetBack(L, 1, criAtomExPlayback);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetTrackInfo(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			CriAtomExPlayback criAtomExPlayback = (CriAtomExPlayback)ToLua.CheckObject(L, 1, typeof(CriAtomExPlayback));
			bool trackInfo = criAtomExPlayback.GetTrackInfo(out var info);
			LuaDLL.lua_pushboolean(L, trackInfo);
			ToLua.PushValue(L, info);
			ToLua.SetBack(L, 1, criAtomExPlayback);
			return 2;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetBeatSyncInfo(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			CriAtomExPlayback criAtomExPlayback = (CriAtomExPlayback)ToLua.CheckObject(L, 1, typeof(CriAtomExPlayback));
			bool beatSyncInfo = criAtomExPlayback.GetBeatSyncInfo(out var info);
			LuaDLL.lua_pushboolean(L, beatSyncInfo);
			ToLua.PushValue(L, info);
			ToLua.SetBack(L, 1, criAtomExPlayback);
			return 2;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetNextBlockIndex(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			CriAtomExPlayback criAtomExPlayback = (CriAtomExPlayback)ToLua.CheckObject(L, 1, typeof(CriAtomExPlayback));
			int nextBlockIndex = (int)LuaDLL.luaL_checknumber(L, 2);
			criAtomExPlayback.SetNextBlockIndex(nextBlockIndex);
			ToLua.SetBack(L, 1, criAtomExPlayback);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int StopWithoutReleaseTime(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			CriAtomExPlayback criAtomExPlayback = (CriAtomExPlayback)ToLua.CheckObject(L, 1, typeof(CriAtomExPlayback));
			criAtomExPlayback.StopWithoutReleaseTime();
			ToLua.SetBack(L, 1, criAtomExPlayback);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_id(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			uint id = ((CriAtomExPlayback)obj).id;
			LuaDLL.lua_pushnumber(L, id);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index id on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_status(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CriAtomExPlayback.Status status = ((CriAtomExPlayback)obj).status;
			ToLua.Push(L, status);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index status on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_time(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			long time = ((CriAtomExPlayback)obj).time;
			LuaDLL.tolua_pushint64(L, time);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index time on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_timeSyncedWithAudio(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			long timeSyncedWithAudio = ((CriAtomExPlayback)obj).timeSyncedWithAudio;
			LuaDLL.tolua_pushint64(L, timeSyncedWithAudio);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index timeSyncedWithAudio on a nil value");
		}
	}
}
