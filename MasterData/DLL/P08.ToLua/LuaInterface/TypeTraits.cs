using System;

namespace LuaInterface;

public static class TypeTraits<T>
{
	public static Func<IntPtr, int, bool> Check = DefaultCheck;

	public static Type type = typeof(T);

	public static bool IsValueType = type.IsValueType;

	public static bool IsArray = type.IsArray;

	private static string typeName = string.Empty;

	private static int nilType = -1;

	private static int metaref = -1;

	public static void Init(Func<IntPtr, int, bool> check)
	{
		if (check != null)
		{
			Check = check;
		}
	}

	public static string GetTypeName()
	{
		if (typeName == string.Empty)
		{
			typeName = LuaMisc.GetTypeName(type);
		}
		return typeName;
	}

	public static int GetLuaReference(IntPtr L)
	{
		if (metaref > 0)
		{
			return metaref;
		}
		metaref = LuaStatic.GetMetaReference(L, type);
		if (metaref > 0)
		{
			LuaState luaState = LuaState.Get(L);
			luaState.OnDestroy = (Action)Delegate.Combine(luaState.OnDestroy, (Action)delegate
			{
				metaref = -1;
			});
		}
		return metaref;
	}

	private static bool DefaultCheck(IntPtr L, int pos)
	{
		return LuaDLL.lua_type(L, pos) switch
		{
			LuaTypes.LUA_TNIL => IsNilType(), 
			LuaTypes.LUA_TUSERDATA => IsUserData(L, pos), 
			LuaTypes.LUA_TTABLE => IsUserTable(L, pos), 
			_ => false, 
		};
	}

	private static bool IsNilType()
	{
		if (nilType != -1)
		{
			return nilType != 0;
		}
		if (!IsValueType)
		{
			nilType = 1;
			return true;
		}
		if (type.IsGenericType && type.GetGenericTypeDefinition() == typeof(Nullable<>))
		{
			nilType = 1;
			return true;
		}
		nilType = 0;
		return false;
	}

	private static bool IsUserData(IntPtr L, int pos)
	{
		object obj = null;
		int num = LuaDLL.tolua_rawnetobj(L, pos);
		if (num != -1)
		{
			obj = ObjectTranslator.Get(L).GetObject(num);
			if (obj != null)
			{
				return obj is T;
			}
			return !IsValueType;
		}
		return false;
	}

	private static bool IsUserTable(IntPtr L, int pos)
	{
		if (type == typeof(LuaTable))
		{
			return true;
		}
		if (type.IsArray)
		{
			if (type.GetElementType().IsArray || type.GetArrayRank() > 1)
			{
				return false;
			}
			return true;
		}
		if (LuaDLL.tolua_isvptrtable(L, pos))
		{
			return IsUserData(L, pos);
		}
		return false;
	}
}
