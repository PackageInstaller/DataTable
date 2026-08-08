using System;
using LuaInterface;

public class GuildActivityNodeDataWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(GuildActivityNodeData), typeof(object));
		L.RegFunction("New", _CreateGuildActivityNodeData);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("id", get_id, set_id);
		L.RegVar("occupied_num", get_occupied_num, set_occupied_num);
		L.RegVar("processing_num", get_processing_num, set_processing_num);
		L.RegVar("myOccupiedTimestamp", get_myOccupiedTimestamp, set_myOccupiedTimestamp);
		L.RegVar("myProcessingTimestamp", get_myProcessingTimestamp, set_myProcessingTimestamp);
		L.RegVar("processingType", get_processingType, set_processingType);
		L.RegVar("health", get_health, set_health);
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
	private static int _CreateGuildActivityNodeData(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				GuildActivityNodeData o = new GuildActivityNodeData();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: GuildActivityNodeData.New");
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
			int id = ((GuildActivityNodeData)obj).id;
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
			int occupied_num = ((GuildActivityNodeData)obj).occupied_num;
			LuaDLL.lua_pushinteger(L, occupied_num);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index occupied_num on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_processing_num(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int processing_num = ((GuildActivityNodeData)obj).processing_num;
			LuaDLL.lua_pushinteger(L, processing_num);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index processing_num on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_myOccupiedTimestamp(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int myOccupiedTimestamp = ((GuildActivityNodeData)obj).myOccupiedTimestamp;
			LuaDLL.lua_pushinteger(L, myOccupiedTimestamp);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index myOccupiedTimestamp on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_myProcessingTimestamp(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int myProcessingTimestamp = ((GuildActivityNodeData)obj).myProcessingTimestamp;
			LuaDLL.lua_pushinteger(L, myProcessingTimestamp);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index myProcessingTimestamp on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_processingType(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int processingType = ((GuildActivityNodeData)obj).processingType;
			LuaDLL.lua_pushinteger(L, processingType);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index processingType on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_health(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int health = ((GuildActivityNodeData)obj).health;
			LuaDLL.lua_pushinteger(L, health);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index health on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_map_id(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int map_id = ((GuildActivityNodeData)obj).map_id;
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
			int type = ((GuildActivityNodeData)obj).type;
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
			int level = ((GuildActivityNodeData)obj).level;
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
			int stage_id = ((GuildActivityNodeData)obj).stage_id;
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
			int vitality_cost = ((GuildActivityNodeData)obj).vitality_cost;
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
			int token_get = ((GuildActivityNodeData)obj).token_get;
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
			int boss_score = ((GuildActivityNodeData)obj).boss_score;
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
			int boss_stage_hp = ((GuildActivityNodeData)obj).boss_stage_hp;
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
			string boss_name = ((GuildActivityNodeData)obj).boss_name;
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
			GuildActivityNodeData obj2 = (GuildActivityNodeData)obj;
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
			GuildActivityNodeData obj2 = (GuildActivityNodeData)obj;
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
	private static int set_processing_num(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GuildActivityNodeData obj2 = (GuildActivityNodeData)obj;
			int processing_num = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.processing_num = processing_num;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index processing_num on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_myOccupiedTimestamp(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GuildActivityNodeData obj2 = (GuildActivityNodeData)obj;
			int myOccupiedTimestamp = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.myOccupiedTimestamp = myOccupiedTimestamp;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index myOccupiedTimestamp on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_myProcessingTimestamp(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GuildActivityNodeData obj2 = (GuildActivityNodeData)obj;
			int myProcessingTimestamp = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.myProcessingTimestamp = myProcessingTimestamp;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index myProcessingTimestamp on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_processingType(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GuildActivityNodeData obj2 = (GuildActivityNodeData)obj;
			int processingType = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.processingType = processingType;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index processingType on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_health(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GuildActivityNodeData obj2 = (GuildActivityNodeData)obj;
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
	private static int set_map_id(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GuildActivityNodeData obj2 = (GuildActivityNodeData)obj;
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
			GuildActivityNodeData obj2 = (GuildActivityNodeData)obj;
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
			GuildActivityNodeData obj2 = (GuildActivityNodeData)obj;
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
			GuildActivityNodeData obj2 = (GuildActivityNodeData)obj;
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
			GuildActivityNodeData obj2 = (GuildActivityNodeData)obj;
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
			GuildActivityNodeData obj2 = (GuildActivityNodeData)obj;
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
			GuildActivityNodeData obj2 = (GuildActivityNodeData)obj;
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
			GuildActivityNodeData obj2 = (GuildActivityNodeData)obj;
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
			GuildActivityNodeData obj2 = (GuildActivityNodeData)obj;
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
