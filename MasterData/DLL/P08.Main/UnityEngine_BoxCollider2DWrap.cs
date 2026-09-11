using System;
using LuaInterface;
using UnityEngine;

public class UnityEngine_BoxCollider2DWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(BoxCollider2D), typeof(Collider2D));
		L.RegFunction("New", _CreateUnityEngine_BoxCollider2D);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("size", get_size, set_size);
		L.RegVar("edgeRadius", get_edgeRadius, set_edgeRadius);
		L.RegVar("autoTiling", get_autoTiling, set_autoTiling);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateUnityEngine_BoxCollider2D(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				BoxCollider2D o = new BoxCollider2D();
				ToLua.PushSealed(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: UnityEngine.BoxCollider2D.New");
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
	private static int get_size(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector2 size = ((BoxCollider2D)obj).size;
			ToLua.Push(L, size);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index size on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_edgeRadius(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float edgeRadius = ((BoxCollider2D)obj).edgeRadius;
			LuaDLL.lua_pushnumber(L, edgeRadius);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index edgeRadius on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_autoTiling(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool autoTiling = ((BoxCollider2D)obj).autoTiling;
			LuaDLL.lua_pushboolean(L, autoTiling);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index autoTiling on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_size(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BoxCollider2D obj2 = (BoxCollider2D)obj;
			Vector2 size = ToLua.ToVector2(L, 2);
			obj2.size = size;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index size on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_edgeRadius(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BoxCollider2D obj2 = (BoxCollider2D)obj;
			float edgeRadius = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.edgeRadius = edgeRadius;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index edgeRadius on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_autoTiling(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BoxCollider2D obj2 = (BoxCollider2D)obj;
			bool autoTiling = LuaDLL.luaL_checkboolean(L, 2);
			obj2.autoTiling = autoTiling;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index autoTiling on a nil value");
		}
	}
}
