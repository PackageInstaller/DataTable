using System;
using LuaInterface;
using MusicGame;
using UnityEngine;

public class MusicGame_MusicSetControllerWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(MusicSetController), typeof(MonoBehaviour));
		L.RegFunction("SetTrackType", SetTrackType);
		L.RegFunction("Begain", Begain);
		L.RegFunction("End", End);
		L.RegFunction("GetCurTime", GetCurTime);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("goodArea", get_goodArea, set_goodArea);
		L.RegVar("latency", get_latency, set_latency);
		L.RegVar("judgeLatency", get_judgeLatency, set_judgeLatency);
		L.RegVar("nodeSpeed", get_nodeSpeed, set_nodeSpeed);
		L.RegVar("mixRange", get_mixRange, set_mixRange);
		L.RegVar("player", get_player, set_player);
		L.RegVar("cueSheetName", get_cueSheetName, set_cueSheetName);
		L.RegVar("cueName", get_cueName, set_cueName);
		L.RegVar("awbFile", get_awbFile, set_awbFile);
		L.RegVar("song_duration", get_song_duration, set_song_duration);
		L.RegVar("startPos", get_startPos, set_startPos);
		L.RegVar("endPos", get_endPos, set_endPos);
		L.RegVar("track", get_track, set_track);
		L.RegVar("gameData", get_gameData, set_gameData);
		L.RegVar("musicPath", get_musicPath, set_musicPath);
		L.RegVar("autoClick", get_autoClick, set_autoClick);
		L.RegVar("specifyTime", get_specifyTime, set_specifyTime);
		L.RegVar("constantStayTime", get_constantStayTime, set_constantStayTime);
		L.RegVar("stayTime", get_stayTime, set_stayTime);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetTrackType(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			MusicSetController obj = (MusicSetController)ToLua.CheckObject<MusicSetController>(L, 1);
			int trackType = (int)LuaDLL.luaL_checknumber(L, 2);
			obj.SetTrackType(trackType);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Begain(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((MusicSetController)ToLua.CheckObject<MusicSetController>(L, 1)).Begain();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int End(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((MusicSetController)ToLua.CheckObject<MusicSetController>(L, 1)).End();
			return 0;
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
			ToLua.CheckArgsCount(L, 1);
			int curTime = ((MusicSetController)ToLua.CheckObject<MusicSetController>(L, 1)).GetCurTime();
			LuaDLL.lua_pushinteger(L, curTime);
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
	private static int get_goodArea(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushinteger(L, MusicSetController.goodArea);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_latency(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushinteger(L, MusicSetController.latency);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_judgeLatency(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushinteger(L, MusicSetController.judgeLatency);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_nodeSpeed(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushnumber(L, MusicSetController.nodeSpeed);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_mixRange(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushnumber(L, MusicSetController.mixRange);
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
			MusicGameCriAtomSource player = ((MusicSetController)obj).player;
			ToLua.Push(L, player);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index player on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_cueSheetName(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string cueSheetName = ((MusicSetController)obj).cueSheetName;
			LuaDLL.lua_pushstring(L, cueSheetName);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index cueSheetName on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_cueName(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string cueName = ((MusicSetController)obj).cueName;
			LuaDLL.lua_pushstring(L, cueName);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index cueName on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_awbFile(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string awbFile = ((MusicSetController)obj).awbFile;
			LuaDLL.lua_pushstring(L, awbFile);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index awbFile on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_song_duration(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int song_duration = ((MusicSetController)obj).song_duration;
			LuaDLL.lua_pushinteger(L, song_duration);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index song_duration on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_startPos(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Transform startPos = ((MusicSetController)obj).startPos;
			ToLua.Push(L, startPos);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index startPos on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_endPos(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Transform endPos = ((MusicSetController)obj).endPos;
			ToLua.Push(L, endPos);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index endPos on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_track(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			MusicSetTrack track = ((MusicSetController)obj).track;
			ToLua.Push(L, track);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index track on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_gameData(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			MusicGameStruct gameData = ((MusicSetController)obj).gameData;
			ToLua.PushValue(L, gameData);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index gameData on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_musicPath(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string musicPath = ((MusicSetController)obj).musicPath;
			LuaDLL.lua_pushstring(L, musicPath);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index musicPath on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_autoClick(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool autoClick = ((MusicSetController)obj).autoClick;
			LuaDLL.lua_pushboolean(L, autoClick);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index autoClick on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_specifyTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int specifyTime = ((MusicSetController)obj).specifyTime;
			LuaDLL.lua_pushinteger(L, specifyTime);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index specifyTime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_constantStayTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int constantStayTime = ((MusicSetController)obj).constantStayTime;
			LuaDLL.lua_pushinteger(L, constantStayTime);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index constantStayTime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_stayTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int stayTime = ((MusicSetController)obj).stayTime;
			LuaDLL.lua_pushinteger(L, stayTime);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index stayTime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_goodArea(IntPtr L)
	{
		try
		{
			MusicSetController.goodArea = (int)LuaDLL.luaL_checknumber(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_latency(IntPtr L)
	{
		try
		{
			MusicSetController.latency = (int)LuaDLL.luaL_checknumber(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_judgeLatency(IntPtr L)
	{
		try
		{
			MusicSetController.judgeLatency = (int)LuaDLL.luaL_checknumber(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_nodeSpeed(IntPtr L)
	{
		try
		{
			MusicSetController.nodeSpeed = (float)LuaDLL.luaL_checknumber(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_mixRange(IntPtr L)
	{
		try
		{
			MusicSetController.mixRange = (float)LuaDLL.luaL_checknumber(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_player(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			MusicSetController obj2 = (MusicSetController)obj;
			MusicGameCriAtomSource player = (MusicGameCriAtomSource)ToLua.CheckObject<MusicGameCriAtomSource>(L, 2);
			obj2.player = player;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index player on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_cueSheetName(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			MusicSetController obj2 = (MusicSetController)obj;
			string cueSheetName = ToLua.CheckString(L, 2);
			obj2.cueSheetName = cueSheetName;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index cueSheetName on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_cueName(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			MusicSetController obj2 = (MusicSetController)obj;
			string cueName = ToLua.CheckString(L, 2);
			obj2.cueName = cueName;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index cueName on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_awbFile(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			MusicSetController obj2 = (MusicSetController)obj;
			string awbFile = ToLua.CheckString(L, 2);
			obj2.awbFile = awbFile;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index awbFile on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_song_duration(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			MusicSetController obj2 = (MusicSetController)obj;
			int song_duration = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.song_duration = song_duration;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index song_duration on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_startPos(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			MusicSetController obj2 = (MusicSetController)obj;
			Transform startPos = (Transform)ToLua.CheckObject<Transform>(L, 2);
			obj2.startPos = startPos;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index startPos on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_endPos(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			MusicSetController obj2 = (MusicSetController)obj;
			Transform endPos = (Transform)ToLua.CheckObject<Transform>(L, 2);
			obj2.endPos = endPos;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index endPos on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_track(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			MusicSetController obj2 = (MusicSetController)obj;
			MusicSetTrack track = (MusicSetTrack)ToLua.CheckObject<MusicSetTrack>(L, 2);
			obj2.track = track;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index track on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_gameData(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			MusicSetController obj2 = (MusicSetController)obj;
			MusicGameStruct gameData = StackTraits<MusicGameStruct>.Check(L, 2);
			obj2.gameData = gameData;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index gameData on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_musicPath(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			MusicSetController obj2 = (MusicSetController)obj;
			string musicPath = ToLua.CheckString(L, 2);
			obj2.musicPath = musicPath;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index musicPath on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_autoClick(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			MusicSetController obj2 = (MusicSetController)obj;
			bool autoClick = LuaDLL.luaL_checkboolean(L, 2);
			obj2.autoClick = autoClick;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index autoClick on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_specifyTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			MusicSetController obj2 = (MusicSetController)obj;
			int specifyTime = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.specifyTime = specifyTime;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index specifyTime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_constantStayTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			MusicSetController obj2 = (MusicSetController)obj;
			int constantStayTime = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.constantStayTime = constantStayTime;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index constantStayTime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_stayTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			MusicSetController obj2 = (MusicSetController)obj;
			int stayTime = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.stayTime = stayTime;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index stayTime on a nil value");
		}
	}
}
