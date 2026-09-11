using System;
using LuaInterface;
using UnityEngine;
using pachinko;

public class pachinko_PaChinKoControllerWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(PaChinKoController), typeof(MonoBehaviour));
		L.RegFunction("StartGame", StartGame);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("m_followGo", get_m_followGo, set_m_followGo);
		L.RegVar("m_ballGo", get_m_ballGo, set_m_ballGo);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int StartGame(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			PaChinKoController obj = (PaChinKoController)ToLua.CheckObject<PaChinKoController>(L, 1);
			Vector2 addForce = ToLua.ToVector2(L, 2);
			obj.StartGame(addForce);
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
	private static int get_m_followGo(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GameObject followGo = ((PaChinKoController)obj).m_followGo;
			ToLua.PushSealed(L, followGo);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index m_followGo on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_m_ballGo(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GameObject ballGo = ((PaChinKoController)obj).m_ballGo;
			ToLua.PushSealed(L, ballGo);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index m_ballGo on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_m_followGo(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PaChinKoController obj2 = (PaChinKoController)obj;
			GameObject followGo = (GameObject)ToLua.CheckObject(L, 2, typeof(GameObject));
			obj2.m_followGo = followGo;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index m_followGo on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_m_ballGo(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PaChinKoController obj2 = (PaChinKoController)obj;
			GameObject ballGo = (GameObject)ToLua.CheckObject(L, 2, typeof(GameObject));
			obj2.m_ballGo = ballGo;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index m_ballGo on a nil value");
		}
	}
}
