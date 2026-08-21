using System;
using LuaInterface;
using UnityEngine;
using UnityEngine.UI;

public class UITypewriterEffectWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(UITypewriterEffect), typeof(BaseMeshEffect));
		L.RegFunction("ModifyMesh", ModifyMesh);
		L.RegFunction("SetDirty", SetDirty);
		L.RegFunction("ResetContent", ResetContent);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("percent", get_percent, set_percent);
		L.RegVar("scRect", get_scRect, set_scRect);
		L.RegVar("content", get_content, set_content);
		L.RegVar("sliderDrag", get_sliderDrag, set_sliderDrag);
		L.RegVar("needAutoScroll", get_needAutoScroll, set_needAutoScroll);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ModifyMesh(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 2 && TypeChecker.CheckTypes<VertexHelper>(L, 2))
			{
				UITypewriterEffect obj = (UITypewriterEffect)ToLua.CheckObject<UITypewriterEffect>(L, 1);
				VertexHelper vh = (VertexHelper)ToLua.ToObject(L, 2);
				obj.ModifyMesh(vh);
				return 0;
			}
			if (num == 2 && TypeChecker.CheckTypes<Mesh>(L, 2))
			{
				UITypewriterEffect obj2 = (UITypewriterEffect)ToLua.CheckObject<UITypewriterEffect>(L, 1);
				Mesh mesh = (Mesh)ToLua.ToObject(L, 2);
				obj2.ModifyMesh(mesh);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UITypewriterEffect.ModifyMesh");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetDirty(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((UITypewriterEffect)ToLua.CheckObject<UITypewriterEffect>(L, 1)).SetDirty();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ResetContent(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((UITypewriterEffect)ToLua.CheckObject<UITypewriterEffect>(L, 1)).ResetContent();
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
	private static int get_percent(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float percent = ((UITypewriterEffect)obj).percent;
			LuaDLL.lua_pushnumber(L, percent);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index percent on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_scRect(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RectTransform scRect = ((UITypewriterEffect)obj).scRect;
			ToLua.PushSealed(L, scRect);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index scRect on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_content(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RectTransform content = ((UITypewriterEffect)obj).content;
			ToLua.PushSealed(L, content);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index content on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_sliderDrag(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Scrollbar sliderDrag = ((UITypewriterEffect)obj).sliderDrag;
			ToLua.Push(L, sliderDrag);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index sliderDrag on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_needAutoScroll(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool needAutoScroll = ((UITypewriterEffect)obj).needAutoScroll;
			LuaDLL.lua_pushboolean(L, needAutoScroll);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index needAutoScroll on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_percent(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UITypewriterEffect obj2 = (UITypewriterEffect)obj;
			float percent = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.percent = percent;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index percent on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_scRect(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UITypewriterEffect obj2 = (UITypewriterEffect)obj;
			RectTransform scRect = (RectTransform)ToLua.CheckObject(L, 2, typeof(RectTransform));
			obj2.scRect = scRect;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index scRect on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_content(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UITypewriterEffect obj2 = (UITypewriterEffect)obj;
			RectTransform content = (RectTransform)ToLua.CheckObject(L, 2, typeof(RectTransform));
			obj2.content = content;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index content on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_sliderDrag(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UITypewriterEffect obj2 = (UITypewriterEffect)obj;
			Scrollbar sliderDrag = (Scrollbar)ToLua.CheckObject<Scrollbar>(L, 2);
			obj2.sliderDrag = sliderDrag;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index sliderDrag on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_needAutoScroll(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UITypewriterEffect obj2 = (UITypewriterEffect)obj;
			bool needAutoScroll = LuaDLL.luaL_checkboolean(L, 2);
			obj2.needAutoScroll = needAutoScroll;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index needAutoScroll on a nil value");
		}
	}
}
