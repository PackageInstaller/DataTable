using System;
using LuaInterface;
using UnityEngine;

public class TextureUtilWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(TextureUtil), typeof(object));
		L.RegFunction("SampleSpriteIsBlack", SampleSpriteIsBlack);
		L.RegFunction("New", _CreateTextureUtil);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateTextureUtil(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				TextureUtil o = new TextureUtil();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: TextureUtil.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SampleSpriteIsBlack(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
			{
				bool value3 = TextureUtil.SampleSpriteIsBlack((Sprite)ToLua.CheckObject(L, 1, typeof(Sprite)));
				LuaDLL.lua_pushboolean(L, value3);
				return 1;
			}
			case 2:
			{
				Sprite sprite2 = (Sprite)ToLua.CheckObject(L, 1, typeof(Sprite));
				int sampleWidthRate2 = (int)LuaDLL.luaL_checknumber(L, 2);
				bool value2 = TextureUtil.SampleSpriteIsBlack(sprite2, sampleWidthRate2);
				LuaDLL.lua_pushboolean(L, value2);
				return 1;
			}
			case 3:
			{
				Sprite sprite = (Sprite)ToLua.CheckObject(L, 1, typeof(Sprite));
				int sampleWidthRate = (int)LuaDLL.luaL_checknumber(L, 2);
				int sampleHeightRate = (int)LuaDLL.luaL_checknumber(L, 3);
				bool value = TextureUtil.SampleSpriteIsBlack(sprite, sampleWidthRate, sampleHeightRate);
				LuaDLL.lua_pushboolean(L, value);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: TextureUtil.SampleSpriteIsBlack");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
