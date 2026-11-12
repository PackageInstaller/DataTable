using System;
using XLua.LuaDLL;

namespace XLua.CSObjectWrap;

public class SoldierLevelControllerSoldierAttrWrap
{
	public static void __Register(IntPtr L)
	{
		ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
		Type typeFromHandle = typeof(SoldierLevelController.SoldierAttr);
		Utils.BeginObjectRegister(typeFromHandle, L, translator, 0, 0, 16, 16);
		Utils.RegisterFunc(L, -2, "Hp", _g_get_Hp);
		Utils.RegisterFunc(L, -2, "HpMax", _g_get_HpMax);
		Utils.RegisterFunc(L, -2, "Atk", _g_get_Atk);
		Utils.RegisterFunc(L, -2, "Def", _g_get_Def);
		Utils.RegisterFunc(L, -2, "CritRate", _g_get_CritRate);
		Utils.RegisterFunc(L, -2, "CritResistance", _g_get_CritResistance);
		Utils.RegisterFunc(L, -2, "CritPower", _g_get_CritPower);
		Utils.RegisterFunc(L, -2, "HitRate", _g_get_HitRate);
		Utils.RegisterFunc(L, -2, "Evd", _g_get_Evd);
		Utils.RegisterFunc(L, -2, "DefPierce", _g_get_DefPierce);
		Utils.RegisterFunc(L, -2, "DefIgnore", _g_get_DefIgnore);
		Utils.RegisterFunc(L, -2, "Suppress", _g_get_Suppress);
		Utils.RegisterFunc(L, -2, "Energy", _g_get_Energy);
		Utils.RegisterFunc(L, -2, "InitialEnergy", _g_get_InitialEnergy);
		Utils.RegisterFunc(L, -2, "Recovery", _g_get_Recovery);
		Utils.RegisterFunc(L, -2, "ATKSPD_P", _g_get_ATKSPD_P);
		Utils.RegisterFunc(L, -1, "Hp", _s_set_Hp);
		Utils.RegisterFunc(L, -1, "HpMax", _s_set_HpMax);
		Utils.RegisterFunc(L, -1, "Atk", _s_set_Atk);
		Utils.RegisterFunc(L, -1, "Def", _s_set_Def);
		Utils.RegisterFunc(L, -1, "CritRate", _s_set_CritRate);
		Utils.RegisterFunc(L, -1, "CritResistance", _s_set_CritResistance);
		Utils.RegisterFunc(L, -1, "CritPower", _s_set_CritPower);
		Utils.RegisterFunc(L, -1, "HitRate", _s_set_HitRate);
		Utils.RegisterFunc(L, -1, "Evd", _s_set_Evd);
		Utils.RegisterFunc(L, -1, "DefPierce", _s_set_DefPierce);
		Utils.RegisterFunc(L, -1, "DefIgnore", _s_set_DefIgnore);
		Utils.RegisterFunc(L, -1, "Suppress", _s_set_Suppress);
		Utils.RegisterFunc(L, -1, "Energy", _s_set_Energy);
		Utils.RegisterFunc(L, -1, "InitialEnergy", _s_set_InitialEnergy);
		Utils.RegisterFunc(L, -1, "Recovery", _s_set_Recovery);
		Utils.RegisterFunc(L, -1, "ATKSPD_P", _s_set_ATKSPD_P);
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
			if (Lua.lua_gettop(L) == 1)
			{
				objectTranslator.Push(L, default(SoldierLevelController.SoldierAttr));
				return 1;
			}
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return Lua.luaL_error(L, "invalid arguments to SoldierLevelController.SoldierAttr constructor!");
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _g_get_Hp(IntPtr L)
	{
		try
		{
			ObjectTranslatorPool.Instance.Find(L).Get(L, 1, out SoldierLevelController.SoldierAttr v);
			Lua.xlua_pushinteger(L, v.Hp);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 1;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _g_get_HpMax(IntPtr L)
	{
		try
		{
			ObjectTranslatorPool.Instance.Find(L).Get(L, 1, out SoldierLevelController.SoldierAttr v);
			Lua.xlua_pushinteger(L, v.HpMax);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 1;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _g_get_Atk(IntPtr L)
	{
		try
		{
			ObjectTranslatorPool.Instance.Find(L).Get(L, 1, out SoldierLevelController.SoldierAttr v);
			Lua.xlua_pushinteger(L, v.Atk);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 1;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _g_get_Def(IntPtr L)
	{
		try
		{
			ObjectTranslatorPool.Instance.Find(L).Get(L, 1, out SoldierLevelController.SoldierAttr v);
			Lua.xlua_pushinteger(L, v.Def);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 1;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _g_get_CritRate(IntPtr L)
	{
		try
		{
			ObjectTranslatorPool.Instance.Find(L).Get(L, 1, out SoldierLevelController.SoldierAttr v);
			Lua.xlua_pushinteger(L, v.CritRate);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 1;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _g_get_CritResistance(IntPtr L)
	{
		try
		{
			ObjectTranslatorPool.Instance.Find(L).Get(L, 1, out SoldierLevelController.SoldierAttr v);
			Lua.xlua_pushinteger(L, v.CritResistance);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 1;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _g_get_CritPower(IntPtr L)
	{
		try
		{
			ObjectTranslatorPool.Instance.Find(L).Get(L, 1, out SoldierLevelController.SoldierAttr v);
			Lua.xlua_pushinteger(L, v.CritPower);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 1;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _g_get_HitRate(IntPtr L)
	{
		try
		{
			ObjectTranslatorPool.Instance.Find(L).Get(L, 1, out SoldierLevelController.SoldierAttr v);
			Lua.xlua_pushinteger(L, v.HitRate);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 1;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _g_get_Evd(IntPtr L)
	{
		try
		{
			ObjectTranslatorPool.Instance.Find(L).Get(L, 1, out SoldierLevelController.SoldierAttr v);
			Lua.xlua_pushinteger(L, v.Evd);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 1;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _g_get_DefPierce(IntPtr L)
	{
		try
		{
			ObjectTranslatorPool.Instance.Find(L).Get(L, 1, out SoldierLevelController.SoldierAttr v);
			Lua.xlua_pushinteger(L, v.DefPierce);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 1;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _g_get_DefIgnore(IntPtr L)
	{
		try
		{
			ObjectTranslatorPool.Instance.Find(L).Get(L, 1, out SoldierLevelController.SoldierAttr v);
			Lua.xlua_pushinteger(L, v.DefIgnore);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 1;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _g_get_Suppress(IntPtr L)
	{
		try
		{
			ObjectTranslatorPool.Instance.Find(L).Get(L, 1, out SoldierLevelController.SoldierAttr v);
			Lua.xlua_pushinteger(L, v.Suppress);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 1;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _g_get_Energy(IntPtr L)
	{
		try
		{
			ObjectTranslatorPool.Instance.Find(L).Get(L, 1, out SoldierLevelController.SoldierAttr v);
			Lua.xlua_pushinteger(L, v.Energy);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 1;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _g_get_InitialEnergy(IntPtr L)
	{
		try
		{
			ObjectTranslatorPool.Instance.Find(L).Get(L, 1, out SoldierLevelController.SoldierAttr v);
			Lua.xlua_pushinteger(L, v.InitialEnergy);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 1;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _g_get_Recovery(IntPtr L)
	{
		try
		{
			ObjectTranslatorPool.Instance.Find(L).Get(L, 1, out SoldierLevelController.SoldierAttr v);
			Lua.lua_pushnumber(L, v.Recovery);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 1;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _g_get_ATKSPD_P(IntPtr L)
	{
		try
		{
			ObjectTranslatorPool.Instance.Find(L).Get(L, 1, out SoldierLevelController.SoldierAttr v);
			Lua.xlua_pushinteger(L, v.ATKSPD_P);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 1;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _s_set_Hp(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			objectTranslator.Get(L, 1, out SoldierLevelController.SoldierAttr v);
			v.Hp = Lua.xlua_tointeger(L, 2);
			objectTranslator.Update(L, 1, v);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 0;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _s_set_HpMax(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			objectTranslator.Get(L, 1, out SoldierLevelController.SoldierAttr v);
			v.HpMax = Lua.xlua_tointeger(L, 2);
			objectTranslator.Update(L, 1, v);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 0;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _s_set_Atk(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			objectTranslator.Get(L, 1, out SoldierLevelController.SoldierAttr v);
			v.Atk = Lua.xlua_tointeger(L, 2);
			objectTranslator.Update(L, 1, v);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 0;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _s_set_Def(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			objectTranslator.Get(L, 1, out SoldierLevelController.SoldierAttr v);
			v.Def = Lua.xlua_tointeger(L, 2);
			objectTranslator.Update(L, 1, v);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 0;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _s_set_CritRate(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			objectTranslator.Get(L, 1, out SoldierLevelController.SoldierAttr v);
			v.CritRate = Lua.xlua_tointeger(L, 2);
			objectTranslator.Update(L, 1, v);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 0;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _s_set_CritResistance(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			objectTranslator.Get(L, 1, out SoldierLevelController.SoldierAttr v);
			v.CritResistance = Lua.xlua_tointeger(L, 2);
			objectTranslator.Update(L, 1, v);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 0;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _s_set_CritPower(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			objectTranslator.Get(L, 1, out SoldierLevelController.SoldierAttr v);
			v.CritPower = Lua.xlua_tointeger(L, 2);
			objectTranslator.Update(L, 1, v);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 0;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _s_set_HitRate(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			objectTranslator.Get(L, 1, out SoldierLevelController.SoldierAttr v);
			v.HitRate = Lua.xlua_tointeger(L, 2);
			objectTranslator.Update(L, 1, v);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 0;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _s_set_Evd(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			objectTranslator.Get(L, 1, out SoldierLevelController.SoldierAttr v);
			v.Evd = Lua.xlua_tointeger(L, 2);
			objectTranslator.Update(L, 1, v);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 0;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _s_set_DefPierce(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			objectTranslator.Get(L, 1, out SoldierLevelController.SoldierAttr v);
			v.DefPierce = Lua.xlua_tointeger(L, 2);
			objectTranslator.Update(L, 1, v);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 0;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _s_set_DefIgnore(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			objectTranslator.Get(L, 1, out SoldierLevelController.SoldierAttr v);
			v.DefIgnore = Lua.xlua_tointeger(L, 2);
			objectTranslator.Update(L, 1, v);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 0;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _s_set_Suppress(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			objectTranslator.Get(L, 1, out SoldierLevelController.SoldierAttr v);
			v.Suppress = Lua.xlua_tointeger(L, 2);
			objectTranslator.Update(L, 1, v);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 0;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _s_set_Energy(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			objectTranslator.Get(L, 1, out SoldierLevelController.SoldierAttr v);
			v.Energy = Lua.xlua_tointeger(L, 2);
			objectTranslator.Update(L, 1, v);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 0;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _s_set_InitialEnergy(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			objectTranslator.Get(L, 1, out SoldierLevelController.SoldierAttr v);
			v.InitialEnergy = Lua.xlua_tointeger(L, 2);
			objectTranslator.Update(L, 1, v);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 0;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _s_set_Recovery(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			objectTranslator.Get(L, 1, out SoldierLevelController.SoldierAttr v);
			v.Recovery = (float)Lua.lua_tonumber(L, 2);
			objectTranslator.Update(L, 1, v);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 0;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _s_set_ATKSPD_P(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			objectTranslator.Get(L, 1, out SoldierLevelController.SoldierAttr v);
			v.ATKSPD_P = Lua.xlua_tointeger(L, 2);
			objectTranslator.Update(L, 1, v);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 0;
	}
}
