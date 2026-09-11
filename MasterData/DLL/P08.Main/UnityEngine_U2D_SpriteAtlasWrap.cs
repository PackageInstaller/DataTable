using System;
using LuaInterface;
using UnityEngine;
using UnityEngine.U2D;

public class UnityEngine_U2D_SpriteAtlasWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(SpriteAtlas), typeof(UnityEngine.Object));
		L.RegFunction("CanBindTo", CanBindTo);
		L.RegFunction("GetSprite", GetSprite);
		L.RegFunction("GetSprites", GetSprites);
		L.RegFunction("New", _CreateUnityEngine_U2D_SpriteAtlas);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("isVariant", get_isVariant, null);
		L.RegVar("tag", get_tag, null);
		L.RegVar("spriteCount", get_spriteCount, null);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateUnityEngine_U2D_SpriteAtlas(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				SpriteAtlas obj = new SpriteAtlas();
				ToLua.Push(L, obj);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: UnityEngine.U2D.SpriteAtlas.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CanBindTo(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			SpriteAtlas obj = (SpriteAtlas)ToLua.CheckObject<SpriteAtlas>(L, 1);
			Sprite sprite = (Sprite)ToLua.CheckObject(L, 2, typeof(Sprite));
			bool value = obj.CanBindTo(sprite);
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
			ToLua.CheckArgsCount(L, 2);
			SpriteAtlas obj = (SpriteAtlas)ToLua.CheckObject<SpriteAtlas>(L, 1);
			string name = ToLua.CheckString(L, 2);
			Sprite sprite = obj.GetSprite(name);
			ToLua.PushSealed(L, sprite);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetSprites(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				SpriteAtlas obj2 = (SpriteAtlas)ToLua.CheckObject<SpriteAtlas>(L, 1);
				Sprite[] sprites3 = ToLua.CheckObjectArray<Sprite>(L, 2);
				int sprites4 = obj2.GetSprites(sprites3);
				LuaDLL.lua_pushinteger(L, sprites4);
				return 1;
			}
			case 3:
			{
				SpriteAtlas obj = (SpriteAtlas)ToLua.CheckObject<SpriteAtlas>(L, 1);
				Sprite[] sprites = ToLua.CheckObjectArray<Sprite>(L, 2);
				string name = ToLua.CheckString(L, 3);
				int sprites2 = obj.GetSprites(sprites, name);
				LuaDLL.lua_pushinteger(L, sprites2);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.U2D.SpriteAtlas.GetSprites");
			}
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
	private static int get_isVariant(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isVariant = ((SpriteAtlas)obj).isVariant;
			LuaDLL.lua_pushboolean(L, isVariant);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isVariant on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_tag(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string tag = ((SpriteAtlas)obj).tag;
			LuaDLL.lua_pushstring(L, tag);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index tag on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_spriteCount(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int spriteCount = ((SpriteAtlas)obj).spriteCount;
			LuaDLL.lua_pushinteger(L, spriteCount);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index spriteCount on a nil value");
		}
	}
}
