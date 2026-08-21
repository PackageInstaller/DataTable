using System;
using System.Collections;
using System.Globalization;
using System.Text;
using LuaInterface;

public class System_StringWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(string), typeof(object));
		L.RegFunction("Equals", Equals);
		L.RegFunction("Clone", Clone);
		L.RegFunction("GetTypeCode", GetTypeCode);
		L.RegFunction("CopyTo", CopyTo);
		L.RegFunction("ToCharArray", ToCharArray);
		L.RegFunction("Split", Split);
		L.RegFunction("Substring", Substring);
		L.RegFunction("Trim", Trim);
		L.RegFunction("TrimStart", TrimStart);
		L.RegFunction("TrimEnd", TrimEnd);
		L.RegFunction("Compare", Compare);
		L.RegFunction("CompareTo", CompareTo);
		L.RegFunction("CompareOrdinal", CompareOrdinal);
		L.RegFunction("EndsWith", EndsWith);
		L.RegFunction("IndexOfAny", IndexOfAny);
		L.RegFunction("IndexOf", IndexOf);
		L.RegFunction("LastIndexOf", LastIndexOf);
		L.RegFunction("LastIndexOfAny", LastIndexOfAny);
		L.RegFunction("Contains", Contains);
		L.RegFunction("IsNullOrEmpty", IsNullOrEmpty);
		L.RegFunction("Normalize", Normalize);
		L.RegFunction("IsNormalized", IsNormalized);
		L.RegFunction("Remove", Remove);
		L.RegFunction("PadLeft", PadLeft);
		L.RegFunction("PadRight", PadRight);
		L.RegFunction("StartsWith", StartsWith);
		L.RegFunction("Replace", Replace);
		L.RegFunction("ToLower", ToLower);
		L.RegFunction("ToLowerInvariant", ToLowerInvariant);
		L.RegFunction("ToUpper", ToUpper);
		L.RegFunction("ToUpperInvariant", ToUpperInvariant);
		L.RegFunction("ToString", ToString);
		L.RegFunction("Format", Format);
		L.RegFunction("Copy", Copy);
		L.RegFunction("Concat", Concat);
		L.RegFunction("Insert", Insert);
		L.RegFunction("Intern", Intern);
		L.RegFunction("IsInterned", IsInterned);
		L.RegFunction("Join", Join);
		L.RegFunction("GetEnumerator", GetEnumerator);
		L.RegFunction("GetHashCode", GetHashCode);
		L.RegFunction("New", _CreateSystem_String);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("Empty", get_Empty, null);
		L.RegVar("Length", get_Length, null);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateSystem_String(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_type(L, 1) == LuaTypes.LUA_TSTRING)
			{
				string o = LuaDLL.lua_tostring(L, 1);
				ToLua.PushSealed(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to string's ctor method");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Equals(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 2 && TypeChecker.CheckTypes<string>(L, 2))
			{
				string text = (string)ToLua.CheckObject(L, 1, typeof(string));
				string text2 = ToLua.ToString(L, 2);
				bool value = text?.Equals(text2) ?? (text2 == null);
				LuaDLL.lua_pushboolean(L, value);
				return 1;
			}
			if (num == 2 && TypeChecker.CheckTypes<object>(L, 2))
			{
				string text3 = (string)ToLua.CheckObject(L, 1, typeof(string));
				object obj = ToLua.ToVarObject(L, 2);
				bool value2 = text3?.Equals(obj) ?? (obj == null);
				LuaDLL.lua_pushboolean(L, value2);
				return 1;
			}
			if (num == 3)
			{
				string obj2 = (string)ToLua.CheckObject(L, 1, typeof(string));
				string value3 = ToLua.CheckString(L, 2);
				StringComparison comparisonType = (StringComparison)ToLua.CheckObject(L, 3, typeof(StringComparison));
				bool value4 = obj2.Equals(value3, comparisonType);
				LuaDLL.lua_pushboolean(L, value4);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: System.String.Equals");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Clone(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			object obj = ((string)ToLua.CheckObject(L, 1, typeof(string))).Clone();
			ToLua.Push(L, obj);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetTypeCode(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			TypeCode typeCode = ((string)ToLua.CheckObject(L, 1, typeof(string))).GetTypeCode();
			ToLua.Push(L, typeCode);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CopyTo(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 5);
			string obj = (string)ToLua.CheckObject(L, 1, typeof(string));
			int sourceIndex = (int)LuaDLL.luaL_checknumber(L, 2);
			char[] destination = ToLua.CheckCharBuffer(L, 3);
			int destinationIndex = (int)LuaDLL.luaL_checknumber(L, 4);
			int count = (int)LuaDLL.luaL_checknumber(L, 5);
			obj.CopyTo(sourceIndex, destination, destinationIndex, count);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ToCharArray(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
			{
				char[] array2 = ((string)ToLua.CheckObject(L, 1, typeof(string))).ToCharArray();
				ToLua.Push(L, array2);
				return 1;
			}
			case 3:
			{
				string obj = (string)ToLua.CheckObject(L, 1, typeof(string));
				int startIndex = (int)LuaDLL.luaL_checknumber(L, 2);
				int length = (int)LuaDLL.luaL_checknumber(L, 3);
				char[] array = obj.ToCharArray(startIndex, length);
				ToLua.Push(L, array);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: System.String.ToCharArray");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Split(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 3 && TypeChecker.CheckTypes<string, char[], StringSplitOptions>(L, 1))
			{
				string obj = (string)ToLua.ToObject(L, 1);
				char[] separator = ToLua.CheckCharBuffer(L, 2);
				StringSplitOptions options = (StringSplitOptions)ToLua.ToObject(L, 3);
				string[] array = obj.Split(separator, options);
				ToLua.Push(L, array);
				return 1;
			}
			if (num == 3 && TypeChecker.CheckTypes<string, char[], int>(L, 1))
			{
				string obj2 = (string)ToLua.ToObject(L, 1);
				char[] separator2 = ToLua.CheckCharBuffer(L, 2);
				int count = (int)LuaDLL.lua_tonumber(L, 3);
				string[] array2 = obj2.Split(separator2, count);
				ToLua.Push(L, array2);
				return 1;
			}
			if (num == 3 && TypeChecker.CheckTypes<string, string[], StringSplitOptions>(L, 1))
			{
				string obj3 = (string)ToLua.ToObject(L, 1);
				string[] separator3 = ToLua.ToStringArray(L, 2);
				StringSplitOptions options2 = (StringSplitOptions)ToLua.ToObject(L, 3);
				string[] array3 = obj3.Split(separator3, options2);
				ToLua.Push(L, array3);
				return 1;
			}
			if (num == 4 && TypeChecker.CheckTypes<string, string[], int, StringSplitOptions>(L, 1))
			{
				string obj4 = (string)ToLua.ToObject(L, 1);
				string[] separator4 = ToLua.ToStringArray(L, 2);
				int count2 = (int)LuaDLL.lua_tonumber(L, 3);
				StringSplitOptions options3 = (StringSplitOptions)ToLua.ToObject(L, 4);
				string[] array4 = obj4.Split(separator4, count2, options3);
				ToLua.Push(L, array4);
				return 1;
			}
			if (num == 4 && TypeChecker.CheckTypes<string, char[], int, StringSplitOptions>(L, 1))
			{
				string obj5 = (string)ToLua.ToObject(L, 1);
				char[] separator5 = ToLua.CheckCharBuffer(L, 2);
				int count3 = (int)LuaDLL.lua_tonumber(L, 3);
				StringSplitOptions options4 = (StringSplitOptions)ToLua.ToObject(L, 4);
				string[] array5 = obj5.Split(separator5, count3, options4);
				ToLua.Push(L, array5);
				return 1;
			}
			if (TypeChecker.CheckTypes<string>(L, 1) && TypeChecker.CheckParamsType<char>(L, 2, num - 1))
			{
				string obj6 = (string)ToLua.ToObject(L, 1);
				char[] separator6 = ToLua.ToParamsChar(L, 2, num - 1);
				string[] array6 = obj6.Split(separator6);
				ToLua.Push(L, array6);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: System.String.Split");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Substring(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				string obj2 = (string)ToLua.CheckObject(L, 1, typeof(string));
				int startIndex2 = (int)LuaDLL.luaL_checknumber(L, 2);
				string str2 = obj2.Substring(startIndex2);
				LuaDLL.lua_pushstring(L, str2);
				return 1;
			}
			case 3:
			{
				string obj = (string)ToLua.CheckObject(L, 1, typeof(string));
				int startIndex = (int)LuaDLL.luaL_checknumber(L, 2);
				int length = (int)LuaDLL.luaL_checknumber(L, 3);
				string str = obj.Substring(startIndex, length);
				LuaDLL.lua_pushstring(L, str);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: System.String.Substring");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Trim(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 1 && TypeChecker.CheckTypes<string>(L, 1))
			{
				string str = ((string)ToLua.ToObject(L, 1)).Trim();
				LuaDLL.lua_pushstring(L, str);
				return 1;
			}
			if (TypeChecker.CheckTypes<string>(L, 1) && TypeChecker.CheckParamsType<char>(L, 2, num - 1))
			{
				string obj = (string)ToLua.ToObject(L, 1);
				char[] trimChars = ToLua.ToParamsChar(L, 2, num - 1);
				string str2 = obj.Trim(trimChars);
				LuaDLL.lua_pushstring(L, str2);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: System.String.Trim");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int TrimStart(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			string obj = (string)ToLua.CheckObject(L, 1, typeof(string));
			char[] trimChars = ToLua.CheckParamsChar(L, 2, num - 1);
			string str = obj.TrimStart(trimChars);
			LuaDLL.lua_pushstring(L, str);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int TrimEnd(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			string obj = (string)ToLua.CheckObject(L, 1, typeof(string));
			char[] trimChars = ToLua.CheckParamsChar(L, 2, num - 1);
			string str = obj.TrimEnd(trimChars);
			LuaDLL.lua_pushstring(L, str);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Compare(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			switch (num)
			{
			case 2:
			{
				string strA2 = ToLua.CheckString(L, 1);
				string strB2 = ToLua.CheckString(L, 2);
				int n2 = string.Compare(strA2, strB2);
				LuaDLL.lua_pushinteger(L, n2);
				return 1;
			}
			case 3:
				if (TypeChecker.CheckTypes<StringComparison>(L, 3))
				{
					string strA = ToLua.CheckString(L, 1);
					string strB = ToLua.CheckString(L, 2);
					StringComparison comparisonType = (StringComparison)ToLua.ToObject(L, 3);
					int n = string.Compare(strA, strB, comparisonType);
					LuaDLL.lua_pushinteger(L, n);
					return 1;
				}
				break;
			}
			if (num == 3 && TypeChecker.CheckTypes<bool>(L, 3))
			{
				string strA3 = ToLua.CheckString(L, 1);
				string strB3 = ToLua.CheckString(L, 2);
				bool ignoreCase = LuaDLL.lua_toboolean(L, 3);
				int n3 = string.Compare(strA3, strB3, ignoreCase);
				LuaDLL.lua_pushinteger(L, n3);
				return 1;
			}
			if (num == 4 && TypeChecker.CheckTypes<CultureInfo, CompareOptions>(L, 3))
			{
				string strA4 = ToLua.CheckString(L, 1);
				string strB4 = ToLua.CheckString(L, 2);
				CultureInfo culture = (CultureInfo)ToLua.ToObject(L, 3);
				CompareOptions options = (CompareOptions)ToLua.ToObject(L, 4);
				int n4 = string.Compare(strA4, strB4, culture, options);
				LuaDLL.lua_pushinteger(L, n4);
				return 1;
			}
			if (num == 4 && TypeChecker.CheckTypes<bool, CultureInfo>(L, 3))
			{
				string strA5 = ToLua.CheckString(L, 1);
				string strB5 = ToLua.CheckString(L, 2);
				bool ignoreCase2 = LuaDLL.lua_toboolean(L, 3);
				CultureInfo culture2 = (CultureInfo)ToLua.ToObject(L, 4);
				int n5 = string.Compare(strA5, strB5, ignoreCase2, culture2);
				LuaDLL.lua_pushinteger(L, n5);
				return 1;
			}
			switch (num)
			{
			case 5:
			{
				string strA7 = ToLua.CheckString(L, 1);
				int indexA2 = (int)LuaDLL.luaL_checknumber(L, 2);
				string strB7 = ToLua.CheckString(L, 3);
				int indexB2 = (int)LuaDLL.luaL_checknumber(L, 4);
				int length2 = (int)LuaDLL.luaL_checknumber(L, 5);
				int n7 = string.Compare(strA7, indexA2, strB7, indexB2, length2);
				LuaDLL.lua_pushinteger(L, n7);
				return 1;
			}
			case 6:
				if (TypeChecker.CheckTypes<StringComparison>(L, 6))
				{
					string strA6 = ToLua.CheckString(L, 1);
					int indexA = (int)LuaDLL.luaL_checknumber(L, 2);
					string strB6 = ToLua.CheckString(L, 3);
					int indexB = (int)LuaDLL.luaL_checknumber(L, 4);
					int length = (int)LuaDLL.luaL_checknumber(L, 5);
					StringComparison comparisonType2 = (StringComparison)ToLua.ToObject(L, 6);
					int n6 = string.Compare(strA6, indexA, strB6, indexB, length, comparisonType2);
					LuaDLL.lua_pushinteger(L, n6);
					return 1;
				}
				break;
			}
			if (num == 6 && TypeChecker.CheckTypes<bool>(L, 6))
			{
				string strA8 = ToLua.CheckString(L, 1);
				int indexA3 = (int)LuaDLL.luaL_checknumber(L, 2);
				string strB8 = ToLua.CheckString(L, 3);
				int indexB3 = (int)LuaDLL.luaL_checknumber(L, 4);
				int length3 = (int)LuaDLL.luaL_checknumber(L, 5);
				bool ignoreCase3 = LuaDLL.lua_toboolean(L, 6);
				int n8 = string.Compare(strA8, indexA3, strB8, indexB3, length3, ignoreCase3);
				LuaDLL.lua_pushinteger(L, n8);
				return 1;
			}
			if (num == 7 && TypeChecker.CheckTypes<CultureInfo, CompareOptions>(L, 6))
			{
				string strA9 = ToLua.CheckString(L, 1);
				int indexA4 = (int)LuaDLL.luaL_checknumber(L, 2);
				string strB9 = ToLua.CheckString(L, 3);
				int indexB4 = (int)LuaDLL.luaL_checknumber(L, 4);
				int length4 = (int)LuaDLL.luaL_checknumber(L, 5);
				CultureInfo culture3 = (CultureInfo)ToLua.ToObject(L, 6);
				CompareOptions options2 = (CompareOptions)ToLua.ToObject(L, 7);
				int n9 = string.Compare(strA9, indexA4, strB9, indexB4, length4, culture3, options2);
				LuaDLL.lua_pushinteger(L, n9);
				return 1;
			}
			if (num == 7 && TypeChecker.CheckTypes<bool, CultureInfo>(L, 6))
			{
				string strA10 = ToLua.CheckString(L, 1);
				int indexA5 = (int)LuaDLL.luaL_checknumber(L, 2);
				string strB10 = ToLua.CheckString(L, 3);
				int indexB5 = (int)LuaDLL.luaL_checknumber(L, 4);
				int length5 = (int)LuaDLL.luaL_checknumber(L, 5);
				bool ignoreCase4 = LuaDLL.lua_toboolean(L, 6);
				CultureInfo culture4 = (CultureInfo)ToLua.ToObject(L, 7);
				int n10 = string.Compare(strA10, indexA5, strB10, indexB5, length5, ignoreCase4, culture4);
				LuaDLL.lua_pushinteger(L, n10);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: System.String.Compare");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CompareTo(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 2 && TypeChecker.CheckTypes<string>(L, 2))
			{
				string obj = (string)ToLua.CheckObject(L, 1, typeof(string));
				string strB = ToLua.ToString(L, 2);
				int n = obj.CompareTo(strB);
				LuaDLL.lua_pushinteger(L, n);
				return 1;
			}
			if (num == 2 && TypeChecker.CheckTypes<object>(L, 2))
			{
				string obj2 = (string)ToLua.CheckObject(L, 1, typeof(string));
				object value = ToLua.ToVarObject(L, 2);
				int n2 = obj2.CompareTo(value);
				LuaDLL.lua_pushinteger(L, n2);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: System.String.CompareTo");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CompareOrdinal(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				string strA2 = ToLua.CheckString(L, 1);
				string strB2 = ToLua.CheckString(L, 2);
				int n2 = string.CompareOrdinal(strA2, strB2);
				LuaDLL.lua_pushinteger(L, n2);
				return 1;
			}
			case 5:
			{
				string strA = ToLua.CheckString(L, 1);
				int indexA = (int)LuaDLL.luaL_checknumber(L, 2);
				string strB = ToLua.CheckString(L, 3);
				int indexB = (int)LuaDLL.luaL_checknumber(L, 4);
				int length = (int)LuaDLL.luaL_checknumber(L, 5);
				int n = string.CompareOrdinal(strA, indexA, strB, indexB, length);
				LuaDLL.lua_pushinteger(L, n);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: System.String.CompareOrdinal");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int EndsWith(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				string obj3 = (string)ToLua.CheckObject(L, 1, typeof(string));
				string value5 = ToLua.CheckString(L, 2);
				bool value6 = obj3.EndsWith(value5);
				LuaDLL.lua_pushboolean(L, value6);
				return 1;
			}
			case 3:
			{
				string obj2 = (string)ToLua.CheckObject(L, 1, typeof(string));
				string value3 = ToLua.CheckString(L, 2);
				StringComparison comparisonType = (StringComparison)ToLua.CheckObject(L, 3, typeof(StringComparison));
				bool value4 = obj2.EndsWith(value3, comparisonType);
				LuaDLL.lua_pushboolean(L, value4);
				return 1;
			}
			case 4:
			{
				string obj = (string)ToLua.CheckObject(L, 1, typeof(string));
				string value = ToLua.CheckString(L, 2);
				bool ignoreCase = LuaDLL.luaL_checkboolean(L, 3);
				CultureInfo culture = (CultureInfo)ToLua.CheckObject<CultureInfo>(L, 4);
				bool value2 = obj.EndsWith(value, ignoreCase, culture);
				LuaDLL.lua_pushboolean(L, value2);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: System.String.EndsWith");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IndexOfAny(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				string obj3 = (string)ToLua.CheckObject(L, 1, typeof(string));
				char[] anyOf3 = ToLua.CheckCharBuffer(L, 2);
				int n3 = obj3.IndexOfAny(anyOf3);
				LuaDLL.lua_pushinteger(L, n3);
				return 1;
			}
			case 3:
			{
				string obj2 = (string)ToLua.CheckObject(L, 1, typeof(string));
				char[] anyOf2 = ToLua.CheckCharBuffer(L, 2);
				int startIndex2 = (int)LuaDLL.luaL_checknumber(L, 3);
				int n2 = obj2.IndexOfAny(anyOf2, startIndex2);
				LuaDLL.lua_pushinteger(L, n2);
				return 1;
			}
			case 4:
			{
				string obj = (string)ToLua.CheckObject(L, 1, typeof(string));
				char[] anyOf = ToLua.CheckCharBuffer(L, 2);
				int startIndex = (int)LuaDLL.luaL_checknumber(L, 3);
				int count = (int)LuaDLL.luaL_checknumber(L, 4);
				int n = obj.IndexOfAny(anyOf, startIndex, count);
				LuaDLL.lua_pushinteger(L, n);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: System.String.IndexOfAny");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IndexOf(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 2 && TypeChecker.CheckTypes<char>(L, 2))
			{
				string obj = (string)ToLua.CheckObject(L, 1, typeof(string));
				char value = (char)LuaDLL.lua_tonumber(L, 2);
				int n = obj.IndexOf(value);
				LuaDLL.lua_pushinteger(L, n);
				return 1;
			}
			if (num == 2 && TypeChecker.CheckTypes<string>(L, 2))
			{
				string obj2 = (string)ToLua.CheckObject(L, 1, typeof(string));
				string value2 = ToLua.ToString(L, 2);
				int n2 = obj2.IndexOf(value2);
				LuaDLL.lua_pushinteger(L, n2);
				return 1;
			}
			if (num == 3 && TypeChecker.CheckTypes<string, int>(L, 2))
			{
				string obj3 = (string)ToLua.CheckObject(L, 1, typeof(string));
				string value3 = ToLua.ToString(L, 2);
				int startIndex = (int)LuaDLL.lua_tonumber(L, 3);
				int n3 = obj3.IndexOf(value3, startIndex);
				LuaDLL.lua_pushinteger(L, n3);
				return 1;
			}
			if (num == 3 && TypeChecker.CheckTypes<char, int>(L, 2))
			{
				string obj4 = (string)ToLua.CheckObject(L, 1, typeof(string));
				char value4 = (char)LuaDLL.lua_tonumber(L, 2);
				int startIndex2 = (int)LuaDLL.lua_tonumber(L, 3);
				int n4 = obj4.IndexOf(value4, startIndex2);
				LuaDLL.lua_pushinteger(L, n4);
				return 1;
			}
			if (num == 3 && TypeChecker.CheckTypes<string, StringComparison>(L, 2))
			{
				string obj5 = (string)ToLua.CheckObject(L, 1, typeof(string));
				string value5 = ToLua.ToString(L, 2);
				StringComparison comparisonType = (StringComparison)ToLua.ToObject(L, 3);
				int n5 = obj5.IndexOf(value5, comparisonType);
				LuaDLL.lua_pushinteger(L, n5);
				return 1;
			}
			if (num == 4 && TypeChecker.CheckTypes<string, int, int>(L, 2))
			{
				string obj6 = (string)ToLua.CheckObject(L, 1, typeof(string));
				string value6 = ToLua.ToString(L, 2);
				int startIndex3 = (int)LuaDLL.lua_tonumber(L, 3);
				int count = (int)LuaDLL.lua_tonumber(L, 4);
				int n6 = obj6.IndexOf(value6, startIndex3, count);
				LuaDLL.lua_pushinteger(L, n6);
				return 1;
			}
			if (num == 4 && TypeChecker.CheckTypes<string, int, StringComparison>(L, 2))
			{
				string obj7 = (string)ToLua.CheckObject(L, 1, typeof(string));
				string value7 = ToLua.ToString(L, 2);
				int startIndex4 = (int)LuaDLL.lua_tonumber(L, 3);
				StringComparison comparisonType2 = (StringComparison)ToLua.ToObject(L, 4);
				int n7 = obj7.IndexOf(value7, startIndex4, comparisonType2);
				LuaDLL.lua_pushinteger(L, n7);
				return 1;
			}
			if (num == 4 && TypeChecker.CheckTypes<char, int, int>(L, 2))
			{
				string obj8 = (string)ToLua.CheckObject(L, 1, typeof(string));
				char value8 = (char)LuaDLL.lua_tonumber(L, 2);
				int startIndex5 = (int)LuaDLL.lua_tonumber(L, 3);
				int count2 = (int)LuaDLL.lua_tonumber(L, 4);
				int n8 = obj8.IndexOf(value8, startIndex5, count2);
				LuaDLL.lua_pushinteger(L, n8);
				return 1;
			}
			if (num == 5)
			{
				string obj9 = (string)ToLua.CheckObject(L, 1, typeof(string));
				string value9 = ToLua.CheckString(L, 2);
				int startIndex6 = (int)LuaDLL.luaL_checknumber(L, 3);
				int count3 = (int)LuaDLL.luaL_checknumber(L, 4);
				StringComparison comparisonType3 = (StringComparison)ToLua.CheckObject(L, 5, typeof(StringComparison));
				int n9 = obj9.IndexOf(value9, startIndex6, count3, comparisonType3);
				LuaDLL.lua_pushinteger(L, n9);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: System.String.IndexOf");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LastIndexOf(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 2 && TypeChecker.CheckTypes<char>(L, 2))
			{
				string obj = (string)ToLua.CheckObject(L, 1, typeof(string));
				char value = (char)LuaDLL.lua_tonumber(L, 2);
				int n = obj.LastIndexOf(value);
				LuaDLL.lua_pushinteger(L, n);
				return 1;
			}
			if (num == 2 && TypeChecker.CheckTypes<string>(L, 2))
			{
				string obj2 = (string)ToLua.CheckObject(L, 1, typeof(string));
				string value2 = ToLua.ToString(L, 2);
				int n2 = obj2.LastIndexOf(value2);
				LuaDLL.lua_pushinteger(L, n2);
				return 1;
			}
			if (num == 3 && TypeChecker.CheckTypes<string, int>(L, 2))
			{
				string obj3 = (string)ToLua.CheckObject(L, 1, typeof(string));
				string value3 = ToLua.ToString(L, 2);
				int startIndex = (int)LuaDLL.lua_tonumber(L, 3);
				int n3 = obj3.LastIndexOf(value3, startIndex);
				LuaDLL.lua_pushinteger(L, n3);
				return 1;
			}
			if (num == 3 && TypeChecker.CheckTypes<char, int>(L, 2))
			{
				string obj4 = (string)ToLua.CheckObject(L, 1, typeof(string));
				char value4 = (char)LuaDLL.lua_tonumber(L, 2);
				int startIndex2 = (int)LuaDLL.lua_tonumber(L, 3);
				int n4 = obj4.LastIndexOf(value4, startIndex2);
				LuaDLL.lua_pushinteger(L, n4);
				return 1;
			}
			if (num == 3 && TypeChecker.CheckTypes<string, StringComparison>(L, 2))
			{
				string obj5 = (string)ToLua.CheckObject(L, 1, typeof(string));
				string value5 = ToLua.ToString(L, 2);
				StringComparison comparisonType = (StringComparison)ToLua.ToObject(L, 3);
				int n5 = obj5.LastIndexOf(value5, comparisonType);
				LuaDLL.lua_pushinteger(L, n5);
				return 1;
			}
			if (num == 4 && TypeChecker.CheckTypes<string, int, int>(L, 2))
			{
				string obj6 = (string)ToLua.CheckObject(L, 1, typeof(string));
				string value6 = ToLua.ToString(L, 2);
				int startIndex3 = (int)LuaDLL.lua_tonumber(L, 3);
				int count = (int)LuaDLL.lua_tonumber(L, 4);
				int n6 = obj6.LastIndexOf(value6, startIndex3, count);
				LuaDLL.lua_pushinteger(L, n6);
				return 1;
			}
			if (num == 4 && TypeChecker.CheckTypes<string, int, StringComparison>(L, 2))
			{
				string obj7 = (string)ToLua.CheckObject(L, 1, typeof(string));
				string value7 = ToLua.ToString(L, 2);
				int startIndex4 = (int)LuaDLL.lua_tonumber(L, 3);
				StringComparison comparisonType2 = (StringComparison)ToLua.ToObject(L, 4);
				int n7 = obj7.LastIndexOf(value7, startIndex4, comparisonType2);
				LuaDLL.lua_pushinteger(L, n7);
				return 1;
			}
			if (num == 4 && TypeChecker.CheckTypes<char, int, int>(L, 2))
			{
				string obj8 = (string)ToLua.CheckObject(L, 1, typeof(string));
				char value8 = (char)LuaDLL.lua_tonumber(L, 2);
				int startIndex5 = (int)LuaDLL.lua_tonumber(L, 3);
				int count2 = (int)LuaDLL.lua_tonumber(L, 4);
				int n8 = obj8.LastIndexOf(value8, startIndex5, count2);
				LuaDLL.lua_pushinteger(L, n8);
				return 1;
			}
			if (num == 5)
			{
				string obj9 = (string)ToLua.CheckObject(L, 1, typeof(string));
				string value9 = ToLua.CheckString(L, 2);
				int startIndex6 = (int)LuaDLL.luaL_checknumber(L, 3);
				int count3 = (int)LuaDLL.luaL_checknumber(L, 4);
				StringComparison comparisonType3 = (StringComparison)ToLua.CheckObject(L, 5, typeof(StringComparison));
				int n9 = obj9.LastIndexOf(value9, startIndex6, count3, comparisonType3);
				LuaDLL.lua_pushinteger(L, n9);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: System.String.LastIndexOf");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LastIndexOfAny(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				string obj3 = (string)ToLua.CheckObject(L, 1, typeof(string));
				char[] anyOf3 = ToLua.CheckCharBuffer(L, 2);
				int n3 = obj3.LastIndexOfAny(anyOf3);
				LuaDLL.lua_pushinteger(L, n3);
				return 1;
			}
			case 3:
			{
				string obj2 = (string)ToLua.CheckObject(L, 1, typeof(string));
				char[] anyOf2 = ToLua.CheckCharBuffer(L, 2);
				int startIndex2 = (int)LuaDLL.luaL_checknumber(L, 3);
				int n2 = obj2.LastIndexOfAny(anyOf2, startIndex2);
				LuaDLL.lua_pushinteger(L, n2);
				return 1;
			}
			case 4:
			{
				string obj = (string)ToLua.CheckObject(L, 1, typeof(string));
				char[] anyOf = ToLua.CheckCharBuffer(L, 2);
				int startIndex = (int)LuaDLL.luaL_checknumber(L, 3);
				int count = (int)LuaDLL.luaL_checknumber(L, 4);
				int n = obj.LastIndexOfAny(anyOf, startIndex, count);
				LuaDLL.lua_pushinteger(L, n);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: System.String.LastIndexOfAny");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Contains(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			string obj = (string)ToLua.CheckObject(L, 1, typeof(string));
			string value = ToLua.CheckString(L, 2);
			bool value2 = obj.Contains(value);
			LuaDLL.lua_pushboolean(L, value2);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IsNullOrEmpty(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = string.IsNullOrEmpty(ToLua.CheckString(L, 1));
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Normalize(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
			{
				string str2 = ((string)ToLua.CheckObject(L, 1, typeof(string))).Normalize();
				LuaDLL.lua_pushstring(L, str2);
				return 1;
			}
			case 2:
			{
				string obj = (string)ToLua.CheckObject(L, 1, typeof(string));
				NormalizationForm normalizationForm = (NormalizationForm)ToLua.CheckObject(L, 2, typeof(NormalizationForm));
				string str = obj.Normalize(normalizationForm);
				LuaDLL.lua_pushstring(L, str);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: System.String.Normalize");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IsNormalized(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
			{
				bool value2 = ((string)ToLua.CheckObject(L, 1, typeof(string))).IsNormalized();
				LuaDLL.lua_pushboolean(L, value2);
				return 1;
			}
			case 2:
			{
				string obj = (string)ToLua.CheckObject(L, 1, typeof(string));
				NormalizationForm normalizationForm = (NormalizationForm)ToLua.CheckObject(L, 2, typeof(NormalizationForm));
				bool value = obj.IsNormalized(normalizationForm);
				LuaDLL.lua_pushboolean(L, value);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: System.String.IsNormalized");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Remove(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				string obj2 = (string)ToLua.CheckObject(L, 1, typeof(string));
				int startIndex2 = (int)LuaDLL.luaL_checknumber(L, 2);
				string str2 = obj2.Remove(startIndex2);
				LuaDLL.lua_pushstring(L, str2);
				return 1;
			}
			case 3:
			{
				string obj = (string)ToLua.CheckObject(L, 1, typeof(string));
				int startIndex = (int)LuaDLL.luaL_checknumber(L, 2);
				int count = (int)LuaDLL.luaL_checknumber(L, 3);
				string str = obj.Remove(startIndex, count);
				LuaDLL.lua_pushstring(L, str);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: System.String.Remove");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int PadLeft(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				string obj2 = (string)ToLua.CheckObject(L, 1, typeof(string));
				int totalWidth2 = (int)LuaDLL.luaL_checknumber(L, 2);
				string str2 = obj2.PadLeft(totalWidth2);
				LuaDLL.lua_pushstring(L, str2);
				return 1;
			}
			case 3:
			{
				string obj = (string)ToLua.CheckObject(L, 1, typeof(string));
				int totalWidth = (int)LuaDLL.luaL_checknumber(L, 2);
				char paddingChar = (char)LuaDLL.luaL_checknumber(L, 3);
				string str = obj.PadLeft(totalWidth, paddingChar);
				LuaDLL.lua_pushstring(L, str);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: System.String.PadLeft");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int PadRight(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				string obj2 = (string)ToLua.CheckObject(L, 1, typeof(string));
				int totalWidth2 = (int)LuaDLL.luaL_checknumber(L, 2);
				string str2 = obj2.PadRight(totalWidth2);
				LuaDLL.lua_pushstring(L, str2);
				return 1;
			}
			case 3:
			{
				string obj = (string)ToLua.CheckObject(L, 1, typeof(string));
				int totalWidth = (int)LuaDLL.luaL_checknumber(L, 2);
				char paddingChar = (char)LuaDLL.luaL_checknumber(L, 3);
				string str = obj.PadRight(totalWidth, paddingChar);
				LuaDLL.lua_pushstring(L, str);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: System.String.PadRight");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int StartsWith(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				string obj3 = (string)ToLua.CheckObject(L, 1, typeof(string));
				string value5 = ToLua.CheckString(L, 2);
				bool value6 = obj3.StartsWith(value5);
				LuaDLL.lua_pushboolean(L, value6);
				return 1;
			}
			case 3:
			{
				string obj2 = (string)ToLua.CheckObject(L, 1, typeof(string));
				string value3 = ToLua.CheckString(L, 2);
				StringComparison comparisonType = (StringComparison)ToLua.CheckObject(L, 3, typeof(StringComparison));
				bool value4 = obj2.StartsWith(value3, comparisonType);
				LuaDLL.lua_pushboolean(L, value4);
				return 1;
			}
			case 4:
			{
				string obj = (string)ToLua.CheckObject(L, 1, typeof(string));
				string value = ToLua.CheckString(L, 2);
				bool ignoreCase = LuaDLL.luaL_checkboolean(L, 3);
				CultureInfo culture = (CultureInfo)ToLua.CheckObject<CultureInfo>(L, 4);
				bool value2 = obj.StartsWith(value, ignoreCase, culture);
				LuaDLL.lua_pushboolean(L, value2);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: System.String.StartsWith");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Replace(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 3 && TypeChecker.CheckTypes<string, string>(L, 2))
			{
				string obj = (string)ToLua.CheckObject(L, 1, typeof(string));
				string oldValue = ToLua.ToString(L, 2);
				string newValue = ToLua.ToString(L, 3);
				string str = obj.Replace(oldValue, newValue);
				LuaDLL.lua_pushstring(L, str);
				return 1;
			}
			if (num == 3 && TypeChecker.CheckTypes<char, char>(L, 2))
			{
				string obj2 = (string)ToLua.CheckObject(L, 1, typeof(string));
				char oldChar = (char)LuaDLL.lua_tonumber(L, 2);
				char newChar = (char)LuaDLL.lua_tonumber(L, 3);
				string str2 = obj2.Replace(oldChar, newChar);
				LuaDLL.lua_pushstring(L, str2);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: System.String.Replace");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ToLower(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
			{
				string str2 = ((string)ToLua.CheckObject(L, 1, typeof(string))).ToLower();
				LuaDLL.lua_pushstring(L, str2);
				return 1;
			}
			case 2:
			{
				string obj = (string)ToLua.CheckObject(L, 1, typeof(string));
				CultureInfo culture = (CultureInfo)ToLua.CheckObject<CultureInfo>(L, 2);
				string str = obj.ToLower(culture);
				LuaDLL.lua_pushstring(L, str);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: System.String.ToLower");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ToLowerInvariant(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			string str = ((string)ToLua.CheckObject(L, 1, typeof(string))).ToLowerInvariant();
			LuaDLL.lua_pushstring(L, str);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ToUpper(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
			{
				string str2 = ((string)ToLua.CheckObject(L, 1, typeof(string))).ToUpper();
				LuaDLL.lua_pushstring(L, str2);
				return 1;
			}
			case 2:
			{
				string obj = (string)ToLua.CheckObject(L, 1, typeof(string));
				CultureInfo culture = (CultureInfo)ToLua.CheckObject<CultureInfo>(L, 2);
				string str = obj.ToUpper(culture);
				LuaDLL.lua_pushstring(L, str);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: System.String.ToUpper");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ToUpperInvariant(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			string str = ((string)ToLua.CheckObject(L, 1, typeof(string))).ToUpperInvariant();
			LuaDLL.lua_pushstring(L, str);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ToString(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
			{
				string str2 = ((string)ToLua.CheckObject(L, 1, typeof(string))).ToString();
				LuaDLL.lua_pushstring(L, str2);
				return 1;
			}
			case 2:
			{
				string obj = (string)ToLua.CheckObject(L, 1, typeof(string));
				IFormatProvider formatProvider = (IFormatProvider)ToLua.CheckObject<IFormatProvider>(L, 2);
				string str = obj.ToString(formatProvider);
				LuaDLL.lua_pushstring(L, str);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: System.String.ToString");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Format(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 2 && TypeChecker.CheckTypes<string, object>(L, 1))
			{
				string format = ToLua.ToString(L, 1);
				object arg = ToLua.ToVarObject(L, 2);
				string str = string.Format(format, arg);
				LuaDLL.lua_pushstring(L, str);
				return 1;
			}
			if (num == 3 && TypeChecker.CheckTypes<string, object, object>(L, 1))
			{
				string format2 = ToLua.ToString(L, 1);
				object arg2 = ToLua.ToVarObject(L, 2);
				object arg3 = ToLua.ToVarObject(L, 3);
				string str2 = string.Format(format2, arg2, arg3);
				LuaDLL.lua_pushstring(L, str2);
				return 1;
			}
			if (num == 4 && TypeChecker.CheckTypes<string, object, object, object>(L, 1))
			{
				string format3 = ToLua.ToString(L, 1);
				object arg4 = ToLua.ToVarObject(L, 2);
				object arg5 = ToLua.ToVarObject(L, 3);
				object arg6 = ToLua.ToVarObject(L, 4);
				string str3 = string.Format(format3, arg4, arg5, arg6);
				LuaDLL.lua_pushstring(L, str3);
				return 1;
			}
			if (TypeChecker.CheckTypes<IFormatProvider, string>(L, 1) && TypeChecker.CheckParamsType<object>(L, 3, num - 2))
			{
				IFormatProvider provider = (IFormatProvider)ToLua.ToObject(L, 1);
				string format4 = ToLua.ToString(L, 2);
				object[] args = ToLua.ToParamsObject(L, 3, num - 2);
				string str4 = string.Format(provider, format4, args);
				LuaDLL.lua_pushstring(L, str4);
				return 1;
			}
			if (TypeChecker.CheckTypes<string>(L, 1) && TypeChecker.CheckParamsType<object>(L, 2, num - 1))
			{
				string format5 = ToLua.ToString(L, 1);
				object[] args2 = ToLua.ToParamsObject(L, 2, num - 1);
				string str5 = string.Format(format5, args2);
				LuaDLL.lua_pushstring(L, str5);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: System.String.Format");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Copy(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			string str = string.Copy(ToLua.CheckString(L, 1));
			LuaDLL.lua_pushstring(L, str);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Concat(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 1 && TypeChecker.CheckTypes<object>(L, 1))
			{
				string str = string.Concat(ToLua.ToVarObject(L, 1));
				LuaDLL.lua_pushstring(L, str);
				return 1;
			}
			if (num == 2 && TypeChecker.CheckTypes<string, string>(L, 1))
			{
				string text = ToLua.ToString(L, 1);
				string text2 = ToLua.ToString(L, 2);
				string str2 = text + text2;
				LuaDLL.lua_pushstring(L, str2);
				return 1;
			}
			if (num == 2 && TypeChecker.CheckTypes<object, object>(L, 1))
			{
				object obj = ToLua.ToVarObject(L, 1);
				object obj2 = ToLua.ToVarObject(L, 2);
				string str3 = string.Concat(obj, obj2);
				LuaDLL.lua_pushstring(L, str3);
				return 1;
			}
			if (num == 3 && TypeChecker.CheckTypes<string, string, string>(L, 1))
			{
				string text3 = ToLua.ToString(L, 1);
				string text4 = ToLua.ToString(L, 2);
				string text5 = ToLua.ToString(L, 3);
				string str4 = text3 + text4 + text5;
				LuaDLL.lua_pushstring(L, str4);
				return 1;
			}
			if (num == 3 && TypeChecker.CheckTypes<object, object, object>(L, 1))
			{
				object obj3 = ToLua.ToVarObject(L, 1);
				object obj4 = ToLua.ToVarObject(L, 2);
				object obj5 = ToLua.ToVarObject(L, 3);
				string str5 = string.Concat(obj3, obj4, obj5);
				LuaDLL.lua_pushstring(L, str5);
				return 1;
			}
			if (num == 4 && TypeChecker.CheckTypes<string, string, string, string>(L, 1))
			{
				string text6 = ToLua.ToString(L, 1);
				string text7 = ToLua.ToString(L, 2);
				string text8 = ToLua.ToString(L, 3);
				string text9 = ToLua.ToString(L, 4);
				string str6 = text6 + text7 + text8 + text9;
				LuaDLL.lua_pushstring(L, str6);
				return 1;
			}
			if (num == 4 && TypeChecker.CheckTypes<object, object, object, object>(L, 1))
			{
				object obj6 = ToLua.ToVarObject(L, 1);
				object obj7 = ToLua.ToVarObject(L, 2);
				object obj8 = ToLua.ToVarObject(L, 3);
				object obj9 = ToLua.ToVarObject(L, 4);
				string str7 = string.Concat(obj6, obj7, obj8, obj9);
				LuaDLL.lua_pushstring(L, str7);
				return 1;
			}
			if (TypeChecker.CheckParamsType<string>(L, 1, num))
			{
				string str8 = string.Concat(ToLua.ToParamsString(L, 1, num));
				LuaDLL.lua_pushstring(L, str8);
				return 1;
			}
			if (TypeChecker.CheckParamsType<object>(L, 1, num))
			{
				string str9 = string.Concat(ToLua.ToParamsObject(L, 1, num));
				LuaDLL.lua_pushstring(L, str9);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: System.String.Concat");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Insert(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			string obj = (string)ToLua.CheckObject(L, 1, typeof(string));
			int startIndex = (int)LuaDLL.luaL_checknumber(L, 2);
			string value = ToLua.CheckString(L, 3);
			string str = obj.Insert(startIndex, value);
			LuaDLL.lua_pushstring(L, str);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Intern(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			string str = string.Intern(ToLua.CheckString(L, 1));
			LuaDLL.lua_pushstring(L, str);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IsInterned(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			string str = string.IsInterned(ToLua.CheckString(L, 1));
			LuaDLL.lua_pushstring(L, str);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Join(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				string separator2 = ToLua.CheckString(L, 1);
				string[] value2 = ToLua.CheckStringArray(L, 2);
				string str2 = string.Join(separator2, value2);
				LuaDLL.lua_pushstring(L, str2);
				return 1;
			}
			case 4:
			{
				string separator = ToLua.CheckString(L, 1);
				string[] value = ToLua.CheckStringArray(L, 2);
				int startIndex = (int)LuaDLL.luaL_checknumber(L, 3);
				int count = (int)LuaDLL.luaL_checknumber(L, 4);
				string str = string.Join(separator, value, startIndex, count);
				LuaDLL.lua_pushstring(L, str);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: System.String.Join");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetEnumerator(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			IEnumerator enumerator = ((string)ToLua.CheckObject(L, 1, typeof(string))).GetEnumerator();
			ToLua.Push(L, enumerator);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetHashCode(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			int hashCode = ((string)ToLua.CheckObject(L, 1, typeof(string))).GetHashCode();
			LuaDLL.lua_pushinteger(L, hashCode);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int op_Equality(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			string text = ToLua.ToString(L, 1);
			string text2 = ToLua.ToString(L, 2);
			bool value = text == text2;
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Empty(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushstring(L, string.Empty);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Length(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int length = ((string)obj).Length;
			LuaDLL.lua_pushinteger(L, length);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index Length on a nil value");
		}
	}
}
