using System;
using System.IO;
using LuaInterface;

public class System_IO_SeekOriginWrap
{
	public static void Register(LuaState L)
	{
		L.BeginEnum(typeof(SeekOrigin));
		L.RegVar("Begin", get_Begin, null);
		L.RegVar("Current", get_Current, null);
		L.RegVar("End", get_End, null);
		L.RegFunction("IntToEnum", IntToEnum);
		L.EndEnum();
		TypeTraits<SeekOrigin>.Check = CheckType;
		StackTraits<SeekOrigin>.Push = Push;
	}

	private static void Push(IntPtr L, SeekOrigin arg)
	{
		ToLua.Push(L, arg);
	}

	private static bool CheckType(IntPtr L, int pos)
	{
		return TypeChecker.CheckEnumType(typeof(SeekOrigin), L, pos);
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Begin(IntPtr L)
	{
		ToLua.Push(L, SeekOrigin.Begin);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Current(IntPtr L)
	{
		ToLua.Push(L, SeekOrigin.Current);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_End(IntPtr L)
	{
		ToLua.Push(L, SeekOrigin.End);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IntToEnum(IntPtr L)
	{
		SeekOrigin seekOrigin = (SeekOrigin)LuaDLL.lua_tonumber(L, 1);
		ToLua.Push(L, seekOrigin);
		return 1;
	}
}
