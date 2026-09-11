using System;
using LuaInterface;

public class CriAtomEx_ResumeModeWrap
{
	public static void Register(LuaState L)
	{
		L.BeginEnum(typeof(CriAtomEx.ResumeMode));
		L.RegVar("AllPlayback", get_AllPlayback, null);
		L.RegVar("PausedPlayback", get_PausedPlayback, null);
		L.RegVar("PreparedPlayback", get_PreparedPlayback, null);
		L.RegFunction("IntToEnum", IntToEnum);
		L.EndEnum();
		TypeTraits<CriAtomEx.ResumeMode>.Check = CheckType;
		StackTraits<CriAtomEx.ResumeMode>.Push = Push;
	}

	private static void Push(IntPtr L, CriAtomEx.ResumeMode arg)
	{
		ToLua.Push(L, arg);
	}

	private static bool CheckType(IntPtr L, int pos)
	{
		return TypeChecker.CheckEnumType(typeof(CriAtomEx.ResumeMode), L, pos);
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_AllPlayback(IntPtr L)
	{
		ToLua.Push(L, CriAtomEx.ResumeMode.AllPlayback);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_PausedPlayback(IntPtr L)
	{
		ToLua.Push(L, CriAtomEx.ResumeMode.PausedPlayback);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_PreparedPlayback(IntPtr L)
	{
		ToLua.Push(L, CriAtomEx.ResumeMode.PreparedPlayback);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IntToEnum(IntPtr L)
	{
		CriAtomEx.ResumeMode resumeMode = (CriAtomEx.ResumeMode)LuaDLL.lua_tonumber(L, 1);
		ToLua.Push(L, resumeMode);
		return 1;
	}
}
