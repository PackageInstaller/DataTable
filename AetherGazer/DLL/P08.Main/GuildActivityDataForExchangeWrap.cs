using System;
using LuaInterface;

public class GuildActivityDataForExchangeWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(GuildActivityDataForExchange), typeof(object));
		L.RegFunction("New", _CreateGuildActivityDataForExchange);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("nodeId", get_nodeId, set_nodeId);
		L.RegVar("level", get_level, set_level);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateGuildActivityDataForExchange(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				GuildActivityDataForExchange o = new GuildActivityDataForExchange();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: GuildActivityDataForExchange.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_nodeId(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int nodeId = ((GuildActivityDataForExchange)obj).nodeId;
			LuaDLL.lua_pushinteger(L, nodeId);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index nodeId on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_level(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int level = ((GuildActivityDataForExchange)obj).level;
			LuaDLL.lua_pushinteger(L, level);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index level on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_nodeId(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GuildActivityDataForExchange obj2 = (GuildActivityDataForExchange)obj;
			int nodeId = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.nodeId = nodeId;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index nodeId on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_level(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GuildActivityDataForExchange obj2 = (GuildActivityDataForExchange)obj;
			int level = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.level = level;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index level on a nil value");
		}
	}
}
