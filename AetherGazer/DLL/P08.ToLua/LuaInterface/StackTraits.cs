using System;

namespace LuaInterface;

public static class StackTraits<T>
{
	public static Action<IntPtr, T> Push = SelectPush();

	public static Func<IntPtr, int, T> Check = DefaultCheck;

	public static Func<IntPtr, int, T> To = DefaultTo;

	public static void Init(Action<IntPtr, T> push, Func<IntPtr, int, T> check, Func<IntPtr, int, T> to)
	{
		if (push != null)
		{
			Push = push;
		}
		if (to != null)
		{
			To = to;
		}
		if (check != null)
		{
			Check = check;
		}
	}

	private static Action<IntPtr, T> SelectPush()
	{
		if (TypeTraits<T>.IsValueType)
		{
			return PushValue;
		}
		if (TypeTraits<T>.IsArray)
		{
			return PushArray;
		}
		return PushObject;
	}

	private static void PushValue(IntPtr L, T o)
	{
		ToLua.PushStruct(L, o);
	}

	private static void PushObject(IntPtr L, T o)
	{
		ToLua.PushObject(L, o);
	}

	private static void PushArray(IntPtr L, T array)
	{
		if (array == null)
		{
			LuaDLL.lua_pushnil(L);
			return;
		}
		int arrayMetatable = LuaStatic.GetArrayMetatable(L);
		ToLua.PushUserData(L, array, arrayMetatable);
	}

	private static T DefaultTo(IntPtr L, int pos)
	{
		return (T)ToLua.ToObject(L, pos);
	}

	private static T DefaultCheck(IntPtr L, int stackPos)
	{
		int num = LuaDLL.tolua_rawnetobj(L, stackPos);
		if (num != -1)
		{
			object obj = ObjectTranslator.Get(L).GetObject(num);
			if (obj != null)
			{
				if (obj is T)
				{
					return (T)obj;
				}
				LuaDLL.luaL_argerror(L, stackPos, $"{TypeTraits<T>.GetTypeName()} expected, got {obj.GetType().FullName}");
			}
			if (!TypeTraits<T>.IsValueType)
			{
				return default(T);
			}
		}
		else if (LuaDLL.lua_isnil(L, stackPos) && !TypeTraits<T>.IsValueType)
		{
			return default(T);
		}
		LuaDLL.luaL_typerror(L, stackPos, TypeTraits<T>.GetTypeName());
		return default(T);
	}
}
