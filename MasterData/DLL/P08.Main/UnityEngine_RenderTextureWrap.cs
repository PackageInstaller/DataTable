using System;
using LuaInterface;
using UnityEngine;
using UnityEngine.Experimental.Rendering;
using UnityEngine.Rendering;

public class UnityEngine_RenderTextureWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(RenderTexture), typeof(Texture));
		L.RegFunction("GetNativeDepthBufferPtr", GetNativeDepthBufferPtr);
		L.RegFunction("DiscardContents", DiscardContents);
		L.RegFunction("MarkRestoreExpected", MarkRestoreExpected);
		L.RegFunction("ResolveAntiAliasedSurface", ResolveAntiAliasedSurface);
		L.RegFunction("SetGlobalShaderProperty", SetGlobalShaderProperty);
		L.RegFunction("Create", Create);
		L.RegFunction("Release", Release);
		L.RegFunction("IsCreated", IsCreated);
		L.RegFunction("GenerateMips", GenerateMips);
		L.RegFunction("ConvertToEquirect", ConvertToEquirect);
		L.RegFunction("SupportsStencil", SupportsStencil);
		L.RegFunction("ReleaseTemporary", ReleaseTemporary);
		L.RegFunction("GetTemporary", GetTemporary);
		L.RegFunction("New", _CreateUnityEngine_RenderTexture);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("width", get_width, set_width);
		L.RegVar("height", get_height, set_height);
		L.RegVar("dimension", get_dimension, set_dimension);
		L.RegVar("useMipMap", get_useMipMap, set_useMipMap);
		L.RegVar("sRGB", get_sRGB, null);
		L.RegVar("format", get_format, set_format);
		L.RegVar("vrUsage", get_vrUsage, set_vrUsage);
		L.RegVar("memorylessMode", get_memorylessMode, set_memorylessMode);
		L.RegVar("autoGenerateMips", get_autoGenerateMips, set_autoGenerateMips);
		L.RegVar("volumeDepth", get_volumeDepth, set_volumeDepth);
		L.RegVar("antiAliasing", get_antiAliasing, set_antiAliasing);
		L.RegVar("bindTextureMS", get_bindTextureMS, set_bindTextureMS);
		L.RegVar("enableRandomWrite", get_enableRandomWrite, set_enableRandomWrite);
		L.RegVar("useDynamicScale", get_useDynamicScale, set_useDynamicScale);
		L.RegVar("isPowerOfTwo", get_isPowerOfTwo, set_isPowerOfTwo);
		L.RegVar("active", get_active, set_active);
		L.RegVar("colorBuffer", get_colorBuffer, null);
		L.RegVar("depthBuffer", get_depthBuffer, null);
		L.RegVar("depth", get_depth, set_depth);
		L.RegVar("descriptor", get_descriptor, set_descriptor);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateUnityEngine_RenderTexture(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 1 && TypeChecker.CheckTypes<RenderTexture>(L, 1))
			{
				RenderTexture obj = new RenderTexture((RenderTexture)ToLua.ToObject(L, 1));
				ToLua.Push(L, obj);
				return 1;
			}
			if (num == 1 && TypeChecker.CheckTypes<RenderTextureDescriptor>(L, 1))
			{
				RenderTexture obj2 = new RenderTexture(StackTraits<RenderTextureDescriptor>.To(L, 1));
				ToLua.Push(L, obj2);
				return 1;
			}
			switch (num)
			{
			case 3:
			{
				int width2 = (int)LuaDLL.luaL_checknumber(L, 1);
				int height2 = (int)LuaDLL.luaL_checknumber(L, 2);
				int depth2 = (int)LuaDLL.luaL_checknumber(L, 3);
				RenderTexture obj4 = new RenderTexture(width2, height2, depth2);
				ToLua.Push(L, obj4);
				return 1;
			}
			case 4:
				if (TypeChecker.CheckTypes<RenderTextureFormat>(L, 4))
				{
					int width = (int)LuaDLL.luaL_checknumber(L, 1);
					int height = (int)LuaDLL.luaL_checknumber(L, 2);
					int depth = (int)LuaDLL.luaL_checknumber(L, 3);
					RenderTextureFormat format = (RenderTextureFormat)ToLua.ToObject(L, 4);
					RenderTexture obj3 = new RenderTexture(width, height, depth, format);
					ToLua.Push(L, obj3);
					return 1;
				}
				break;
			}
			if (num == 4 && TypeChecker.CheckTypes<GraphicsFormat>(L, 4))
			{
				int width3 = (int)LuaDLL.luaL_checknumber(L, 1);
				int height3 = (int)LuaDLL.luaL_checknumber(L, 2);
				int depth3 = (int)LuaDLL.luaL_checknumber(L, 3);
				GraphicsFormat format2 = (GraphicsFormat)ToLua.ToObject(L, 4);
				RenderTexture obj5 = new RenderTexture(width3, height3, depth3, format2);
				ToLua.Push(L, obj5);
				return 1;
			}
			if (num == 5)
			{
				int width4 = (int)LuaDLL.luaL_checknumber(L, 1);
				int height4 = (int)LuaDLL.luaL_checknumber(L, 2);
				int depth4 = (int)LuaDLL.luaL_checknumber(L, 3);
				RenderTextureFormat format3 = (RenderTextureFormat)ToLua.CheckObject(L, 4, typeof(RenderTextureFormat));
				RenderTextureReadWrite readWrite = (RenderTextureReadWrite)ToLua.CheckObject(L, 5, typeof(RenderTextureReadWrite));
				RenderTexture obj6 = new RenderTexture(width4, height4, depth4, format3, readWrite);
				ToLua.Push(L, obj6);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: UnityEngine.RenderTexture.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetNativeDepthBufferPtr(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			IntPtr nativeDepthBufferPtr = ((RenderTexture)ToLua.CheckObject<RenderTexture>(L, 1)).GetNativeDepthBufferPtr();
			LuaDLL.lua_pushlightuserdata(L, nativeDepthBufferPtr);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int DiscardContents(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
				((RenderTexture)ToLua.CheckObject<RenderTexture>(L, 1)).DiscardContents();
				return 0;
			case 3:
			{
				RenderTexture obj = (RenderTexture)ToLua.CheckObject<RenderTexture>(L, 1);
				bool discardColor = LuaDLL.luaL_checkboolean(L, 2);
				bool discardDepth = LuaDLL.luaL_checkboolean(L, 3);
				obj.DiscardContents(discardColor, discardDepth);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.RenderTexture.DiscardContents");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int MarkRestoreExpected(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((RenderTexture)ToLua.CheckObject<RenderTexture>(L, 1)).MarkRestoreExpected();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ResolveAntiAliasedSurface(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
				((RenderTexture)ToLua.CheckObject<RenderTexture>(L, 1)).ResolveAntiAliasedSurface();
				return 0;
			case 2:
			{
				RenderTexture obj = (RenderTexture)ToLua.CheckObject<RenderTexture>(L, 1);
				RenderTexture target = (RenderTexture)ToLua.CheckObject<RenderTexture>(L, 2);
				obj.ResolveAntiAliasedSurface(target);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.RenderTexture.ResolveAntiAliasedSurface");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetGlobalShaderProperty(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			RenderTexture obj = (RenderTexture)ToLua.CheckObject<RenderTexture>(L, 1);
			string globalShaderProperty = ToLua.CheckString(L, 2);
			obj.SetGlobalShaderProperty(globalShaderProperty);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Create(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = ((RenderTexture)ToLua.CheckObject<RenderTexture>(L, 1)).Create();
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Release(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((RenderTexture)ToLua.CheckObject<RenderTexture>(L, 1)).Release();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IsCreated(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = ((RenderTexture)ToLua.CheckObject<RenderTexture>(L, 1)).IsCreated();
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GenerateMips(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((RenderTexture)ToLua.CheckObject<RenderTexture>(L, 1)).GenerateMips();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ConvertToEquirect(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				RenderTexture obj2 = (RenderTexture)ToLua.CheckObject<RenderTexture>(L, 1);
				RenderTexture equirect2 = (RenderTexture)ToLua.CheckObject<RenderTexture>(L, 2);
				obj2.ConvertToEquirect(equirect2);
				return 0;
			}
			case 3:
			{
				RenderTexture obj = (RenderTexture)ToLua.CheckObject<RenderTexture>(L, 1);
				RenderTexture equirect = (RenderTexture)ToLua.CheckObject<RenderTexture>(L, 2);
				Camera.MonoOrStereoscopicEye eye = (Camera.MonoOrStereoscopicEye)ToLua.CheckObject(L, 3, typeof(Camera.MonoOrStereoscopicEye));
				obj.ConvertToEquirect(equirect, eye);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.RenderTexture.ConvertToEquirect");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SupportsStencil(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = RenderTexture.SupportsStencil((RenderTexture)ToLua.CheckObject<RenderTexture>(L, 1));
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ReleaseTemporary(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			RenderTexture.ReleaseTemporary((RenderTexture)ToLua.CheckObject<RenderTexture>(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetTemporary(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
			{
				RenderTexture temporary9 = RenderTexture.GetTemporary(StackTraits<RenderTextureDescriptor>.Check(L, 1));
				ToLua.Push(L, temporary9);
				return 1;
			}
			case 2:
			{
				int width8 = (int)LuaDLL.luaL_checknumber(L, 1);
				int height8 = (int)LuaDLL.luaL_checknumber(L, 2);
				RenderTexture temporary8 = RenderTexture.GetTemporary(width8, height8);
				ToLua.Push(L, temporary8);
				return 1;
			}
			case 3:
			{
				int width7 = (int)LuaDLL.luaL_checknumber(L, 1);
				int height7 = (int)LuaDLL.luaL_checknumber(L, 2);
				int depthBuffer7 = (int)LuaDLL.luaL_checknumber(L, 3);
				RenderTexture temporary7 = RenderTexture.GetTemporary(width7, height7, depthBuffer7);
				ToLua.Push(L, temporary7);
				return 1;
			}
			case 4:
			{
				int width6 = (int)LuaDLL.luaL_checknumber(L, 1);
				int height6 = (int)LuaDLL.luaL_checknumber(L, 2);
				int depthBuffer6 = (int)LuaDLL.luaL_checknumber(L, 3);
				RenderTextureFormat format6 = (RenderTextureFormat)ToLua.CheckObject(L, 4, typeof(RenderTextureFormat));
				RenderTexture temporary6 = RenderTexture.GetTemporary(width6, height6, depthBuffer6, format6);
				ToLua.Push(L, temporary6);
				return 1;
			}
			case 5:
			{
				int width5 = (int)LuaDLL.luaL_checknumber(L, 1);
				int height5 = (int)LuaDLL.luaL_checknumber(L, 2);
				int depthBuffer5 = (int)LuaDLL.luaL_checknumber(L, 3);
				RenderTextureFormat format5 = (RenderTextureFormat)ToLua.CheckObject(L, 4, typeof(RenderTextureFormat));
				RenderTextureReadWrite readWrite5 = (RenderTextureReadWrite)ToLua.CheckObject(L, 5, typeof(RenderTextureReadWrite));
				RenderTexture temporary5 = RenderTexture.GetTemporary(width5, height5, depthBuffer5, format5, readWrite5);
				ToLua.Push(L, temporary5);
				return 1;
			}
			case 6:
			{
				int width4 = (int)LuaDLL.luaL_checknumber(L, 1);
				int height4 = (int)LuaDLL.luaL_checknumber(L, 2);
				int depthBuffer4 = (int)LuaDLL.luaL_checknumber(L, 3);
				RenderTextureFormat format4 = (RenderTextureFormat)ToLua.CheckObject(L, 4, typeof(RenderTextureFormat));
				RenderTextureReadWrite readWrite4 = (RenderTextureReadWrite)ToLua.CheckObject(L, 5, typeof(RenderTextureReadWrite));
				int antiAliasing4 = (int)LuaDLL.luaL_checknumber(L, 6);
				RenderTexture temporary4 = RenderTexture.GetTemporary(width4, height4, depthBuffer4, format4, readWrite4, antiAliasing4);
				ToLua.Push(L, temporary4);
				return 1;
			}
			case 7:
			{
				int width3 = (int)LuaDLL.luaL_checknumber(L, 1);
				int height3 = (int)LuaDLL.luaL_checknumber(L, 2);
				int depthBuffer3 = (int)LuaDLL.luaL_checknumber(L, 3);
				RenderTextureFormat format3 = (RenderTextureFormat)ToLua.CheckObject(L, 4, typeof(RenderTextureFormat));
				RenderTextureReadWrite readWrite3 = (RenderTextureReadWrite)ToLua.CheckObject(L, 5, typeof(RenderTextureReadWrite));
				int antiAliasing3 = (int)LuaDLL.luaL_checknumber(L, 6);
				RenderTextureMemoryless memorylessMode3 = (RenderTextureMemoryless)ToLua.CheckObject(L, 7, typeof(RenderTextureMemoryless));
				RenderTexture temporary3 = RenderTexture.GetTemporary(width3, height3, depthBuffer3, format3, readWrite3, antiAliasing3, memorylessMode3);
				ToLua.Push(L, temporary3);
				return 1;
			}
			case 8:
			{
				int width2 = (int)LuaDLL.luaL_checknumber(L, 1);
				int height2 = (int)LuaDLL.luaL_checknumber(L, 2);
				int depthBuffer2 = (int)LuaDLL.luaL_checknumber(L, 3);
				RenderTextureFormat format2 = (RenderTextureFormat)ToLua.CheckObject(L, 4, typeof(RenderTextureFormat));
				RenderTextureReadWrite readWrite2 = (RenderTextureReadWrite)ToLua.CheckObject(L, 5, typeof(RenderTextureReadWrite));
				int antiAliasing2 = (int)LuaDLL.luaL_checknumber(L, 6);
				RenderTextureMemoryless memorylessMode2 = (RenderTextureMemoryless)ToLua.CheckObject(L, 7, typeof(RenderTextureMemoryless));
				VRTextureUsage vrUsage2 = (VRTextureUsage)ToLua.CheckObject(L, 8, typeof(VRTextureUsage));
				RenderTexture temporary2 = RenderTexture.GetTemporary(width2, height2, depthBuffer2, format2, readWrite2, antiAliasing2, memorylessMode2, vrUsage2);
				ToLua.Push(L, temporary2);
				return 1;
			}
			case 9:
			{
				int width = (int)LuaDLL.luaL_checknumber(L, 1);
				int height = (int)LuaDLL.luaL_checknumber(L, 2);
				int depthBuffer = (int)LuaDLL.luaL_checknumber(L, 3);
				RenderTextureFormat format = (RenderTextureFormat)ToLua.CheckObject(L, 4, typeof(RenderTextureFormat));
				RenderTextureReadWrite readWrite = (RenderTextureReadWrite)ToLua.CheckObject(L, 5, typeof(RenderTextureReadWrite));
				int antiAliasing = (int)LuaDLL.luaL_checknumber(L, 6);
				RenderTextureMemoryless memorylessMode = (RenderTextureMemoryless)ToLua.CheckObject(L, 7, typeof(RenderTextureMemoryless));
				VRTextureUsage vrUsage = (VRTextureUsage)ToLua.CheckObject(L, 8, typeof(VRTextureUsage));
				bool useDynamicScale = LuaDLL.luaL_checkboolean(L, 9);
				RenderTexture temporary = RenderTexture.GetTemporary(width, height, depthBuffer, format, readWrite, antiAliasing, memorylessMode, vrUsage, useDynamicScale);
				ToLua.Push(L, temporary);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.RenderTexture.GetTemporary");
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
	private static int get_width(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int width = ((RenderTexture)obj).width;
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
			int height = ((RenderTexture)obj).height;
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
			TextureDimension dimension = ((RenderTexture)obj).dimension;
			ToLua.Push(L, dimension);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index dimension on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_useMipMap(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool useMipMap = ((RenderTexture)obj).useMipMap;
			LuaDLL.lua_pushboolean(L, useMipMap);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index useMipMap on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_sRGB(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool sRGB = ((RenderTexture)obj).sRGB;
			LuaDLL.lua_pushboolean(L, sRGB);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index sRGB on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_format(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RenderTextureFormat format = ((RenderTexture)obj).format;
			ToLua.Push(L, format);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index format on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_vrUsage(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			VRTextureUsage vrUsage = ((RenderTexture)obj).vrUsage;
			ToLua.Push(L, vrUsage);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index vrUsage on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_memorylessMode(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RenderTextureMemoryless memorylessMode = ((RenderTexture)obj).memorylessMode;
			ToLua.Push(L, memorylessMode);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index memorylessMode on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_autoGenerateMips(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool autoGenerateMips = ((RenderTexture)obj).autoGenerateMips;
			LuaDLL.lua_pushboolean(L, autoGenerateMips);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index autoGenerateMips on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_volumeDepth(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int volumeDepth = ((RenderTexture)obj).volumeDepth;
			LuaDLL.lua_pushinteger(L, volumeDepth);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index volumeDepth on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_antiAliasing(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int antiAliasing = ((RenderTexture)obj).antiAliasing;
			LuaDLL.lua_pushinteger(L, antiAliasing);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index antiAliasing on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_bindTextureMS(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool bindTextureMS = ((RenderTexture)obj).bindTextureMS;
			LuaDLL.lua_pushboolean(L, bindTextureMS);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index bindTextureMS on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_enableRandomWrite(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool enableRandomWrite = ((RenderTexture)obj).enableRandomWrite;
			LuaDLL.lua_pushboolean(L, enableRandomWrite);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index enableRandomWrite on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_useDynamicScale(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool useDynamicScale = ((RenderTexture)obj).useDynamicScale;
			LuaDLL.lua_pushboolean(L, useDynamicScale);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index useDynamicScale on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isPowerOfTwo(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isPowerOfTwo = ((RenderTexture)obj).isPowerOfTwo;
			LuaDLL.lua_pushboolean(L, isPowerOfTwo);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isPowerOfTwo on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_active(IntPtr L)
	{
		try
		{
			ToLua.Push(L, RenderTexture.active);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_colorBuffer(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RenderBuffer colorBuffer = ((RenderTexture)obj).colorBuffer;
			ToLua.PushValue(L, colorBuffer);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index colorBuffer on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_depthBuffer(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RenderBuffer depthBuffer = ((RenderTexture)obj).depthBuffer;
			ToLua.PushValue(L, depthBuffer);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index depthBuffer on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_depth(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int depth = ((RenderTexture)obj).depth;
			LuaDLL.lua_pushinteger(L, depth);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index depth on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_descriptor(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RenderTextureDescriptor descriptor = ((RenderTexture)obj).descriptor;
			ToLua.PushValue(L, descriptor);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index descriptor on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_width(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RenderTexture obj2 = (RenderTexture)obj;
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
			RenderTexture obj2 = (RenderTexture)obj;
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
			RenderTexture obj2 = (RenderTexture)obj;
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
	private static int set_useMipMap(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RenderTexture obj2 = (RenderTexture)obj;
			bool useMipMap = LuaDLL.luaL_checkboolean(L, 2);
			obj2.useMipMap = useMipMap;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index useMipMap on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_format(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RenderTexture obj2 = (RenderTexture)obj;
			RenderTextureFormat format = (RenderTextureFormat)ToLua.CheckObject(L, 2, typeof(RenderTextureFormat));
			obj2.format = format;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index format on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_vrUsage(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RenderTexture obj2 = (RenderTexture)obj;
			VRTextureUsage vrUsage = (VRTextureUsage)ToLua.CheckObject(L, 2, typeof(VRTextureUsage));
			obj2.vrUsage = vrUsage;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index vrUsage on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_memorylessMode(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RenderTexture obj2 = (RenderTexture)obj;
			RenderTextureMemoryless memorylessMode = (RenderTextureMemoryless)ToLua.CheckObject(L, 2, typeof(RenderTextureMemoryless));
			obj2.memorylessMode = memorylessMode;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index memorylessMode on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_autoGenerateMips(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RenderTexture obj2 = (RenderTexture)obj;
			bool autoGenerateMips = LuaDLL.luaL_checkboolean(L, 2);
			obj2.autoGenerateMips = autoGenerateMips;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index autoGenerateMips on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_volumeDepth(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RenderTexture obj2 = (RenderTexture)obj;
			int volumeDepth = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.volumeDepth = volumeDepth;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index volumeDepth on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_antiAliasing(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RenderTexture obj2 = (RenderTexture)obj;
			int antiAliasing = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.antiAliasing = antiAliasing;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index antiAliasing on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_bindTextureMS(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RenderTexture obj2 = (RenderTexture)obj;
			bool bindTextureMS = LuaDLL.luaL_checkboolean(L, 2);
			obj2.bindTextureMS = bindTextureMS;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index bindTextureMS on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_enableRandomWrite(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RenderTexture obj2 = (RenderTexture)obj;
			bool enableRandomWrite = LuaDLL.luaL_checkboolean(L, 2);
			obj2.enableRandomWrite = enableRandomWrite;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index enableRandomWrite on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_useDynamicScale(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RenderTexture obj2 = (RenderTexture)obj;
			bool useDynamicScale = LuaDLL.luaL_checkboolean(L, 2);
			obj2.useDynamicScale = useDynamicScale;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index useDynamicScale on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_isPowerOfTwo(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RenderTexture obj2 = (RenderTexture)obj;
			bool isPowerOfTwo = LuaDLL.luaL_checkboolean(L, 2);
			obj2.isPowerOfTwo = isPowerOfTwo;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isPowerOfTwo on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_active(IntPtr L)
	{
		try
		{
			RenderTexture.active = (RenderTexture)ToLua.CheckObject<RenderTexture>(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_depth(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RenderTexture obj2 = (RenderTexture)obj;
			int depth = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.depth = depth;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index depth on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_descriptor(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RenderTexture obj2 = (RenderTexture)obj;
			RenderTextureDescriptor descriptor = StackTraits<RenderTextureDescriptor>.Check(L, 2);
			obj2.descriptor = descriptor;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index descriptor on a nil value");
		}
	}
}
