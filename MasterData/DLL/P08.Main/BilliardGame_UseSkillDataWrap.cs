using System;
using BilliardGame;
using LuaInterface;

public class BilliardGame_UseSkillDataWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(UseSkillData), typeof(object));
		L.RegFunction("New", _CreateBilliardGame_UseSkillData);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("id", get_id, set_id);
		L.RegVar("useNum", get_useNum, set_useNum);
		L.RegVar("useRound", get_useRound, set_useRound);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateBilliardGame_UseSkillData(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 3)
			{
				int id = (int)LuaDLL.luaL_checknumber(L, 1);
				int useNum = (int)LuaDLL.luaL_checknumber(L, 2);
				int useRound = (int)LuaDLL.luaL_checknumber(L, 3);
				UseSkillData o = new UseSkillData(id, useNum, useRound);
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: BilliardGame.UseSkillData.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_id(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int id = ((UseSkillData)obj).id;
			LuaDLL.lua_pushinteger(L, id);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index id on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_useNum(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int useNum = ((UseSkillData)obj).useNum;
			LuaDLL.lua_pushinteger(L, useNum);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index useNum on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_useRound(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int useRound = ((UseSkillData)obj).useRound;
			LuaDLL.lua_pushinteger(L, useRound);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index useRound on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_id(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UseSkillData obj2 = (UseSkillData)obj;
			int id = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.id = id;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index id on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_useNum(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UseSkillData obj2 = (UseSkillData)obj;
			int useNum = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.useNum = useNum;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index useNum on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_useRound(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UseSkillData obj2 = (UseSkillData)obj;
			int useRound = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.useRound = useRound;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index useRound on a nil value");
		}
	}
}
