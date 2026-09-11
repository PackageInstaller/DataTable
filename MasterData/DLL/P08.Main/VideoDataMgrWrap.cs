using System;
using LuaInterface;
using UnityEngine;

public class VideoDataMgrWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(VideoDataMgr), typeof(MonoBehaviour));
		L.RegFunction("StartVideoLogger", StartVideoLogger);
		L.RegFunction("StartVideoLoggerWithID", StartVideoLoggerWithID);
		L.RegFunction("Cmds2File", Cmds2File);
		L.RegFunction("StopVideoLogger", StopVideoLogger);
		L.RegFunction("GiveUpVideo", GiveUpVideo);
		L.RegFunction("VideoIndexData34File", VideoIndexData34File);
		L.RegFunction("VideoIndexDataChangeName", VideoIndexDataChangeName);
		L.RegFunction("GetVideoIndexDataByName", GetVideoIndexDataByName);
		L.RegFunction("GetVideoIndexData", GetVideoIndexData);
		L.RegFunction("GetVideoFiles", GetVideoFiles);
		L.RegFunction("IsExistForVideo", IsExistForVideo);
		L.RegFunction("GetVideoDataByFileName", GetVideoDataByFileName);
		L.RegFunction("FileExit", FileExit);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("Inst", get_Inst, null);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int StartVideoLogger(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			int n = ((VideoDataMgr)ToLua.CheckObject<VideoDataMgr>(L, 1)).StartVideoLogger();
			LuaDLL.lua_pushinteger(L, n);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int StartVideoLoggerWithID(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			VideoDataMgr obj = (VideoDataMgr)ToLua.CheckObject<VideoDataMgr>(L, 1);
			int id = (int)LuaDLL.luaL_checknumber(L, 2);
			int n = obj.StartVideoLoggerWithID(id);
			LuaDLL.lua_pushinteger(L, n);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Cmds2File(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			VideoDataMgr obj = (VideoDataMgr)ToLua.CheckObject<VideoDataMgr>(L, 1);
			string cmd = ToLua.CheckString(L, 2);
			int n = obj.Cmds2File(cmd);
			LuaDLL.lua_pushinteger(L, n);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int StopVideoLogger(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			VideoDataMgr obj = (VideoDataMgr)ToLua.CheckObject<VideoDataMgr>(L, 1);
			string newName = ToLua.CheckString(L, 2);
			string otherData = ToLua.CheckString(L, 3);
			int n = obj.StopVideoLogger(newName, otherData);
			LuaDLL.lua_pushinteger(L, n);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GiveUpVideo(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			int n = ((VideoDataMgr)ToLua.CheckObject<VideoDataMgr>(L, 1)).GiveUpVideo();
			LuaDLL.lua_pushinteger(L, n);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int VideoIndexData34File(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			VideoDataMgr obj = (VideoDataMgr)ToLua.CheckObject<VideoDataMgr>(L, 1);
			string videoName = ToLua.CheckString(L, 2);
			int n = obj.VideoIndexData34File(videoName);
			LuaDLL.lua_pushinteger(L, n);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int VideoIndexDataChangeName(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			VideoDataMgr obj = (VideoDataMgr)ToLua.CheckObject<VideoDataMgr>(L, 1);
			string oldName = ToLua.CheckString(L, 2);
			string newName = ToLua.CheckString(L, 3);
			int n = obj.VideoIndexDataChangeName(oldName, newName);
			LuaDLL.lua_pushinteger(L, n);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetVideoIndexDataByName(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			VideoDataMgr obj = (VideoDataMgr)ToLua.CheckObject<VideoDataMgr>(L, 1);
			string videoName = ToLua.CheckString(L, 2);
			string videoIndexDataByName = obj.GetVideoIndexDataByName(videoName);
			LuaDLL.lua_pushstring(L, videoIndexDataByName);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetVideoIndexData(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			string videoIndexData = ((VideoDataMgr)ToLua.CheckObject<VideoDataMgr>(L, 1)).GetVideoIndexData();
			LuaDLL.lua_pushstring(L, videoIndexData);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetVideoFiles(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			string videoFiles = ((VideoDataMgr)ToLua.CheckObject<VideoDataMgr>(L, 1)).GetVideoFiles();
			LuaDLL.lua_pushstring(L, videoFiles);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IsExistForVideo(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			VideoDataMgr obj = (VideoDataMgr)ToLua.CheckObject<VideoDataMgr>(L, 1);
			string videoName = ToLua.CheckString(L, 2);
			int n = obj.IsExistForVideo(videoName);
			LuaDLL.lua_pushinteger(L, n);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetVideoDataByFileName(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			VideoDataMgr obj = (VideoDataMgr)ToLua.CheckObject<VideoDataMgr>(L, 1);
			string fileName = ToLua.CheckString(L, 2);
			string videoDataByFileName = obj.GetVideoDataByFileName(fileName);
			LuaDLL.lua_pushstring(L, videoDataByFileName);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int FileExit(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			VideoDataMgr obj = (VideoDataMgr)ToLua.CheckObject<VideoDataMgr>(L, 1);
			string name = ToLua.CheckString(L, 2);
			int n = obj.FileExit(name);
			LuaDLL.lua_pushinteger(L, n);
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
	private static int get_Inst(IntPtr L)
	{
		try
		{
			ToLua.Push(L, VideoDataMgr.Inst);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
