using System;
using LuaInterface;
using UnityEngine;

public class ScreenShotWrap
{
	public static void Register(LuaState L)
	{
		L.BeginStaticLibs("ScreenShot");
		L.RegFunction("GetReady", GetReady);
		L.RegFunction("Initialize", Initialize);
		L.RegFunction("GetScreenSprite", GetScreenSprite);
		L.RegFunction("StartScreenShot", StartScreenShot);
		L.RegVar("cutTool", get_cutTool, set_cutTool);
		L.EndStaticLibs();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetReady(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			bool ready = ScreenShot.GetReady();
			LuaDLL.lua_pushboolean(L, ready);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Initialize(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			ScreenShot.Initialize();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetScreenSprite(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			Sprite screenSprite = ScreenShot.GetScreenSprite();
			ToLua.PushSealed(L, screenSprite);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int StartScreenShot(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			ScreenShot.StartScreenShot((Action)ToLua.CheckDelegate<Action>(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_cutTool(IntPtr L)
	{
		try
		{
			ToLua.Push(L, ScreenShot.cutTool);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_cutTool(IntPtr L)
	{
		try
		{
			ScreenShot.cutTool = (CutPicture)ToLua.CheckObject<CutPicture>(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
