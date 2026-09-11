using System;
using LuaInterface;
using UnityEngine;

public class UnityEngine_AudioListenerWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(AudioListener), typeof(AudioBehaviour));
		L.RegFunction("GetOutputData", GetOutputData);
		L.RegFunction("GetSpectrumData", GetSpectrumData);
		L.RegFunction("New", _CreateUnityEngine_AudioListener);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("volume", get_volume, set_volume);
		L.RegVar("pause", get_pause, set_pause);
		L.RegVar("velocityUpdateMode", get_velocityUpdateMode, set_velocityUpdateMode);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateUnityEngine_AudioListener(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				AudioListener o = new AudioListener();
				ToLua.PushSealed(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: UnityEngine.AudioListener.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetOutputData(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			float[] samples = ToLua.CheckNumberArray<float>(L, 1);
			int channel = (int)LuaDLL.luaL_checknumber(L, 2);
			AudioListener.GetOutputData(samples, channel);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetSpectrumData(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			float[] samples = ToLua.CheckNumberArray<float>(L, 1);
			int channel = (int)LuaDLL.luaL_checknumber(L, 2);
			FFTWindow window = (FFTWindow)ToLua.CheckObject(L, 3, typeof(FFTWindow));
			AudioListener.GetSpectrumData(samples, channel, window);
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
	private static int get_volume(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushnumber(L, AudioListener.volume);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_pause(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, AudioListener.pause);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_velocityUpdateMode(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			AudioVelocityUpdateMode velocityUpdateMode = ((AudioListener)obj).velocityUpdateMode;
			ToLua.Push(L, velocityUpdateMode);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index velocityUpdateMode on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_volume(IntPtr L)
	{
		try
		{
			AudioListener.volume = (float)LuaDLL.luaL_checknumber(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_pause(IntPtr L)
	{
		try
		{
			AudioListener.pause = LuaDLL.luaL_checkboolean(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_velocityUpdateMode(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			AudioListener obj2 = (AudioListener)obj;
			AudioVelocityUpdateMode velocityUpdateMode = (AudioVelocityUpdateMode)ToLua.CheckObject(L, 2, typeof(AudioVelocityUpdateMode));
			obj2.velocityUpdateMode = velocityUpdateMode;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index velocityUpdateMode on a nil value");
		}
	}
}
