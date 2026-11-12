using System;
using XLua.LuaDLL;

namespace XLua.CSObjectWrap;

public class HpBarRotationWrap
{
	public static void __Register(IntPtr L)
	{
		ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
		Type typeFromHandle = typeof(HpBarRotation);
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
				HpBarRotation o = new HpBarRotation();
				objectTranslator.Push(L, o);
				return 1;
			}
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return Lua.luaL_error(L, "invalid arguments to HpBarRotation constructor!");
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_Stop(IntPtr L)
	{
		try
		{
			((HpBarRotation)ObjectTranslatorPool.Instance.Find(L).FastGetCSObj(L, 1)).Stop();
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
			HpBarRotation hpBarRotation = (HpBarRotation)ObjectTranslatorPool.Instance.Find(L).FastGetCSObj(L, 1);
			float target = (float)Lua.lua_tonumber(L, 2);
			float cur = (float)Lua.lua_tonumber(L, 3);
			float duration = (float)Lua.lua_tonumber(L, 4);
			float delay = (float)Lua.lua_tonumber(L, 5);
			hpBarRotation.SetTarget(target, cur, duration, delay);
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
			HpBarRotation hpBarRotation = (HpBarRotation)ObjectTranslatorPool.Instance.Find(L).FastGetCSObj(L, 1);
			float dt = (float)Lua.lua_tonumber(L, 2);
			hpBarRotation.HUDUpdate(dt);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}
}
