using System;
using System.Collections.Generic;
using XLua.LuaDLL;

namespace XLua.CSObjectWrap;

public class SoldierLevelControllerSoldierLevelMsgWrap
{
	public static void __Register(IntPtr L)
	{
		ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
		Type typeFromHandle = typeof(SoldierLevelController.SoldierLevelMsg);
		Utils.BeginObjectRegister(typeFromHandle, L, translator, 0, 2, 4, 4);
		Utils.RegisterFunc(L, -3, "AddPartner", _m_AddPartner);
		Utils.RegisterFunc(L, -3, "ToJson", _m_ToJson);
		Utils.RegisterFunc(L, -2, "SoldierData", _g_get_SoldierData);
		Utils.RegisterFunc(L, -2, "PartnerArrDic", _g_get_PartnerArrDic);
		Utils.RegisterFunc(L, -2, "nHarvestCount", _g_get_nHarvestCount);
		Utils.RegisterFunc(L, -2, "buffEffectList", _g_get_buffEffectList);
		Utils.RegisterFunc(L, -1, "SoldierData", _s_set_SoldierData);
		Utils.RegisterFunc(L, -1, "PartnerArrDic", _s_set_PartnerArrDic);
		Utils.RegisterFunc(L, -1, "nHarvestCount", _s_set_nHarvestCount);
		Utils.RegisterFunc(L, -1, "buffEffectList", _s_set_buffEffectList);
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
			if (Lua.lua_gettop(L) == 2 && LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 2))
			{
				int a = Lua.xlua_tointeger(L, 2);
				SoldierLevelController.SoldierLevelMsg soldierLevelMsg = new SoldierLevelController.SoldierLevelMsg(a);
				objectTranslator.Push(L, soldierLevelMsg);
				return 1;
			}
			if (Lua.lua_gettop(L) == 1)
			{
				objectTranslator.Push(L, default(SoldierLevelController.SoldierLevelMsg));
				return 1;
			}
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return Lua.luaL_error(L, "invalid arguments to SoldierLevelController.SoldierLevelMsg constructor!");
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_AddPartner(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			objectTranslator.Get(L, 1, out SoldierLevelController.SoldierLevelMsg v);
			int partnerId = Lua.xlua_tointeger(L, 2);
			int[] soldiers = (int[])objectTranslator.GetObject(L, 3, typeof(int[]));
			v.AddPartner(partnerId, soldiers);
			objectTranslator.Update(L, 1, v);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_ToJson(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			objectTranslator.Get(L, 1, out SoldierLevelController.SoldierLevelMsg v);
			string str = v.ToJson();
			Lua.lua_pushstring(L, str);
			objectTranslator.Update(L, 1, v);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _g_get_SoldierData(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			objectTranslator.Get(L, 1, out SoldierLevelController.SoldierLevelMsg v);
			objectTranslator.Push(L, v.SoldierData);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 1;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _g_get_PartnerArrDic(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			objectTranslator.Get(L, 1, out SoldierLevelController.SoldierLevelMsg v);
			objectTranslator.Push(L, v.PartnerArrDic);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 1;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _g_get_nHarvestCount(IntPtr L)
	{
		try
		{
			ObjectTranslatorPool.Instance.Find(L).Get(L, 1, out SoldierLevelController.SoldierLevelMsg v);
			Lua.xlua_pushinteger(L, v.nHarvestCount);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 1;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _g_get_buffEffectList(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			objectTranslator.Get(L, 1, out SoldierLevelController.SoldierLevelMsg v);
			objectTranslator.Push(L, v.buffEffectList);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 1;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _s_set_SoldierData(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			objectTranslator.Get(L, 1, out SoldierLevelController.SoldierLevelMsg v);
			v.SoldierData = (List<SoldierLevelController.SoldierMsg>)objectTranslator.GetObject(L, 2, typeof(List<SoldierLevelController.SoldierMsg>));
			objectTranslator.Update(L, 1, v);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 0;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _s_set_PartnerArrDic(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			objectTranslator.Get(L, 1, out SoldierLevelController.SoldierLevelMsg v);
			v.PartnerArrDic = (Dictionary<int, List<int>>)objectTranslator.GetObject(L, 2, typeof(Dictionary<int, List<int>>));
			objectTranslator.Update(L, 1, v);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 0;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _s_set_nHarvestCount(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			objectTranslator.Get(L, 1, out SoldierLevelController.SoldierLevelMsg v);
			v.nHarvestCount = Lua.xlua_tointeger(L, 2);
			objectTranslator.Update(L, 1, v);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 0;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _s_set_buffEffectList(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			objectTranslator.Get(L, 1, out SoldierLevelController.SoldierLevelMsg v);
			v.buffEffectList = (List<int>)objectTranslator.GetObject(L, 2, typeof(List<int>));
			objectTranslator.Update(L, 1, v);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 0;
	}
}
