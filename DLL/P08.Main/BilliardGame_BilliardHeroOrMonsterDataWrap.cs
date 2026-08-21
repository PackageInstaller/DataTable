using System;
using BilliardGame;
using LuaInterface;

public class BilliardGame_BilliardHeroOrMonsterDataWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(BilliardHeroOrMonsterData), typeof(object));
		L.RegFunction("New", _CreateBilliardGame_BilliardHeroOrMonsterData);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("id", get_id, set_id);
		L.RegVar("startHp", get_startHp, set_startHp);
		L.RegVar("endHp", get_endHp, set_endHp);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateBilliardGame_BilliardHeroOrMonsterData(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				BilliardHeroOrMonsterData o = new BilliardHeroOrMonsterData();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: BilliardGame.BilliardHeroOrMonsterData.New");
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
			int id = ((BilliardHeroOrMonsterData)obj).id;
			LuaDLL.lua_pushinteger(L, id);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index id on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_startHp(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int startHp = ((BilliardHeroOrMonsterData)obj).startHp;
			LuaDLL.lua_pushinteger(L, startHp);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index startHp on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_endHp(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int endHp = ((BilliardHeroOrMonsterData)obj).endHp;
			LuaDLL.lua_pushinteger(L, endHp);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index endHp on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_id(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BilliardHeroOrMonsterData obj2 = (BilliardHeroOrMonsterData)obj;
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
	private static int set_startHp(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BilliardHeroOrMonsterData obj2 = (BilliardHeroOrMonsterData)obj;
			int startHp = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.startHp = startHp;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index startHp on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_endHp(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BilliardHeroOrMonsterData obj2 = (BilliardHeroOrMonsterData)obj;
			int endHp = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.endHp = endHp;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index endHp on a nil value");
		}
	}
}
