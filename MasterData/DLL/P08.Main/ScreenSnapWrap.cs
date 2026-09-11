using System;
using LuaInterface;
using UnityEngine;

public class ScreenSnapWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(ScreenSnap), typeof(object));
		L.RegFunction("Take", Take);
		L.RegFunction("SaveSnap", SaveSnap);
		L.RegFunction("SaveTexture", SaveTexture);
		L.RegFunction("SaveRenderTexture", SaveRenderTexture);
		L.RegFunction("GetSprite", GetSprite);
		L.RegFunction("New", _CreateScreenSnap);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("_sp", get__sp, set__sp);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateScreenSnap(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				int width2 = (int)LuaDLL.luaL_checknumber(L, 1);
				int height2 = (int)LuaDLL.luaL_checknumber(L, 2);
				ScreenSnap o2 = new ScreenSnap(width2, height2);
				ToLua.PushObject(L, o2);
				return 1;
			}
			case 3:
			{
				int width = (int)LuaDLL.luaL_checknumber(L, 1);
				int height = (int)LuaDLL.luaL_checknumber(L, 2);
				TextureFormat format = (TextureFormat)ToLua.CheckObject(L, 3, typeof(TextureFormat));
				ScreenSnap o = new ScreenSnap(width, height, format);
				ToLua.PushObject(L, o);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: ScreenSnap.New");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Take(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((ScreenSnap)ToLua.CheckObject<ScreenSnap>(L, 1)).Take();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SaveSnap(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			ScreenSnap obj = (ScreenSnap)ToLua.CheckObject<ScreenSnap>(L, 1);
			string savePath = ToLua.CheckString(L, 2);
			bool value = obj.SaveSnap(savePath);
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SaveTexture(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			string savePath = ToLua.CheckString(L, 1);
			Texture2D texture = (Texture2D)ToLua.CheckObject(L, 2, typeof(Texture2D));
			bool value = ScreenSnap.SaveTexture(savePath, texture);
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SaveRenderTexture(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			string savePath = ToLua.CheckString(L, 1);
			RenderTexture texture = (RenderTexture)ToLua.CheckObject<RenderTexture>(L, 2);
			bool value = ScreenSnap.SaveRenderTexture(savePath, texture);
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetSprite(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			Sprite sprite = ((ScreenSnap)ToLua.CheckObject<ScreenSnap>(L, 1)).GetSprite();
			ToLua.PushSealed(L, sprite);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get__sp(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Sprite sp = ((ScreenSnap)obj)._sp;
			ToLua.PushSealed(L, sp);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index _sp on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set__sp(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ScreenSnap obj2 = (ScreenSnap)obj;
			Sprite sp = (Sprite)ToLua.CheckObject(L, 2, typeof(Sprite));
			obj2._sp = sp;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index _sp on a nil value");
		}
	}
}
