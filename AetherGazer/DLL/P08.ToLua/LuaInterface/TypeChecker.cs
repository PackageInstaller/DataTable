using System;
using UnityEngine;

namespace LuaInterface;

public static class TypeChecker
{
	public static Type[] LuaValueTypeMap;

	private static Type monoType;

	static TypeChecker()
	{
		LuaValueTypeMap = new Type[64];
		monoType = typeof(Type).GetType();
		LuaValueTypeMap[0] = null;
		LuaValueTypeMap[1] = typeof(Vector3);
		LuaValueTypeMap[2] = typeof(Quaternion);
		LuaValueTypeMap[3] = typeof(Vector2);
		LuaValueTypeMap[4] = typeof(Color);
		LuaValueTypeMap[5] = typeof(Vector4);
		LuaValueTypeMap[6] = typeof(Ray);
		LuaValueTypeMap[7] = typeof(Bounds);
		LuaValueTypeMap[8] = typeof(Touch);
		LuaValueTypeMap[9] = typeof(LayerMask);
		LuaValueTypeMap[10] = typeof(RaycastHit);
		LuaValueTypeMap[11] = typeof(long);
		LuaValueTypeMap[12] = typeof(ulong);
	}

	public static bool IsValueType(Type t)
	{
		if (!t.IsEnum)
		{
			return t.IsValueType;
		}
		return false;
	}

	public static bool CheckTypes(IntPtr L, int begin, Type type0)
	{
		return CheckType(L, type0, begin);
	}

	public static bool CheckTypes(IntPtr L, int begin, Type type0, Type type1)
	{
		if (CheckType(L, type0, begin))
		{
			return CheckType(L, type1, begin + 1);
		}
		return false;
	}

	public static bool CheckTypes(IntPtr L, int begin, Type type0, Type type1, Type type2)
	{
		if (CheckType(L, type0, begin) && CheckType(L, type1, begin + 1))
		{
			return CheckType(L, type2, begin + 2);
		}
		return false;
	}

	public static bool CheckTypes(IntPtr L, int begin, Type type0, Type type1, Type type2, Type type3)
	{
		if (CheckType(L, type0, begin) && CheckType(L, type1, begin + 1) && CheckType(L, type2, begin + 2))
		{
			return CheckType(L, type3, begin + 3);
		}
		return false;
	}

	public static bool CheckTypes(IntPtr L, int begin, Type type0, Type type1, Type type2, Type type3, Type type4)
	{
		if (CheckType(L, type0, begin) && CheckType(L, type1, begin + 1) && CheckType(L, type2, begin + 2) && CheckType(L, type3, begin + 3))
		{
			return CheckType(L, type4, begin + 4);
		}
		return false;
	}

	public static bool CheckTypes(IntPtr L, int begin, Type type0, Type type1, Type type2, Type type3, Type type4, Type type5)
	{
		if (CheckType(L, type0, begin) && CheckType(L, type1, begin + 1) && CheckType(L, type2, begin + 2) && CheckType(L, type3, begin + 3) && CheckType(L, type4, begin + 4))
		{
			return CheckType(L, type5, begin + 5);
		}
		return false;
	}

	public static bool CheckTypes(IntPtr L, int begin, Type type0, Type type1, Type type2, Type type3, Type type4, Type type5, Type type6)
	{
		if (CheckType(L, type0, begin) && CheckType(L, type1, begin + 1) && CheckType(L, type2, begin + 2) && CheckType(L, type3, begin + 3) && CheckType(L, type4, begin + 4) && CheckType(L, type5, begin + 5))
		{
			return CheckType(L, type6, begin + 6);
		}
		return false;
	}

	public static bool CheckTypes(IntPtr L, int begin, Type type0, Type type1, Type type2, Type type3, Type type4, Type type5, Type type6, Type type7)
	{
		if (CheckType(L, type0, begin) && CheckType(L, type1, begin + 1) && CheckType(L, type2, begin + 2) && CheckType(L, type3, begin + 3) && CheckType(L, type4, begin + 4) && CheckType(L, type5, begin + 5) && CheckType(L, type6, begin + 6))
		{
			return CheckType(L, type7, begin + 7);
		}
		return false;
	}

