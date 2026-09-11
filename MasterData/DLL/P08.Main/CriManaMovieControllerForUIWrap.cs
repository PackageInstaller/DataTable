using System;
using LuaInterface;
using UnityEngine;
using UnityEngine.UI;

public class CriManaMovieControllerForUIWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(CriManaMovieControllerForUI), typeof(CriManaMovieMaterial));
		L.RegFunction("CriInternalUpdate", CriInternalUpdate);
		L.RegFunction("RenderTargetManualSetup", RenderTargetManualSetup);
		L.RegFunction("RenderTargetManualFinalize", RenderTargetManualFinalize);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("target", get_target, set_target);
		L.RegVar("useOriginalMaterial", get_useOriginalMaterial, set_useOriginalMaterial);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CriInternalUpdate(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((CriManaMovieControllerForUI)ToLua.CheckObject<CriManaMovieControllerForUI>(L, 1)).CriInternalUpdate();
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
			bool value = ((CriManaMovieControllerForUI)ToLua.CheckObject<CriManaMovieControllerForUI>(L, 1)).RenderTargetManualSetup();
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
			((CriManaMovieControllerForUI)ToLua.CheckObject<CriManaMovieControllerForUI>(L, 1)).RenderTargetManualFinalize();
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
	private static int get_target(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Graphic target = ((CriManaMovieControllerForUI)obj).target;
			ToLua.Push(L, target);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index target on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_useOriginalMaterial(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool useOriginalMaterial = ((CriManaMovieControllerForUI)obj).useOriginalMaterial;
			LuaDLL.lua_pushboolean(L, useOriginalMaterial);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index useOriginalMaterial on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_target(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CriManaMovieControllerForUI obj2 = (CriManaMovieControllerForUI)obj;
			Graphic target = (Graphic)ToLua.CheckObject<Graphic>(L, 2);
			obj2.target = target;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index target on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_useOriginalMaterial(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CriManaMovieControllerForUI obj2 = (CriManaMovieControllerForUI)obj;
			bool useOriginalMaterial = LuaDLL.luaL_checkboolean(L, 2);
			obj2.useOriginalMaterial = useOriginalMaterial;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index useOriginalMaterial on a nil value");
		}
	}
}
