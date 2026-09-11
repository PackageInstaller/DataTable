using System;
using LuaInterface;

public class System_EnumWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(Enum), null);
		L.RegFunction("GetTypeCode", GetTypeCode);
		L.RegFunction("GetValues", GetValues);
		L.RegFunction("GetNames", GetNames);
		L.RegFunction("GetName", GetName);
		L.RegFunction("IsDefined", IsDefined);
		L.RegFunction("GetUnderlyingType", GetUnderlyingType);
		L.RegFunction("CompareTo", CompareTo);
		L.RegFunction("ToString", ToString);
		L.RegFunction("Equals", Equals);
		L.RegFunction("GetHashCode", GetHashCode);
		L.RegFunction("Format", Format);
		L.RegFunction("Parse", Parse);
		L.RegFunction("ToObject", ToObject);
		L.RegFunction("ToInt", ToInt);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetTypeCode(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			TypeCode typeCode = ((Enum)ToLua.CheckObject<Enum>(L, 1)).GetTypeCode();
			ToLua.Push(L, typeCode);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetValues(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			Array values = Enum.GetValues(ToLua.CheckMonoType(L, 1));
			ToLua.Push(L, values);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetNames(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			string[] names = Enum.GetNames(ToLua.CheckMonoType(L, 1));
			ToLua.Push(L, names);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetName(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Type enumType = ToLua.CheckMonoType(L, 1);
			object value = ToLua.ToVarObject(L, 2);
			string name = Enum.GetName(enumType, value);
			LuaDLL.lua_pushstring(L, name);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IsDefined(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Type enumType = ToLua.CheckMonoType(L, 1);
			object value = ToLua.ToVarObject(L, 2);
			bool value2 = Enum.IsDefined(enumType, value);
			LuaDLL.lua_pushboolean(L, value2);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetUnderlyingType(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			Type underlyingType = Enum.GetUnderlyingType(ToLua.CheckMonoType(L, 1));
			ToLua.Push(L, underlyingType);
			return 1;
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
			ToLua.CheckArgsCount(L, 2);
			Enum obj = (Enum)ToLua.CheckObject<Enum>(L, 1);
			object target = ToLua.ToVarObject(L, 2);
			int n = obj.CompareTo(target);
			LuaDLL.lua_pushinteger(L, n);
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
				string str2 = ((Enum)ToLua.CheckObject<Enum>(L, 1)).ToString();
				LuaDLL.lua_pushstring(L, str2);
				return 1;
			}
			case 2:
			{
				Enum obj = (Enum)ToLua.CheckObject<Enum>(L, 1);
				string text = ToLua.CheckString(L, 2);
				string str = obj.ToString(text);
				LuaDLL.lua_pushstring(L, str);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: System.Enum.ToString");
			}
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
			ToLua.CheckArgsCount(L, 2);
			Enum obj = (Enum)ToLua.CheckObject<Enum>(L, 1);
			object obj2 = ToLua.ToVarObject(L, 2);
			bool value = obj?.Equals(obj2) ?? (obj2 == null);
			LuaDLL.lua_pushboolean(L, value);
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
			int hashCode = ((Enum)ToLua.CheckObject<Enum>(L, 1)).GetHashCode();
			LuaDLL.lua_pushinteger(L, hashCode);
			return 1;
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
			ToLua.CheckArgsCount(L, 3);
			Type enumType = ToLua.CheckMonoType(L, 1);
			object value = ToLua.ToVarObject(L, 2);
			string format = ToLua.CheckString(L, 3);
			string str = Enum.Format(enumType, value, format);
			LuaDLL.lua_pushstring(L, str);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Parse(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 2 && TypeChecker.CheckTypes<Type, string>(L, 1))
			{
				Type enumType = (Type)ToLua.ToObject(L, 1);
				string value = ToLua.ToString(L, 2);
				object obj = Enum.Parse(enumType, value);
				ToLua.Push(L, (Enum)obj);
				return 1;
			}
			if (num == 3 && TypeChecker.CheckTypes<Type, string, bool>(L, 1))
			{
				Type enumType2 = (Type)ToLua.ToObject(L, 1);
				string value2 = ToLua.ToString(L, 2);
				bool ignoreCase = LuaDLL.lua_toboolean(L, 3);
				object obj2 = Enum.Parse(enumType2, value2, ignoreCase);
				ToLua.Push(L, (Enum)obj2);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: System.Enum.Parse");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ToObject(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 2 && TypeChecker.CheckTypes<Type, int>(L, 1))
			{
				Type enumType = (Type)ToLua.ToObject(L, 1);
				int value = (int)LuaDLL.lua_tonumber(L, 2);
				object obj = Enum.ToObject(enumType, value);
				ToLua.Push(L, (Enum)obj);
				return 1;
			}
			if (num == 2 && TypeChecker.CheckTypes<Type, object>(L, 1))
			{
				Type enumType2 = (Type)ToLua.ToObject(L, 1);
				object value2 = ToLua.ToVarObject(L, 2);
				object obj2 = Enum.ToObject(enumType2, value2);
				ToLua.Push(L, (Enum)obj2);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: System.Enum.ToObject");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ToInt(IntPtr L)
	{
		try
		{
			int n = Convert.ToInt32(ToLua.CheckObject<Enum>(L, 1));
			LuaDLL.lua_pushinteger(L, n);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
