using System;
using LuaInterface;
using UnityEngine.UI;

public class MusicLuaBridgeWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(MusicLuaBridge), typeof(object));
		L.RegFunction("Launcher", Launcher);
		L.RegFunction("StartMusicGame", StartMusicGame);
		L.RegFunction("PauseMusicGame", PauseMusicGame);
		L.RegFunction("ResumeMusicGame", ResumeMusicGame);
		L.RegFunction("EndMusicGame", EndMusicGame);
		L.RegFunction("ReStartMusicGame", ReStartMusicGame);
		L.RegFunction("GetCurrentState", GetCurrentState);
		L.RegFunction("GetMusicPlay", GetMusicPlay);
		L.RegFunction("GetCurTime", GetCurTime);
		L.RegFunction("GetMusicLength", GetMusicLength);
		L.RegFunction("GetTrackNum", GetTrackNum);
		L.RegFunction("SetProcessSlider", SetProcessSlider);
		L.RegFunction("New", _CreateMusicLuaBridge);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateMusicLuaBridge(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				MusicLuaBridge o = new MusicLuaBridge();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: MusicLuaBridge.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Launcher(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			MusicLuaBridge.Launcher((MusicDataForExchange)ToLua.CheckObject<MusicDataForExchange>(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int StartMusicGame(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			MusicLuaBridge.StartMusicGame();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int PauseMusicGame(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			MusicLuaBridge.PauseMusicGame();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ResumeMusicGame(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			MusicLuaBridge.ResumeMusicGame();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int EndMusicGame(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			MusicLuaBridge.EndMusicGame();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ReStartMusicGame(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			MusicLuaBridge.ReStartMusicGame();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetCurrentState(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			string currentState = MusicLuaBridge.GetCurrentState();
			LuaDLL.lua_pushstring(L, currentState);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetMusicPlay(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			CriAtomSource musicPlay = MusicLuaBridge.GetMusicPlay();
			ToLua.Push(L, musicPlay);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetCurTime(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			int curTime = MusicLuaBridge.GetCurTime();
			LuaDLL.lua_pushinteger(L, curTime);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetMusicLength(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			int musicLength = MusicLuaBridge.GetMusicLength();
			LuaDLL.lua_pushinteger(L, musicLength);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetTrackNum(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			int trackNum = MusicLuaBridge.GetTrackNum();
			LuaDLL.lua_pushinteger(L, trackNum);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetProcessSlider(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			MusicLuaBridge.SetProcessSlider((Slider)ToLua.CheckObject<Slider>(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
