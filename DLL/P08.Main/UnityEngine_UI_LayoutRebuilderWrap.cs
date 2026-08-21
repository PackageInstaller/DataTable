using System;
using LuaInterface;
using UnityEngine;
using UnityEngine.UI;

public class UnityEngine_UI_LayoutRebuilderWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(LayoutRebuilder), typeof(object));
		L.RegFunction("IsDestroyed", IsDestroyed);
		L.RegFunction("ForceRebuildLayoutImmediate", ForceRebuildLayoutImmediate);
		L.RegFunction("Rebuild", Rebuild);
		L.RegFunction("MarkLayoutForRebuild", MarkLayoutForRebuild);
		L.RegFunction("LayoutComplete", LayoutComplete);
		L.RegFunction("GraphicUpdateComplete", GraphicUpdateComplete);
		L.RegFunction("GetHashCode", GetHashCode);
		L.RegFunction("Equals", Equals);
		L.RegFunction("ToString", ToString);
		L.RegFunction("New", _CreateUnityEngine_UI_LayoutRebuilder);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("transform", get_transform, null);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateUnityEngine_UI_LayoutRebuilder(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				LayoutRebuilder o = new LayoutRebuilder();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: UnityEngine.UI.LayoutRebuilder.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IsDestroyed(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = ((LayoutRebuilder)ToLua.CheckObject<LayoutRebuilder>(L, 1)).IsDestroyed();
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ForceRebuildLayoutImmediate(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LayoutRebuilder.ForceRebuildLayoutImmediate((RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform)));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Rebuild(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			LayoutRebuilder obj = (LayoutRebuilder)ToLua.CheckObject<LayoutRebuilder>(L, 1);
			CanvasUpdate executing = (CanvasUpdate)ToLua.CheckObject(L, 2, typeof(CanvasUpdate));
			obj.Rebuild(executing);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int MarkLayoutForRebuild(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LayoutRebuilder.MarkLayoutForRebuild((RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform)));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LayoutComplete(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((LayoutRebuilder)ToLua.CheckObject<LayoutRebuilder>(L, 1)).LayoutComplete();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GraphicUpdateComplete(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((LayoutRebuilder)ToLua.CheckObject<LayoutRebuilder>(L, 1)).GraphicUpdateComplete();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetHashCode(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			int hashCode = ((LayoutRebuilder)ToLua.CheckObject<LayoutRebuilder>(L, 1)).GetHashCode();
			LuaDLL.lua_pushinteger(L, hashCode);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Equals(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			LayoutRebuilder layoutRebuilder = (LayoutRebuilder)ToLua.CheckObject<LayoutRebuilder>(L, 1);
			object obj = ToLua.ToVarObject(L, 2);
			bool value = layoutRebuilder?.Equals(obj) ?? (obj == null);
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ToString(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			string str = ((LayoutRebuilder)ToLua.CheckObject<LayoutRebuilder>(L, 1)).ToString();
			LuaDLL.lua_pushstring(L, str);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_transform(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Transform transform = ((LayoutRebuilder)obj).transform;
			ToLua.Push(L, transform);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index transform on a nil value");
		}
	}
}
