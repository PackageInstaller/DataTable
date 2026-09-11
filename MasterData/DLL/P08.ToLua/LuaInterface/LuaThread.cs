using System;

namespace LuaInterface;

public class LuaThread : LuaBaseRef
{
	public LuaThread(int reference, LuaState state)
	{
		luaState = state;
		base.reference = reference;
	}

	protected int Resume(IntPtr L, int nArgs)
	{
		int num = LuaDLL.lua_resume(L, nArgs);
		if (num > 1)
		{
			int num2 = LuaDLL.lua_gettop(L);
			LuaDLL.tolua_pushtraceback(L);
			LuaDLL.lua_pushthread(L);
			LuaDLL.lua_pushvalue(L, num2);
			if (LuaDLL.lua_pcall(L, 2, -1, 0) != 0)
			{
				LuaDLL.lua_settop(L, num2);
			}
			string msg = LuaDLL.lua_tostring(L, -1);
			luaState.LuaSetTop(0);
			throw new LuaException(msg);
		}
		return num;
	}

	public int Resume()
	{
		luaState.Push(this);
		IntPtr l = luaState.LuaToThread(-1);
		luaState.LuaPop(1);
		int num = Resume(l, 0);
		if (num == 0)
		{
			Dispose();
		}
		return num;
	}

	public int Resume<T1>(T1 arg1)
	{
		luaState.Push(this);
		IntPtr intPtr = luaState.LuaToThread(-1);
		luaState.LuaPop(1);
		StackTraits<T1>.Push(intPtr, arg1);
		int num = Resume(intPtr, 1);
		if (num == 0)
		{
			Dispose();
		}
		return num;
	}

	public int Resume<T1, T2>(T1 arg1, T2 arg2)
	{
		luaState.Push(this);
		IntPtr intPtr = luaState.LuaToThread(-1);
		luaState.LuaPop(1);
		StackTraits<T1>.Push(intPtr, arg1);
		StackTraits<T2>.Push(intPtr, arg2);
		int num = Resume(intPtr, 2);
		if (num == 0)
		{
			Dispose();
		}
		return num;
	}

	public int Resume<T1, T2, T3>(T1 arg1, T2 arg2, T3 arg3)
	{
		luaState.Push(this);
		IntPtr intPtr = luaState.LuaToThread(-1);
		luaState.LuaPop(1);
		StackTraits<T1>.Push(intPtr, arg1);
		StackTraits<T2>.Push(intPtr, arg2);
		StackTraits<T3>.Push(intPtr, arg3);
		int num = Resume(intPtr, 3);
		if (num == 0)
		{
			Dispose();
		}
		return num;
	}

	public int Resume<R1>(out R1 ret1)
	{
		luaState.Push(this);
		IntPtr intPtr = luaState.LuaToThread(-1);
		luaState.LuaPop(1);
		int num = Resume(intPtr, 0);
		if (num == 0)
		{
			ret1 = default(R1);
			Dispose();
			return num;
		}
		int arg = LuaDLL.lua_gettop(intPtr);
		ret1 = StackTraits<R1>.Check(intPtr, arg);
		return num;
	}

	public int Resume<T1, R1>(T1 arg1, out R1 ret1)
	{
		luaState.Push(this);
		IntPtr intPtr = luaState.LuaToThread(-1);
		luaState.LuaPop(1);
		StackTraits<T1>.Push(intPtr, arg1);
		int num = Resume(intPtr, 1);
		if (num == 0)
		{
			ret1 = default(R1);
			Dispose();
			return num;
		}
		int arg2 = LuaDLL.lua_gettop(intPtr);
		ret1 = StackTraits<R1>.Check(intPtr, arg2);
		return num;
	}

	public int Resume<T1, T2, R1>(T1 arg1, T2 arg2, out R1 ret1)
	{
		luaState.Push(this);
		IntPtr intPtr = luaState.LuaToThread(-1);
		luaState.LuaPop(1);
		StackTraits<T1>.Push(intPtr, arg1);
		StackTraits<T2>.Push(intPtr, arg2);
		int num = Resume(intPtr, 2);
		if (num == 0)
		{
			ret1 = default(R1);
			Dispose();
			return num;
		}
		int arg3 = LuaDLL.lua_gettop(intPtr);
		ret1 = StackTraits<R1>.Check(intPtr, arg3);
		return num;
	}

	public int Resume<T1, T2, T3, R1>(T1 arg1, T2 arg2, T3 arg3, out R1 ret1)
	{
		luaState.Push(this);
		IntPtr intPtr = luaState.LuaToThread(-1);
		luaState.LuaPop(1);
		StackTraits<T1>.Push(intPtr, arg1);
		StackTraits<T2>.Push(intPtr, arg2);
		StackTraits<T3>.Push(intPtr, arg3);
		int num = Resume(intPtr, 3);
		if (num == 0)
		{
			ret1 = default(R1);
			Dispose();
			return num;
		}
		int arg4 = LuaDLL.lua_gettop(intPtr);
		ret1 = StackTraits<R1>.Check(intPtr, arg4);
		return num;
	}
}
