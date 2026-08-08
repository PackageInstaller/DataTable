using System;
using LuaInterface;
using UnityEngine;
using UnityEngine.UI;

public class AssetExWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(AssetEx), typeof(object));
		L.RegFunction("LoadSprite", LoadSprite);
		L.RegFunction("LoadSpriteAsync", LoadSpriteAsync);
		L.RegFunction("SetSpriteAsync", SetSpriteAsync);
		L.RegFunction("LoadText", LoadText);
		L.RegFunction("UnloadSprite", UnloadSprite);
		L.RegFunction("New", _CreateAssetEx);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateAssetEx(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				AssetEx o = new AssetEx();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: AssetEx.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LoadSprite(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
			{
				Sprite o2 = AssetEx.LoadSprite(ToLua.CheckString(L, 1));
				ToLua.PushSealed(L, o2);
				return 1;
			}
			case 2:
			{
				string path = ToLua.CheckString(L, 1);
				bool isdontdistroy = LuaDLL.luaL_checkboolean(L, 2);
				Sprite o = AssetEx.LoadSprite(path, isdontdistroy);
				ToLua.PushSealed(L, o);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: AssetEx.LoadSprite");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LoadSpriteAsync(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
				AssetEx.LoadSpriteAsync(ToLua.CheckString(L, 1));
				return 0;
			case 2:
			{
				string path = ToLua.CheckString(L, 1);
				OnVoidHandler<Sprite> callback = (OnVoidHandler<Sprite>)ToLua.CheckDelegate<OnVoidHandler<Sprite>>(L, 2);
				AssetEx.LoadSpriteAsync(path, callback);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: AssetEx.LoadSpriteAsync");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetSpriteAsync(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Image image = (Image)ToLua.CheckObject<Image>(L, 1);
			string path = ToLua.CheckString(L, 2);
			AssetEx.SetSpriteAsync(image, path);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LoadText(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			string str = AssetEx.LoadText(ToLua.CheckString(L, 1));
			LuaDLL.lua_pushstring(L, str);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UnloadSprite(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
				AssetEx.UnloadSprite(ToLua.CheckString(L, 1));
				return 0;
			case 2:
			{
				string path = ToLua.CheckString(L, 1);
				bool isdontdistroy = LuaDLL.luaL_checkboolean(L, 2);
				AssetEx.UnloadSprite(path, isdontdistroy);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: AssetEx.UnloadSprite");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
