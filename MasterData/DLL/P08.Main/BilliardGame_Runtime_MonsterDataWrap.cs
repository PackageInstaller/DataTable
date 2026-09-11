using System;
using BilliardGame.Runtime;
using LuaInterface;
using UnityEngine;

public class BilliardGame_Runtime_MonsterDataWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(MonsterData), typeof(object));
		L.RegFunction("New", _CreateBilliardGame_Runtime_MonsterData);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("index", get_index, set_index);
		L.RegVar("entityId", get_entityId, set_entityId);
		L.RegVar("path", get_path, set_path);
		L.RegVar("turnType", get_turnType, set_turnType);
		L.RegVar("turn", get_turn, set_turn);
		L.RegVar("afterWave", get_afterWave, set_afterWave);
		L.RegVar("wave", get_wave, set_wave);
		L.RegVar("position", get_position, set_position);
		L.RegVar("rotation", get_rotation, set_rotation);
		L.RegVar("scale", get_scale, set_scale);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateBilliardGame_Runtime_MonsterData(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				MonsterData o = new MonsterData();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: BilliardGame.Runtime.MonsterData.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_index(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int index = ((MonsterData)obj).index;
			LuaDLL.lua_pushinteger(L, index);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index index on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_entityId(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int entityId = ((MonsterData)obj).entityId;
			LuaDLL.lua_pushinteger(L, entityId);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index entityId on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_path(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string path = ((MonsterData)obj).path;
			LuaDLL.lua_pushstring(L, path);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index path on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_turnType(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BilliardTurnType turnType = ((MonsterData)obj).turnType;
			ToLua.Push(L, turnType);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index turnType on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_turn(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int turn = ((MonsterData)obj).turn;
			LuaDLL.lua_pushinteger(L, turn);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index turn on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_afterWave(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int afterWave = ((MonsterData)obj).afterWave;
			LuaDLL.lua_pushinteger(L, afterWave);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index afterWave on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_wave(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int wave = ((MonsterData)obj).wave;
			LuaDLL.lua_pushinteger(L, wave);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index wave on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_position(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector3 position = ((MonsterData)obj).position;
			ToLua.Push(L, position);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index position on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_rotation(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector3 rotation = ((MonsterData)obj).rotation;
			ToLua.Push(L, rotation);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index rotation on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_scale(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector3 scale = ((MonsterData)obj).scale;
			ToLua.Push(L, scale);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index scale on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_index(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			MonsterData obj2 = (MonsterData)obj;
			int index = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.index = index;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index index on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_entityId(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			MonsterData obj2 = (MonsterData)obj;
			int entityId = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.entityId = entityId;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index entityId on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_path(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			MonsterData obj2 = (MonsterData)obj;
			string path = ToLua.CheckString(L, 2);
			obj2.path = path;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index path on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_turnType(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			MonsterData obj2 = (MonsterData)obj;
			BilliardTurnType turnType = (BilliardTurnType)ToLua.CheckObject(L, 2, typeof(BilliardTurnType));
			obj2.turnType = turnType;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index turnType on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_turn(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			MonsterData obj2 = (MonsterData)obj;
			int turn = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.turn = turn;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index turn on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_afterWave(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			MonsterData obj2 = (MonsterData)obj;
			int afterWave = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.afterWave = afterWave;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index afterWave on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_wave(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			MonsterData obj2 = (MonsterData)obj;
			int wave = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.wave = wave;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index wave on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_position(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			MonsterData obj2 = (MonsterData)obj;
			Vector3 position = ToLua.ToVector3(L, 2);
			obj2.position = position;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index position on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_rotation(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			MonsterData obj2 = (MonsterData)obj;
			Vector3 rotation = ToLua.ToVector3(L, 2);
			obj2.rotation = rotation;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index rotation on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_scale(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			MonsterData obj2 = (MonsterData)obj;
			Vector3 scale = ToLua.ToVector3(L, 2);
			obj2.scale = scale;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index scale on a nil value");
		}
	}
}
