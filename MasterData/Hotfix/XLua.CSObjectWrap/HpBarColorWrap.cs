using System;
using UnityEngine;
using XLua.LuaDLL;

namespace XLua.CSObjectWrap;

public class HpBarColorWrap
{
	public static void __Register(IntPtr L)
	{
		ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
		Type typeFromHandle = typeof(HpBarColor);
		Utils.BeginObjectRegister(typeFromHandle, L, translator, 0, 3, 0, 0);
		Utils.RegisterFunc(L, -3, "Stop", _m_Stop);
		Utils.RegisterFunc(L, -3, "SetTarget", _m_SetTarget);
		Utils.RegisterFunc(L, -3, "HUDUpdate", _m_HUDUpdate);
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
				HpBarColor o = new HpBarColor();
				objectTranslator.Push(L, o);
				return 1;
			}
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return Lua.luaL_error(L, "invalid arguments to HpBarColor constructor!");
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_Stop(IntPtr L)
	{
		try
		{
			((HpBarColor)ObjectTranslatorPool.Instance.Find(L).FastGetCSObj(L, 1)).Stop();
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetTarget(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			HpBarColor hpBarColor = (HpBarColor)objectTranslator.FastGetCSObj(L, 1);
			objectTranslator.Get(L, 2, out Color val);
			float duration = (float)Lua.lua_tonumber(L, 3);
			float delay = (float)Lua.lua_tonumber(L, 4);
			hpBarColor.SetTarget(val, duration, delay);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_HUDUpdate(IntPtr L)
	{
		try
		{
			HpBarColor hpBarColor = (HpBarColor)ObjectTranslatorPool.Instance.Find(L).FastGetCSObj(L, 1);
			float dt = (float)Lua.lua_tonumber(L, 2);
			hpBarColor.HUDUpdate(dt);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}
}
