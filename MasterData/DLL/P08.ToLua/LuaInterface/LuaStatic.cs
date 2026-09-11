using System;

namespace LuaInterface;

public static class LuaStatic
{
	public static int GetMetaReference(IntPtr L, Type t)
	{
		return LuaState.Get(L).GetMetaReference(t);
	}

	public static int GetMissMetaReference(IntPtr L, Type t)
	{
		return LuaState.Get(L).GetMissMetaReference(t);
	}

	public static Type GetClassType(IntPtr L, int reference)
	{
		return LuaState.Get(L).GetClassType(reference);
	}

	public static LuaFunction GetFunction(IntPtr L, int reference)
	{
		return LuaState.Get(L).GetFunction(reference);
	}

	public static LuaTable GetTable(IntPtr L, int reference)
	{
		return LuaState.Get(L).GetTable(reference);
	}

	public static LuaThread GetLuaThread(IntPtr L, int reference)
	{
		return LuaState.Get(L).GetLuaThread(reference);
	}

	public static void GetUnpackRayRef(IntPtr L)
	{
		LuaState luaState = LuaState.Get(L);
		LuaDLL.lua_getref(L, luaState.UnpackRay);
	}

	public static void GetUnpackBounds(IntPtr L)
	{
		LuaState luaState = LuaState.Get(L);
		LuaDLL.lua_getref(L, luaState.UnpackBounds);
	}

	public static void GetPackRay(IntPtr L)
	{
		LuaState luaState = LuaState.Get(L);
		LuaDLL.lua_getref(L, luaState.PackRay);
	}

	public static void GetPackRaycastHit(IntPtr L)
	{
		LuaState luaState = LuaState.Get(L);
		LuaDLL.lua_getref(L, luaState.PackRaycastHit);
	}

	public static void GetPackTouch(IntPtr L)
	{
		LuaState luaState = LuaState.Get(L);
		LuaDLL.lua_getref(L, luaState.PackTouch);
	}

	public static void GetPackBounds(IntPtr L)
	{
		LuaState luaState = LuaState.Get(L);
		LuaDLL.lua_getref(L, luaState.PackBounds);
	}

	public static int GetArrayMetatable(IntPtr L)
	{
		return LuaState.Get(L).ArrayMetatable;
	}

	public static int GetTypeMetatable(IntPtr L)
	{
		return LuaState.Get(L).TypeMetatable;
	}

	public static int GetDelegateMetatable(IntPtr L)
	{
		return LuaState.Get(L).DelegateMetatable;
	}

	public static int GetEventMetatable(IntPtr L)
	{
		return LuaState.Get(L).EventMetatable;
	}

	public static int GetIterMetatable(IntPtr L)
	{
		return LuaState.Get(L).IterMetatable;
	}

	public static int GetEnumObject(IntPtr L, Enum e, out object obj)
	{
		LuaState luaState = LuaState.Get(L);
		obj = luaState.GetEnumObj(e);
		return luaState.EnumMetatable;
	}

	public static LuaCSFunction GetPreModule(IntPtr L, Type t)
	{
		return LuaState.Get(L).GetPreModule(t);
	}
}
