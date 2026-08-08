using System;
using LuaInterface;
using UnityEngine.Playables;

public class UnityEngine_Playables_DirectorWrapModeWrap
{
	public static void Register(LuaState L)
	{
		L.BeginEnum(typeof(DirectorWrapMode));
		L.RegVar("Hold", get_Hold, null);
		L.RegVar("Loop", get_Loop, null);
		L.RegVar("None", get_None, null);
		L.RegFunction("IntToEnum", IntToEnum);
		L.EndEnum();
		TypeTraits<DirectorWrapMode>.Check = CheckType;
		StackTraits<DirectorWrapMode>.Push = Push;
	}

	private static void Push(IntPtr L, DirectorWrapMode arg)
	{
		ToLua.Push(L, arg);
	}

	private static bool CheckType(IntPtr L, int pos)
	{
		return TypeChecker.CheckEnumType(typeof(DirectorWrapMode), L, pos);
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Hold(IntPtr L)
	{
		ToLua.Push(L, DirectorWrapMode.Hold);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Loop(IntPtr L)
	{
		ToLua.Push(L, DirectorWrapMode.Loop);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_None(IntPtr L)
	{
		ToLua.Push(L, DirectorWrapMode.None);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IntToEnum(IntPtr L)
	{
		DirectorWrapMode directorWrapMode = (DirectorWrapMode)LuaDLL.lua_tonumber(L, 1);
		ToLua.Push(L, directorWrapMode);
		return 1;
	}
}