	public static bool CheckTypes(IntPtr L, int begin, Type type0, Type type1, Type type2, Type type3, Type type4, Type type5, Type type6, Type type7, Type type8)
	{
		if (CheckType(L, type0, begin) && CheckType(L, type1, begin + 1) && CheckType(L, type2, begin + 2) && CheckType(L, type3, begin + 3) && CheckType(L, type4, begin + 4) && CheckType(L, type5, begin + 5) && CheckType(L, type6, begin + 6) && CheckType(L, type7, begin + 7))
		{
			return CheckType(L, type8, begin + 8);
		}
		return false;
	}

	public static bool CheckTypes(IntPtr L, int begin, Type type0, Type type1, Type type2, Type type3, Type type4, Type type5, Type type6, Type type7, Type type8, Type type9)
	{
		if (CheckType(L, type0, begin) && CheckType(L, type1, begin + 1) && CheckType(L, type2, begin + 2) && CheckType(L, type3, begin + 3) && CheckType(L, type4, begin + 4) && CheckType(L, type5, begin + 5) && CheckType(L, type6, begin + 6) && CheckType(L, type7, begin + 7) && CheckType(L, type8, begin + 8))
		{
			return CheckType(L, type9, begin + 9);
		}
		return false;
	}

	public static bool CheckTypes(IntPtr L, int begin, params Type[] types)
	{
		for (int i = 0; i < types.Length; i++)
		{
			if (!CheckType(L, types[i], i + begin))
			{
				return false;
			}
		}
		return true;
	}

	public static bool CheckParamsType(IntPtr L, Type t, int begin, int count)
	{
		if (t == typeof(object))
		{
			return true;
		}
		for (int i = 0; i < count; i++)
		{
			if (!CheckType(L, t, i + begin))
			{
				return false;
			}
		}
		return true;
	}

	private static bool IsNilType(Type t)
	{
		if (!t.IsValueType)
		{
			return true;
		}
		if (IsNullable(t))
		{
			return true;
		}
		return false;
	}

	public static bool IsNullable(Type t)
	{
		if (t.IsGenericType && t.GetGenericTypeDefinition() == typeof(Nullable<>))
		{
			return true;
		}
		return false;
	}

	public static Type GetNullableType(Type t)
	{
		if (t.IsGenericType && t.GetGenericTypeDefinition() == typeof(Nullable<>))
		{
			t = t.GetGenericArguments()[0];
		}
		return t;
	}

	public static bool CheckType(IntPtr L, Type type, int pos)
	{
		if (type == typeof(object))
		{
			return true;
		}
		Type nullableType = GetNullableType(type);
		switch (LuaDLL.lua_type(L, pos))
		{
		case LuaTypes.LUA_TNUMBER:
			return IsNumberType(nullableType);
		case LuaTypes.LUA_TSTRING:
			if (!(nullableType == typeof(string)) && !(nullableType == typeof(byte[])) && !(nullableType == typeof(char[])))
			{
				return nullableType == typeof(LuaByteBuffer);
			}
			return true;
		case LuaTypes.LUA_TUSERDATA:
			return IsMatchUserData(L, nullableType, pos);
		case LuaTypes.LUA_TBOOLEAN:
			return nullableType == typeof(bool);
		case LuaTypes.LUA_TFUNCTION:
			return nullableType == typeof(LuaFunction);
		case LuaTypes.LUA_TTABLE:
			return IsUserTable(nullableType, L, pos);
		case LuaTypes.LUA_TLIGHTUSERDATA:
			if (!(nullableType == typeof(IntPtr)))
			{
				return nullableType == typeof(UIntPtr);
			}
			return true;
		case LuaTypes.LUA_TNIL:
			return IsNilType(type);
		default:
			throw new LuaException("undefined type to check" + LuaDLL.luaL_typename(L, pos));
		}
	}

	public static T ChangeType<T>(object temp, Type type)
	{
		Type type2 = temp.GetType();
		if (type2 == monoType || type.IsAssignableFrom(type2))
		{
			return (T)temp;
		}
		return (T)Convert.ChangeType(temp, type);
	}

	public static object ChangeType(object temp, Type type)
	{
		Type type2 = temp.GetType();
		if (type2 == monoType)
		{
			return (Type)temp;
		}
		if (type.IsAssignableFrom(type2))
		{
			return temp;
		}
		return Convert.ChangeType(temp, type);
	}

