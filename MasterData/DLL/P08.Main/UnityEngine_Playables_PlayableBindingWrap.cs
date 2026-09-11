using System;
using LuaInterface;
using UnityEngine;
using UnityEngine.Playables;

public class UnityEngine_Playables_PlayableBindingWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(PlayableBinding), null);
		L.RegFunction("New", _CreateUnityEngine_Playables_PlayableBinding);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("None", get_None, null);
		L.RegVar("DefaultDuration", get_DefaultDuration, null);
		L.RegVar("streamName", get_streamName, set_streamName);
		L.RegVar("sourceObject", get_sourceObject, set_sourceObject);
		L.RegVar("outputTargetType", get_outputTargetType, null);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateUnityEngine_Playables_PlayableBinding(IntPtr L)
	{
		ToLua.PushValue(L, default(PlayableBinding));
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_None(IntPtr L)
	{
		try
		{
			ToLua.Push(L, PlayableBinding.None);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_DefaultDuration(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushnumber(L, PlayableBinding.DefaultDuration);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_streamName(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string streamName = ((PlayableBinding)obj).streamName;
			LuaDLL.lua_pushstring(L, streamName);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index streamName on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_sourceObject(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UnityEngine.Object sourceObject = ((PlayableBinding)obj).sourceObject;
			ToLua.Push(L, sourceObject);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index sourceObject on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_outputTargetType(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Type outputTargetType = ((PlayableBinding)obj).outputTargetType;
			ToLua.Push(L, outputTargetType);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index outputTargetType on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_streamName(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PlayableBinding playableBinding = (PlayableBinding)obj;
			string streamName = ToLua.CheckString(L, 2);
			playableBinding.streamName = streamName;
			ToLua.SetBack(L, 1, playableBinding);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index streamName on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_sourceObject(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PlayableBinding playableBinding = (PlayableBinding)obj;
			UnityEngine.Object sourceObject = (UnityEngine.Object)ToLua.CheckObject<UnityEngine.Object>(L, 2);
			playableBinding.sourceObject = sourceObject;
			ToLua.SetBack(L, 1, playableBinding);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index sourceObject on a nil value");
		}
	}
}
