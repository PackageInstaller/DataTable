using System;
using LuaInterface;
using UnityEngine;

public class UnityEngine_SpriteRendererWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(SpriteRenderer), typeof(Renderer));
		L.RegFunction("New", _CreateUnityEngine_SpriteRenderer);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("sprite", get_sprite, set_sprite);
		L.RegVar("drawMode", get_drawMode, set_drawMode);
		L.RegVar("size", get_size, set_size);
		L.RegVar("adaptiveModeThreshold", get_adaptiveModeThreshold, set_adaptiveModeThreshold);
		L.RegVar("tileMode", get_tileMode, set_tileMode);
		L.RegVar("color", get_color, set_color);
		L.RegVar("maskInteraction", get_maskInteraction, set_maskInteraction);
		L.RegVar("flipX", get_flipX, set_flipX);
		L.RegVar("flipY", get_flipY, set_flipY);
		L.RegVar("spriteSortPoint", get_spriteSortPoint, set_spriteSortPoint);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateUnityEngine_SpriteRenderer(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				SpriteRenderer o = new SpriteRenderer();
				ToLua.PushSealed(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: UnityEngine.SpriteRenderer.New");
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
	private static int get_sprite(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Sprite sprite = ((SpriteRenderer)obj).sprite;
			ToLua.PushSealed(L, sprite);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index sprite on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_drawMode(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SpriteDrawMode drawMode = ((SpriteRenderer)obj).drawMode;
			ToLua.Push(L, drawMode);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index drawMode on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_size(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector2 size = ((SpriteRenderer)obj).size;
			ToLua.Push(L, size);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index size on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_adaptiveModeThreshold(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float adaptiveModeThreshold = ((SpriteRenderer)obj).adaptiveModeThreshold;
			LuaDLL.lua_pushnumber(L, adaptiveModeThreshold);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index adaptiveModeThreshold on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_tileMode(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SpriteTileMode tileMode = ((SpriteRenderer)obj).tileMode;
			ToLua.Push(L, tileMode);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index tileMode on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_color(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Color color = ((SpriteRenderer)obj).color;
			ToLua.Push(L, color);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index color on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_maskInteraction(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SpriteMaskInteraction maskInteraction = ((SpriteRenderer)obj).maskInteraction;
			ToLua.Push(L, maskInteraction);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index maskInteraction on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_flipX(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool flipX = ((SpriteRenderer)obj).flipX;
			LuaDLL.lua_pushboolean(L, flipX);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index flipX on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_flipY(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool flipY = ((SpriteRenderer)obj).flipY;
			LuaDLL.lua_pushboolean(L, flipY);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index flipY on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_spriteSortPoint(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SpriteSortPoint spriteSortPoint = ((SpriteRenderer)obj).spriteSortPoint;
			ToLua.Push(L, spriteSortPoint);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index spriteSortPoint on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_sprite(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SpriteRenderer spriteRenderer = (SpriteRenderer)obj;
			if (TypeChecker.CheckType(L, typeof(string), 2))
			{
				string text = ToLua.ToString(L, 2);
				if (text == null)
				{
					spriteRenderer.sprite = null;
				}
				else
				{
					AtlasManager.GetSpriteWithoutAtlas(spriteRenderer, text);
				}
			}
			else if (TypeChecker.CheckType(L, typeof(Sprite), 2))
			{
				Sprite sprite = (Sprite)ToLua.CheckObject(L, 2, typeof(Sprite));
				spriteRenderer.sprite = sprite;
			}
			else
			{
				spriteRenderer.sprite = null;
			}
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index sprite on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_drawMode(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SpriteRenderer obj2 = (SpriteRenderer)obj;
			SpriteDrawMode drawMode = (SpriteDrawMode)ToLua.CheckObject(L, 2, typeof(SpriteDrawMode));
			obj2.drawMode = drawMode;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index drawMode on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_size(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SpriteRenderer obj2 = (SpriteRenderer)obj;
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
	private static int set_adaptiveModeThreshold(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SpriteRenderer obj2 = (SpriteRenderer)obj;
			float adaptiveModeThreshold = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.adaptiveModeThreshold = adaptiveModeThreshold;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index adaptiveModeThreshold on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_tileMode(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SpriteRenderer obj2 = (SpriteRenderer)obj;
			SpriteTileMode tileMode = (SpriteTileMode)ToLua.CheckObject(L, 2, typeof(SpriteTileMode));
			obj2.tileMode = tileMode;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index tileMode on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_color(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SpriteRenderer obj2 = (SpriteRenderer)obj;
			Color color = ToLua.ToColor(L, 2);
			obj2.color = color;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index color on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_maskInteraction(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SpriteRenderer obj2 = (SpriteRenderer)obj;
			SpriteMaskInteraction maskInteraction = (SpriteMaskInteraction)ToLua.CheckObject(L, 2, typeof(SpriteMaskInteraction));
			obj2.maskInteraction = maskInteraction;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index maskInteraction on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_flipX(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SpriteRenderer obj2 = (SpriteRenderer)obj;
			bool flipX = LuaDLL.luaL_checkboolean(L, 2);
			obj2.flipX = flipX;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index flipX on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_flipY(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SpriteRenderer obj2 = (SpriteRenderer)obj;
			bool flipY = LuaDLL.luaL_checkboolean(L, 2);
			obj2.flipY = flipY;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index flipY on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_spriteSortPoint(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SpriteRenderer obj2 = (SpriteRenderer)obj;
			SpriteSortPoint spriteSortPoint = (SpriteSortPoint)ToLua.CheckObject(L, 2, typeof(SpriteSortPoint));
			obj2.spriteSortPoint = spriteSortPoint;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index spriteSortPoint on a nil value");
		}
	}
}
