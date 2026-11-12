using System;
using TrueSync;
using XLua.LuaDLL;

namespace XLua.CSObjectWrap;

public class InteractiveManagerWrap
{
	public static void __Register(IntPtr L)
	{
		ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
		Type typeFromHandle = typeof(InteractiveManager);
		Utils.BeginObjectRegister(typeFromHandle, L, translator, 0, 18, 1, 1);
		Utils.RegisterFunc(L, -3, "ClearData", _m_ClearData);
		Utils.RegisterFunc(L, -3, "AddInteractiveGroup", _m_AddInteractiveGroup);
		Utils.RegisterFunc(L, -3, "AddInteractiveObj", _m_AddInteractiveObj);
		Utils.RegisterFunc(L, -3, "removeInteractiveObj", _m_removeInteractiveObj);
		Utils.RegisterFunc(L, -3, "setInteractiveObjState", _m_setInteractiveObjState);
		Utils.RegisterFunc(L, -3, "triggerInteractiveObjState", _m_triggerInteractiveObjState);
		Utils.RegisterFunc(L, -3, "setInteractiveNpcState", _m_setInteractiveNpcState);
		Utils.RegisterFunc(L, -3, "setInteractiveObjActiveState", _m_setInteractiveObjActiveState);
		Utils.RegisterFunc(L, -3, "setInteractiveObjInterState", _m_setInteractiveObjInterState);
		Utils.RegisterFunc(L, -3, "ForceActiveInterObj", _m_ForceActiveInterObj);
		Utils.RegisterFunc(L, -3, "setInteractiveInterActiveByGroup", _m_setInteractiveInterActiveByGroup);
		Utils.RegisterFunc(L, -3, "addopTiggerOpListener", _m_addopTiggerOpListener);
		Utils.RegisterFunc(L, -3, "removeTiggerOpListener", _m_removeTiggerOpListener);
		Utils.RegisterFunc(L, -3, "triggerOpListener", _m_triggerOpListener);
		Utils.RegisterFunc(L, -3, "getPbDuration", _m_getPbDuration);
		Utils.RegisterFunc(L, -3, "GetPbName", _m_GetPbName);
		Utils.RegisterFunc(L, -3, "refreshTypeState", _m_refreshTypeState);
		Utils.RegisterFunc(L, -3, "SetIneractiveUI", _m_SetIneractiveUI);
		Utils.RegisterFunc(L, -2, "_Uid", _g_get__Uid);
		Utils.RegisterFunc(L, -1, "_Uid", _s_set__Uid);
		Utils.EndObjectRegister(typeFromHandle, L, translator, null, null, null, null, null);
		Utils.BeginClassRegister(typeFromHandle, L, __CreateInstance, 2, 0, 0);
		Utils.RegisterFunc(L, -4, "getLogicDeletaTime", _m_getLogicDeletaTime_xlua_st_);
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
				InteractiveManager o = new InteractiveManager();
				objectTranslator.Push(L, o);
				return 1;
			}
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return Lua.luaL_error(L, "invalid arguments to InteractiveManager constructor!");
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_ClearData(IntPtr L)
	{
		try
		{
			((InteractiveManager)ObjectTranslatorPool.Instance.Find(L).FastGetCSObj(L, 1)).ClearData();
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_AddInteractiveGroup(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			InteractiveManager interactiveManager = (InteractiveManager)objectTranslator.FastGetCSObj(L, 1);
			InteractiveGroup interGroup = (InteractiveGroup)objectTranslator.GetObject(L, 2, typeof(InteractiveGroup));
			interactiveManager.AddInteractiveGroup(interGroup);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_AddInteractiveObj(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			InteractiveManager interactiveManager = (InteractiveManager)objectTranslator.FastGetCSObj(L, 1);
			InteractiveBase interactiveObj = (InteractiveBase)objectTranslator.GetObject(L, 2, typeof(InteractiveBase));
			interactiveManager.AddInteractiveObj(interactiveObj);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_removeInteractiveObj(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			InteractiveManager interactiveManager = (InteractiveManager)objectTranslator.FastGetCSObj(L, 1);
			InteractiveBase interactiveObj = (InteractiveBase)objectTranslator.GetObject(L, 2, typeof(InteractiveBase));
			interactiveManager.removeInteractiveObj(interactiveObj);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_setInteractiveObjState(IntPtr L)
	{
		try
		{
			InteractiveManager interactiveManager = (InteractiveManager)ObjectTranslatorPool.Instance.Find(L).FastGetCSObj(L, 1);
			string interactiveObjState = Lua.lua_tostring(L, 2);
			bool value = interactiveManager.setInteractiveObjState(interactiveObjState);
			Lua.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_triggerInteractiveObjState(IntPtr L)
	{
		try
		{
			InteractiveManager interactiveManager = (InteractiveManager)ObjectTranslatorPool.Instance.Find(L).FastGetCSObj(L, 1);
			string id = Lua.lua_tostring(L, 2);
			interactiveManager.triggerInteractiveObjState(id);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_setInteractiveNpcState(IntPtr L)
	{
		try
		{
			InteractiveManager interactiveManager = (InteractiveManager)ObjectTranslatorPool.Instance.Find(L).FastGetCSObj(L, 1);
			string interactiveNpcState = Lua.lua_tostring(L, 2);
			interactiveManager.setInteractiveNpcState(interactiveNpcState);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_setInteractiveObjActiveState(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			InteractiveManager interactiveManager = (InteractiveManager)objectTranslator.FastGetCSObj(L, 1);
			string id = Lua.lua_tostring(L, 2);
			objectTranslator.Get(L, 3, out InteractiveManager.processState v);
			Action onComplete = objectTranslator.GetDelegate<Action>(L, 4);
			interactiveManager.setInteractiveObjActiveState(id, v, onComplete);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_setInteractiveObjInterState(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			InteractiveManager interactiveManager = (InteractiveManager)objectTranslator.FastGetCSObj(L, 1);
			string id = Lua.lua_tostring(L, 2);
			objectTranslator.Get(L, 3, out InteractiveManager.processState v);
			Action onComplete = objectTranslator.GetDelegate<Action>(L, 4);
			interactiveManager.setInteractiveObjInterState(id, v, onComplete);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_ForceActiveInterObj(IntPtr L)
	{
		try
		{
			InteractiveManager interactiveManager = (InteractiveManager)ObjectTranslatorPool.Instance.Find(L).FastGetCSObj(L, 1);
			string groupTitle = Lua.lua_tostring(L, 2);
			string id = Lua.lua_tostring(L, 3);
			interactiveManager.ForceActiveInterObj(groupTitle, id);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_setInteractiveInterActiveByGroup(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			InteractiveManager interactiveManager = (InteractiveManager)objectTranslator.FastGetCSObj(L, 1);
			string groupTitle = Lua.lua_tostring(L, 2);
			objectTranslator.Get(L, 3, out InteractiveManager.processState v);
			interactiveManager.setInteractiveInterActiveByGroup(groupTitle, v);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_addopTiggerOpListener(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			InteractiveManager interactiveManager = (InteractiveManager)objectTranslator.FastGetCSObj(L, 1);
			TriggerInteractiveOperate oprate = (TriggerInteractiveOperate)objectTranslator.GetObject(L, 2, typeof(TriggerInteractiveOperate));
			interactiveManager.addopTiggerOpListener(oprate);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_removeTiggerOpListener(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			InteractiveManager interactiveManager = (InteractiveManager)objectTranslator.FastGetCSObj(L, 1);
			TriggerInteractiveOperate oprate = (TriggerInteractiveOperate)objectTranslator.GetObject(L, 2, typeof(TriggerInteractiveOperate));
			interactiveManager.removeTiggerOpListener(oprate);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_triggerOpListener(IntPtr L)
	{
		try
		{
			InteractiveManager interactiveManager = (InteractiveManager)ObjectTranslatorPool.Instance.Find(L).FastGetCSObj(L, 1);
			int num = Lua.lua_gettop(L);
			if (num == 2 && LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 2))
			{
				int opId = Lua.xlua_tointeger(L, 2);
				interactiveManager.triggerOpListener(opId);
				return 0;
			}
			if (num == 2 && (Lua.lua_isnil(L, 2) || Lua.lua_type(L, 2) == LuaTypes.LUA_TSTRING))
			{
				string opId2 = Lua.lua_tostring(L, 2);
				interactiveManager.triggerOpListener(opId2);
				return 0;
			}
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return Lua.luaL_error(L, "invalid arguments to InteractiveManager.triggerOpListener!");
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_getPbDuration(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			InteractiveManager interactiveManager = (InteractiveManager)objectTranslator.FastGetCSObj(L, 1);
			TimelinePlayerClip pDirecClip = (TimelinePlayerClip)objectTranslator.GetObject(L, 2, typeof(TimelinePlayerClip));
			FP pbDuration = interactiveManager.getPbDuration(pDirecClip);
			objectTranslator.Push(L, pbDuration);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetPbName(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			InteractiveManager interactiveManager = (InteractiveManager)objectTranslator.FastGetCSObj(L, 1);
			objectTranslator.Get(L, 2, out InteractiveManager.processState v);
			objectTranslator.Get(L, 3, out InteractiveManager.interactiveState v2);
			InteractiveManager.typeState pbName = interactiveManager.GetPbName(v, v2);
			objectTranslator.Push(L, pbName);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_refreshTypeState(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			InteractiveManager interactiveManager = (InteractiveManager)objectTranslator.FastGetCSObj(L, 1);
			objectTranslator.Get(L, 2, out InteractiveManager.typeState v);
			objectTranslator.Get(L, 3, out InteractiveManager.interactiveState v2);
			interactiveManager.refreshTypeState(v, ref v2);
			objectTranslator.Push(L, v2);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_getLogicDeletaTime_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			FP logicDeletaTime = InteractiveManager.getLogicDeletaTime();
			objectTranslator.Push(L, logicDeletaTime);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetIneractiveUI(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			InteractiveManager interactiveManager = (InteractiveManager)objectTranslator.FastGetCSObj(L, 1);
			InteractiveBase activeObj = (InteractiveBase)objectTranslator.GetObject(L, 2, typeof(InteractiveBase));
			bool showUI = Lua.lua_toboolean(L, 3);
			interactiveManager.SetIneractiveUI(activeObj, showUI);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _g_get__Uid(IntPtr L)
	{
		try
		{
			InteractiveManager interactiveManager = (InteractiveManager)ObjectTranslatorPool.Instance.Find(L).FastGetCSObj(L, 1);
			Lua.xlua_pushinteger(L, interactiveManager._Uid);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 1;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _s_set__Uid(IntPtr L)
	{
		try
		{
			((InteractiveManager)ObjectTranslatorPool.Instance.Find(L).FastGetCSObj(L, 1))._Uid = Lua.xlua_tointeger(L, 2);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 0;
	}
}
