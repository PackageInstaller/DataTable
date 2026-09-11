using System;
using LuaInterface;
using UnityEngine;

public class UnityEngine_CanvasWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(Canvas), typeof(Behaviour));
		L.RegFunction("GetDefaultCanvasMaterial", GetDefaultCanvasMaterial);
		L.RegFunction("GetETC1SupportedCanvasMaterial", GetETC1SupportedCanvasMaterial);
		L.RegFunction("ForceUpdateCanvases", ForceUpdateCanvases);
		L.RegFunction("New", _CreateUnityEngine_Canvas);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("renderMode", get_renderMode, set_renderMode);
		L.RegVar("isRootCanvas", get_isRootCanvas, null);
		L.RegVar("pixelRect", get_pixelRect, null);
		L.RegVar("scaleFactor", get_scaleFactor, set_scaleFactor);
		L.RegVar("referencePixelsPerUnit", get_referencePixelsPerUnit, set_referencePixelsPerUnit);
		L.RegVar("overridePixelPerfect", get_overridePixelPerfect, set_overridePixelPerfect);
		L.RegVar("pixelPerfect", get_pixelPerfect, set_pixelPerfect);
		L.RegVar("planeDistance", get_planeDistance, set_planeDistance);
		L.RegVar("renderOrder", get_renderOrder, null);
		L.RegVar("overrideSorting", get_overrideSorting, set_overrideSorting);
		L.RegVar("sortingOrder", get_sortingOrder, set_sortingOrder);
		L.RegVar("targetDisplay", get_targetDisplay, set_targetDisplay);
		L.RegVar("sortingLayerID", get_sortingLayerID, set_sortingLayerID);
		L.RegVar("cachedSortingLayerValue", get_cachedSortingLayerValue, null);
		L.RegVar("additionalShaderChannels", get_additionalShaderChannels, set_additionalShaderChannels);
		L.RegVar("sortingLayerName", get_sortingLayerName, set_sortingLayerName);
		L.RegVar("rootCanvas", get_rootCanvas, null);
		L.RegVar("renderingDisplaySize", get_renderingDisplaySize, null);
		L.RegVar("worldCamera", get_worldCamera, set_worldCamera);
		L.RegVar("normalizedSortingGridSize", get_normalizedSortingGridSize, set_normalizedSortingGridSize);
		L.RegVar("preWillRenderCanvases", get_preWillRenderCanvases, set_preWillRenderCanvases);
		L.RegVar("willRenderCanvases", get_willRenderCanvases, set_willRenderCanvases);
		L.RegFunction("WillRenderCanvases", UnityEngine_Canvas_WillRenderCanvases);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateUnityEngine_Canvas(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				Canvas o = new Canvas();
				ToLua.PushSealed(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: UnityEngine.Canvas.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetDefaultCanvasMaterial(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			Material defaultCanvasMaterial = Canvas.GetDefaultCanvasMaterial();
			ToLua.Push(L, defaultCanvasMaterial);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetETC1SupportedCanvasMaterial(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			Material eTC1SupportedCanvasMaterial = Canvas.GetETC1SupportedCanvasMaterial();
			ToLua.Push(L, eTC1SupportedCanvasMaterial);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ForceUpdateCanvases(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			Canvas.ForceUpdateCanvases();
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
	private static int get_renderMode(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RenderMode renderMode = ((Canvas)obj).renderMode;
			ToLua.Push(L, renderMode);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index renderMode on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isRootCanvas(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isRootCanvas = ((Canvas)obj).isRootCanvas;
			LuaDLL.lua_pushboolean(L, isRootCanvas);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isRootCanvas on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_pixelRect(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Rect pixelRect = ((Canvas)obj).pixelRect;
			ToLua.PushValue(L, pixelRect);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index pixelRect on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_scaleFactor(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float scaleFactor = ((Canvas)obj).scaleFactor;
			LuaDLL.lua_pushnumber(L, scaleFactor);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index scaleFactor on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_referencePixelsPerUnit(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float referencePixelsPerUnit = ((Canvas)obj).referencePixelsPerUnit;
			LuaDLL.lua_pushnumber(L, referencePixelsPerUnit);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index referencePixelsPerUnit on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_overridePixelPerfect(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool overridePixelPerfect = ((Canvas)obj).overridePixelPerfect;
			LuaDLL.lua_pushboolean(L, overridePixelPerfect);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index overridePixelPerfect on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_pixelPerfect(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool pixelPerfect = ((Canvas)obj).pixelPerfect;
			LuaDLL.lua_pushboolean(L, pixelPerfect);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index pixelPerfect on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_planeDistance(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float planeDistance = ((Canvas)obj).planeDistance;
			LuaDLL.lua_pushnumber(L, planeDistance);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index planeDistance on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_renderOrder(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int renderOrder = ((Canvas)obj).renderOrder;
			LuaDLL.lua_pushinteger(L, renderOrder);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index renderOrder on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_overrideSorting(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool overrideSorting = ((Canvas)obj).overrideSorting;
			LuaDLL.lua_pushboolean(L, overrideSorting);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index overrideSorting on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_sortingOrder(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int sortingOrder = ((Canvas)obj).sortingOrder;
			LuaDLL.lua_pushinteger(L, sortingOrder);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index sortingOrder on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_targetDisplay(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int targetDisplay = ((Canvas)obj).targetDisplay;
			LuaDLL.lua_pushinteger(L, targetDisplay);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index targetDisplay on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_sortingLayerID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int sortingLayerID = ((Canvas)obj).sortingLayerID;
			LuaDLL.lua_pushinteger(L, sortingLayerID);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index sortingLayerID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_cachedSortingLayerValue(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int cachedSortingLayerValue = ((Canvas)obj).cachedSortingLayerValue;
			LuaDLL.lua_pushinteger(L, cachedSortingLayerValue);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index cachedSortingLayerValue on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_additionalShaderChannels(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			AdditionalCanvasShaderChannels additionalShaderChannels = ((Canvas)obj).additionalShaderChannels;
			ToLua.Push(L, additionalShaderChannels);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index additionalShaderChannels on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_sortingLayerName(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string sortingLayerName = ((Canvas)obj).sortingLayerName;
			LuaDLL.lua_pushstring(L, sortingLayerName);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index sortingLayerName on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_rootCanvas(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Canvas rootCanvas = ((Canvas)obj).rootCanvas;
			ToLua.PushSealed(L, rootCanvas);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index rootCanvas on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_renderingDisplaySize(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector2 renderingDisplaySize = ((Canvas)obj).renderingDisplaySize;
			ToLua.Push(L, renderingDisplaySize);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index renderingDisplaySize on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_worldCamera(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Camera worldCamera = ((Canvas)obj).worldCamera;
			ToLua.PushSealed(L, worldCamera);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index worldCamera on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_normalizedSortingGridSize(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float normalizedSortingGridSize = ((Canvas)obj).normalizedSortingGridSize;
			LuaDLL.lua_pushnumber(L, normalizedSortingGridSize);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index normalizedSortingGridSize on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_preWillRenderCanvases(IntPtr L)
	{
		ToLua.Push(L, new EventObject(typeof(Canvas.WillRenderCanvases)));
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_willRenderCanvases(IntPtr L)
	{
		ToLua.Push(L, new EventObject(typeof(Canvas.WillRenderCanvases)));
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_renderMode(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Canvas obj2 = (Canvas)obj;
			RenderMode renderMode = (RenderMode)ToLua.CheckObject(L, 2, typeof(RenderMode));
			obj2.renderMode = renderMode;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index renderMode on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_scaleFactor(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Canvas obj2 = (Canvas)obj;
			float scaleFactor = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.scaleFactor = scaleFactor;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index scaleFactor on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_referencePixelsPerUnit(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Canvas obj2 = (Canvas)obj;
			float referencePixelsPerUnit = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.referencePixelsPerUnit = referencePixelsPerUnit;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index referencePixelsPerUnit on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_overridePixelPerfect(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Canvas obj2 = (Canvas)obj;
			bool overridePixelPerfect = LuaDLL.luaL_checkboolean(L, 2);
			obj2.overridePixelPerfect = overridePixelPerfect;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index overridePixelPerfect on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_pixelPerfect(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Canvas obj2 = (Canvas)obj;
			bool pixelPerfect = LuaDLL.luaL_checkboolean(L, 2);
			obj2.pixelPerfect = pixelPerfect;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index pixelPerfect on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_planeDistance(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Canvas obj2 = (Canvas)obj;
			float planeDistance = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.planeDistance = planeDistance;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index planeDistance on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_overrideSorting(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Canvas obj2 = (Canvas)obj;
			bool overrideSorting = LuaDLL.luaL_checkboolean(L, 2);
			obj2.overrideSorting = overrideSorting;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index overrideSorting on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_sortingOrder(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Canvas obj2 = (Canvas)obj;
			int sortingOrder = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.sortingOrder = sortingOrder;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index sortingOrder on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_targetDisplay(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Canvas obj2 = (Canvas)obj;
			int targetDisplay = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.targetDisplay = targetDisplay;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index targetDisplay on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_sortingLayerID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Canvas obj2 = (Canvas)obj;
			int sortingLayerID = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.sortingLayerID = sortingLayerID;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index sortingLayerID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_additionalShaderChannels(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Canvas obj2 = (Canvas)obj;
			AdditionalCanvasShaderChannels additionalShaderChannels = (AdditionalCanvasShaderChannels)ToLua.CheckObject(L, 2, typeof(AdditionalCanvasShaderChannels));
			obj2.additionalShaderChannels = additionalShaderChannels;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index additionalShaderChannels on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_sortingLayerName(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Canvas obj2 = (Canvas)obj;
			string sortingLayerName = ToLua.CheckString(L, 2);
			obj2.sortingLayerName = sortingLayerName;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index sortingLayerName on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_worldCamera(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Canvas obj2 = (Canvas)obj;
			Camera worldCamera = (Camera)ToLua.CheckObject(L, 2, typeof(Camera));
			obj2.worldCamera = worldCamera;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index worldCamera on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_normalizedSortingGridSize(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Canvas obj2 = (Canvas)obj;
			float normalizedSortingGridSize = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.normalizedSortingGridSize = normalizedSortingGridSize;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index normalizedSortingGridSize on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_preWillRenderCanvases(IntPtr L)
	{
		try
		{
			EventObject eventObject = null;
			if (LuaDLL.lua_isuserdata(L, 2) != 0)
			{
				eventObject = (EventObject)ToLua.ToObject(L, 2);
				if (eventObject.op == EventOp.Add)
				{
					Canvas.preWillRenderCanvases += (Canvas.WillRenderCanvases)eventObject.func;
				}
				else if (eventObject.op == EventOp.Sub)
				{
					Canvas.preWillRenderCanvases -= (Canvas.WillRenderCanvases)eventObject.func;
				}
				return 0;
			}
			return LuaDLL.luaL_throw(L, "The event 'UnityEngine.Canvas.preWillRenderCanvases' can only appear on the left hand side of += or -= when used outside of the type 'UnityEngine.Canvas'");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_willRenderCanvases(IntPtr L)
	{
		try
		{
			EventObject eventObject = null;
			if (LuaDLL.lua_isuserdata(L, 2) != 0)
			{
				eventObject = (EventObject)ToLua.ToObject(L, 2);
				if (eventObject.op == EventOp.Add)
				{
					Canvas.willRenderCanvases += (Canvas.WillRenderCanvases)eventObject.func;
				}
				else if (eventObject.op == EventOp.Sub)
				{
					Canvas.willRenderCanvases -= (Canvas.WillRenderCanvases)eventObject.func;
				}
				return 0;
			}
			return LuaDLL.luaL_throw(L, "The event 'UnityEngine.Canvas.willRenderCanvases' can only appear on the left hand side of += or -= when used outside of the type 'UnityEngine.Canvas'");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UnityEngine_Canvas_WillRenderCanvases(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<Canvas.WillRenderCanvases>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<Canvas.WillRenderCanvases>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
