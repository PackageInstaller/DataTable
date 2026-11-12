using System;
using XLua.LuaDLL;

namespace XLua.CSObjectWrap;

public class SoldierLevelControllerSoldierMsgWrap
{
	public static void __Register(IntPtr L)
	{
		ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
		Type typeFromHandle = typeof(SoldierLevelController.SoldierMsg);
		Utils.BeginObjectRegister(typeFromHandle, L, translator, 0, 0, 5, 5);
		Utils.RegisterFunc(L, -2, "nSoldierId", _g_get_nSoldierId);
		Utils.RegisterFunc(L, -2, "nBattleRole", _g_get_nBattleRole);
		Utils.RegisterFunc(L, -2, "boardIndex", _g_get_boardIndex);
		Utils.RegisterFunc(L, -2, "nSoldierLv", _g_get_nSoldierLv);
		Utils.RegisterFunc(L, -2, "soldierAttr", _g_get_soldierAttr);
		Utils.RegisterFunc(L, -1, "nSoldierId", _s_set_nSoldierId);
		Utils.RegisterFunc(L, -1, "nBattleRole", _s_set_nBattleRole);
		Utils.RegisterFunc(L, -1, "boardIndex", _s_set_boardIndex);
		Utils.RegisterFunc(L, -1, "nSoldierLv", _s_set_nSoldierLv);
		Utils.RegisterFunc(L, -1, "soldierAttr", _s_set_soldierAttr);
		Utils.EndObjectRegister(typeFromHandle, L, translator, null, null, null, null, null);
		Utils.BeginClassRegister(typeFromHandle, L, __CreateInstance, 1, 0, 0);
		Utils.EndClassRegister(typeFromHandle, L, translator);
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int __CreateInstance(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			if (Lua.lua_gettop(L) == 6 && LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 2) && LuaTypes.LUA_TBOOLEAN == Lua.lua_type(L, 3) && LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 4) && LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 5) && objectTranslator.Assignable<SoldierLevelController.SoldierAttr>(L, 6))
			{
				int nSoldierId = Lua.xlua_tointeger(L, 2);
				bool nBattleRole = Lua.lua_toboolean(L, 3);
				int boardIndex = Lua.xlua_tointeger(L, 4);
				int nSoldierLv = Lua.xlua_tointeger(L, 5);
				objectTranslator.Get(L, 6, out SoldierLevelController.SoldierAttr v);
				SoldierLevelController.SoldierMsg soldierMsg = new SoldierLevelController.SoldierMsg(nSoldierId, nBattleRole, boardIndex, nSoldierLv, v);
				objectTranslator.Push(L, soldierMsg);
				return 1;
			}
			if (Lua.lua_gettop(L) == 1)
			{
				objectTranslator.Push(L, default(SoldierLevelController.SoldierMsg));
				return 1;
			}
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return Lua.luaL_error(L, "invalid arguments to SoldierLevelController.SoldierMsg constructor!");
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _g_get_nSoldierId(IntPtr L)
	{
		try
		{
			ObjectTranslatorPool.Instance.Find(L).Get(L, 1, out SoldierLevelController.SoldierMsg v);
			Lua.xlua_pushinteger(L, v.nSoldierId);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 1;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _g_get_nBattleRole(IntPtr L)
	{
		try
		{
			ObjectTranslatorPool.Instance.Find(L).Get(L, 1, out SoldierLevelController.SoldierMsg v);
			Lua.lua_pushboolean(L, v.nBattleRole);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 1;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _g_get_boardIndex(IntPtr L)
	{
		try
		{
			ObjectTranslatorPool.Instance.Find(L).Get(L, 1, out SoldierLevelController.SoldierMsg v);
			Lua.xlua_pushinteger(L, v.boardIndex);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 1;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _g_get_nSoldierLv(IntPtr L)
	{
		try
		{
			ObjectTranslatorPool.Instance.Find(L).Get(L, 1, out SoldierLevelController.SoldierMsg v);
			Lua.xlua_pushinteger(L, v.nSoldierLv);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 1;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _g_get_soldierAttr(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			objectTranslator.Get(L, 1, out SoldierLevelController.SoldierMsg v);
			objectTranslator.Push(L, v.soldierAttr);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 1;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _s_set_nSoldierId(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			objectTranslator.Get(L, 1, out SoldierLevelController.SoldierMsg v);
			v.nSoldierId = Lua.xlua_tointeger(L, 2);
			objectTranslator.Update(L, 1, v);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 0;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _s_set_nBattleRole(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			objectTranslator.Get(L, 1, out SoldierLevelController.SoldierMsg v);
			v.nBattleRole = Lua.lua_toboolean(L, 2);
			objectTranslator.Update(L, 1, v);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 0;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _s_set_boardIndex(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			objectTranslator.Get(L, 1, out SoldierLevelController.SoldierMsg v);
			v.boardIndex = Lua.xlua_tointeger(L, 2);
			objectTranslator.Update(L, 1, v);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 0;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _s_set_nSoldierLv(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			objectTranslator.Get(L, 1, out SoldierLevelController.SoldierMsg v);
			v.nSoldierLv = Lua.xlua_tointeger(L, 2);
			objectTranslator.Update(L, 1, v);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 0;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _s_set_soldierAttr(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			objectTranslator.Get(L, 1, out SoldierLevelController.SoldierMsg v);
			objectTranslator.Get(L, 2, out SoldierLevelController.SoldierAttr v2);
			v.soldierAttr = v2;
			objectTranslator.Update(L, 1, v);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 0;
	}
}
