using System;
using LuaInterface;
using UnityEngine;

public class AdaptiveServantSpriteWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(AdaptiveServantSprite), typeof(MonoBehaviour));
		L.RegFunction("SetSprite", SetSprite);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("renderComps", get_renderComps, set_renderComps);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetSprite(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				AdaptiveServantSprite obj7 = (AdaptiveServantSprite)ToLua.CheckObject<AdaptiveServantSprite>(L, 1);
				Sprite newSprite7 = (Sprite)ToLua.CheckObject(L, 2, typeof(Sprite));
				obj7.SetSprite(newSprite7);
				return 0;
			}
			case 3:
			{
				AdaptiveServantSprite obj6 = (AdaptiveServantSprite)ToLua.CheckObject<AdaptiveServantSprite>(L, 1);
				Sprite newSprite6 = (Sprite)ToLua.CheckObject(L, 2, typeof(Sprite));
				bool customOffsetX6 = LuaDLL.luaL_checkboolean(L, 3);
				obj6.SetSprite(newSprite6, customOffsetX6);
				return 0;
			}
			case 4:
			{
				AdaptiveServantSprite obj5 = (AdaptiveServantSprite)ToLua.CheckObject<AdaptiveServantSprite>(L, 1);
				Sprite newSprite5 = (Sprite)ToLua.CheckObject(L, 2, typeof(Sprite));
				bool customOffsetX5 = LuaDLL.luaL_checkboolean(L, 3);
				bool customOffsetY5 = LuaDLL.luaL_checkboolean(L, 4);
				obj5.SetSprite(newSprite5, customOffsetX5, customOffsetY5);
				return 0;
			}
			case 5:
			{
				AdaptiveServantSprite obj4 = (AdaptiveServantSprite)ToLua.CheckObject<AdaptiveServantSprite>(L, 1);
				Sprite newSprite4 = (Sprite)ToLua.CheckObject(L, 2, typeof(Sprite));
				bool customOffsetX4 = LuaDLL.luaL_checkboolean(L, 3);
				bool customOffsetY4 = LuaDLL.luaL_checkboolean(L, 4);
				float offsetX4 = (float)LuaDLL.luaL_checknumber(L, 5);
				obj4.SetSprite(newSprite4, customOffsetX4, customOffsetY4, offsetX4);
				return 0;
			}
			case 6:
			{
				AdaptiveServantSprite obj3 = (AdaptiveServantSprite)ToLua.CheckObject<AdaptiveServantSprite>(L, 1);
				Sprite newSprite3 = (Sprite)ToLua.CheckObject(L, 2, typeof(Sprite));
				bool customOffsetX3 = LuaDLL.luaL_checkboolean(L, 3);
				bool customOffsetY3 = LuaDLL.luaL_checkboolean(L, 4);
				float offsetX3 = (float)LuaDLL.luaL_checknumber(L, 5);
				float offsetY3 = (float)LuaDLL.luaL_checknumber(L, 6);
				obj3.SetSprite(newSprite3, customOffsetX3, customOffsetY3, offsetX3, offsetY3);
				return 0;
			}
			case 7:
			{
				AdaptiveServantSprite obj2 = (AdaptiveServantSprite)ToLua.CheckObject<AdaptiveServantSprite>(L, 1);
				Sprite newSprite2 = (Sprite)ToLua.CheckObject(L, 2, typeof(Sprite));
				bool customOffsetX2 = LuaDLL.luaL_checkboolean(L, 3);
				bool customOffsetY2 = LuaDLL.luaL_checkboolean(L, 4);
				float offsetX2 = (float)LuaDLL.luaL_checknumber(L, 5);
				float offsetY2 = (float)LuaDLL.luaL_checknumber(L, 6);
				bool customTiling2 = LuaDLL.luaL_checkboolean(L, 7);
				obj2.SetSprite(newSprite2, customOffsetX2, customOffsetY2, offsetX2, offsetY2, customTiling2);
				return 0;
			}
			case 8:
			{
				AdaptiveServantSprite obj = (AdaptiveServantSprite)ToLua.CheckObject<AdaptiveServantSprite>(L, 1);
				Sprite newSprite = (Sprite)ToLua.CheckObject(L, 2, typeof(Sprite));
				bool customOffsetX = LuaDLL.luaL_checkboolean(L, 3);
				bool customOffsetY = LuaDLL.luaL_checkboolean(L, 4);
				float offsetX = (float)LuaDLL.luaL_checknumber(L, 5);
				float offsetY = (float)LuaDLL.luaL_checknumber(L, 6);
				bool customTiling = LuaDLL.luaL_checkboolean(L, 7);
				float tilingScale = (float)LuaDLL.luaL_checknumber(L, 8);
				obj.SetSprite(newSprite, customOffsetX, customOffsetY, offsetX, offsetY, customTiling, tilingScale);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: AdaptiveServantSprite.SetSprite");
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
	private static int get_renderComps(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SpriteRenderer renderComps = ((AdaptiveServantSprite)obj).renderComps;
			ToLua.PushSealed(L, renderComps);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index renderComps on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_renderComps(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			AdaptiveServantSprite obj2 = (AdaptiveServantSprite)obj;
			SpriteRenderer renderComps = (SpriteRenderer)ToLua.CheckObject(L, 2, typeof(SpriteRenderer));
			obj2.renderComps = renderComps;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index renderComps on a nil value");
		}
	}
}
