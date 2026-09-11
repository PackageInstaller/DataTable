using System;
using LuaInterface;
using UnityEngine;
using UnityEngine.UI;

public class UnityEngine_UI_MaskableGraphicWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(MaskableGraphic), typeof(Graphic));
		L.RegFunction("GetModifiedMaterial", GetModifiedMaterial);
		L.RegFunction("Cull", Cull);
		L.RegFunction("SetClipRect", SetClipRect);
		L.RegFunction("RecalculateClipping", RecalculateClipping);
		L.RegFunction("RecalculateMasking", RecalculateMasking);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("onCullStateChanged", get_onCullStateChanged, set_onCullStateChanged);
		L.RegVar("maskable", get_maskable, set_maskable);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetModifiedMaterial(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			MaskableGraphic obj = (MaskableGraphic)ToLua.CheckObject<MaskableGraphic>(L, 1);
			Material baseMaterial = (Material)ToLua.CheckObject<Material>(L, 2);
			Material modifiedMaterial = obj.GetModifiedMaterial(baseMaterial);
			ToLua.Push(L, modifiedMaterial);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Cull(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			MaskableGraphic obj = (MaskableGraphic)ToLua.CheckObject<MaskableGraphic>(L, 1);
			Rect clipRect = StackTraits<Rect>.Check(L, 2);
			bool validRect = LuaDLL.luaL_checkboolean(L, 3);
			obj.Cull(clipRect, validRect);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetClipRect(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			MaskableGraphic obj = (MaskableGraphic)ToLua.CheckObject<MaskableGraphic>(L, 1);
			Rect clipRect = StackTraits<Rect>.Check(L, 2);
			bool validRect = LuaDLL.luaL_checkboolean(L, 3);
			obj.SetClipRect(clipRect, validRect);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RecalculateClipping(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((MaskableGraphic)ToLua.CheckObject<MaskableGraphic>(L, 1)).RecalculateClipping();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RecalculateMasking(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((MaskableGraphic)ToLua.CheckObject<MaskableGraphic>(L, 1)).RecalculateMasking();
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
	private static int get_onCullStateChanged(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			MaskableGraphic.CullStateChangedEvent onCullStateChanged = ((MaskableGraphic)obj).onCullStateChanged;
			ToLua.PushObject(L, onCullStateChanged);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index onCullStateChanged on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_maskable(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool maskable = ((MaskableGraphic)obj).maskable;
			LuaDLL.lua_pushboolean(L, maskable);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index maskable on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_onCullStateChanged(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			MaskableGraphic obj2 = (MaskableGraphic)obj;
			MaskableGraphic.CullStateChangedEvent onCullStateChanged = (MaskableGraphic.CullStateChangedEvent)ToLua.CheckObject<MaskableGraphic.CullStateChangedEvent>(L, 2);
			obj2.onCullStateChanged = onCullStateChanged;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index onCullStateChanged on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_maskable(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			MaskableGraphic obj2 = (MaskableGraphic)obj;
			bool maskable = LuaDLL.luaL_checkboolean(L, 2);
			obj2.maskable = maskable;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index maskable on a nil value");
		}
	}
}
