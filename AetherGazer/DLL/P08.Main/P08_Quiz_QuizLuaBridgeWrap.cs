using System;
using LuaInterface;
using P08.Quiz;
using UnityEngine;

public class P08_Quiz_QuizLuaBridgeWrap
{
	public static void Register(LuaState L)
	{
		L.BeginStaticLibs("QuizLuaBridge");
		L.RegFunction("Launcher", Launcher);
		L.RegFunction("InitJoystick", InitJoystick);
		L.RegVar("OnQuizPlayerModelChanged", get_OnQuizPlayerModelChanged, set_OnQuizPlayerModelChanged);
		L.RegVar("OnQuizPlayerGestureChanged", get_OnQuizPlayerGestureChanged, set_OnQuizPlayerGestureChanged);
		L.EndStaticLibs();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Launcher(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			QuizLuaBridge.Launcher((QuizDataForExchange)ToLua.CheckObject<QuizDataForExchange>(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int InitJoystick(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			QuizLuaBridge.InitJoystick((GameObject)ToLua.CheckObject(L, 1, typeof(GameObject)));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_OnQuizPlayerModelChanged(IntPtr L)
	{
		try
		{
			ToLua.Push(L, QuizLuaBridge.OnQuizPlayerModelChanged);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_OnQuizPlayerGestureChanged(IntPtr L)
	{
		try
		{
			ToLua.Push(L, QuizLuaBridge.OnQuizPlayerGestureChanged);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_OnQuizPlayerModelChanged(IntPtr L)
	{
		try
		{
			QuizLuaBridge.OnQuizPlayerModelChanged = (Action<long, int, int>)ToLua.CheckDelegate<Action<long, int, int>>(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_OnQuizPlayerGestureChanged(IntPtr L)
	{
		try
		{
			QuizLuaBridge.OnQuizPlayerGestureChanged = (Action<long, int>)ToLua.CheckDelegate<Action<long, int>>(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
