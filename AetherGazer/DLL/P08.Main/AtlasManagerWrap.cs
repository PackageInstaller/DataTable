using System;
using LuaInterface;
using UnityEngine;
using UnityEngine.UI;

public class AtlasManagerWrap
{
	public static void Register(LuaState L)
	{
		L.BeginStaticLibs("AtlasManager");
		L.RegFunction("GetReady", GetReady);
		L.RegFunction("Initialize", Initialize);
		L.RegFunction("GetSpriteWithoutAtlas", GetSpriteWithoutAtlas);
		L.RegFunction("GetSpriteWithoutAtlasAsync", GetSpriteWithoutAtlasAsync);
		L.RegFunction("UnloadSpriteWithoutAtlas", UnloadSpriteWithoutAtlas);
		L.RegFunction("GetSprite", GetSprite);
		L.RegFunction("UnloadSprite", UnloadSprite);
		L.RegFunction("UnloadAtlas", UnloadAtlas);
		L.RegFunction("UnloadAllSprite", UnloadAllSprite);
		L.RegFunction("Destroy", Destroy);
		L.RegFunction("GetSpriteWithoutAtlasAsyncNew", GetSpriteWithoutAtlasAsyncNew);
		L.RegFunction("SetSprite", SetSprite);
		L.RegFunction("RecordRef", RecordRef);
		L.RegFunction("UnloadAssets", UnloadAssets);
		L.RegFunction("GCSprites", GCSprites);
		L.RegFunction("UnloadAtlasWithoutUnloadAB", UnloadAtlasWithoutUnloadAB);
		L.EndStaticLibs();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetReady(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			bool ready = AtlasManager.GetReady();
			LuaDLL.lua_pushboolean(L, ready);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Initialize(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			AtlasManager.Initialize();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetSpriteWithoutAtlas(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			switch (num)
			{
			case 1:
			{
				Sprite spriteWithoutAtlas2 = AtlasManager.GetSpriteWithoutAtlas(ToLua.CheckString(L, 1));
				ToLua.PushSealed(L, spriteWithoutAtlas2);
				return 1;
			}
			case 2:
				if (TypeChecker.CheckTypes<SpriteRenderer, string>(L, 1))
				{
					SpriteRenderer image = (SpriteRenderer)ToLua.ToObject(L, 1);
					string spritePath = ToLua.ToString(L, 2);
					Sprite spriteWithoutAtlas = AtlasManager.GetSpriteWithoutAtlas(image, spritePath);
					ToLua.PushSealed(L, spriteWithoutAtlas);
					return 1;
				}
				break;
			}
			if (num == 2 && TypeChecker.CheckTypes<Image, string>(L, 1))
			{
				Image image2 = (Image)ToLua.ToObject(L, 1);
				string spritePath2 = ToLua.ToString(L, 2);
				Sprite spriteWithoutAtlas3 = AtlasManager.GetSpriteWithoutAtlas(image2, spritePath2);
				ToLua.PushSealed(L, spriteWithoutAtlas3);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: AtlasManager.GetSpriteWithoutAtlas");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetSpriteWithoutAtlasAsync(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
				AtlasManager.GetSpriteWithoutAtlasAsync(ToLua.CheckString(L, 1));
				return 0;
			case 2:
			{
				string spritePath = ToLua.CheckString(L, 1);
				OnVoidHandler<Sprite> callback = (OnVoidHandler<Sprite>)ToLua.CheckDelegate<OnVoidHandler<Sprite>>(L, 2);
				AtlasManager.GetSpriteWithoutAtlasAsync(spritePath, callback);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: AtlasManager.GetSpriteWithoutAtlasAsync");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UnloadSpriteWithoutAtlas(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			AtlasManager.UnloadSpriteWithoutAtlas(ToLua.CheckString(L, 1));
			return 0;
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
			ToLua.CheckArgsCount(L, 2);
			string atlasName = ToLua.CheckString(L, 1);
			string spriteName = ToLua.CheckString(L, 2);
			Sprite sprite = AtlasManager.GetSprite(atlasName, spriteName);
			ToLua.PushSealed(L, sprite);
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
			ToLua.CheckArgsCount(L, 2);
			string atlasName = ToLua.CheckString(L, 1);
			string spriteName = ToLua.CheckString(L, 2);
			AtlasManager.UnloadSprite(atlasName, spriteName);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UnloadAtlas(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			AtlasManager.UnloadAtlas(ToLua.CheckString(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UnloadAllSprite(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			AtlasManager.UnloadAllSprite();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Destroy(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			AtlasManager.Destroy();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetSpriteWithoutAtlasAsyncNew(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 2 && TypeChecker.CheckTypes<SpriteRenderer, string>(L, 1))
			{
				SpriteRenderer owner = (SpriteRenderer)ToLua.ToObject(L, 1);
				string spritePath = ToLua.ToString(L, 2);
				AtlasManager.GetSpriteWithoutAtlasAsyncNew(owner, spritePath);
				return 0;
			}
			if (num == 2 && TypeChecker.CheckTypes<Image, string>(L, 1))
			{
				Image owner2 = (Image)ToLua.ToObject(L, 1);
				string spritePath2 = ToLua.ToString(L, 2);
				AtlasManager.GetSpriteWithoutAtlasAsyncNew(owner2, spritePath2);
				return 0;
			}
			if (num == 3 && TypeChecker.CheckTypes<SpriteRenderer, string, OnVoidHandler<Sprite>>(L, 1))
			{
				SpriteRenderer owner3 = (SpriteRenderer)ToLua.ToObject(L, 1);
				string spritePath3 = ToLua.ToString(L, 2);
				OnVoidHandler<Sprite> callback = (OnVoidHandler<Sprite>)ToLua.ToObject(L, 3);
				AtlasManager.GetSpriteWithoutAtlasAsyncNew(owner3, spritePath3, callback);
				return 0;
			}
			if (num == 3 && TypeChecker.CheckTypes<Image, string, OnVoidHandler<Sprite>>(L, 1))
			{
				Image owner4 = (Image)ToLua.ToObject(L, 1);
				string spritePath4 = ToLua.ToString(L, 2);
				OnVoidHandler<Sprite> callback2 = (OnVoidHandler<Sprite>)ToLua.ToObject(L, 3);
				AtlasManager.GetSpriteWithoutAtlasAsyncNew(owner4, spritePath4, callback2);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: AtlasManager.GetSpriteWithoutAtlasAsyncNew");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetSprite(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			Image image = (Image)ToLua.CheckObject<Image>(L, 1);
			string atlasName = ToLua.CheckString(L, 2);
			string spriteName = ToLua.CheckString(L, 3);
			bool value = AtlasManager.SetSprite(image, atlasName, spriteName);
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RecordRef(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			UnityEngine.Object owner = (UnityEngine.Object)ToLua.CheckObject<UnityEngine.Object>(L, 1);
			string spritePath = ToLua.CheckString(L, 2);
			AtlasManager.RecordRef(owner, spritePath);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UnloadAssets(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			AtlasManager.UnloadAssets((int)LuaDLL.luaL_checknumber(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GCSprites(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			AtlasManager.GCSprites();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UnloadAtlasWithoutUnloadAB(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			AtlasManager.UnloadAtlasWithoutUnloadAB(ToLua.CheckString(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
