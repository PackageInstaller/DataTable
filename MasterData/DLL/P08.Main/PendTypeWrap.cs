using System;
using LuaInterface;

public class PendTypeWrap
{
	public static void Register(LuaState L)
	{
		L.BeginEnum(typeof(PendType));
		L.RegVar("Package", get_Package, null);
		L.RegVar("SingleAsset", get_SingleAsset, null);
		L.RegVar("SingleVoice", get_SingleVoice, null);
		L.RegFunction("IntToEnum", IntToEnum);
		L.EndEnum();
		TypeTraits<PendType>.Check = CheckType;
		StackTraits<PendType>.Push = Push;
	}

	private static void Push(IntPtr L, PendType arg)
	{
		ToLua.Push(L, arg);
	}

	private static bool CheckType(IntPtr L, int pos)
	{
		return TypeChecker.CheckEnumType(typeof(PendType), L, pos);
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Package(IntPtr L)
	{
		ToLua.Push(L, PendType.Package);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_SingleAsset(IntPtr L)
	{
		ToLua.Push(L, PendType.SingleAsset);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_SingleVoice(IntPtr L)
	{
		ToLua.Push(L, PendType.SingleVoice);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IntToEnum(IntPtr L)
	{
		PendType pendType = (PendType)LuaDLL.lua_tonumber(L, 1);
		ToLua.Push(L, pendType);
		return 1;
	}
}
