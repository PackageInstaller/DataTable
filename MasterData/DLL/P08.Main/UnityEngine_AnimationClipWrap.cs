using System;
using LuaInterface;
using UnityEngine;

public class UnityEngine_AnimationClipWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(AnimationClip), typeof(Motion));
		L.RegFunction("SampleAnimation", SampleAnimation);
		L.RegFunction("SetCurve", SetCurve);
		L.RegFunction("EnsureQuaternionContinuity", EnsureQuaternionContinuity);
		L.RegFunction("ClearCurves", ClearCurves);
		L.RegFunction("AddEvent", AddEvent);
		L.RegFunction("New", _CreateUnityEngine_AnimationClip);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("length", get_length, null);
		L.RegVar("frameRate", get_frameRate, set_frameRate);
		L.RegVar("wrapMode", get_wrapMode, set_wrapMode);
		L.RegVar("localBounds", get_localBounds, set_localBounds);
		L.RegVar("legacy", get_legacy, set_legacy);
		L.RegVar("humanMotion", get_humanMotion, null);
		L.RegVar("empty", get_empty, null);
		L.RegVar("hasGenericRootTransform", get_hasGenericRootTransform, null);
		L.RegVar("hasMotionFloatCurves", get_hasMotionFloatCurves, null);
		L.RegVar("hasMotionCurves", get_hasMotionCurves, null);
		L.RegVar("hasRootCurves", get_hasRootCurves, null);
		L.RegVar("events", get_events, set_events);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateUnityEngine_AnimationClip(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				AnimationClip o = new AnimationClip();
				ToLua.PushSealed(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: UnityEngine.AnimationClip.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SampleAnimation(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			AnimationClip obj = (AnimationClip)ToLua.CheckObject(L, 1, typeof(AnimationClip));
			GameObject go = (GameObject)ToLua.CheckObject(L, 2, typeof(GameObject));
			float time = (float)LuaDLL.luaL_checknumber(L, 3);
			obj.SampleAnimation(go, time);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetCurve(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 5);
			AnimationClip obj = (AnimationClip)ToLua.CheckObject(L, 1, typeof(AnimationClip));
			string relativePath = ToLua.CheckString(L, 2);
			Type type = ToLua.CheckMonoType(L, 3);
			string propertyName = ToLua.CheckString(L, 4);
			AnimationCurve curve = (AnimationCurve)ToLua.CheckObject<AnimationCurve>(L, 5);
			obj.SetCurve(relativePath, type, propertyName, curve);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int EnsureQuaternionContinuity(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((AnimationClip)ToLua.CheckObject(L, 1, typeof(AnimationClip))).EnsureQuaternionContinuity();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ClearCurves(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((AnimationClip)ToLua.CheckObject(L, 1, typeof(AnimationClip))).ClearCurves();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int AddEvent(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			AnimationClip obj = (AnimationClip)ToLua.CheckObject(L, 1, typeof(AnimationClip));
			AnimationEvent evt = (AnimationEvent)ToLua.CheckObject(L, 2, typeof(AnimationEvent));
			obj.AddEvent(evt);
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
	private static int get_length(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float length = ((AnimationClip)obj).length;
			LuaDLL.lua_pushnumber(L, length);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index length on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_frameRate(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float frameRate = ((AnimationClip)obj).frameRate;
			LuaDLL.lua_pushnumber(L, frameRate);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index frameRate on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_wrapMode(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			WrapMode wrapMode = ((AnimationClip)obj).wrapMode;
			ToLua.Push(L, wrapMode);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index wrapMode on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_localBounds(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Bounds localBounds = ((AnimationClip)obj).localBounds;
			ToLua.Push(L, localBounds);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index localBounds on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_legacy(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool legacy = ((AnimationClip)obj).legacy;
			LuaDLL.lua_pushboolean(L, legacy);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index legacy on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_humanMotion(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool humanMotion = ((AnimationClip)obj).humanMotion;
			LuaDLL.lua_pushboolean(L, humanMotion);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index humanMotion on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_empty(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool empty = ((AnimationClip)obj).empty;
			LuaDLL.lua_pushboolean(L, empty);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index empty on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_hasGenericRootTransform(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool hasGenericRootTransform = ((AnimationClip)obj).hasGenericRootTransform;
			LuaDLL.lua_pushboolean(L, hasGenericRootTransform);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index hasGenericRootTransform on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_hasMotionFloatCurves(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool hasMotionFloatCurves = ((AnimationClip)obj).hasMotionFloatCurves;
			LuaDLL.lua_pushboolean(L, hasMotionFloatCurves);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index hasMotionFloatCurves on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_hasMotionCurves(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool hasMotionCurves = ((AnimationClip)obj).hasMotionCurves;
			LuaDLL.lua_pushboolean(L, hasMotionCurves);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index hasMotionCurves on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_hasRootCurves(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool hasRootCurves = ((AnimationClip)obj).hasRootCurves;
			LuaDLL.lua_pushboolean(L, hasRootCurves);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index hasRootCurves on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_events(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			AnimationEvent[] events = ((AnimationClip)obj).events;
			ToLua.Push(L, events);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index events on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_frameRate(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			AnimationClip obj2 = (AnimationClip)obj;
			float frameRate = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.frameRate = frameRate;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index frameRate on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_wrapMode(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			AnimationClip obj2 = (AnimationClip)obj;
			WrapMode wrapMode = (WrapMode)ToLua.CheckObject(L, 2, typeof(WrapMode));
			obj2.wrapMode = wrapMode;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index wrapMode on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_localBounds(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			AnimationClip obj2 = (AnimationClip)obj;
			Bounds localBounds = ToLua.ToBounds(L, 2);
			obj2.localBounds = localBounds;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index localBounds on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_legacy(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			AnimationClip obj2 = (AnimationClip)obj;
			bool legacy = LuaDLL.luaL_checkboolean(L, 2);
			obj2.legacy = legacy;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index legacy on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_events(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			AnimationClip obj2 = (AnimationClip)obj;
			AnimationEvent[] events = ToLua.CheckObjectArray<AnimationEvent>(L, 2);
			obj2.events = events;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index events on a nil value");
		}
	}
}
