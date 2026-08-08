using System;
using LuaInterface;

public class GuildActivitySPDataForExchangeWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(GuildActivitySPDataForExchange), typeof(object));
		L.RegFunction("New", _CreateGuildActivitySPDataForExchange);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("nodeId", get_nodeId, set_nodeId);
		L.RegVar("level", get_level, set_level);
		L.RegVar("activityID", get_activityID, set_activityID);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateGuildActivitySPDataForExchange(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				GuildActivitySPDataForExchange o = new GuildActivitySPDataForExchange();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: GuildActivitySPDataForExchange.New");
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
			int nodeId = ((GuildActivitySPDataForExchange)obj).nodeId;
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
			int level = ((GuildActivitySPDataForExchange)obj).level;
			LuaDLL.lua_pushinteger(L, level);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index level on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_activityID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int activityID = ((GuildActivitySPDataForExchange)obj).activityID;
			LuaDLL.lua_pushinteger(L, activityID);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index activityID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_nodeId(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GuildActivitySPDataForExchange obj2 = (GuildActivitySPDataForExchange)obj;
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
			GuildActivitySPDataForExchange obj2 = (GuildActivitySPDataForExchange)obj;
			int level = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.level = level;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index level on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_activityID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GuildActivitySPDataForExchange obj2 = (GuildActivitySPDataForExchange)obj;
			int activityID = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.activityID = activityID;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index activityID on a nil value");
		}
	}
}
