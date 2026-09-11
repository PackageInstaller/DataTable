using System;
using LuaInterface;

public class HurtInfoWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(HurtInfo), null);
		L.RegFunction("New", _CreateHurtInfo);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("frameCount", get_frameCount, set_frameCount);
		L.RegVar("agentID", get_agentID, set_agentID);
		L.RegVar("isLocalPlayer", get_isLocalPlayer, set_isLocalPlayer);
		L.RegVar("agentOrder", get_agentOrder, set_agentOrder);
		L.RegVar("casterID", get_casterID, set_casterID);
		L.RegVar("IsCasterLocalPlayer", get_IsCasterLocalPlayer, set_IsCasterLocalPlayer);
		L.RegVar("casterAbilityID", get_casterAbilityID, set_casterAbilityID);
		L.RegVar("casterOrder", get_casterOrder, set_casterOrder);
		L.RegVar("damageType", get_damageType, set_damageType);
		L.RegVar("damageValue", get_damageValue, set_damageValue);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateHurtInfo(IntPtr L)
	{
		ToLua.PushValue(L, default(HurtInfo));
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_frameCount(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			uint frameCount = ((HurtInfo)obj).frameCount;
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
			int agentID = ((HurtInfo)obj).agentID;
			LuaDLL.lua_pushinteger(L, agentID);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index agentID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isLocalPlayer(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isLocalPlayer = ((HurtInfo)obj).isLocalPlayer;
			LuaDLL.lua_pushboolean(L, isLocalPlayer);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isLocalPlayer on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_agentOrder(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int agentOrder = ((HurtInfo)obj).agentOrder;
			LuaDLL.lua_pushinteger(L, agentOrder);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index agentOrder on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_casterID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int casterID = ((HurtInfo)obj).casterID;
			LuaDLL.lua_pushinteger(L, casterID);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index casterID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_IsCasterLocalPlayer(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isCasterLocalPlayer = ((HurtInfo)obj).IsCasterLocalPlayer;
			LuaDLL.lua_pushboolean(L, isCasterLocalPlayer);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index IsCasterLocalPlayer on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_casterAbilityID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int casterAbilityID = ((HurtInfo)obj).casterAbilityID;
			LuaDLL.lua_pushinteger(L, casterAbilityID);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index casterAbilityID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_casterOrder(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int casterOrder = ((HurtInfo)obj).casterOrder;
			LuaDLL.lua_pushinteger(L, casterOrder);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index casterOrder on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_damageType(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			DamageType damageType = ((HurtInfo)obj).damageType;
			ToLua.Push(L, damageType);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index damageType on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_damageValue(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			long damageValue = ((HurtInfo)obj).damageValue;
			LuaDLL.tolua_pushint64(L, damageValue);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index damageValue on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_frameCount(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			HurtInfo hurtInfo = (HurtInfo)obj;
			uint frameCount = (uint)LuaDLL.luaL_checknumber(L, 2);
			hurtInfo.frameCount = frameCount;
			ToLua.SetBack(L, 1, hurtInfo);
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
			HurtInfo hurtInfo = (HurtInfo)obj;
			int agentID = (int)LuaDLL.luaL_checknumber(L, 2);
			hurtInfo.agentID = agentID;
			ToLua.SetBack(L, 1, hurtInfo);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index agentID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_isLocalPlayer(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			HurtInfo hurtInfo = (HurtInfo)obj;
			bool isLocalPlayer = LuaDLL.luaL_checkboolean(L, 2);
			hurtInfo.isLocalPlayer = isLocalPlayer;
			ToLua.SetBack(L, 1, hurtInfo);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isLocalPlayer on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_agentOrder(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			HurtInfo hurtInfo = (HurtInfo)obj;
			int agentOrder = (int)LuaDLL.luaL_checknumber(L, 2);
			hurtInfo.agentOrder = agentOrder;
			ToLua.SetBack(L, 1, hurtInfo);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index agentOrder on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_casterID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			HurtInfo hurtInfo = (HurtInfo)obj;
			int casterID = (int)LuaDLL.luaL_checknumber(L, 2);
			hurtInfo.casterID = casterID;
			ToLua.SetBack(L, 1, hurtInfo);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index casterID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_IsCasterLocalPlayer(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			HurtInfo hurtInfo = (HurtInfo)obj;
			bool isCasterLocalPlayer = LuaDLL.luaL_checkboolean(L, 2);
			hurtInfo.IsCasterLocalPlayer = isCasterLocalPlayer;
			ToLua.SetBack(L, 1, hurtInfo);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index IsCasterLocalPlayer on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_casterAbilityID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			HurtInfo hurtInfo = (HurtInfo)obj;
			int casterAbilityID = (int)LuaDLL.luaL_checknumber(L, 2);
			hurtInfo.casterAbilityID = casterAbilityID;
			ToLua.SetBack(L, 1, hurtInfo);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index casterAbilityID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_casterOrder(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			HurtInfo hurtInfo = (HurtInfo)obj;
			int casterOrder = (int)LuaDLL.luaL_checknumber(L, 2);
			hurtInfo.casterOrder = casterOrder;
			ToLua.SetBack(L, 1, hurtInfo);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index casterOrder on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_damageType(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			HurtInfo hurtInfo = (HurtInfo)obj;
			DamageType damageType = (DamageType)ToLua.CheckObject(L, 2, typeof(DamageType));
			hurtInfo.damageType = damageType;
			ToLua.SetBack(L, 1, hurtInfo);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index damageType on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_damageValue(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			HurtInfo hurtInfo = (HurtInfo)obj;
			long damageValue = LuaDLL.tolua_checkint64(L, 2);
			hurtInfo.damageValue = damageValue;
			ToLua.SetBack(L, 1, hurtInfo);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index damageValue on a nil value");
		}
	}
}
