using System;
using LuaInterface;
using UnityEngine;

public class UnityEngine_AudioClipWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(AudioClip), typeof(UnityEngine.Object));
		L.RegFunction("LoadAudioData", LoadAudioData);
		L.RegFunction("UnloadAudioData", UnloadAudioData);
		L.RegFunction("GetData", GetData);
		L.RegFunction("SetData", SetData);
		L.RegFunction("Create", Create);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("length", get_length, null);
		L.RegVar("samples", get_samples, null);
		L.RegVar("channels", get_channels, null);
		L.RegVar("frequency", get_frequency, null);
		L.RegVar("loadType", get_loadType, null);
		L.RegVar("preloadAudioData", get_preloadAudioData, null);
		L.RegVar("ambisonic", get_ambisonic, null);
		L.RegVar("loadState", get_loadState, null);
		L.RegVar("loadInBackground", get_loadInBackground, null);
		L.RegFunction("PCMReaderCallback", UnityEngine_AudioClip_PCMReaderCallback);
		L.RegFunction("PCMSetPositionCallback", UnityEngine_AudioClip_PCMSetPositionCallback);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LoadAudioData(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = ((AudioClip)ToLua.CheckObject(L, 1, typeof(AudioClip))).LoadAudioData();
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UnloadAudioData(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = ((AudioClip)ToLua.CheckObject(L, 1, typeof(AudioClip))).UnloadAudioData();
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetData(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			AudioClip obj = (AudioClip)ToLua.CheckObject(L, 1, typeof(AudioClip));
			float[] data = ToLua.CheckNumberArray<float>(L, 2);
			int offsetSamples = (int)LuaDLL.luaL_checknumber(L, 3);
			bool data2 = obj.GetData(data, offsetSamples);
			LuaDLL.lua_pushboolean(L, data2);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetData(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			AudioClip obj = (AudioClip)ToLua.CheckObject(L, 1, typeof(AudioClip));
			float[] data = ToLua.CheckNumberArray<float>(L, 2);
			int offsetSamples = (int)LuaDLL.luaL_checknumber(L, 3);
			bool value = obj.SetData(data, offsetSamples);
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Create(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 5:
			{
				string name3 = ToLua.CheckString(L, 1);
				int lengthSamples3 = (int)LuaDLL.luaL_checknumber(L, 2);
				int channels3 = (int)LuaDLL.luaL_checknumber(L, 3);
				int frequency3 = (int)LuaDLL.luaL_checknumber(L, 4);
				bool stream3 = LuaDLL.luaL_checkboolean(L, 5);
				AudioClip o3 = AudioClip.Create(name3, lengthSamples3, channels3, frequency3, stream3);
				ToLua.PushSealed(L, o3);
				return 1;
			}
			case 6:
			{
				string name2 = ToLua.CheckString(L, 1);
				int lengthSamples2 = (int)LuaDLL.luaL_checknumber(L, 2);
				int channels2 = (int)LuaDLL.luaL_checknumber(L, 3);
				int frequency2 = (int)LuaDLL.luaL_checknumber(L, 4);
				bool stream2 = LuaDLL.luaL_checkboolean(L, 5);
				AudioClip.PCMReaderCallback pcmreadercallback2 = (AudioClip.PCMReaderCallback)ToLua.CheckDelegate<AudioClip.PCMReaderCallback>(L, 6);
				AudioClip o2 = AudioClip.Create(name2, lengthSamples2, channels2, frequency2, stream2, pcmreadercallback2);
				ToLua.PushSealed(L, o2);
				return 1;
			}
			case 7:
			{
				string name = ToLua.CheckString(L, 1);
				int lengthSamples = (int)LuaDLL.luaL_checknumber(L, 2);
				int channels = (int)LuaDLL.luaL_checknumber(L, 3);
				int frequency = (int)LuaDLL.luaL_checknumber(L, 4);
				bool stream = LuaDLL.luaL_checkboolean(L, 5);
				AudioClip.PCMReaderCallback pcmreadercallback = (AudioClip.PCMReaderCallback)ToLua.CheckDelegate<AudioClip.PCMReaderCallback>(L, 6);
				AudioClip.PCMSetPositionCallback pcmsetpositioncallback = (AudioClip.PCMSetPositionCallback)ToLua.CheckDelegate<AudioClip.PCMSetPositionCallback>(L, 7);
				AudioClip o = AudioClip.Create(name, lengthSamples, channels, frequency, stream, pcmreadercallback, pcmsetpositioncallback);
				ToLua.PushSealed(L, o);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.AudioClip.Create");
			}
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
			float length = ((AudioClip)obj).length;
			LuaDLL.lua_pushnumber(L, length);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index length on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_samples(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int samples = ((AudioClip)obj).samples;
			LuaDLL.lua_pushinteger(L, samples);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index samples on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_channels(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int channels = ((AudioClip)obj).channels;
			LuaDLL.lua_pushinteger(L, channels);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index channels on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_frequency(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int frequency = ((AudioClip)obj).frequency;
			LuaDLL.lua_pushinteger(L, frequency);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index frequency on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_loadType(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			AudioClipLoadType loadType = ((AudioClip)obj).loadType;
			ToLua.Push(L, loadType);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index loadType on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_preloadAudioData(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool preloadAudioData = ((AudioClip)obj).preloadAudioData;
			LuaDLL.lua_pushboolean(L, preloadAudioData);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index preloadAudioData on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_ambisonic(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool ambisonic = ((AudioClip)obj).ambisonic;
			LuaDLL.lua_pushboolean(L, ambisonic);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index ambisonic on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_loadState(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			AudioDataLoadState loadState = ((AudioClip)obj).loadState;
			ToLua.Push(L, loadState);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index loadState on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_loadInBackground(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool loadInBackground = ((AudioClip)obj).loadInBackground;
			LuaDLL.lua_pushboolean(L, loadInBackground);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index loadInBackground on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UnityEngine_AudioClip_PCMReaderCallback(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<AudioClip.PCMReaderCallback>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<AudioClip.PCMReaderCallback>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UnityEngine_AudioClip_PCMSetPositionCallback(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<AudioClip.PCMSetPositionCallback>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<AudioClip.PCMSetPositionCallback>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
