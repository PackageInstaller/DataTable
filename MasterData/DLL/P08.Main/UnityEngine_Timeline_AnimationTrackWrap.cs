using System;
using System.Collections.Generic;
using LuaInterface;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

public class UnityEngine_Timeline_AnimationTrackWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(AnimationTrack), typeof(TrackAsset));
		L.RegFunction("CreateClip", CreateClip);
		L.RegFunction("GatherProperties", GatherProperties);
		L.RegFunction("New", _CreateUnityEngine_Timeline_AnimationTrack);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("position", get_position, set_position);
		L.RegVar("rotation", get_rotation, set_rotation);
		L.RegVar("eulerAngles", get_eulerAngles, set_eulerAngles);
		L.RegVar("trackOffset", get_trackOffset, set_trackOffset);
		L.RegVar("matchTargetFields", get_matchTargetFields, set_matchTargetFields);
		L.RegVar("avatarMask", get_avatarMask, set_avatarMask);
		L.RegVar("applyAvatarMask", get_applyAvatarMask, set_applyAvatarMask);
		L.RegVar("outputs", get_outputs, null);
		L.RegVar("inClipMode", get_inClipMode, null);
		L.RegVar("openClipOffsetPosition", get_openClipOffsetPosition, set_openClipOffsetPosition);
		L.RegVar("openClipOffsetRotation", get_openClipOffsetRotation, set_openClipOffsetRotation);
		L.RegVar("openClipOffsetEulerAngles", get_openClipOffsetEulerAngles, set_openClipOffsetEulerAngles);
		L.RegVar("openClipPreExtrapolation", get_openClipPreExtrapolation, set_openClipPreExtrapolation);
		L.RegVar("openClipPostExtrapolation", get_openClipPostExtrapolation, set_openClipPostExtrapolation);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateUnityEngine_Timeline_AnimationTrack(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				AnimationTrack obj = new AnimationTrack();
				ToLua.Push(L, obj);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: UnityEngine.Timeline.AnimationTrack.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CreateClip(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			AnimationTrack obj = (AnimationTrack)ToLua.CheckObject<AnimationTrack>(L, 1);
			AnimationClip clip = (AnimationClip)ToLua.CheckObject(L, 2, typeof(AnimationClip));
			TimelineClip o = obj.CreateClip(clip);
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
			AnimationTrack obj = (AnimationTrack)ToLua.CheckObject<AnimationTrack>(L, 1);
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
	private static int get_position(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector3 position = ((AnimationTrack)obj).position;
			ToLua.Push(L, position);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index position on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_rotation(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Quaternion rotation = ((AnimationTrack)obj).rotation;
			ToLua.Push(L, rotation);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index rotation on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_eulerAngles(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector3 eulerAngles = ((AnimationTrack)obj).eulerAngles;
			ToLua.Push(L, eulerAngles);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index eulerAngles on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_trackOffset(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			TrackOffset trackOffset = ((AnimationTrack)obj).trackOffset;
			ToLua.Push(L, trackOffset);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index trackOffset on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_matchTargetFields(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			MatchTargetFields matchTargetFields = ((AnimationTrack)obj).matchTargetFields;
			ToLua.Push(L, matchTargetFields);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index matchTargetFields on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_avatarMask(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			AvatarMask avatarMask = ((AnimationTrack)obj).avatarMask;
			ToLua.PushSealed(L, avatarMask);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index avatarMask on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_applyAvatarMask(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool applyAvatarMask = ((AnimationTrack)obj).applyAvatarMask;
			LuaDLL.lua_pushboolean(L, applyAvatarMask);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index applyAvatarMask on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_outputs(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			IEnumerable<PlayableBinding> outputs = ((AnimationTrack)obj).outputs;
			ToLua.PushObject(L, outputs);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index outputs on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_inClipMode(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool inClipMode = ((AnimationTrack)obj).inClipMode;
			LuaDLL.lua_pushboolean(L, inClipMode);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index inClipMode on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_openClipOffsetPosition(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector3 infiniteClipOffsetPosition = ((AnimationTrack)obj).infiniteClipOffsetPosition;
			ToLua.Push(L, infiniteClipOffsetPosition);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index openClipOffsetPosition on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_openClipOffsetRotation(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Quaternion infiniteClipOffsetRotation = ((AnimationTrack)obj).infiniteClipOffsetRotation;
			ToLua.Push(L, infiniteClipOffsetRotation);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index openClipOffsetRotation on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_openClipOffsetEulerAngles(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector3 infiniteClipOffsetEulerAngles = ((AnimationTrack)obj).infiniteClipOffsetEulerAngles;
			ToLua.Push(L, infiniteClipOffsetEulerAngles);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index openClipOffsetEulerAngles on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_openClipPreExtrapolation(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			TimelineClip.ClipExtrapolation infiniteClipPreExtrapolation = ((AnimationTrack)obj).infiniteClipPreExtrapolation;
			ToLua.Push(L, infiniteClipPreExtrapolation);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index openClipPreExtrapolation on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_openClipPostExtrapolation(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			TimelineClip.ClipExtrapolation infiniteClipPostExtrapolation = ((AnimationTrack)obj).infiniteClipPostExtrapolation;
			ToLua.Push(L, infiniteClipPostExtrapolation);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index openClipPostExtrapolation on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_position(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			AnimationTrack obj2 = (AnimationTrack)obj;
			Vector3 position = ToLua.ToVector3(L, 2);
			obj2.position = position;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index position on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_rotation(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			AnimationTrack obj2 = (AnimationTrack)obj;
			Quaternion rotation = ToLua.ToQuaternion(L, 2);
			obj2.rotation = rotation;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index rotation on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_eulerAngles(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			AnimationTrack obj2 = (AnimationTrack)obj;
			Vector3 eulerAngles = ToLua.ToVector3(L, 2);
			obj2.eulerAngles = eulerAngles;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index eulerAngles on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_trackOffset(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			AnimationTrack obj2 = (AnimationTrack)obj;
			TrackOffset trackOffset = (TrackOffset)ToLua.CheckObject(L, 2, typeof(TrackOffset));
			obj2.trackOffset = trackOffset;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index trackOffset on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_matchTargetFields(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			AnimationTrack obj2 = (AnimationTrack)obj;
			MatchTargetFields matchTargetFields = (MatchTargetFields)ToLua.CheckObject(L, 2, typeof(MatchTargetFields));
			obj2.matchTargetFields = matchTargetFields;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index matchTargetFields on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_avatarMask(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			AnimationTrack obj2 = (AnimationTrack)obj;
			AvatarMask avatarMask = (AvatarMask)ToLua.CheckObject(L, 2, typeof(AvatarMask));
			obj2.avatarMask = avatarMask;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index avatarMask on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_applyAvatarMask(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			AnimationTrack obj2 = (AnimationTrack)obj;
			bool applyAvatarMask = LuaDLL.luaL_checkboolean(L, 2);
			obj2.applyAvatarMask = applyAvatarMask;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index applyAvatarMask on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_openClipOffsetPosition(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			AnimationTrack obj2 = (AnimationTrack)obj;
			Vector3 infiniteClipOffsetPosition = ToLua.ToVector3(L, 2);
			obj2.infiniteClipOffsetPosition = infiniteClipOffsetPosition;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index openClipOffsetPosition on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_openClipOffsetRotation(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			AnimationTrack obj2 = (AnimationTrack)obj;
			Quaternion infiniteClipOffsetRotation = ToLua.ToQuaternion(L, 2);
			obj2.infiniteClipOffsetRotation = infiniteClipOffsetRotation;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index openClipOffsetRotation on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_openClipOffsetEulerAngles(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			AnimationTrack obj2 = (AnimationTrack)obj;
			Vector3 infiniteClipOffsetEulerAngles = ToLua.ToVector3(L, 2);
			obj2.infiniteClipOffsetEulerAngles = infiniteClipOffsetEulerAngles;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index openClipOffsetEulerAngles on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_openClipPreExtrapolation(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			AnimationTrack obj2 = (AnimationTrack)obj;
			TimelineClip.ClipExtrapolation infiniteClipPreExtrapolation = (TimelineClip.ClipExtrapolation)ToLua.CheckObject(L, 2, typeof(TimelineClip.ClipExtrapolation));
			obj2.infiniteClipPreExtrapolation = infiniteClipPreExtrapolation;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index openClipPreExtrapolation on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_openClipPostExtrapolation(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			AnimationTrack obj2 = (AnimationTrack)obj;
			TimelineClip.ClipExtrapolation infiniteClipPostExtrapolation = (TimelineClip.ClipExtrapolation)ToLua.CheckObject(L, 2, typeof(TimelineClip.ClipExtrapolation));
			obj2.infiniteClipPostExtrapolation = infiniteClipPostExtrapolation;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index openClipPostExtrapolation on a nil value");
		}
	}
}
