using System;
using System.Collections.Generic;
using LuaInterface;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

public class UnityEngine_Timeline_TimelineAssetWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(TimelineAsset), typeof(PlayableAsset));
		L.RegFunction("GetRootTrack", GetRootTrack);
		L.RegFunction("GetRootTracks", GetRootTracks);
		L.RegFunction("GetOutputTrack", GetOutputTrack);
		L.RegFunction("GetOutputTracks", GetOutputTracks);
		L.RegFunction("CreatePlayable", CreatePlayable);
		L.RegFunction("GatherProperties", GatherProperties);
		L.RegFunction("CreateTrack", CreateTrack);
		L.RegFunction("DeleteClip", DeleteClip);
		L.RegFunction("DeleteTrack", DeleteTrack);
		L.RegFunction("New", _CreateUnityEngine_Timeline_TimelineAsset);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("editorSettings", get_editorSettings, null);
		L.RegVar("duration", get_duration, null);
		L.RegVar("fixedDuration", get_fixedDuration, set_fixedDuration);
		L.RegVar("durationMode", get_durationMode, set_durationMode);
		L.RegVar("outputs", get_outputs, null);
		L.RegVar("clipCaps", get_clipCaps, null);
		L.RegVar("outputTrackCount", get_outputTrackCount, null);
		L.RegVar("rootTrackCount", get_rootTrackCount, null);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateUnityEngine_Timeline_TimelineAsset(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				TimelineAsset obj = new TimelineAsset();
				ToLua.Push(L, obj);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: UnityEngine.Timeline.TimelineAsset.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetRootTrack(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			TimelineAsset obj = (TimelineAsset)ToLua.CheckObject<TimelineAsset>(L, 1);
			int index = (int)LuaDLL.luaL_checknumber(L, 2);
			TrackAsset rootTrack = obj.GetRootTrack(index);
			ToLua.Push(L, rootTrack);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetRootTracks(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			IEnumerable<TrackAsset> rootTracks = ((TimelineAsset)ToLua.CheckObject<TimelineAsset>(L, 1)).GetRootTracks();
			ToLua.PushObject(L, rootTracks);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetOutputTrack(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			TimelineAsset obj = (TimelineAsset)ToLua.CheckObject<TimelineAsset>(L, 1);
			int index = (int)LuaDLL.luaL_checknumber(L, 2);
			TrackAsset outputTrack = obj.GetOutputTrack(index);
			ToLua.Push(L, outputTrack);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetOutputTracks(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			IEnumerable<TrackAsset> outputTracks = ((TimelineAsset)ToLua.CheckObject<TimelineAsset>(L, 1)).GetOutputTracks();
			ToLua.PushObject(L, outputTracks);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CreatePlayable(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			TimelineAsset obj = (TimelineAsset)ToLua.CheckObject<TimelineAsset>(L, 1);
			PlayableGraph graph = StackTraits<PlayableGraph>.Check(L, 2);
			GameObject owner = (GameObject)ToLua.CheckObject(L, 3, typeof(GameObject));
			Playable v = obj.CreatePlayable(graph, owner);
			ToLua.PushValue(L, v);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GatherProperties(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			TimelineAsset obj = (TimelineAsset)ToLua.CheckObject<TimelineAsset>(L, 1);
			PlayableDirector director = (PlayableDirector)ToLua.CheckObject<PlayableDirector>(L, 2);
			IPropertyCollector driver = (IPropertyCollector)ToLua.CheckObject<IPropertyCollector>(L, 3);
			obj.GatherProperties(director, driver);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CreateTrack(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			TimelineAsset obj = (TimelineAsset)ToLua.CheckObject<TimelineAsset>(L, 1);
			Type type = ToLua.CheckMonoType(L, 2);
			TrackAsset parent = (TrackAsset)ToLua.CheckObject<TrackAsset>(L, 3);
			string name = ToLua.CheckString(L, 4);
			TrackAsset obj2 = obj.CreateTrack(type, parent, name);
			ToLua.Push(L, obj2);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int DeleteClip(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			TimelineAsset obj = (TimelineAsset)ToLua.CheckObject<TimelineAsset>(L, 1);
			TimelineClip clip = (TimelineClip)ToLua.CheckObject<TimelineClip>(L, 2);
			bool value = obj.DeleteClip(clip);
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int DeleteTrack(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			TimelineAsset obj = (TimelineAsset)ToLua.CheckObject<TimelineAsset>(L, 1);
			TrackAsset track = (TrackAsset)ToLua.CheckObject<TrackAsset>(L, 2);
			bool value = obj.DeleteTrack(track);
			LuaDLL.lua_pushboolean(L, value);
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
	private static int get_editorSettings(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			TimelineAsset.EditorSettings editorSettings = ((TimelineAsset)obj).editorSettings;
			ToLua.PushObject(L, editorSettings);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index editorSettings on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_duration(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			double duration = ((TimelineAsset)obj).duration;
			LuaDLL.lua_pushnumber(L, duration);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index duration on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_fixedDuration(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			double fixedDuration = ((TimelineAsset)obj).fixedDuration;
			LuaDLL.lua_pushnumber(L, fixedDuration);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index fixedDuration on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_durationMode(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			TimelineAsset.DurationMode durationMode = ((TimelineAsset)obj).durationMode;
			ToLua.Push(L, durationMode);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index durationMode on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_outputs(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			IEnumerable<PlayableBinding> outputs = ((TimelineAsset)obj).outputs;
			ToLua.PushObject(L, outputs);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index outputs on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_clipCaps(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ClipCaps clipCaps = ((TimelineAsset)obj).clipCaps;
			ToLua.Push(L, clipCaps);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index clipCaps on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_outputTrackCount(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int outputTrackCount = ((TimelineAsset)obj).outputTrackCount;
			LuaDLL.lua_pushinteger(L, outputTrackCount);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index outputTrackCount on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_rootTrackCount(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int rootTrackCount = ((TimelineAsset)obj).rootTrackCount;
			LuaDLL.lua_pushinteger(L, rootTrackCount);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index rootTrackCount on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_fixedDuration(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			TimelineAsset obj2 = (TimelineAsset)obj;
			double fixedDuration = LuaDLL.luaL_checknumber(L, 2);
			obj2.fixedDuration = fixedDuration;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index fixedDuration on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_durationMode(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			TimelineAsset obj2 = (TimelineAsset)obj;
			TimelineAsset.DurationMode durationMode = (TimelineAsset.DurationMode)ToLua.CheckObject(L, 2, typeof(TimelineAsset.DurationMode));
			obj2.durationMode = durationMode;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index durationMode on a nil value");
		}
	}
}
