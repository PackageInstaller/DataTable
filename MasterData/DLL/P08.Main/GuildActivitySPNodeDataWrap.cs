using System;
using LuaInterface;

public class GuildActivitySPNodeDataWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(GuildActivitySPNodeData), typeof(object));
		L.RegFunction("New", _CreateGuildActivitySPNodeData);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("id", get_id, set_id);
		L.RegVar("occupied_num", get_occupied_num, set_occupied_num);
		L.RegVar("dispatch_num", get_dispatch_num, set_dispatch_num);
		L.RegVar("is_occupied", get_is_occupied, set_is_occupied);
		L.RegVar("myDispatchTime", get_myDispatchTime, set_myDispatchTime);
		L.RegVar("myDispatchCatId", get_myDispatchCatId, set_myDispatchCatId);
		L.RegVar("health", get_health, set_health);
		L.RegVar("eliteHealthRate", get_eliteHealthRate, set_eliteHealthRate);
		L.RegVar("map_id", get_map_id, set_map_id);
		L.RegVar("type", get_type, set_type);
		L.RegVar("level", get_level, set_level);
		L.RegVar("stage_id", get_stage_id, set_stage_id);
		L.RegVar("vitality_cost", get_vitality_cost, set_vitality_cost);
		L.RegVar("token_get", get_token_get, set_token_get);
		L.RegVar("boss_score", get_boss_score, set_boss_score);
		L.RegVar("boss_stage_hp", get_boss_stage_hp, set_boss_stage_hp);
		L.RegVar("boss_name", get_boss_name, set_boss_name);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateGuildActivitySPNodeData(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				GuildActivitySPNodeData o = new GuildActivitySPNodeData();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: GuildActivitySPNodeData.New");
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
			int id = ((GuildActivitySPNodeData)obj).id;
			LuaDLL.lua_pushinteger(L, id);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index id on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_occupied_num(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int occupied_num = ((GuildActivitySPNodeData)obj).occupied_num;
			LuaDLL.lua_pushinteger(L, occupied_num);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index occupied_num on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_dispatch_num(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int dispatch_num = ((GuildActivitySPNodeData)obj).dispatch_num;
			LuaDLL.lua_pushinteger(L, dispatch_num);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index dispatch_num on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_is_occupied(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int is_occupied = ((GuildActivitySPNodeData)obj).is_occupied;
			LuaDLL.lua_pushinteger(L, is_occupied);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index is_occupied on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_myDispatchTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int myDispatchTime = ((GuildActivitySPNodeData)obj).myDispatchTime;
			LuaDLL.lua_pushinteger(L, myDispatchTime);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index myDispatchTime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_myDispatchCatId(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int myDispatchCatId = ((GuildActivitySPNodeData)obj).myDispatchCatId;
			LuaDLL.lua_pushinteger(L, myDispatchCatId);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index myDispatchCatId on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_health(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int health = ((GuildActivitySPNodeData)obj).health;
			LuaDLL.lua_pushinteger(L, health);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index health on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_eliteHealthRate(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int eliteHealthRate = ((GuildActivitySPNodeData)obj).eliteHealthRate;
			LuaDLL.lua_pushinteger(L, eliteHealthRate);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index eliteHealthRate on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_map_id(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int map_id = ((GuildActivitySPNodeData)obj).map_id;
			LuaDLL.lua_pushinteger(L, map_id);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index map_id on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_type(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int type = ((GuildActivitySPNodeData)obj).type;
			LuaDLL.lua_pushinteger(L, type);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index type on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_level(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int level = ((GuildActivitySPNodeData)obj).level;
			LuaDLL.lua_pushinteger(L, level);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index level on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_stage_id(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int stage_id = ((GuildActivitySPNodeData)obj).stage_id;
			LuaDLL.lua_pushinteger(L, stage_id);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index stage_id on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_vitality_cost(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int vitality_cost = ((GuildActivitySPNodeData)obj).vitality_cost;
			LuaDLL.lua_pushinteger(L, vitality_cost);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index vitality_cost on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_token_get(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int token_get = ((GuildActivitySPNodeData)obj).token_get;
			LuaDLL.lua_pushinteger(L, token_get);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index token_get on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_boss_score(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int boss_score = ((GuildActivitySPNodeData)obj).boss_score;
			LuaDLL.lua_pushinteger(L, boss_score);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index boss_score on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_boss_stage_hp(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int boss_stage_hp = ((GuildActivitySPNodeData)obj).boss_stage_hp;
			LuaDLL.lua_pushinteger(L, boss_stage_hp);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index boss_stage_hp on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_boss_name(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string boss_name = ((GuildActivitySPNodeData)obj).boss_name;
			LuaDLL.lua_pushstring(L, boss_name);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index boss_name on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_id(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GuildActivitySPNodeData obj2 = (GuildActivitySPNodeData)obj;
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
	private static int set_occupied_num(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GuildActivitySPNodeData obj2 = (GuildActivitySPNodeData)obj;
			int occupied_num = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.occupied_num = occupied_num;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index occupied_num on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_dispatch_num(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GuildActivitySPNodeData obj2 = (GuildActivitySPNodeData)obj;
			int dispatch_num = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.dispatch_num = dispatch_num;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index dispatch_num on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_is_occupied(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GuildActivitySPNodeData obj2 = (GuildActivitySPNodeData)obj;
			int is_occupied = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.is_occupied = is_occupied;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index is_occupied on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_myDispatchTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GuildActivitySPNodeData obj2 = (GuildActivitySPNodeData)obj;
			int myDispatchTime = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.myDispatchTime = myDispatchTime;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index myDispatchTime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_myDispatchCatId(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GuildActivitySPNodeData obj2 = (GuildActivitySPNodeData)obj;
			int myDispatchCatId = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.myDispatchCatId = myDispatchCatId;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index myDispatchCatId on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_health(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GuildActivitySPNodeData obj2 = (GuildActivitySPNodeData)obj;
			int health = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.health = health;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index health on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_eliteHealthRate(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GuildActivitySPNodeData obj2 = (GuildActivitySPNodeData)obj;
			int eliteHealthRate = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.eliteHealthRate = eliteHealthRate;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index eliteHealthRate on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_map_id(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GuildActivitySPNodeData obj2 = (GuildActivitySPNodeData)obj;
			int map_id = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.map_id = map_id;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index map_id on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_type(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GuildActivitySPNodeData obj2 = (GuildActivitySPNodeData)obj;
			int type = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.type = type;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index type on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_level(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GuildActivitySPNodeData obj2 = (GuildActivitySPNodeData)obj;
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
	private static int set_stage_id(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GuildActivitySPNodeData obj2 = (GuildActivitySPNodeData)obj;
			int stage_id = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.stage_id = stage_id;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index stage_id on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_vitality_cost(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GuildActivitySPNodeData obj2 = (GuildActivitySPNodeData)obj;
			int vitality_cost = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.vitality_cost = vitality_cost;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index vitality_cost on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_token_get(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GuildActivitySPNodeData obj2 = (GuildActivitySPNodeData)obj;
			int token_get = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.token_get = token_get;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index token_get on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_boss_score(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GuildActivitySPNodeData obj2 = (GuildActivitySPNodeData)obj;
			int boss_score = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.boss_score = boss_score;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index boss_score on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_boss_stage_hp(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GuildActivitySPNodeData obj2 = (GuildActivitySPNodeData)obj;
			int boss_stage_hp = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.boss_stage_hp = boss_stage_hp;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index boss_stage_hp on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_boss_name(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GuildActivitySPNodeData obj2 = (GuildActivitySPNodeData)obj;
			string boss_name = ToLua.CheckString(L, 2);
			obj2.boss_name = boss_name;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index boss_name on a nil value");
		}
	}
}
