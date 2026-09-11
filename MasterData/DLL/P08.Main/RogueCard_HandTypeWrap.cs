using System;
using LuaInterface;
using RogueCard;

public class RogueCard_HandTypeWrap
{
	public static void Register(LuaState L)
	{
		L.BeginEnum(typeof(HandType));
		L.RegVar("StraightFlush", get_StraightFlush, null);
		L.RegVar("Bomb", get_Bomb, null);
		L.RegVar("Flush", get_Flush, null);
		L.RegVar("Straight", get_Straight, null);
		L.RegVar("Pair", get_Pair, null);
		L.RegVar("HighCard", get_HighCard, null);
		L.RegFunction("IntToEnum", IntToEnum);
		L.EndEnum();
		TypeTraits<HandType>.Check = CheckType;
		StackTraits<HandType>.Push = Push;
	}

	private static void Push(IntPtr L, HandType arg)
	{
		ToLua.Push(L, arg);
	}

	private static bool CheckType(IntPtr L, int pos)
	{
		return TypeChecker.CheckEnumType(typeof(HandType), L, pos);
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_StraightFlush(IntPtr L)
	{
		ToLua.Push(L, HandType.StraightFlush);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Bomb(IntPtr L)
	{
		ToLua.Push(L, HandType.Bomb);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Flush(IntPtr L)
	{
		ToLua.Push(L, HandType.Flush);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Straight(IntPtr L)
	{
		ToLua.Push(L, HandType.Straight);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Pair(IntPtr L)
	{
		ToLua.Push(L, HandType.Pair);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_HighCard(IntPtr L)
	{
		ToLua.Push(L, HandType.HighCard);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IntToEnum(IntPtr L)
	{
		HandType handType = (HandType)LuaDLL.lua_tonumber(L, 1);
		ToLua.Push(L, handType);
		return 1;
	}
}
