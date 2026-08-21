using System;
using CriMana;
using LuaInterface;

public class CriMana_Player_SetModeWrap
{
	public static void Register(LuaState L)
	{
		L.BeginEnum(typeof(Player.SetMode));
		L.RegVar("New", get_New, null);
		L.RegVar("Append", get_Append, null);
		L.RegVar("AppendRepeatedly", get_AppendRepeatedly, null);
		L.RegFunction("IntToEnum", IntToEnum);
		L.EndEnum();
		TypeTraits<Player.SetMode>.Check = CheckType;
		StackTraits<Player.SetMode>.Push = Push;
	}

	private static void Push(IntPtr L, Player.SetMode arg)
	{
		ToLua.Push(L, arg);
	}

	private static bool CheckType(IntPtr L, int pos)
	{
		return TypeChecker.CheckEnumType(typeof(Player.SetMode), L, pos);
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_New(IntPtr L)
	{
		ToLua.Push(L, Player.SetMode.New);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Append(IntPtr L)
	{
		ToLua.Push(L, Player.SetMode.Append);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_AppendRepeatedly(IntPtr L)
	{
		ToLua.Push(L, Player.SetMode.AppendRepeatedly);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IntToEnum(IntPtr L)
	{
		Player.SetMode setMode = (Player.SetMode)LuaDLL.lua_tonumber(L, 1);
		ToLua.Push(L, setMode);
		return 1;
	}
}
