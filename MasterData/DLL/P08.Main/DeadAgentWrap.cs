using System;
using Config;
using LuaInterface;

public class DeadAgentWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(DeadAgent), null);
		L.RegFunction("New", _CreateDeadAgent);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("frameCount", get_frameCount, set_frameCount);
		L.RegVar("agentID", get_agentID, set_agentID);
		L.RegVar("camp", get_camp, set_camp);
		L.RegVar("isLocalPlayer", get_isLocalPlayer, set_isLocalPlayer);
		L.RegVar("killerID", get_killerID, set_killerID);
		L.RegVar("IsKillerLocalPlayer", get_IsKillerLocalPlayer, set_IsKillerLocalPlayer);
		L.RegVar("killerAbilityID", get_killerAbilityID, set_killerAbilityID);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateDeadAgent(IntPtr L)
	{
		ToLua.PushValue(L, default(DeadAgent));
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_frameCount(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			uint frameCount = ((DeadAgent)obj).frameCount;
			LuaDLL.lua_pushnumber(L, frameCount);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index frameCount on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_agentID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int agentID = ((DeadAgent)obj).agentID;
			LuaDLL.lua_pushinteger(L, agentID);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index agentID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_camp(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RoleType camp = ((DeadAgent)obj).camp;
			ToLua.Push(L, camp);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index camp on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isLocalPlayer(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isLocalPlayer = ((DeadAgent)obj).isLocalPlayer;
			LuaDLL.lua_pushboolean(L, isLocalPlayer);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isLocalPlayer on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_killerID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int killerID = ((DeadAgent)obj).killerID;
			LuaDLL.lua_pushinteger(L, killerID);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index killerID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_IsKillerLocalPlayer(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isKillerLocalPlayer = ((DeadAgent)obj).IsKillerLocalPlayer;
			LuaDLL.lua_pushboolean(L, isKillerLocalPlayer);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index IsKillerLocalPlayer on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_killerAbilityID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int killerAbilityID = ((DeadAgent)obj).killerAbilityID;
			LuaDLL.lua_pushinteger(L, killerAbilityID);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index killerAbilityID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_frameCount(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			DeadAgent deadAgent = (DeadAgent)obj;
			uint frameCount = (uint)LuaDLL.luaL_checknumber(L, 2);
			deadAgent.frameCount = frameCount;
			ToLua.SetBack(L, 1, deadAgent);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index frameCount on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_agentID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			DeadAgent deadAgent = (DeadAgent)obj;
			int agentID = (int)LuaDLL.luaL_checknumber(L, 2);
			deadAgent.agentID = agentID;
			ToLua.SetBack(L, 1, deadAgent);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index agentID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_camp(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			DeadAgent deadAgent = (DeadAgent)obj;
			RoleType camp = (RoleType)ToLua.CheckObject(L, 2, typeof(RoleType));
			deadAgent.camp = camp;
			ToLua.SetBack(L, 1, deadAgent);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index camp on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_isLocalPlayer(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			DeadAgent deadAgent = (DeadAgent)obj;
			bool isLocalPlayer = LuaDLL.luaL_checkboolean(L, 2);
			deadAgent.isLocalPlayer = isLocalPlayer;
			ToLua.SetBack(L, 1, deadAgent);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isLocalPlayer on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_killerID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			DeadAgent deadAgent = (DeadAgent)obj;
			int killerID = (int)LuaDLL.luaL_checknumber(L, 2);
			deadAgent.killerID = killerID;
			ToLua.SetBack(L, 1, deadAgent);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index killerID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_IsKillerLocalPlayer(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			DeadAgent deadAgent = (DeadAgent)obj;
			bool isKillerLocalPlayer = LuaDLL.luaL_checkboolean(L, 2);
			deadAgent.IsKillerLocalPlayer = isKillerLocalPlayer;
			ToLua.SetBack(L, 1, deadAgent);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index IsKillerLocalPlayer on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_killerAbilityID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			DeadAgent deadAgent = (DeadAgent)obj;
			int killerAbilityID = (int)LuaDLL.luaL_checknumber(L, 2);
			deadAgent.killerAbilityID = killerAbilityID;
			ToLua.SetBack(L, 1, deadAgent);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index killerAbilityID on a nil value");
		}
	}
}
