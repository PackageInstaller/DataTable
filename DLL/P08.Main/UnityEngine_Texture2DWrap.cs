using System;
using System.Collections.Generic;
using LuaInterface;
using UnityEngine;
using UnityEngine.Experimental.Rendering;

public class UnityEngine_Texture2DWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(Texture2D), typeof(Texture));
		L.RegFunction("Compress", Compress);
		L.RegFunction("ClearRequestedMipmapLevel", ClearRequestedMipmapLevel);
		L.RegFunction("IsRequestedMipmapLevelLoaded", IsRequestedMipmapLevelLoaded);
		L.RegFunction("UpdateExternalTexture", UpdateExternalTexture);
		L.RegFunction("GetRawTextureData", GetRawTextureData);
		L.RegFunction("GetPixels", GetPixels);
		L.RegFunction("GetPixels32", GetPixels32);
		L.RegFunction("PackTextures", PackTextures);
		L.RegFunction("CreateExternalTexture", CreateExternalTexture);
		L.RegFunction("SetPixel", SetPixel);
		L.RegFunction("SetPixels", SetPixels);
		L.RegFunction("GetPixel", GetPixel);
		L.RegFunction("GetPixelBilinear", GetPixelBilinear);
		L.RegFunction("LoadRawTextureData", LoadRawTextureData);
		L.RegFunction("Apply", Apply);
		L.RegFunction("Resize", Resize);
		L.RegFunction("ReadPixels", ReadPixels);
		L.RegFunction("GenerateAtlas", GenerateAtlas);
		L.RegFunction("SetPixels32", SetPixels32);
		L.RegFunction("New", _CreateUnityEngine_Texture2D);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("mipmapCount", get_mipmapCount, null);
		L.RegVar("format", get_format, null);
		L.RegVar("whiteTexture", get_whiteTexture, null);
		L.RegVar("blackTexture", get_blackTexture, null);
		L.RegVar("isReadable", get_isReadable, null);
		L.RegVar("streamingMipmaps", get_streamingMipmaps, null);
		L.RegVar("streamingMipmapsPriority", get_streamingMipmapsPriority, null);
		L.RegVar("requestedMipmapLevel", get_requestedMipmapLevel, set_requestedMipmapLevel);
		L.RegVar("desiredMipmapLevel", get_desiredMipmapLevel, null);
		L.RegVar("loadingMipmapLevel", get_loadingMipmapLevel, null);
		L.RegVar("loadedMipmapLevel", get_loadedMipmapLevel, null);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateUnityEngine_Texture2D(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			switch (num)
			{
			case 2:
			{
				int width2 = (int)LuaDLL.luaL_checknumber(L, 1);
				int height2 = (int)LuaDLL.luaL_checknumber(L, 2);
				Texture2D o2 = new Texture2D(width2, height2);
				ToLua.PushSealed(L, o2);
				return 1;
			}
			case 4:
				if (TypeChecker.CheckTypes<TextureFormat, bool>(L, 3))
				{
					int width = (int)LuaDLL.luaL_checknumber(L, 1);
					int height = (int)LuaDLL.luaL_checknumber(L, 2);
					TextureFormat textureFormat = (TextureFormat)ToLua.ToObject(L, 3);
					bool mipChain = LuaDLL.lua_toboolean(L, 4);
					Texture2D o = new Texture2D(width, height, textureFormat, mipChain);
					ToLua.PushSealed(L, o);
					return 1;
				}
				break;
			}
			if (num == 4 && TypeChecker.CheckTypes<GraphicsFormat, TextureCreationFlags>(L, 3))
			{
				int width3 = (int)LuaDLL.luaL_checknumber(L, 1);
				int height3 = (int)LuaDLL.luaL_checknumber(L, 2);
				GraphicsFormat format = (GraphicsFormat)ToLua.ToObject(L, 3);
				TextureCreationFlags flags = (TextureCreationFlags)ToLua.ToObject(L, 4);
				Texture2D o3 = new Texture2D(width3, height3, format, flags);
				ToLua.PushSealed(L, o3);
				return 1;
			}
			if (num == 5)
			{
				int width4 = (int)LuaDLL.luaL_checknumber(L, 1);
				int height4 = (int)LuaDLL.luaL_checknumber(L, 2);
				TextureFormat textureFormat2 = (TextureFormat)ToLua.CheckObject(L, 3, typeof(TextureFormat));
				bool mipChain2 = LuaDLL.luaL_checkboolean(L, 4);
				bool linear = LuaDLL.luaL_checkboolean(L, 5);
				Texture2D o4 = new Texture2D(width4, height4, textureFormat2, mipChain2, linear);
				ToLua.PushSealed(L, o4);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: UnityEngine.Texture2D.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Compress(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Texture2D obj = (Texture2D)ToLua.CheckObject(L, 1, typeof(Texture2D));
			bool highQuality = LuaDLL.luaL_checkboolean(L, 2);
			obj.Compress(highQuality);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ClearRequestedMipmapLevel(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((Texture2D)ToLua.CheckObject(L, 1, typeof(Texture2D))).ClearRequestedMipmapLevel();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IsRequestedMipmapLevelLoaded(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = ((Texture2D)ToLua.CheckObject(L, 1, typeof(Texture2D))).IsRequestedMipmapLevelLoaded();
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UpdateExternalTexture(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Texture2D obj = (Texture2D)ToLua.CheckObject(L, 1, typeof(Texture2D));
			IntPtr nativeTex = ToLua.CheckIntPtr(L, 2);
			obj.UpdateExternalTexture(nativeTex);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetRawTextureData(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			byte[] rawTextureData = ((Texture2D)ToLua.CheckObject(L, 1, typeof(Texture2D))).GetRawTextureData();
			ToLua.Push(L, rawTextureData);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetPixels(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
			{
				Color[] pixels4 = ((Texture2D)ToLua.CheckObject(L, 1, typeof(Texture2D))).GetPixels();
				ToLua.Push(L, pixels4);
				return 1;
			}
			case 2:
			{
				Texture2D obj3 = (Texture2D)ToLua.CheckObject(L, 1, typeof(Texture2D));
				int miplevel2 = (int)LuaDLL.luaL_checknumber(L, 2);
				Color[] pixels3 = obj3.GetPixels(miplevel2);
				ToLua.Push(L, pixels3);
				return 1;
			}
			case 5:
			{
				Texture2D obj2 = (Texture2D)ToLua.CheckObject(L, 1, typeof(Texture2D));
				int x2 = (int)LuaDLL.luaL_checknumber(L, 2);
				int y2 = (int)LuaDLL.luaL_checknumber(L, 3);
				int blockWidth2 = (int)LuaDLL.luaL_checknumber(L, 4);
				int blockHeight2 = (int)LuaDLL.luaL_checknumber(L, 5);
				Color[] pixels2 = obj2.GetPixels(x2, y2, blockWidth2, blockHeight2);
				ToLua.Push(L, pixels2);
				return 1;
			}
			case 6:
			{
				Texture2D obj = (Texture2D)ToLua.CheckObject(L, 1, typeof(Texture2D));
				int x = (int)LuaDLL.luaL_checknumber(L, 2);
				int y = (int)LuaDLL.luaL_checknumber(L, 3);
				int blockWidth = (int)LuaDLL.luaL_checknumber(L, 4);
				int blockHeight = (int)LuaDLL.luaL_checknumber(L, 5);
				int miplevel = (int)LuaDLL.luaL_checknumber(L, 6);
				Color[] pixels = obj.GetPixels(x, y, blockWidth, blockHeight, miplevel);
				ToLua.Push(L, pixels);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Texture2D.GetPixels");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetPixels32(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
			{
				Color32[] pixels2 = ((Texture2D)ToLua.CheckObject(L, 1, typeof(Texture2D))).GetPixels32();
				ToLua.Push(L, pixels2);
				return 1;
			}
			case 2:
			{
				Texture2D obj = (Texture2D)ToLua.CheckObject(L, 1, typeof(Texture2D));
				int miplevel = (int)LuaDLL.luaL_checknumber(L, 2);
				Color32[] pixels = obj.GetPixels32(miplevel);
				ToLua.Push(L, pixels);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Texture2D.GetPixels32");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int PackTextures(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 3:
			{
				Texture2D obj3 = (Texture2D)ToLua.CheckObject(L, 1, typeof(Texture2D));
				Texture2D[] textures3 = ToLua.CheckObjectArray<Texture2D>(L, 2);
				int padding3 = (int)LuaDLL.luaL_checknumber(L, 3);
				Rect[] array3 = obj3.PackTextures(textures3, padding3);
				ToLua.Push(L, array3);
				return 1;
			}
			case 4:
			{
				Texture2D obj2 = (Texture2D)ToLua.CheckObject(L, 1, typeof(Texture2D));
				Texture2D[] textures2 = ToLua.CheckObjectArray<Texture2D>(L, 2);
				int padding2 = (int)LuaDLL.luaL_checknumber(L, 3);
				int maximumAtlasSize2 = (int)LuaDLL.luaL_checknumber(L, 4);
				Rect[] array2 = obj2.PackTextures(textures2, padding2, maximumAtlasSize2);
				ToLua.Push(L, array2);
				return 1;
			}
			case 5:
			{
				Texture2D obj = (Texture2D)ToLua.CheckObject(L, 1, typeof(Texture2D));
				Texture2D[] textures = ToLua.CheckObjectArray<Texture2D>(L, 2);
				int padding = (int)LuaDLL.luaL_checknumber(L, 3);
				int maximumAtlasSize = (int)LuaDLL.luaL_checknumber(L, 4);
				bool makeNoLongerReadable = LuaDLL.luaL_checkboolean(L, 5);
				Rect[] array = obj.PackTextures(textures, padding, maximumAtlasSize, makeNoLongerReadable);
				ToLua.Push(L, array);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Texture2D.PackTextures");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CreateExternalTexture(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 6);
			int width = (int)LuaDLL.luaL_checknumber(L, 1);
			int height = (int)LuaDLL.luaL_checknumber(L, 2);
			TextureFormat format = (TextureFormat)ToLua.CheckObject(L, 3, typeof(TextureFormat));
			bool mipChain = LuaDLL.luaL_checkboolean(L, 4);
			bool linear = LuaDLL.luaL_checkboolean(L, 5);
			IntPtr nativeTex = ToLua.CheckIntPtr(L, 6);
			Texture2D o = Texture2D.CreateExternalTexture(width, height, format, mipChain, linear, nativeTex);
			ToLua.PushSealed(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetPixel(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			Texture2D obj = (Texture2D)ToLua.CheckObject(L, 1, typeof(Texture2D));
			int x = (int)LuaDLL.luaL_checknumber(L, 2);
			int y = (int)LuaDLL.luaL_checknumber(L, 3);
			Color color = ToLua.ToColor(L, 4);
			obj.SetPixel(x, y, color);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetPixels(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				Texture2D obj4 = (Texture2D)ToLua.CheckObject(L, 1, typeof(Texture2D));
				Color[] pixels = ToLua.CheckStructArray<Color>(L, 2);
				obj4.SetPixels(pixels);
				return 0;
			}
			case 3:
			{
				Texture2D obj3 = (Texture2D)ToLua.CheckObject(L, 1, typeof(Texture2D));
				Color[] colors3 = ToLua.CheckStructArray<Color>(L, 2);
				int miplevel2 = (int)LuaDLL.luaL_checknumber(L, 3);
				obj3.SetPixels(colors3, miplevel2);
				return 0;
			}
			case 6:
			{
				Texture2D obj2 = (Texture2D)ToLua.CheckObject(L, 1, typeof(Texture2D));
				int x2 = (int)LuaDLL.luaL_checknumber(L, 2);
				int y2 = (int)LuaDLL.luaL_checknumber(L, 3);
				int blockWidth2 = (int)LuaDLL.luaL_checknumber(L, 4);
				int blockHeight2 = (int)LuaDLL.luaL_checknumber(L, 5);
				Color[] colors2 = ToLua.CheckStructArray<Color>(L, 6);
				obj2.SetPixels(x2, y2, blockWidth2, blockHeight2, colors2);
				return 0;
			}
			case 7:
			{
				Texture2D obj = (Texture2D)ToLua.CheckObject(L, 1, typeof(Texture2D));
				int x = (int)LuaDLL.luaL_checknumber(L, 2);
				int y = (int)LuaDLL.luaL_checknumber(L, 3);
				int blockWidth = (int)LuaDLL.luaL_checknumber(L, 4);
				int blockHeight = (int)LuaDLL.luaL_checknumber(L, 5);
				Color[] colors = ToLua.CheckStructArray<Color>(L, 6);
				int miplevel = (int)LuaDLL.luaL_checknumber(L, 7);
				obj.SetPixels(x, y, blockWidth, blockHeight, colors, miplevel);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Texture2D.SetPixels");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetPixel(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			Texture2D obj = (Texture2D)ToLua.CheckObject(L, 1, typeof(Texture2D));
			int x = (int)LuaDLL.luaL_checknumber(L, 2);
			int y = (int)LuaDLL.luaL_checknumber(L, 3);
			Color pixel = obj.GetPixel(x, y);
			ToLua.Push(L, pixel);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetPixelBilinear(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			Texture2D obj = (Texture2D)ToLua.CheckObject(L, 1, typeof(Texture2D));
			float u = (float)LuaDLL.luaL_checknumber(L, 2);
			float v = (float)LuaDLL.luaL_checknumber(L, 3);
			Color pixelBilinear = obj.GetPixelBilinear(u, v);
			ToLua.Push(L, pixelBilinear);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LoadRawTextureData(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				Texture2D obj2 = (Texture2D)ToLua.CheckObject(L, 1, typeof(Texture2D));
				byte[] data2 = ToLua.CheckByteBuffer(L, 2);
				obj2.LoadRawTextureData(data2);
				return 0;
			}
			case 3:
			{
				Texture2D obj = (Texture2D)ToLua.CheckObject(L, 1, typeof(Texture2D));
				IntPtr data = ToLua.CheckIntPtr(L, 2);
				int size = (int)LuaDLL.luaL_checknumber(L, 3);
				obj.LoadRawTextureData(data, size);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Texture2D.LoadRawTextureData");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Apply(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
				((Texture2D)ToLua.CheckObject(L, 1, typeof(Texture2D))).Apply();
				return 0;
			case 2:
			{
				Texture2D obj2 = (Texture2D)ToLua.CheckObject(L, 1, typeof(Texture2D));
				bool updateMipmaps2 = LuaDLL.luaL_checkboolean(L, 2);
				obj2.Apply(updateMipmaps2);
				return 0;
			}
			case 3:
			{
				Texture2D obj = (Texture2D)ToLua.CheckObject(L, 1, typeof(Texture2D));
				bool updateMipmaps = LuaDLL.luaL_checkboolean(L, 2);
				bool makeNoLongerReadable = LuaDLL.luaL_checkboolean(L, 3);
				obj.Apply(updateMipmaps, makeNoLongerReadable);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Texture2D.Apply");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Resize(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 3:
			{
				Texture2D obj2 = (Texture2D)ToLua.CheckObject(L, 1, typeof(Texture2D));
				int width2 = (int)LuaDLL.luaL_checknumber(L, 2);
				int height2 = (int)LuaDLL.luaL_checknumber(L, 3);
				bool value2 = obj2.Reinitialize(width2, height2);
				LuaDLL.lua_pushboolean(L, value2);
				return 1;
			}
			case 5:
			{
				Texture2D obj = (Texture2D)ToLua.CheckObject(L, 1, typeof(Texture2D));
				int width = (int)LuaDLL.luaL_checknumber(L, 2);
				int height = (int)LuaDLL.luaL_checknumber(L, 3);
				TextureFormat format = (TextureFormat)ToLua.CheckObject(L, 4, typeof(TextureFormat));
				bool hasMipMap = LuaDLL.luaL_checkboolean(L, 5);
				bool value = obj.Reinitialize(width, height, format, hasMipMap);
				LuaDLL.lua_pushboolean(L, value);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Texture2D.Resize");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ReadPixels(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 4:
			{
				Texture2D obj2 = (Texture2D)ToLua.CheckObject(L, 1, typeof(Texture2D));
				Rect source2 = StackTraits<Rect>.Check(L, 2);
				int destX2 = (int)LuaDLL.luaL_checknumber(L, 3);
				int destY2 = (int)LuaDLL.luaL_checknumber(L, 4);
				obj2.ReadPixels(source2, destX2, destY2);
				return 0;
			}
			case 5:
			{
				Texture2D obj = (Texture2D)ToLua.CheckObject(L, 1, typeof(Texture2D));
				Rect source = StackTraits<Rect>.Check(L, 2);
				int destX = (int)LuaDLL.luaL_checknumber(L, 3);
				int destY = (int)LuaDLL.luaL_checknumber(L, 4);
				bool recalculateMipMaps = LuaDLL.luaL_checkboolean(L, 5);
				obj.ReadPixels(source, destX, destY, recalculateMipMaps);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Texture2D.ReadPixels");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GenerateAtlas(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			Vector2[] sizes = ToLua.CheckStructArray<Vector2>(L, 1);
			int padding = (int)LuaDLL.luaL_checknumber(L, 2);
			int atlasSize = (int)LuaDLL.luaL_checknumber(L, 3);
			List<Rect> results = (List<Rect>)ToLua.CheckObject(L, 4, typeof(List<Rect>));
			bool value = Texture2D.GenerateAtlas(sizes, padding, atlasSize, results);
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetPixels32(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				Texture2D obj4 = (Texture2D)ToLua.CheckObject(L, 1, typeof(Texture2D));
				Color32[] pixels = ToLua.CheckStructArray<Color32>(L, 2);
				obj4.SetPixels32(pixels);
				return 0;
			}
			case 3:
			{
				Texture2D obj3 = (Texture2D)ToLua.CheckObject(L, 1, typeof(Texture2D));
				Color32[] colors3 = ToLua.CheckStructArray<Color32>(L, 2);
				int miplevel2 = (int)LuaDLL.luaL_checknumber(L, 3);
				obj3.SetPixels32(colors3, miplevel2);
				return 0;
			}
			case 6:
			{
				Texture2D obj2 = (Texture2D)ToLua.CheckObject(L, 1, typeof(Texture2D));
				int x2 = (int)LuaDLL.luaL_checknumber(L, 2);
				int y2 = (int)LuaDLL.luaL_checknumber(L, 3);
				int blockWidth2 = (int)LuaDLL.luaL_checknumber(L, 4);
				int blockHeight2 = (int)LuaDLL.luaL_checknumber(L, 5);
				Color32[] colors2 = ToLua.CheckStructArray<Color32>(L, 6);
				obj2.SetPixels32(x2, y2, blockWidth2, blockHeight2, colors2);
				return 0;
			}
			case 7:
			{
				Texture2D obj = (Texture2D)ToLua.CheckObject(L, 1, typeof(Texture2D));
				int x = (int)LuaDLL.luaL_checknumber(L, 2);
				int y = (int)LuaDLL.luaL_checknumber(L, 3);
				int blockWidth = (int)LuaDLL.luaL_checknumber(L, 4);
				int blockHeight = (int)LuaDLL.luaL_checknumber(L, 5);
				Color32[] colors = ToLua.CheckStructArray<Color32>(L, 6);
				int miplevel = (int)LuaDLL.luaL_checknumber(L, 7);
				obj.SetPixels32(x, y, blockWidth, blockHeight, colors, miplevel);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Texture2D.SetPixels32");
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
	private static int get_mipmapCount(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int mipmapCount = ((Texture2D)obj).mipmapCount;
			LuaDLL.lua_pushinteger(L, mipmapCount);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mipmapCount on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_format(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			TextureFormat format = ((Texture2D)obj).format;
			ToLua.Push(L, format);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index format on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_whiteTexture(IntPtr L)
	{
		try
		{
			ToLua.PushSealed(L, Texture2D.whiteTexture);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_blackTexture(IntPtr L)
	{
		try
		{
			ToLua.PushSealed(L, Texture2D.blackTexture);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isReadable(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isReadable = ((Texture2D)obj).isReadable;
			LuaDLL.lua_pushboolean(L, isReadable);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isReadable on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_streamingMipmaps(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool streamingMipmaps = ((Texture2D)obj).streamingMipmaps;
			LuaDLL.lua_pushboolean(L, streamingMipmaps);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index streamingMipmaps on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_streamingMipmapsPriority(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int streamingMipmapsPriority = ((Texture2D)obj).streamingMipmapsPriority;
			LuaDLL.lua_pushinteger(L, streamingMipmapsPriority);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index streamingMipmapsPriority on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_requestedMipmapLevel(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int requestedMipmapLevel = ((Texture2D)obj).requestedMipmapLevel;
			LuaDLL.lua_pushinteger(L, requestedMipmapLevel);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index requestedMipmapLevel on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_desiredMipmapLevel(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int desiredMipmapLevel = ((Texture2D)obj).desiredMipmapLevel;
			LuaDLL.lua_pushinteger(L, desiredMipmapLevel);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index desiredMipmapLevel on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_loadingMipmapLevel(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int loadingMipmapLevel = ((Texture2D)obj).loadingMipmapLevel;
			LuaDLL.lua_pushinteger(L, loadingMipmapLevel);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index loadingMipmapLevel on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_loadedMipmapLevel(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int loadedMipmapLevel = ((Texture2D)obj).loadedMipmapLevel;
			LuaDLL.lua_pushinteger(L, loadedMipmapLevel);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index loadedMipmapLevel on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_requestedMipmapLevel(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Texture2D obj2 = (Texture2D)obj;
			int requestedMipmapLevel = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.requestedMipmapLevel = requestedMipmapLevel;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index requestedMipmapLevel on a nil value");
		}
	}
}
