using System;
using LuaInterface;
using UnityEngine;
using UnityEngine.Playables;

public class BlendTwoTimelinesWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(BlendTwoTimelines), typeof(MonoBehaviour));
		L.RegFunction("GetmationParam", GetmationParam);
		L.RegFunction("startLerp", startLerp);
		L.RegFunction("StartLerpByLateUpdate", StartLerpByLateUpdate);
		L.RegFunction("Dispose", Dispose);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("directorA", get_directorA, set_directorA);
		L.RegVar("directorB", get_directorB, set_directorB);
		L.RegVar("tpose_Object", get_tpose_Object, set_tpose_Object);
		L.RegVar("animator", get_animator, set_animator);
		L.RegVar("isOpen", get_isOpen, set_isOpen);
		L.RegVar("isOnLaterUpdate", get_isOnLaterUpdate, set_isOnLaterUpdate);
		L.RegVar("lerpDuration", get_lerpDuration, set_lerpDuration);
		L.RegVar("lastUpdateTime", get_lastUpdateTime, set_lastUpdateTime);
		L.RegVar("callBack", get_callBack, set_callBack);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetmationParam(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((BlendTwoTimelines)ToLua.CheckObject<BlendTwoTimelines>(L, 1)).GetmationParam();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int startLerp(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((BlendTwoTimelines)ToLua.CheckObject<BlendTwoTimelines>(L, 1)).startLerp();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int StartLerpByLateUpdate(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((BlendTwoTimelines)ToLua.CheckObject<BlendTwoTimelines>(L, 1)).StartLerpByLateUpdate();
			return 0;
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
			((BlendTwoTimelines)ToLua.CheckObject<BlendTwoTimelines>(L, 1)).Dispose();
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
	private static int get_directorA(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PlayableDirector directorA = ((BlendTwoTimelines)obj).directorA;
			ToLua.Push(L, directorA);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index directorA on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_directorB(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PlayableDirector directorB = ((BlendTwoTimelines)obj).directorB;
			ToLua.Push(L, directorB);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index directorB on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_tpose_Object(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GameObject tpose_Object = ((BlendTwoTimelines)obj).tpose_Object;
			ToLua.PushSealed(L, tpose_Object);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index tpose_Object on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_animator(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Animator animator = ((BlendTwoTimelines)obj).animator;
			ToLua.Push(L, animator);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index animator on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isOpen(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isOpen = ((BlendTwoTimelines)obj).isOpen;
			LuaDLL.lua_pushboolean(L, isOpen);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isOpen on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isOnLaterUpdate(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isOnLaterUpdate = ((BlendTwoTimelines)obj).isOnLaterUpdate;
			LuaDLL.lua_pushboolean(L, isOnLaterUpdate);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isOnLaterUpdate on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_lerpDuration(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float lerpDuration = ((BlendTwoTimelines)obj).lerpDuration;
			LuaDLL.lua_pushnumber(L, lerpDuration);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index lerpDuration on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_lastUpdateTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float lastUpdateTime = ((BlendTwoTimelines)obj).lastUpdateTime;
			LuaDLL.lua_pushnumber(L, lastUpdateTime);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index lastUpdateTime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_callBack(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Action callBack = ((BlendTwoTimelines)obj).callBack;
			ToLua.Push(L, callBack);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index callBack on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_directorA(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BlendTwoTimelines obj2 = (BlendTwoTimelines)obj;
			PlayableDirector directorA = (PlayableDirector)ToLua.CheckObject<PlayableDirector>(L, 2);
			obj2.directorA = directorA;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index directorA on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_directorB(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BlendTwoTimelines obj2 = (BlendTwoTimelines)obj;
			PlayableDirector directorB = (PlayableDirector)ToLua.CheckObject<PlayableDirector>(L, 2);
			obj2.directorB = directorB;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index directorB on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_tpose_Object(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BlendTwoTimelines obj2 = (BlendTwoTimelines)obj;
			GameObject tpose_Object = (GameObject)ToLua.CheckObject(L, 2, typeof(GameObject));
			obj2.tpose_Object = tpose_Object;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index tpose_Object on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_animator(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BlendTwoTimelines obj2 = (BlendTwoTimelines)obj;
			Animator animator = (Animator)ToLua.CheckObject<Animator>(L, 2);
			obj2.animator = animator;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index animator on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_isOpen(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BlendTwoTimelines obj2 = (BlendTwoTimelines)obj;
			bool isOpen = LuaDLL.luaL_checkboolean(L, 2);
			obj2.isOpen = isOpen;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isOpen on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_isOnLaterUpdate(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BlendTwoTimelines obj2 = (BlendTwoTimelines)obj;
			bool isOnLaterUpdate = LuaDLL.luaL_checkboolean(L, 2);
			obj2.isOnLaterUpdate = isOnLaterUpdate;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isOnLaterUpdate on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_lerpDuration(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BlendTwoTimelines obj2 = (BlendTwoTimelines)obj;
			float lerpDuration = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.lerpDuration = lerpDuration;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index lerpDuration on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_lastUpdateTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BlendTwoTimelines obj2 = (BlendTwoTimelines)obj;
			float lastUpdateTime = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.lastUpdateTime = lastUpdateTime;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index lastUpdateTime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_callBack(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BlendTwoTimelines obj2 = (BlendTwoTimelines)obj;
			Action callBack = (Action)ToLua.CheckDelegate<Action>(L, 2);
			obj2.callBack = callBack;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index callBack on a nil value");
		}
	}
}
