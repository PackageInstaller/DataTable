using System;
using CriMana;
using LuaInterface;
using UnityEngine;

public class CriManaMovieMaterialBaseWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(CriManaMovieMaterialBase), typeof(CriMonoBehaviour));
		L.RegFunction("Play", Play);
		L.RegFunction("Stop", Stop);
		L.RegFunction("Pause", Pause);
		L.RegFunction("PlayerManualInitialize", PlayerManualInitialize);
		L.RegFunction("PlayerManualFinalize", PlayerManualFinalize);
		L.RegFunction("PlayerManualSetup", PlayerManualSetup);
		L.RegFunction("RenderTargetManualSetup", RenderTargetManualSetup);
		L.RegFunction("RenderTargetManualFinalize", RenderTargetManualFinalize);
		L.RegFunction("PlayerManualUpdate", PlayerManualUpdate);
		L.RegFunction("CriInternalUpdate", CriInternalUpdate);
		L.RegFunction("RenderMovie", RenderMovie);
		L.RegFunction("CriInternalLateUpdate", CriInternalLateUpdate);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("playOnStart", get_playOnStart, set_playOnStart);
		L.RegVar("restartOnEnable", get_restartOnEnable, set_restartOnEnable);
		L.RegVar("renderMode", get_renderMode, set_renderMode);
		L.RegVar("onApplicationPauseCallback", get_onApplicationPauseCallback, set_onApplicationPauseCallback);
		L.RegVar("maxFrameDrop", get_maxFrameDrop, set_maxFrameDrop);
		L.RegVar("isMaterialAvailable", get_isMaterialAvailable, null);
		L.RegVar("player", get_player, null);
		L.RegVar("material", get_material, set_material);
		L.RegVar("timerType", get_timerType, set_timerType);
		L.RegFunction("OnApplicationPauseCallback", CriManaMovieMaterialBase_OnApplicationPauseCallback);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Play(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((CriManaMovieMaterialBase)ToLua.CheckObject<CriManaMovieMaterialBase>(L, 1)).Play();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Stop(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((CriManaMovieMaterialBase)ToLua.CheckObject<CriManaMovieMaterialBase>(L, 1)).Stop();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Pause(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			CriManaMovieMaterialBase obj = (CriManaMovieMaterialBase)ToLua.CheckObject<CriManaMovieMaterialBase>(L, 1);
			bool sw = LuaDLL.luaL_checkboolean(L, 2);
			obj.Pause(sw);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int PlayerManualInitialize(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((CriManaMovieMaterialBase)ToLua.CheckObject<CriManaMovieMaterialBase>(L, 1)).PlayerManualInitialize();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int PlayerManualFinalize(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((CriManaMovieMaterialBase)ToLua.CheckObject<CriManaMovieMaterialBase>(L, 1)).PlayerManualFinalize();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int PlayerManualSetup(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((CriManaMovieMaterialBase)ToLua.CheckObject<CriManaMovieMaterialBase>(L, 1)).PlayerManualSetup();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RenderTargetManualSetup(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = ((CriManaMovieMaterialBase)ToLua.CheckObject<CriManaMovieMaterialBase>(L, 1)).RenderTargetManualSetup();
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RenderTargetManualFinalize(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((CriManaMovieMaterialBase)ToLua.CheckObject<CriManaMovieMaterialBase>(L, 1)).RenderTargetManualFinalize();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int PlayerManualUpdate(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((CriManaMovieMaterialBase)ToLua.CheckObject<CriManaMovieMaterialBase>(L, 1)).PlayerManualUpdate();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CriInternalUpdate(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((CriManaMovieMaterialBase)ToLua.CheckObject<CriManaMovieMaterialBase>(L, 1)).CriInternalUpdate();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RenderMovie(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((CriManaMovieMaterialBase)ToLua.CheckObject<CriManaMovieMaterialBase>(L, 1)).RenderMovie();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CriInternalLateUpdate(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((CriManaMovieMaterialBase)ToLua.CheckObject<CriManaMovieMaterialBase>(L, 1)).CriInternalLateUpdate();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int op_Equality(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			UnityEngine.Object obj = (UnityEngine.Object)ToLua.ToObject(L, 1);
			UnityEngine.Object obj2 = (UnityEngine.Object)ToLua.ToObject(L, 2);
			bool value = obj == obj2;
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_playOnStart(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool playOnStart = ((CriManaMovieMaterialBase)obj).playOnStart;
			LuaDLL.lua_pushboolean(L, playOnStart);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index playOnStart on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_restartOnEnable(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool restartOnEnable = ((CriManaMovieMaterialBase)obj).restartOnEnable;
			LuaDLL.lua_pushboolean(L, restartOnEnable);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index restartOnEnable on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_renderMode(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CriManaMovieMaterialBase.RenderMode renderMode = ((CriManaMovieMaterialBase)obj).renderMode;
			ToLua.Push(L, renderMode);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index renderMode on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_onApplicationPauseCallback(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CriManaMovieMaterialBase.OnApplicationPauseCallback onApplicationPauseCallback = ((CriManaMovieMaterialBase)obj).onApplicationPauseCallback;
			ToLua.Push(L, onApplicationPauseCallback);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index onApplicationPauseCallback on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_maxFrameDrop(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CriManaMovieMaterialBase.MaxFrameDrop maxFrameDrop = ((CriManaMovieMaterialBase)obj).maxFrameDrop;
			ToLua.Push(L, maxFrameDrop);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index maxFrameDrop on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isMaterialAvailable(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isMaterialAvailable = ((CriManaMovieMaterialBase)obj).isMaterialAvailable;
			LuaDLL.lua_pushboolean(L, isMaterialAvailable);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isMaterialAvailable on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_player(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Player player = ((CriManaMovieMaterialBase)obj).player;
			ToLua.PushObject(L, player);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index player on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_material(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Material material = ((CriManaMovieMaterialBase)obj).material;
			ToLua.Push(L, material);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index material on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_timerType(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Player.TimerType timerType = ((CriManaMovieMaterialBase)obj).timerType;
			ToLua.Push(L, timerType);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index timerType on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_playOnStart(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CriManaMovieMaterialBase obj2 = (CriManaMovieMaterialBase)obj;
			bool playOnStart = LuaDLL.luaL_checkboolean(L, 2);
			obj2.playOnStart = playOnStart;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index playOnStart on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_restartOnEnable(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CriManaMovieMaterialBase obj2 = (CriManaMovieMaterialBase)obj;
			bool restartOnEnable = LuaDLL.luaL_checkboolean(L, 2);
			obj2.restartOnEnable = restartOnEnable;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index restartOnEnable on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_renderMode(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CriManaMovieMaterialBase obj2 = (CriManaMovieMaterialBase)obj;
			CriManaMovieMaterialBase.RenderMode renderMode = (CriManaMovieMaterialBase.RenderMode)ToLua.CheckObject(L, 2, typeof(CriManaMovieMaterialBase.RenderMode));
			obj2.renderMode = renderMode;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index renderMode on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_onApplicationPauseCallback(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CriManaMovieMaterialBase obj2 = (CriManaMovieMaterialBase)obj;
			CriManaMovieMaterialBase.OnApplicationPauseCallback onApplicationPauseCallback = (CriManaMovieMaterialBase.OnApplicationPauseCallback)ToLua.CheckDelegate<CriManaMovieMaterialBase.OnApplicationPauseCallback>(L, 2);
			obj2.onApplicationPauseCallback = onApplicationPauseCallback;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index onApplicationPauseCallback on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_maxFrameDrop(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CriManaMovieMaterialBase obj2 = (CriManaMovieMaterialBase)obj;
			CriManaMovieMaterialBase.MaxFrameDrop maxFrameDrop = (CriManaMovieMaterialBase.MaxFrameDrop)ToLua.CheckObject(L, 2, typeof(CriManaMovieMaterialBase.MaxFrameDrop));
			obj2.maxFrameDrop = maxFrameDrop;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index maxFrameDrop on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_material(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CriManaMovieMaterialBase obj2 = (CriManaMovieMaterialBase)obj;
			Material material = (Material)ToLua.CheckObject<Material>(L, 2);
			obj2.material = material;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index material on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_timerType(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CriManaMovieMaterialBase obj2 = (CriManaMovieMaterialBase)obj;
			Player.TimerType timerType = (Player.TimerType)ToLua.CheckObject(L, 2, typeof(Player.TimerType));
			obj2.timerType = timerType;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index timerType on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CriManaMovieMaterialBase_OnApplicationPauseCallback(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<CriManaMovieMaterialBase.OnApplicationPauseCallback>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<CriManaMovieMaterialBase.OnApplicationPauseCallback>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
