using System;
using System.Collections.Generic;
using LuaInterface;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

public class UnityEngine_Timeline_TrackAssetWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(TrackAsset), typeof(PlayableAsset));
		L.RegFunction("GetClips", GetClips);
		L.RegFunction("GetChildTracks", GetChildTracks);
		L.RegFunction("CreateTrackMixer", CreateTrackMixer);
		L.RegFunction("CreatePlayable", CreatePlayable);
		L.RegFunction("CreateDefaultClip", CreateDefaultClip);
		L.RegFunction("GatherProperties", GatherProperties);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("start", get_start, null);
		L.RegVar("end", get_end, null);
		L.RegVar("duration", get_duration, null);
		L.RegVar("muted", get_muted, set_muted);
		L.RegVar("timelineAsset", get_timelineAsset, null);
		L.RegVar("parent", get_parent, null);
		L.RegVar("isEmpty", get_isEmpty, null);
		L.RegVar("isSubTrack", get_isSubTrack, null);
		L.RegVar("outputs", get_outputs, null);
		L.RegVar("locked", get_locked, set_locked);
		L.RegVar("lockedInHierarchy", get_lockedInHierarchy, null);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetClips(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			IEnumerable<TimelineClip> clips = ((TrackAsset)ToLua.CheckObject<TrackAsset>(L, 1)).GetClips();
			ToLua.PushObject(L, clips);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetChildTracks(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			IEnumerable<TrackAsset> childTracks = ((TrackAsset)ToLua.CheckObject<TrackAsset>(L, 1)).GetChildTracks();
			ToLua.PushObject(L, childTracks);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CreateTrackMixer(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			TrackAsset obj = (TrackAsset)ToLua.CheckObject<TrackAsset>(L, 1);
			PlayableGraph graph = StackTraits<PlayableGraph>.Check(L, 2);
			GameObject go = (GameObject)ToLua.CheckObject(L, 3, typeof(GameObject));
			int inputCount = (int)LuaDLL.luaL_checknumber(L, 4);
			Playable v = obj.CreateTrackMixer(graph, go, inputCount);
			ToLua.PushValue(L, v);
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
			TrackAsset obj = (TrackAsset)ToLua.CheckObject<TrackAsset>(L, 1);
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
	private static int CreateDefaultClip(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			TimelineClip o = ((TrackAsset)ToLua.CheckObject<TrackAsset>(L, 1)).CreateDefaultClip();
			ToLua.PushObject(L, o);
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
			TrackAsset obj = (TrackAsset)ToLua.CheckObject<TrackAsset>(L, 1);
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
	private static int get_start(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			double start = ((TrackAsset)obj).start;
			LuaDLL.lua_pushnumber(L, start);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index start on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_end(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			double end = ((TrackAsset)obj).end;
			LuaDLL.lua_pushnumber(L, end);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index end on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_duration(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			double duration = ((TrackAsset)obj).duration;
			LuaDLL.lua_pushnumber(L, duration);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index duration on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_muted(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool muted = ((TrackAsset)obj).muted;
			LuaDLL.lua_pushboolean(L, muted);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index muted on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_timelineAsset(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			TimelineAsset timelineAsset = ((TrackAsset)obj).timelineAsset;
			ToLua.Push(L, timelineAsset);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index timelineAsset on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_parent(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PlayableAsset parent = ((TrackAsset)obj).parent;
			ToLua.Push(L, parent);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index parent on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isEmpty(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isEmpty = ((TrackAsset)obj).isEmpty;
			LuaDLL.lua_pushboolean(L, isEmpty);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isEmpty on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isSubTrack(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isSubTrack = ((TrackAsset)obj).isSubTrack;
			LuaDLL.lua_pushboolean(L, isSubTrack);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isSubTrack on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_outputs(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			IEnumerable<PlayableBinding> outputs = ((TrackAsset)obj).outputs;
			ToLua.PushObject(L, outputs);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index outputs on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_locked(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool locked = ((TrackAsset)obj).locked;
			LuaDLL.lua_pushboolean(L, locked);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index locked on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_lockedInHierarchy(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool lockedInHierarchy = ((TrackAsset)obj).lockedInHierarchy;
			LuaDLL.lua_pushboolean(L, lockedInHierarchy);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index lockedInHierarchy on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_muted(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			TrackAsset obj2 = (TrackAsset)obj;
			bool muted = LuaDLL.luaL_checkboolean(L, 2);
			obj2.muted = muted;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index muted on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_locked(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			TrackAsset obj2 = (TrackAsset)obj;
			bool locked = LuaDLL.luaL_checkboolean(L, 2);
			obj2.locked = locked;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index locked on a nil value");
		}
	}
}
