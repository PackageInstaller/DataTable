using System;
using Config;
using LuaInterface;

public class HitRecoverInfoWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(HitRecoverInfo), null);
		L.RegFunction("New", _CreateHitRecoverInfo);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("attackerID", get_attackerID, set_attackerID);
		L.RegVar("targetID", get_targetID, set_targetID);
		L.RegVar("status", get_status, set_status);
		L.RegVar("camp", get_camp, set_camp);
		L.RegVar("isAttackerLocalPlayer", get_isAttackerLocalPlayer, set_isAttackerLocalPlayer);
		L.RegVar("isTargetLocalPlayer", get_isTargetLocalPlayer, set_isTargetLocalPlayer);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateHitRecoverInfo(IntPtr L)
	{
		ToLua.PushValue(L, default(HitRecoverInfo));
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_attackerID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int attackerID = ((HitRecoverInfo)obj).attackerID;
			LuaDLL.lua_pushinteger(L, attackerID);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index attackerID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_targetID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int targetID = ((HitRecoverInfo)obj).targetID;
			LuaDLL.lua_pushinteger(L, targetID);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index targetID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_status(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			E_HitRecoverStatus status = ((HitRecoverInfo)obj).status;
			ToLua.Push(L, status);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index status on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_camp(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RoleType camp = ((HitRecoverInfo)obj).camp;
			ToLua.Push(L, camp);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index camp on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isAttackerLocalPlayer(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isAttackerLocalPlayer = ((HitRecoverInfo)obj).isAttackerLocalPlayer;
			LuaDLL.lua_pushboolean(L, isAttackerLocalPlayer);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isAttackerLocalPlayer on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isTargetLocalPlayer(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isTargetLocalPlayer = ((HitRecoverInfo)obj).isTargetLocalPlayer;
			LuaDLL.lua_pushboolean(L, isTargetLocalPlayer);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isTargetLocalPlayer on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_attackerID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			HitRecoverInfo hitRecoverInfo = (HitRecoverInfo)obj;
			int attackerID = (int)LuaDLL.luaL_checknumber(L, 2);
			hitRecoverInfo.attackerID = attackerID;
			ToLua.SetBack(L, 1, hitRecoverInfo);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index attackerID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_targetID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			HitRecoverInfo hitRecoverInfo = (HitRecoverInfo)obj;
			int targetID = (int)LuaDLL.luaL_checknumber(L, 2);
			hitRecoverInfo.targetID = targetID;
			ToLua.SetBack(L, 1, hitRecoverInfo);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index targetID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_status(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			HitRecoverInfo hitRecoverInfo = (HitRecoverInfo)obj;
			E_HitRecoverStatus status = (E_HitRecoverStatus)ToLua.CheckObject(L, 2, typeof(E_HitRecoverStatus));
			hitRecoverInfo.status = status;
			ToLua.SetBack(L, 1, hitRecoverInfo);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index status on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_camp(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			HitRecoverInfo hitRecoverInfo = (HitRecoverInfo)obj;
			RoleType camp = (RoleType)ToLua.CheckObject(L, 2, typeof(RoleType));
			hitRecoverInfo.camp = camp;
			ToLua.SetBack(L, 1, hitRecoverInfo);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index camp on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_isAttackerLocalPlayer(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			HitRecoverInfo hitRecoverInfo = (HitRecoverInfo)obj;
			bool isAttackerLocalPlayer = LuaDLL.luaL_checkboolean(L, 2);
			hitRecoverInfo.isAttackerLocalPlayer = isAttackerLocalPlayer;
			ToLua.SetBack(L, 1, hitRecoverInfo);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isAttackerLocalPlayer on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_isTargetLocalPlayer(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			HitRecoverInfo hitRecoverInfo = (HitRecoverInfo)obj;
			bool isTargetLocalPlayer = LuaDLL.luaL_checkboolean(L, 2);
			hitRecoverInfo.isTargetLocalPlayer = isTargetLocalPlayer;
			ToLua.SetBack(L, 1, hitRecoverInfo);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isTargetLocalPlayer on a nil value");
		}
	}
}
