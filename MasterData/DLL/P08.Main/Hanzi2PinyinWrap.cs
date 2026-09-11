using System;
using LuaInterface;

public class Hanzi2PinyinWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(Hanzi2Pinyin), typeof(object));
		L.RegFunction("GetFirst", GetFirst);
		L.RegFunction("Sort", Sort);
		L.RegFunction("New", _CreateHanzi2Pinyin);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateHanzi2Pinyin(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				Hanzi2Pinyin o = new Hanzi2Pinyin();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: Hanzi2Pinyin.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetFirst(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			string first = Hanzi2Pinyin.GetFirst(ToLua.CheckString(L, 1));
			LuaDLL.lua_pushstring(L, first);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Sort(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			string a = ToLua.CheckString(L, 1);
			string b = ToLua.CheckString(L, 2);
			bool value = Hanzi2Pinyin.Sort(a, b);
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
