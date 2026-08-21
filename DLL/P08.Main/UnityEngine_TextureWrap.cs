using System;
using LuaInterface;
using UnityEngine;
using UnityEngine.Rendering;

public class UnityEngine_TextureWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(Texture), typeof(UnityEngine.Object));
		L.RegFunction("SetGlobalAnisotropicFilteringLimits", SetGlobalAnisotropicFilteringLimits);
		L.RegFunction("GetNativeTexturePtr", GetNativeTexturePtr);
		L.RegFunction("IncrementUpdateCount", IncrementUpdateCount);
		L.RegFunction("SetStreamingTextureMaterialDebugProperties", SetStreamingTextureMaterialDebugProperties);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("masterTextureLimit", get_masterTextureLimit, set_masterTextureLimit);
		L.RegVar("anisotropicFiltering", get_anisotropicFiltering, set_anisotropicFiltering);
		L.RegVar("width", get_width, set_width);
		L.RegVar("height", get_height, set_height);
		L.RegVar("dimension", get_dimension, set_dimension);
		L.RegVar("isReadable", get_isReadable, null);
		L.RegVar("wrapMode", get_wrapMode, set_wrapMode);
		L.RegVar("wrapModeU", get_wrapModeU, set_wrapModeU);
		L.RegVar("wrapModeV", get_wrapModeV, set_wrapModeV);
		L.RegVar("wrapModeW", get_wrapModeW, set_wrapModeW);
		L.RegVar("filterMode", get_filterMode, set_filterMode);
		L.RegVar("anisoLevel", get_anisoLevel, set_anisoLevel);
		L.RegVar("mipMapBias", get_mipMapBias, set_mipMapBias);
		L.RegVar("texelSize", get_texelSize, null);
		L.RegVar("updateCount", get_updateCount, null);
		L.RegVar("totalTextureMemory", get_totalTextureMemory, null);
		L.RegVar("desiredTextureMemory", get_desiredTextureMemory, null);
		L.RegVar("targetTextureMemory", get_targetTextureMemory, null);
		L.RegVar("currentTextureMemory", get_currentTextureMemory, null);
		L.RegVar("nonStreamingTextureMemory", get_nonStreamingTextureMemory, null);
		L.RegVar("streamingMipmapUploadCount", get_streamingMipmapUploadCount, null);
		L.RegVar("streamingRendererCount", get_streamingRendererCount, null);
		L.RegVar("streamingTextureCount", get_streamingTextureCount, null);
		L.RegVar("nonStreamingTextureCount", get_nonStreamingTextureCount, null);
		L.RegVar("streamingTexturePendingLoadCount", get_streamingTexturePendingLoadCount, null);
		L.RegVar("streamingTextureLoadingCount", get_streamingTextureLoadingCount, null);
		L.RegVar("streamingTextureForceLoadAll", get_streamingTextureForceLoadAll, set_streamingTextureForceLoadAll);
		L.RegVar("streamingTextureDiscardUnusedMips", get_streamingTextureDiscardUnusedMips, set_streamingTextureDiscardUnusedMips);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetGlobalAnisotropicFilteringLimits(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			int forcedMin = (int)LuaDLL.luaL_checknumber(L, 1);
			int globalMax = (int)LuaDLL.luaL_checknumber(L, 2);
			Texture.SetGlobalAnisotropicFilteringLimits(forcedMin, globalMax);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetNativeTexturePtr(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			IntPtr nativeTexturePtr = ((Texture)ToLua.CheckObject<Texture>(L, 1)).GetNativeTexturePtr();
			LuaDLL.lua_pushlightuserdata(L, nativeTexturePtr);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IncrementUpdateCount(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((Texture)ToLua.CheckObject<Texture>(L, 1)).IncrementUpdateCount();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetStreamingTextureMaterialDebugProperties(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			Texture.SetStreamingTextureMaterialDebugProperties();
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
	private static int get_masterTextureLimit(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushinteger(L, Texture.globalMipmapLimit);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_anisotropicFiltering(IntPtr L)
	{
		try
		{
			ToLua.Push(L, Texture.anisotropicFiltering);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_width(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int width = ((Texture)obj).width;
			LuaDLL.lua_pushinteger(L, width);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index width on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_height(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int height = ((Texture)obj).height;
			LuaDLL.lua_pushinteger(L, height);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index height on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_dimension(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			TextureDimension dimension = ((Texture)obj).dimension;
			ToLua.Push(L, dimension);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index dimension on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isReadable(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isReadable = ((Texture)obj).isReadable;
			LuaDLL.lua_pushboolean(L, isReadable);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isReadable on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_wrapMode(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			TextureWrapMode wrapMode = ((Texture)obj).wrapMode;
			ToLua.Push(L, wrapMode);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index wrapMode on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_wrapModeU(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			TextureWrapMode wrapModeU = ((Texture)obj).wrapModeU;
			ToLua.Push(L, wrapModeU);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index wrapModeU on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_wrapModeV(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			TextureWrapMode wrapModeV = ((Texture)obj).wrapModeV;
			ToLua.Push(L, wrapModeV);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index wrapModeV on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_wrapModeW(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			TextureWrapMode wrapModeW = ((Texture)obj).wrapModeW;
			ToLua.Push(L, wrapModeW);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index wrapModeW on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_filterMode(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			FilterMode filterMode = ((Texture)obj).filterMode;
			ToLua.Push(L, filterMode);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index filterMode on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_anisoLevel(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int anisoLevel = ((Texture)obj).anisoLevel;
			LuaDLL.lua_pushinteger(L, anisoLevel);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index anisoLevel on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_mipMapBias(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float mipMapBias = ((Texture)obj).mipMapBias;
			LuaDLL.lua_pushnumber(L, mipMapBias);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mipMapBias on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_texelSize(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector2 texelSize = ((Texture)obj).texelSize;
			ToLua.Push(L, texelSize);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index texelSize on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_updateCount(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			uint updateCount = ((Texture)obj).updateCount;
			LuaDLL.lua_pushnumber(L, updateCount);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index updateCount on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_totalTextureMemory(IntPtr L)
	{
		try
		{
			LuaDLL.tolua_pushuint64(L, Texture.totalTextureMemory);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_desiredTextureMemory(IntPtr L)
	{
		try
		{
			LuaDLL.tolua_pushuint64(L, Texture.desiredTextureMemory);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_targetTextureMemory(IntPtr L)
	{
		try
		{
			LuaDLL.tolua_pushuint64(L, Texture.targetTextureMemory);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_currentTextureMemory(IntPtr L)
	{
		try
		{
			LuaDLL.tolua_pushuint64(L, Texture.currentTextureMemory);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_nonStreamingTextureMemory(IntPtr L)
	{
		try
		{
			LuaDLL.tolua_pushuint64(L, Texture.nonStreamingTextureMemory);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_streamingMipmapUploadCount(IntPtr L)
	{
		try
		{
			LuaDLL.tolua_pushuint64(L, Texture.streamingMipmapUploadCount);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_streamingRendererCount(IntPtr L)
	{
		try
		{
			LuaDLL.tolua_pushuint64(L, Texture.streamingRendererCount);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_streamingTextureCount(IntPtr L)
	{
		try
		{
			LuaDLL.tolua_pushuint64(L, Texture.streamingTextureCount);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_nonStreamingTextureCount(IntPtr L)
	{
		try
		{
			LuaDLL.tolua_pushuint64(L, Texture.nonStreamingTextureCount);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_streamingTexturePendingLoadCount(IntPtr L)
	{
		try
		{
			LuaDLL.tolua_pushuint64(L, Texture.streamingTexturePendingLoadCount);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_streamingTextureLoadingCount(IntPtr L)
	{
		try
		{
			LuaDLL.tolua_pushuint64(L, Texture.streamingTextureLoadingCount);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_streamingTextureForceLoadAll(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, Texture.streamingTextureForceLoadAll);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_streamingTextureDiscardUnusedMips(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, Texture.streamingTextureDiscardUnusedMips);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_masterTextureLimit(IntPtr L)
	{
		try
		{
			Texture.globalMipmapLimit = (int)LuaDLL.luaL_checknumber(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_anisotropicFiltering(IntPtr L)
	{
		try
		{
			Texture.anisotropicFiltering = (AnisotropicFiltering)ToLua.CheckObject(L, 2, typeof(AnisotropicFiltering));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_width(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Texture obj2 = (Texture)obj;
			int width = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.width = width;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index width on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_height(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Texture obj2 = (Texture)obj;
			int height = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.height = height;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index height on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_dimension(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Texture obj2 = (Texture)obj;
			TextureDimension dimension = (TextureDimension)ToLua.CheckObject(L, 2, typeof(TextureDimension));
			obj2.dimension = dimension;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index dimension on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_wrapMode(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Texture obj2 = (Texture)obj;
			TextureWrapMode wrapMode = (TextureWrapMode)ToLua.CheckObject(L, 2, typeof(TextureWrapMode));
			obj2.wrapMode = wrapMode;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index wrapMode on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_wrapModeU(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Texture obj2 = (Texture)obj;
			TextureWrapMode wrapModeU = (TextureWrapMode)ToLua.CheckObject(L, 2, typeof(TextureWrapMode));
			obj2.wrapModeU = wrapModeU;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index wrapModeU on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_wrapModeV(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Texture obj2 = (Texture)obj;
			TextureWrapMode wrapModeV = (TextureWrapMode)ToLua.CheckObject(L, 2, typeof(TextureWrapMode));
			obj2.wrapModeV = wrapModeV;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index wrapModeV on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_wrapModeW(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Texture obj2 = (Texture)obj;
			TextureWrapMode wrapModeW = (TextureWrapMode)ToLua.CheckObject(L, 2, typeof(TextureWrapMode));
			obj2.wrapModeW = wrapModeW;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index wrapModeW on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_filterMode(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Texture obj2 = (Texture)obj;
			FilterMode filterMode = (FilterMode)ToLua.CheckObject(L, 2, typeof(FilterMode));
			obj2.filterMode = filterMode;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index filterMode on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_anisoLevel(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Texture obj2 = (Texture)obj;
			int anisoLevel = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.anisoLevel = anisoLevel;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index anisoLevel on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_mipMapBias(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Texture obj2 = (Texture)obj;
			float mipMapBias = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.mipMapBias = mipMapBias;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mipMapBias on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_streamingTextureForceLoadAll(IntPtr L)
	{
		try
		{
			Texture.streamingTextureForceLoadAll = LuaDLL.luaL_checkboolean(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_streamingTextureDiscardUnusedMips(IntPtr L)
	{
		try
		{
			Texture.streamingTextureDiscardUnusedMips = LuaDLL.luaL_checkboolean(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
