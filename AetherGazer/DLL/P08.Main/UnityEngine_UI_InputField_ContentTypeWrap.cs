using System;
using LuaInterface;
using UnityEngine.UI;

public class UnityEngine_UI_InputField_ContentTypeWrap
{
	public static void Register(LuaState L)
	{
		L.BeginEnum(typeof(InputField.ContentType));
		L.RegVar("Standard", get_Standard, null);
		L.RegVar("Autocorrected", get_Autocorrected, null);
		L.RegVar("IntegerNumber", get_IntegerNumber, null);
		L.RegVar("DecimalNumber", get_DecimalNumber, null);
		L.RegVar("Alphanumeric", get_Alphanumeric, null);
		L.RegVar("Name", get_Name, null);
		L.RegVar("EmailAddress", get_EmailAddress, null);
		L.RegVar("Password", get_Password, null);
		L.RegVar("Pin", get_Pin, null);
		L.RegVar("Custom", get_Custom, null);
		L.RegFunction("IntToEnum", IntToEnum);
		L.EndEnum();
		TypeTraits<InputField.ContentType>.Check = CheckType;
		StackTraits<InputField.ContentType>.Push = Push;
	}

	private static void Push(IntPtr L, InputField.ContentType arg)
	{
		ToLua.Push(L, arg);
	}

	private static bool CheckType(IntPtr L, int pos)
	{
		return TypeChecker.CheckEnumType(typeof(InputField.ContentType), L, pos);
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Standard(IntPtr L)
	{
		ToLua.Push(L, InputField.ContentType.Standard);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Autocorrected(IntPtr L)
	{
		ToLua.Push(L, InputField.ContentType.Autocorrected);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_IntegerNumber(IntPtr L)
	{
		ToLua.Push(L, InputField.ContentType.IntegerNumber);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_DecimalNumber(IntPtr L)
	{
		ToLua.Push(L, InputField.ContentType.DecimalNumber);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Alphanumeric(IntPtr L)
	{
		ToLua.Push(L, InputField.ContentType.Alphanumeric);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Name(IntPtr L)
	{
		ToLua.Push(L, InputField.ContentType.Name);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_EmailAddress(IntPtr L)
	{
		ToLua.Push(L, InputField.ContentType.EmailAddress);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Password(IntPtr L)
	{
		ToLua.Push(L, InputField.ContentType.Password);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Pin(IntPtr L)
	{
		ToLua.Push(L, InputField.ContentType.Pin);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Custom(IntPtr L)
	{
		ToLua.Push(L, InputField.ContentType.Custom);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IntToEnum(IntPtr L)
	{
		InputField.ContentType contentType = (InputField.ContentType)LuaDLL.lua_tonumber(L, 1);
		ToLua.Push(L, contentType);
		return 1;
	}
}
