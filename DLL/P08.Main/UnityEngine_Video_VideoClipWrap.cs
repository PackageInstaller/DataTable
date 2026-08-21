using System;
using LuaInterface;
using UnityEngine;
using UnityEngine.Video;

public class UnityEngine_Video_VideoClipWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(VideoClip), typeof(UnityEngine.Object));
		L.RegFunction("GetAudioChannelCount", GetAudioChannelCount);
		L.RegFunction("GetAudioSampleRate", GetAudioSampleRate);
		L.RegFunction("GetAudioLanguage", GetAudioLanguage);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("originalPath", get_originalPath, null);
		L.RegVar("frameCount", get_frameCount, null);
		L.RegVar("frameRate", get_frameRate, null);
		L.RegVar("length", get_length, null);
		L.RegVar("width", get_width, null);
		L.RegVar("height", get_height, null);
		L.RegVar("pixelAspectRatioNumerator", get_pixelAspectRatioNumerator, null);
		L.RegVar("pixelAspectRatioDenominator", get_pixelAspectRatioDenominator, null);
		L.RegVar("audioTrackCount", get_audioTrackCount, null);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetAudioChannelCount(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			VideoClip obj = (VideoClip)ToLua.CheckObject(L, 1, typeof(VideoClip));
			ushort audioTrackIdx = (ushort)LuaDLL.luaL_checknumber(L, 2);
			ushort audioChannelCount = obj.GetAudioChannelCount(audioTrackIdx);
			LuaDLL.lua_pushnumber(L, (int)audioChannelCount);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetAudioSampleRate(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			VideoClip obj = (VideoClip)ToLua.CheckObject(L, 1, typeof(VideoClip));
			ushort audioTrackIdx = (ushort)LuaDLL.luaL_checknumber(L, 2);
			uint audioSampleRate = obj.GetAudioSampleRate(audioTrackIdx);
			LuaDLL.lua_pushnumber(L, audioSampleRate);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetAudioLanguage(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			VideoClip obj = (VideoClip)ToLua.CheckObject(L, 1, typeof(VideoClip));
			ushort audioTrackIdx = (ushort)LuaDLL.luaL_checknumber(L, 2);
			string audioLanguage = obj.GetAudioLanguage(audioTrackIdx);
			LuaDLL.lua_pushstring(L, audioLanguage);
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
	private static int get_originalPath(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string originalPath = ((VideoClip)obj).originalPath;
			LuaDLL.lua_pushstring(L, originalPath);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index originalPath on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_frameCount(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ulong frameCount = ((VideoClip)obj).frameCount;
			LuaDLL.tolua_pushuint64(L, frameCount);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index frameCount on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_frameRate(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			double frameRate = ((VideoClip)obj).frameRate;
			LuaDLL.lua_pushnumber(L, frameRate);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index frameRate on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_length(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			double length = ((VideoClip)obj).length;
			LuaDLL.lua_pushnumber(L, length);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index length on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_width(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			uint width = ((VideoClip)obj).width;
			LuaDLL.lua_pushnumber(L, width);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index width on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_height(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			uint height = ((VideoClip)obj).height;
			LuaDLL.lua_pushnumber(L, height);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index height on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_pixelAspectRatioNumerator(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			uint pixelAspectRatioNumerator = ((VideoClip)obj).pixelAspectRatioNumerator;
			LuaDLL.lua_pushnumber(L, pixelAspectRatioNumerator);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index pixelAspectRatioNumerator on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_pixelAspectRatioDenominator(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			uint pixelAspectRatioDenominator = ((VideoClip)obj).pixelAspectRatioDenominator;
			LuaDLL.lua_pushnumber(L, pixelAspectRatioDenominator);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index pixelAspectRatioDenominator on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_audioTrackCount(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ushort audioTrackCount = ((VideoClip)obj).audioTrackCount;
			LuaDLL.lua_pushnumber(L, (int)audioTrackCount);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index audioTrackCount on a nil value");
		}
	}
}