	private static bool IsMatchUserData(IntPtr L, Type t, int pos)
	{
		if (t == typeof(long))
		{
			return LuaDLL.tolua_getvaluetype(L, pos) == 11;
		}
		if (t == typeof(ulong))
		{
			return LuaDLL.tolua_getvaluetype(L, pos) == 12;
		}
		object obj = null;
		int num = LuaDLL.tolua_rawnetobj(L, pos);
		if (num != -1)
		{
			obj = ObjectTranslator.Get(L).GetObject(num);
			if (obj == null)
			{
				return !t.IsValueType;
			}
			Type type = obj.GetType();
			if (t == type || t.IsAssignableFrom(type))
			{
				return true;
			}
		}
		return false;
	}

	public static bool IsNumberType(Type t)
	{
		if (t.IsPrimitive)
		{
			if (t == typeof(bool) || t == typeof(IntPtr) || t == typeof(UIntPtr))
			{
				return false;
			}
			return true;
		}
		return false;
	}

	public static bool IsUserTable(Type t, IntPtr L, int pos)
	{
		int num = LuaDLL.tolua_getvaluetype(L, pos);
		if (num != 0)
		{
			return t == LuaValueTypeMap[num];
		}
		if (t.IsArray)
		{
			if (t.GetElementType().IsArray || t.GetArrayRank() > 1)
			{
				return false;
			}
			return true;
		}
		if (t == typeof(LuaTable))
		{
			return true;
		}
		if (LuaDLL.tolua_isvptrtable(L, pos))
		{
			return IsMatchUserData(L, t, pos);
		}
		return false;
	}

	public static bool CheckTypes<T1>(IntPtr L, int pos)
	{
		return TypeTraits<T1>.Check(L, pos);
	}

	public static bool CheckTypes<T1, T2>(IntPtr L, int pos)
	{
		if (TypeTraits<T1>.Check(L, pos))
		{
			return TypeTraits<T2>.Check(L, pos + 1);
		}
		return false;
	}

	public static bool CheckTypes<T1, T2, T3>(IntPtr L, int pos)
	{
		if (TypeTraits<T1>.Check(L, pos) && TypeTraits<T2>.Check(L, pos + 1))
		{
			return TypeTraits<T3>.Check(L, pos + 2);
		}
		return false;
	}

	public static bool CheckTypes<T1, T2, T3, T4>(IntPtr L, int pos)
	{
		if (TypeTraits<T1>.Check(L, pos) && TypeTraits<T2>.Check(L, pos + 1) && TypeTraits<T3>.Check(L, pos + 2))
		{
			return TypeTraits<T4>.Check(L, pos + 3);
		}
		return false;
	}

	public static bool CheckTypes<T1, T2, T3, T4, T5>(IntPtr L, int pos)
	{
		if (TypeTraits<T1>.Check(L, pos) && TypeTraits<T2>.Check(L, pos + 1) && TypeTraits<T3>.Check(L, pos + 2) && TypeTraits<T4>.Check(L, pos + 3))
		{
			return TypeTraits<T5>.Check(L, pos + 4);
		}
		return false;
	}

	public static bool CheckTypes<T1, T2, T3, T4, T5, T6>(IntPtr L, int pos)
	{
		if (TypeTraits<T1>.Check(L, pos) && TypeTraits<T2>.Check(L, pos + 1) && TypeTraits<T3>.Check(L, pos + 2) && TypeTraits<T4>.Check(L, pos + 3) && TypeTraits<T5>.Check(L, pos + 4))
		{
			return TypeTraits<T6>.Check(L, pos + 5);
		}
		return false;
	}

	public static bool CheckTypes<T1, T2, T3, T4, T5, T6, T7>(IntPtr L, int pos)
	{
		if (TypeTraits<T1>.Check(L, pos) && TypeTraits<T2>.Check(L, pos + 1) && TypeTraits<T3>.Check(L, pos + 2) && TypeTraits<T4>.Check(L, pos + 3) && TypeTraits<T5>.Check(L, pos + 4) && TypeTraits<T6>.Check(L, pos + 5))
		{
			return TypeTraits<T7>.Check(L, pos + 6);
		}
		return false;
	}

	public static bool CheckTypes<T1, T2, T3, T4, T5, T6, T7, T8>(IntPtr L, int pos)
	{
		if (TypeTraits<T1>.Check(L, pos) && TypeTraits<T2>.Check(L, pos + 1) && TypeTraits<T3>.Check(L, pos + 2) && TypeTraits<T4>.Check(L, pos + 3) && TypeTraits<T5>.Check(L, pos + 4) && TypeTraits<T6>.Check(L, pos + 5) && TypeTraits<T7>.Check(L, pos + 6))
		{
			return TypeTraits<T8>.Check(L, pos + 7);
		}
		return false;
	}

