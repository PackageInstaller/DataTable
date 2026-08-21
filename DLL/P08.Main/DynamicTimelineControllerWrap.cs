using System;
using System.Collections.Generic;
using LuaInterface;
using UnityEngine;

public class DynamicTimelineControllerWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(DynamicTimelineController), typeof(MonoBehaviour));
		L.RegFunction("GetHero", GetHero);
		L.RegFunction("ReleaseHero", ReleaseHero);
		L.RegFunction("PlayAnimation", PlayAnimation);
		L.RegFunction("SetPlayerToTransform", SetPlayerToTransform);
		L.RegFunction("StopTimeline", StopTimeline);
		L.RegFunction("Restart", Restart);
		L.RegFunction("GetDirectorLength", GetDirectorLength);
		L.RegFunction("GetTransform", GetTransform);
		L.RegFunction("GetTransTags", GetTransTags);
		L.RegFunction("Dispose", Dispose);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("transforms", get_transforms, set_transforms);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetHero(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			DynamicTimelineController obj = (DynamicTimelineController)ToLua.CheckObject<DynamicTimelineController>(L, 1);
			string heroPath = ToLua.CheckString(L, 2);
			DynamicHeroProxy hero = obj.GetHero(heroPath);
			ToLua.Push(L, hero);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ReleaseHero(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			DynamicTimelineController obj = (DynamicTimelineController)ToLua.CheckObject<DynamicTimelineController>(L, 1);
			string heroPath = ToLua.CheckString(L, 2);
			obj.ReleaseHero(heroPath);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int PlayAnimation(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			DynamicTimelineController obj = (DynamicTimelineController)ToLua.CheckObject<DynamicTimelineController>(L, 1);
			string heroPath = ToLua.CheckString(L, 2);
			string animName = ToLua.CheckString(L, 3);
			float crossFade = (float)LuaDLL.luaL_checknumber(L, 4);
			obj.PlayAnimation(heroPath, animName, crossFade);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetPlayerToTransform(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			DynamicTimelineController obj = (DynamicTimelineController)ToLua.CheckObject<DynamicTimelineController>(L, 1);
			string heroPath = ToLua.CheckString(L, 2);
			Transform trans = (Transform)ToLua.CheckObject<Transform>(L, 3);
			obj.SetPlayerToTransform(heroPath, trans);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int StopTimeline(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((DynamicTimelineController)ToLua.CheckObject<DynamicTimelineController>(L, 1)).StopTimeline();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Restart(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((DynamicTimelineController)ToLua.CheckObject<DynamicTimelineController>(L, 1)).Restart();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetDirectorLength(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			float directorLength = ((DynamicTimelineController)ToLua.CheckObject<DynamicTimelineController>(L, 1)).GetDirectorLength();
			LuaDLL.lua_pushnumber(L, directorLength);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetTransform(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			DynamicTimelineController obj = (DynamicTimelineController)ToLua.CheckObject<DynamicTimelineController>(L, 1);
			string tag = ToLua.CheckString(L, 2);
			Transform transform = obj.GetTransform(tag);
			ToLua.Push(L, transform);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetTransTags(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			List<string> transTags = ((DynamicTimelineController)ToLua.CheckObject<DynamicTimelineController>(L, 1)).GetTransTags();
			ToLua.PushSealed(L, transTags);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Dispose(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((DynamicTimelineController)ToLua.CheckObject<DynamicTimelineController>(L, 1)).Dispose();
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
	private static int get_transforms(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<TransformProxy> transforms = ((DynamicTimelineController)obj).transforms;
			ToLua.PushSealed(L, transforms);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index transforms on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_transforms(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			DynamicTimelineController obj2 = (DynamicTimelineController)obj;
			List<TransformProxy> transforms = (List<TransformProxy>)ToLua.CheckObject(L, 2, typeof(List<TransformProxy>));
			obj2.transforms = transforms;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index transforms on a nil value");
		}
	}
}
