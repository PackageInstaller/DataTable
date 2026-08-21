using System;
using LuaInterface;
using UnityEngine;

public class UnityEngine_SystemLanguageWrap
{
	public static void Register(LuaState L)
	{
		L.BeginEnum(typeof(SystemLanguage));
		L.RegVar("Afrikaans", get_Afrikaans, null);
		L.RegVar("Arabic", get_Arabic, null);
		L.RegVar("Basque", get_Basque, null);
		L.RegVar("Belarusian", get_Belarusian, null);
		L.RegVar("Bulgarian", get_Bulgarian, null);
		L.RegVar("Catalan", get_Catalan, null);
		L.RegVar("Chinese", get_Chinese, null);
		L.RegVar("Czech", get_Czech, null);
		L.RegVar("Danish", get_Danish, null);
		L.RegVar("Dutch", get_Dutch, null);
		L.RegVar("English", get_English, null);
		L.RegVar("Estonian", get_Estonian, null);
		L.RegVar("Faroese", get_Faroese, null);
		L.RegVar("Finnish", get_Finnish, null);
		L.RegVar("French", get_French, null);
		L.RegVar("German", get_German, null);
		L.RegVar("Greek", get_Greek, null);
		L.RegVar("Hebrew", get_Hebrew, null);
		L.RegVar("Icelandic", get_Icelandic, null);
		L.RegVar("Indonesian", get_Indonesian, null);
		L.RegVar("Italian", get_Italian, null);
		L.RegVar("Japanese", get_Japanese, null);
		L.RegVar("Korean", get_Korean, null);
		L.RegVar("Latvian", get_Latvian, null);
		L.RegVar("Lithuanian", get_Lithuanian, null);
		L.RegVar("Norwegian", get_Norwegian, null);
		L.RegVar("Polish", get_Polish, null);
		L.RegVar("Portuguese", get_Portuguese, null);
		L.RegVar("Romanian", get_Romanian, null);
		L.RegVar("Russian", get_Russian, null);
		L.RegVar("SerboCroatian", get_SerboCroatian, null);
		L.RegVar("Slovak", get_Slovak, null);
		L.RegVar("Slovenian", get_Slovenian, null);
		L.RegVar("Spanish", get_Spanish, null);
		L.RegVar("Swedish", get_Swedish, null);
		L.RegVar("Thai", get_Thai, null);
		L.RegVar("Turkish", get_Turkish, null);
		L.RegVar("Ukrainian", get_Ukrainian, null);
		L.RegVar("Vietnamese", get_Vietnamese, null);
		L.RegVar("ChineseSimplified", get_ChineseSimplified, null);
		L.RegVar("ChineseTraditional", get_ChineseTraditional, null);
		L.RegVar("Unknown", get_Unknown, null);
		L.RegVar("Hungarian", get_Hungarian, null);
		L.RegFunction("IntToEnum", IntToEnum);
		L.EndEnum();
		TypeTraits<SystemLanguage>.Check = CheckType;
		StackTraits<SystemLanguage>.Push = Push;
	}

	private static void Push(IntPtr L, SystemLanguage arg)
	{
		ToLua.Push(L, arg);
	}