	public static bool CheckTypes<T1, T2, T3, T4, T5, T6, T7, T8, T9>(IntPtr L, int pos)
	{
		if (TypeTraits<T1>.Check(L, pos) && TypeTraits<T2>.Check(L, pos + 1) && TypeTraits<T3>.Check(L, pos + 2) && TypeTraits<T4>.Check(L, pos + 3) && TypeTraits<T5>.Check(L, pos + 4) && TypeTraits<T6>.Check(L, pos + 5) && TypeTraits<T7>.Check(L, pos + 6) && TypeTraits<T8>.Check(L, pos + 7))
		{
			return TypeTraits<T9>.Check(L, pos + 8);
		}
		return false;
	}

	public static bool CheckTypes<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>(IntPtr L, int pos)
	{
		if (TypeTraits<T1>.Check(L, pos) && TypeTraits<T2>.Check(L, pos + 1) && TypeTraits<T3>.Check(L, pos + 2) && TypeTraits<T4>.Check(L, pos + 3) && TypeTraits<T5>.Check(L, pos + 4) && TypeTraits<T6>.Check(L, pos + 5) && TypeTraits<T7>.Check(L, pos + 6) && TypeTraits<T8>.Check(L, pos + 7) && TypeTraits<T9>.Check(L, pos + 8))
		{
			return TypeTraits<T10>.Check(L, pos + 9);
		}
		return false;
	}

	public static bool CheckTypes<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>(IntPtr L, int pos)
	{
		if (TypeTraits<T1>.Check(L, pos) && TypeTraits<T2>.Check(L, pos + 1) && TypeTraits<T3>.Check(L, pos + 2) && TypeTraits<T4>.Check(L, pos + 3) && TypeTraits<T5>.Check(L, pos + 4) && TypeTraits<T6>.Check(L, pos + 5) && TypeTraits<T7>.Check(L, pos + 6) && TypeTraits<T8>.Check(L, pos + 7) && TypeTraits<T9>.Check(L, pos + 8) && TypeTraits<T10>.Check(L, pos + 9))
		{
			return TypeTraits<T11>.Check(L, pos + 10);
		}
		return false;
	}

	public static bool CheckTypes<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12>(IntPtr L, int pos)
	{
		if (TypeTraits<T1>.Check(L, pos) && TypeTraits<T2>.Check(L, pos + 1) && TypeTraits<T3>.Check(L, pos + 2) && TypeTraits<T4>.Check(L, pos + 3) && TypeTraits<T5>.Check(L, pos + 4) && TypeTraits<T6>.Check(L, pos + 5) && TypeTraits<T7>.Check(L, pos + 6) && TypeTraits<T8>.Check(L, pos + 7) && TypeTraits<T9>.Check(L, pos + 8) && TypeTraits<T10>.Check(L, pos + 9) && TypeTraits<T11>.Check(L, pos + 10))
		{
			return TypeTraits<T12>.Check(L, pos + 11);
		}
		return false;
	}

	public static bool CheckParamsType<T>(IntPtr L, int begin, int count)
	{
		if (typeof(T) == typeof(object))
		{
			return true;
		}
		for (int i = 0; i < count; i++)
		{
			if (!TypeTraits<T>.Check(L, i + begin))
			{
				return false;
			}
		}
		return true;
	}

	public static bool CheckDelegateType(Type type, IntPtr L, int pos)
	{
		switch (LuaDLL.lua_type(L, pos))
		{
		case LuaTypes.LUA_TNIL:
			return true;
		case LuaTypes.LUA_TUSERDATA:
		{
			int num = LuaDLL.tolua_rawnetobj(L, pos);
			if (num != -1)
			{
				object obj = ObjectTranslator.Get(L).GetObject(num);
				if (obj != null)
				{
					return type == obj.GetType();
				}
				return true;
			}
			return false;
		}
		default:
			return false;
		}
	}

	public static bool CheckEnumType(Type type, IntPtr L, int pos)
	{
		if (LuaDLL.lua_type(L, pos) == LuaTypes.LUA_TUSERDATA)
		{
			int num = LuaDLL.tolua_rawnetobj(L, pos);
			if (num != -1)
			{
				object obj = ObjectTranslator.Get(L).GetObject(num);
				if (obj != null)
				{
					return type == obj.GetType();
				}
				return false;
			}
		}
		return false;
	}
}
