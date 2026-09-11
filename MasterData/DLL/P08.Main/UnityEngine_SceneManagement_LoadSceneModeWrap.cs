using System;
using LuaInterface;
using UnityEngine.SceneManagement;

public class UnityEngine_SceneManagement_LoadSceneModeWrap
{
	public static void Register(LuaState L)
	{
		L.BeginEnum(typeof(LoadSceneMode));
		L.RegVar("Single", get_Single, null);
		L.RegVar("Additive", get_Additive, null);
		L.RegFunction("IntToEnum", IntToEnum);
		L.EndEnum();
		TypeTraits<LoadSceneMode>.Check = CheckType;
		StackTraits<LoadSceneMode>.Push = Push;
	}

	private static void Push(IntPtr L, LoadSceneMode arg)
	{
		ToLua.Push(L, arg);
	}

	private static bool CheckType(IntPtr L, int pos)
	{
		return TypeChecker.CheckEnumType(typeof(LoadSceneMode), L, pos);
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Single(IntPtr L)
	{
		ToLua.Push(L, LoadSceneMode.Single);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Additive(IntPtr L)
	{
		ToLua.Push(L, LoadSceneMode.Additive);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IntToEnum(IntPtr L)
	{
		LoadSceneMode loadSceneMode = (LoadSceneMode)LuaDLL.lua_tonumber(L, 1);
		ToLua.Push(L, loadSceneMode);
		return 1;
	}
}
