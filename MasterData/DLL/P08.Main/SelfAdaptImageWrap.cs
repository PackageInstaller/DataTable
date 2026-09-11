using System;
using LuaInterface;
using UnityEngine;
using UnityEngine.UI;

public class SelfAdaptImageWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(SelfAdaptImage), typeof(Image));
		L.RegFunction("AdaptImg", AdaptImg);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("sprite", get_sprite, set_sprite);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int AdaptImg(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((SelfAdaptImage)ToLua.CheckObject<SelfAdaptImage>(L, 1)).AdaptImg();
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
	private static int get_sprite(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Sprite sprite = ((SelfAdaptImage)obj).sprite;
			ToLua.PushSealed(L, sprite);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index sprite on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_sprite(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SelfAdaptImage selfAdaptImage = (SelfAdaptImage)obj;
			if (TypeChecker.CheckType(L, typeof(string), 2))
			{
				string text = ToLua.ToString(L, 2);
				if (text == null)
				{
					selfAdaptImage.sprite = null;
				}
				else
				{
					AtlasManager.GetSpriteWithoutAtlas(selfAdaptImage, text);
					selfAdaptImage.AdaptImg();
				}
			}
			else if (TypeChecker.CheckType(L, typeof(Sprite), 2))
			{
				Sprite sprite = (Sprite)ToLua.CheckObject(L, 2, typeof(Sprite));
				selfAdaptImage.sprite = sprite;
			}
			else
			{
				selfAdaptImage.sprite = null;
			}
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index sprite on a nil value");
		}
	}
}