	private static bool CheckType(IntPtr L, int pos)
	{
		return TypeChecker.CheckEnumType(typeof(SystemLanguage), L, pos);
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Afrikaans(IntPtr L)
	{
		ToLua.Push(L, SystemLanguage.Afrikaans);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Arabic(IntPtr L)
	{
		ToLua.Push(L, SystemLanguage.Arabic);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Basque(IntPtr L)
	{
		ToLua.Push(L, SystemLanguage.Basque);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Belarusian(IntPtr L)
	{
		ToLua.Push(L, SystemLanguage.Belarusian);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Bulgarian(IntPtr L)
	{
		ToLua.Push(L, SystemLanguage.Bulgarian);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Catalan(IntPtr L)
	{
		ToLua.Push(L, SystemLanguage.Catalan);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Chinese(IntPtr L)
	{
		ToLua.Push(L, SystemLanguage.Chinese);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Czech(IntPtr L)
	{
		ToLua.Push(L, SystemLanguage.Czech);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Danish(IntPtr L)
	{
		ToLua.Push(L, SystemLanguage.Danish);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Dutch(IntPtr L)
	{
		ToLua.Push(L, SystemLanguage.Dutch);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_English(IntPtr L)
	{
		ToLua.Push(L, SystemLanguage.English);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Estonian(IntPtr L)
	{
		ToLua.Push(L, SystemLanguage.Estonian);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Faroese(IntPtr L)
	{
		ToLua.Push(L, SystemLanguage.Faroese);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Finnish(IntPtr L)
	{
		ToLua.Push(L, SystemLanguage.Finnish);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_French(IntPtr L)
	{
		ToLua.Push(L, SystemLanguage.French);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_German(IntPtr L)
	{
		ToLua.Push(L, SystemLanguage.German);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Greek(IntPtr L)
	{
		ToLua.Push(L, SystemLanguage.Greek);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Hebrew(IntPtr L)
	{
		ToLua.Push(L, SystemLanguage.Hebrew);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Icelandic(IntPtr L)
	{
		ToLua.Push(L, SystemLanguage.Icelandic);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Indonesian(IntPtr L)
	{
		ToLua.Push(L, SystemLanguage.Indonesian);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Italian(IntPtr L)
	{
		ToLua.Push(L, SystemLanguage.Italian);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Japanese(IntPtr L)
	{
		ToLua.Push(L, SystemLanguage.Japanese);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Korean(IntPtr L)
	{
		ToLua.Push(L, SystemLanguage.Korean);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Latvian(IntPtr L)
	{
		ToLua.Push(L, SystemLanguage.Latvian);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Lithuanian(IntPtr L)
	{
		ToLua.Push(L, SystemLanguage.Lithuanian);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Norwegian(IntPtr L)
	{
		ToLua.Push(L, SystemLanguage.Norwegian);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Polish(IntPtr L)
	{
		ToLua.Push(L, SystemLanguage.Polish);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Portuguese(IntPtr L)
	{
		ToLua.Push(L, SystemLanguage.Portuguese);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Romanian(IntPtr L)
	{
		ToLua.Push(L, SystemLanguage.Romanian);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Russian(IntPtr L)
	{
		ToLua.Push(L, SystemLanguage.Russian);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_SerboCroatian(IntPtr L)
	{
		ToLua.Push(L, SystemLanguage.SerboCroatian);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Slovak(IntPtr L)
	{
		ToLua.Push(L, SystemLanguage.Slovak);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Slovenian(IntPtr L)
	{
		ToLua.Push(L, SystemLanguage.Slovenian);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Spanish(IntPtr L)
	{
		ToLua.Push(L, SystemLanguage.Spanish);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Swedish(IntPtr L)
	{
		ToLua.Push(L, SystemLanguage.Swedish);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Thai(IntPtr L)
	{
		ToLua.Push(L, SystemLanguage.Thai);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Turkish(IntPtr L)
	{
		ToLua.Push(L, SystemLanguage.Turkish);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Ukrainian(IntPtr L)
	{
		ToLua.Push(L, SystemLanguage.Ukrainian);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Vietnamese(IntPtr L)
	{
		ToLua.Push(L, SystemLanguage.Vietnamese);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_ChineseSimplified(IntPtr L)
	{
		ToLua.Push(L, SystemLanguage.ChineseSimplified);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_ChineseTraditional(IntPtr L)
	{
		ToLua.Push(L, SystemLanguage.ChineseTraditional);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Unknown(IntPtr L)
	{
		ToLua.Push(L, SystemLanguage.Unknown);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Hungarian(IntPtr L)
	{
		ToLua.Push(L, SystemLanguage.Hungarian);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IntToEnum(IntPtr L)
	{
		SystemLanguage systemLanguage = (SystemLanguage)LuaDLL.lua_tonumber(L, 1);
		ToLua.Push(L, systemLanguage);
		return 1;
	}
}
