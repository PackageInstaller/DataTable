using System;
using System.Collections.Generic;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using Unity.Collections;
using Unity.Collections.LowLevel.Unsafe;
using UnityEngine.Bindings;
using UnityEngine.Experimental.Rendering;
using UnityEngine.Internal;
using UnityEngine.Scripting;

namespace UnityEngine;

[UsedByNativeCode]
[NativeHeader("Runtime/Graphics/GeneratedTextures.h")]
[NativeHeader("Runtime/Graphics/Texture2D.h")]
public sealed class Texture2D : Texture
{
	internal const int streamingMipmapsPriorityMin = -128;

	internal const int streamingMipmapsPriorityMax = 127;

	public extern TextureFormat format
	{
		[MethodImpl((MethodImplOptions)4096)]
		[NativeName("GetTextureFormat")]
		get;
	}

	public extern bool ignoreMipmapLimit
	{
		[MethodImpl((MethodImplOptions)4096)]
		[NativeName("IgnoreMasterTextureLimit")]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		[NativeName("SetIgnoreMasterTextureLimitAndReload")]
		set;
	}

	[StaticAccessor(/*Could not decode attribute arguments.*/)]
	public static extern Texture2D whiteTexture
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	[StaticAccessor(/*Could not decode attribute arguments.*/)]
	public static extern Texture2D blackTexture
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	[StaticAccessor(/*Could not decode attribute arguments.*/)]
	public static extern Texture2D redTexture
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	[StaticAccessor(/*Could not decode attribute arguments.*/)]
	public static extern Texture2D grayTexture
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	[StaticAccessor(/*Could not decode attribute arguments.*/)]
	public static extern Texture2D linearGrayTexture
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	[StaticAccessor(/*Could not decode attribute arguments.*/)]
	public static extern Texture2D normalTexture
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	public override extern bool isReadable
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	[NativeConditional("ENABLE_VIRTUALTEXTURING && UNITY_EDITOR")]
	[NativeName("VTOnly")]
	public extern bool vtOnly
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	internal extern bool isPreProcessed
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	public extern bool streamingMipmaps
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	public extern int streamingMipmapsPriority
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	public extern int requestedMipmapLevel
	{
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction(Name = "GetTextureStreamingManager().GetRequestedMipmapLevel", HasExplicitThis = true)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction(Name = "GetTextureStreamingManager().SetRequestedMipmapLevel", HasExplicitThis = true)]
		set;
	}

	public extern int minimumMipmapLevel
	{
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction(Name = "GetTextureStreamingManager().GetMinimumMipmapLevel", HasExplicitThis = true)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction(Name = "GetTextureStreamingManager().SetMinimumMipmapLevel", HasExplicitThis = true)]
		set;
	}

	internal extern bool loadAllMips
	{
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction(Name = "GetTextureStreamingManager().GetLoadAllMips", HasExplicitThis = true)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction(Name = "GetTextureStreamingManager().SetLoadAllMips", HasExplicitThis = true)]
		set;
	}

	public extern int calculatedMipmapLevel
	{
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction(Name = "GetTextureStreamingManager().GetCalculatedMipmapLevel", HasExplicitThis = true)]
		get;
	}

	public extern int desiredMipmapLevel
	{
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction(Name = "GetTextureStreamingManager().GetDesiredMipmapLevel", HasExplicitThis = true)]
		get;
	}

	public extern int loadingMipmapLevel
	{
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction(Name = "GetTextureStreamingManager().GetLoadingMipmapLevel", HasExplicitThis = true)]
		get;
	}

	public extern int loadedMipmapLevel
	{
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction(Name = "GetTextureStreamingManager().GetLoadedMipmapLevel", HasExplicitThis = true)]
		get;
	}

	internal bool ValidateFormat(TextureFormat format, int width, int height)
	{
		bool flag = ValidateFormat(format);
		if (flag && TextureFormat.PVRTC_RGB2 <= format && format <= TextureFormat.PVRTC_RGBA4 && (width != height || !Mathf.IsPowerOfTwo(width)))
		{
			throw new UnityException($"'{format.ToString()}' demands texture to be square and have power-of-two dimensions");
		}
		return flag;
	}

	internal bool ValidateFormat(GraphicsFormat format, int width, int height)
	{
		bool flag = ValidateFormat(format, FormatUsage.Sample);
		if (flag && GraphicsFormatUtility.IsPVRTCFormat(format) && (width != height || !Mathf.IsPowerOfTwo(width)))
		{
			throw new UnityException($"'{format.ToString()}' demands texture to be square and have power-of-two dimensions");
		}
		return flag;
	}

	internal Texture2D(int width, int height, GraphicsFormat format, TextureCreationFlags flags, int mipCount, IntPtr nativeTex)
	{
		if (ValidateFormat(format, width, height))
		{
			Internal_Create(this, width, height, mipCount, format, GetTextureColorSpace(format), flags, nativeTex);
		}
	}

	[ExcludeFromDocs]
	public Texture2D(int width, int height, DefaultFormat format, TextureCreationFlags flags)
		: this(width, height, SystemInfo.GetGraphicsFormat(format), flags)
	{
	}

	[ExcludeFromDocs]
	public Texture2D(int width, int height, GraphicsFormat format, TextureCreationFlags flags)
		: this(width, height, format, flags, Texture.GenerateAllMips, IntPtr.Zero)
	{
	}

	[ExcludeFromDocs]
	public Texture2D(int width, int height, GraphicsFormat format, int mipCount, TextureCreationFlags flags)
		: this(width, height, format, flags, mipCount, IntPtr.Zero)
	{
	}

	internal Texture2D(int width, int height, TextureFormat textureFormat, int mipCount, bool linear, IntPtr nativeTex)
	{
		if (ValidateFormat(textureFormat, width, height))
		{
			GraphicsFormat graphicsFormat = GraphicsFormatUtility.GetGraphicsFormat(textureFormat, !linear);
			TextureCreationFlags textureCreationFlags = ((mipCount != 1) ? TextureCreationFlags.MipChain : TextureCreationFlags.None);
			if (GraphicsFormatUtility.IsCrunchFormat(textureFormat))
			{
				textureCreationFlags |= TextureCreationFlags.Crunch;
			}
			Internal_Create(this, width, height, mipCount, graphicsFormat, GetTextureColorSpace(linear), textureCreationFlags, nativeTex);
		}
	}

	public Texture2D(int width, int height, [DefaultValue("TextureFormat.RGBA32")] TextureFormat textureFormat, [DefaultValue("-1")] int mipCount, [DefaultValue("false")] bool linear)
		: this(width, height, textureFormat, mipCount, linear, IntPtr.Zero)
	{
	}

	public Texture2D(int width, int height, [DefaultValue("TextureFormat.RGBA32")] TextureFormat textureFormat, [DefaultValue("true")] bool mipChain, [DefaultValue("false")] bool linear)
		: this(width, height, textureFormat, (!mipChain) ? 1 : (-1), linear, IntPtr.Zero)
	{
	}

	[ExcludeFromDocs]
	public Texture2D(int width, int height, TextureFormat textureFormat, bool mipChain)
		: this(width, height, textureFormat, (!mipChain) ? 1 : (-1), linear: false, IntPtr.Zero)
	{
	}

	[ExcludeFromDocs]
	public Texture2D(int width, int height)
		: this(width, height, TextureFormat.RGBA32, Texture.GenerateAllMips, linear: false, IntPtr.Zero)
	{
	}

	public static Texture2D CreateExternalTexture(int width, int height, TextureFormat format, bool mipChain, bool linear, IntPtr nativeTex)
	{
		if (nativeTex == IntPtr.Zero)
		{
			throw new ArgumentException("nativeTex can not be null");
		}
		return new Texture2D(width, height, format, (!mipChain) ? 1 : (-1), linear, nativeTex);
	}

	[ExcludeFromDocs]
	public void SetPixel(int x, int y, Color color)
	{
		if (!isReadable)
		{
			throw CreateNonReadableException(this);
		}
		SetPixelImpl(0, 0, x, y, color);
	}

	public void SetPixel(int x, int y, Color color, [DefaultValue("0")] int mipLevel)
	{
		if (!isReadable)
		{
			throw CreateNonReadableException(this);
		}
		SetPixelImpl(0, mipLevel, x, y, color);
	}

	public void SetPixels(int x, int y, int blockWidth, int blockHeight, Color[] colors, [DefaultValue("0")] int miplevel)
	{
		if (!isReadable)
		{
			throw CreateNonReadableException(this);
		}
		SetPixelsImpl(x, y, blockWidth, blockHeight, colors, miplevel, 0);
	}

	[ExcludeFromDocs]
	public void SetPixels(int x, int y, int blockWidth, int blockHeight, Color[] colors)
	{
		SetPixels(x, y, blockWidth, blockHeight, colors, 0);
	}

	public void SetPixels(Color[] colors, [DefaultValue("0")] int miplevel)
	{
		int num = width >> miplevel;
		if (num < 1)
		{
			num = 1;
		}
		int num2 = height >> miplevel;
		if (num2 < 1)
		{
			num2 = 1;
		}
		SetPixels(0, 0, num, num2, colors, miplevel);
	}

	[ExcludeFromDocs]
	public void SetPixels(Color[] colors)
	{
		SetPixels(0, 0, width, height, colors, 0);
	}

	[ExcludeFromDocs]
	public Color GetPixel(int x, int y)
	{
		if (!isReadable)
		{
			throw CreateNonReadableException(this);
		}
		return GetPixelImpl(0, 0, x, y);
	}

	public Color GetPixel(int x, int y, [DefaultValue("0")] int mipLevel)
	{
		if (!isReadable)
		{
			throw CreateNonReadableException(this);
		}
		return GetPixelImpl(0, mipLevel, x, y);
	}

	[ExcludeFromDocs]
	public Color GetPixelBilinear(float u, float v)
	{
		if (!isReadable)
		{
			throw CreateNonReadableException(this);
		}
		return GetPixelBilinearImpl(0, 0, u, v);
	}

	public Color GetPixelBilinear(float u, float v, [DefaultValue("0")] int mipLevel)
	{
		if (!isReadable)
		{
			throw CreateNonReadableException(this);
		}
		return GetPixelBilinearImpl(0, mipLevel, u, v);
	}

	public void LoadRawTextureData(IntPtr data, int size)
	{
		if (!isReadable)
		{
			throw CreateNonReadableException(this);
		}
		if (data == IntPtr.Zero || size == 0)
		{
			Debug.LogError("No texture data provided to LoadRawTextureData", this);
		}
		else if (!LoadRawTextureDataImpl(data, (ulong)size))
		{
			throw new UnityException("LoadRawTextureData: not enough data provided (will result in overread).");
		}
	}

	public void LoadRawTextureData(byte[] data)
	{
		if (!isReadable)
		{
			throw CreateNonReadableException(this);
		}
		if (data == null || data.Length == 0)
		{
			Debug.LogError("No texture data provided to LoadRawTextureData", this);
		}
		else if (!LoadRawTextureDataImplArray(data))
		{
			throw new UnityException("LoadRawTextureData: not enough data provided (will result in overread).");
		}
	}

	public unsafe void LoadRawTextureData<T>(NativeArray<T> data) where T : struct
	{
		if (!isReadable)
		{
			throw CreateNonReadableException(this);
		}
		if (!data.IsCreated || data.Length == 0)
		{
			throw new UnityException("No texture data provided to LoadRawTextureData");
		}
		if (!LoadRawTextureDataImpl((IntPtr)data.GetUnsafeReadOnlyPtr(), (ulong)data.Length * (ulong)UnsafeUtility.SizeOf<T>()))
		{
			throw new UnityException("LoadRawTextureData: not enough data provided (will result in overread).");
		}
	}

	public void SetPixelData<T>(T[] data, int mipLevel, [DefaultValue("0")] int sourceDataStartIndex = 0)
	{
		if (sourceDataStartIndex < 0)
		{
			throw new UnityException("SetPixelData: sourceDataStartIndex cannot be less than 0.");
		}
		if (!isReadable)
		{
			throw CreateNonReadableException(this);
		}
		if (data == null || data.Length == 0)
		{
			throw new UnityException("No texture data provided to SetPixelData.");
		}
		SetPixelDataImplArray(data, mipLevel, Marshal.SizeOf((object)data[0]), data.Length, sourceDataStartIndex);
	}

	public unsafe void SetPixelData<T>(NativeArray<T> data, int mipLevel, [DefaultValue("0")] int sourceDataStartIndex = 0) where T : struct
	{
		if (sourceDataStartIndex < 0)
		{
			throw new UnityException("SetPixelData: sourceDataStartIndex cannot be less than 0.");
		}
		if (!isReadable)
		{
			throw CreateNonReadableException(this);
		}
		if (!data.IsCreated || data.Length == 0)
		{
			throw new UnityException("No texture data provided to SetPixelData.");
		}
		SetPixelDataImpl((IntPtr)data.GetUnsafeReadOnlyPtr(), mipLevel, UnsafeUtility.SizeOf<T>(), data.Length, sourceDataStartIndex);
	}

	public unsafe NativeArray<T> GetPixelData<T>(int mipLevel) where T : struct
	{
		if (!isReadable)
		{
			throw CreateNonReadableException(this);
		}
		if (mipLevel < 0 || mipLevel >= base.mipmapCount)
		{
			throw new ArgumentException("The passed in miplevel " + mipLevel + " is invalid. It needs to be in the range 0 and " + (base.mipmapCount - 1));
		}
		if (GetWritableImageData(0).ToInt64() == 0)
		{
			throw new UnityException("Texture '" + base.name + "' has no data.");
		}
		ulong pixelDataOffset = GetPixelDataOffset(mipLevel);
		ulong pixelDataSize = GetPixelDataSize(mipLevel);
		int num = UnsafeUtility.SizeOf<T>();
		ulong num2 = pixelDataSize / (ulong)num;
		if (num2 > int.MaxValue)
		{
			throw CreateNativeArrayLengthOverflowException();
		}
		IntPtr intPtr = new IntPtr((long)GetWritableImageData(0) + (long)pixelDataOffset);
		return NativeArrayUnsafeUtility.ConvertExistingDataToNativeArray<T>((void*)intPtr, (int)num2, Allocator.None);
	}

	public unsafe NativeArray<T> GetRawTextureData<T>() where T : struct
	{
		if (!isReadable)
		{
			throw CreateNonReadableException(this);
		}
		int num = UnsafeUtility.SizeOf<T>();
		ulong num2 = GetRawImageDataSize() / (ulong)num;
		if (num2 > int.MaxValue)
		{
			throw CreateNativeArrayLengthOverflowException();
		}
		return NativeArrayUnsafeUtility.ConvertExistingDataToNativeArray<T>((void*)GetWritableImageData(0), (int)num2, Allocator.None);
	}

	public void Apply([DefaultValue("true")] bool updateMipmaps, [DefaultValue("false")] bool makeNoLongerReadable)
	{
		if (!isReadable)
		{
			throw CreateNonReadableException(this);
		}
		ApplyImpl(updateMipmaps, makeNoLongerReadable);
	}

	[ExcludeFromDocs]
	public void Apply(bool updateMipmaps)
	{
		Apply(updateMipmaps, makeNoLongerReadable: false);
	}

	[ExcludeFromDocs]
	public void Apply()
	{
		Apply(updateMipmaps: true, makeNoLongerReadable: false);
	}

	public bool Reinitialize(int width, int height)
	{
		if (!isReadable)
		{
			throw CreateNonReadableException(this);
		}
		return ReinitializeImpl(width, height);
	}

	public bool Reinitialize(int width, int height, TextureFormat format, bool hasMipMap)
	{
		return ReinitializeWithFormatImpl(width, height, GraphicsFormatUtility.GetGraphicsFormat(format, base.activeTextureColorSpace == ColorSpace.Gamma), hasMipMap);
	}

	public bool Reinitialize(int width, int height, GraphicsFormat format, bool hasMipMap)
	{
		if (!isReadable)
		{
			throw CreateNonReadableException(this);
		}
		return ReinitializeWithFormatImpl(width, height, format, hasMipMap);
	}

	[Obsolete("Texture2D.Resize(int, int) has been deprecated because it actually reinitializes the texture. Use Texture2D.Reinitialize(int, int) instead (UnityUpgradable) -> Reinitialize([*] System.Int32, [*] System.Int32)", false)]
	public bool Resize(int width, int height)
	{
		return Reinitialize(width, height);
	}

	[Obsolete("Texture2D.Resize(int, int, TextureFormat, bool) has been deprecated because it actually reinitializes the texture. Use Texture2D.Reinitialize(int, int, TextureFormat, bool) instead (UnityUpgradable) -> Reinitialize([*] System.Int32, [*] System.Int32, UnityEngine.TextureFormat, [*] System.Boolean)", false)]
	public bool Resize(int width, int height, TextureFormat format, bool hasMipMap)
	{
		return Reinitialize(width, height, format, hasMipMap);
	}

	[Obsolete("Texture2D.Resize(int, int, GraphicsFormat, bool) has been deprecated because it actually reinitializes the texture. Use Texture2D.Reinitialize(int, int, GraphicsFormat, bool) instead (UnityUpgradable) -> Reinitialize([*] System.Int32, [*] System.Int32, UnityEngine.Experimental.Rendering.GraphicsFormat, [*] System.Boolean)", false)]
	public bool Resize(int width, int height, GraphicsFormat format, bool hasMipMap)
	{
		return Reinitialize(width, height, format, hasMipMap);
	}

	public void ReadPixels(Rect source, int destX, int destY, [DefaultValue("true")] bool recalculateMipMaps)
	{
		if (!isReadable)
		{
			throw CreateNonReadableException(this);
		}
		ReadPixelsImpl(source, destX, destY, recalculateMipMaps);
	}

	[ExcludeFromDocs]
	public void ReadPixels(Rect source, int destX, int destY)
	{
		ReadPixels(source, destX, destY, recalculateMipMaps: true);
	}

	public static bool GenerateAtlas(Vector2[] sizes, int padding, int atlasSize, List<Rect> results)
	{
		if (sizes == null)
		{
			throw new ArgumentException("sizes array can not be null");
		}
		if (results == null)
		{
			throw new ArgumentException("results list cannot be null");
		}
		if (padding < 0)
		{
			throw new ArgumentException("padding can not be negative");
		}
		if (atlasSize <= 0)
		{
			throw new ArgumentException("atlas size must be positive");
		}
		results.Clear();
		if (sizes.Length == 0)
		{
			return true;
		}
		NoAllocHelpers.EnsureListElemCount(results, sizes.Length);
		GenerateAtlasImpl(sizes, padding, atlasSize, NoAllocHelpers.ExtractArrayFromListT(results));
		return results.Count != 0;
	}

	public void SetPixels32(Color32[] colors, [DefaultValue("0")] int miplevel)
	{
		SetAllPixels32(colors, miplevel);
	}

	[ExcludeFromDocs]
	public void SetPixels32(Color32[] colors)
	{
		SetPixels32(colors, 0);
	}

	public void SetPixels32(int x, int y, int blockWidth, int blockHeight, Color32[] colors, [DefaultValue("0")] int miplevel)
	{
		SetBlockOfPixels32(x, y, blockWidth, blockHeight, colors, miplevel);
	}

	[ExcludeFromDocs]
	public void SetPixels32(int x, int y, int blockWidth, int blockHeight, Color32[] colors)
	{
		SetPixels32(x, y, blockWidth, blockHeight, colors, 0);
	}

	public Color[] GetPixels([DefaultValue("0")] int miplevel)
	{
		int num = width >> miplevel;
		if (num < 1)
		{
			num = 1;
		}
		int num2 = height >> miplevel;
		if (num2 < 1)
		{
			num2 = 1;
		}
		return GetPixels(0, 0, num, num2, miplevel);
	}

	[ExcludeFromDocs]
	public Color[] GetPixels()
	{
		return GetPixels(0);
	}

	[MethodImpl((MethodImplOptions)4096)]
	public extern void Compress(bool highQuality);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("Texture2DScripting::Create")]
	private static extern bool Internal_CreateImpl([Writable] Texture2D mono, int w, int h, int mipCount, GraphicsFormat format, TextureColorSpace colorSpace, TextureCreationFlags flags, IntPtr nativeTex);

	private static void Internal_Create([Writable] Texture2D mono, int w, int h, int mipCount, GraphicsFormat format, TextureColorSpace colorSpace, TextureCreationFlags flags, IntPtr nativeTex)
	{
		if (!Internal_CreateImpl(mono, w, h, mipCount, format, colorSpace, flags, nativeTex))
		{
			throw new UnityException("Failed to create texture because of invalid parameters.");
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	[NativeName("Apply")]
	private extern void ApplyImpl(bool updateMipmaps, bool makeNoLongerReadable);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeName("Reinitialize")]
	private extern bool ReinitializeImpl(int width, int height);

	[NativeName("SetPixel")]
	private void SetPixelImpl(int image, int mip, int x, int y, Color color)
	{
		SetPixelImpl_Injected(image, mip, x, y, ref color);
	}

	[NativeName("GetPixel")]
	private Color GetPixelImpl(int image, int mip, int x, int y)
	{
		GetPixelImpl_Injected(image, mip, x, y, out var ret);
		return ret;
	}

	[NativeName("GetPixelBilinear")]
	private Color GetPixelBilinearImpl(int image, int mip, float u, float v)
	{
		GetPixelBilinearImpl_Injected(image, mip, u, v, out var ret);
		return ret;
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "Texture2DScripting::ReinitializeWithFormat", HasExplicitThis = true)]
	private extern bool ReinitializeWithFormatImpl(int width, int height, GraphicsFormat format, bool hasMipMap);

	[FreeFunction(Name = "Texture2DScripting::ReadPixels", HasExplicitThis = true)]
	private void ReadPixelsImpl(Rect source, int destX, int destY, bool recalculateMipMaps)
	{
		ReadPixelsImpl_Injected(ref source, destX, destY, recalculateMipMaps);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "Texture2DScripting::SetPixels", HasExplicitThis = true, ThrowsException = true)]
	private extern void SetPixelsImpl(int x, int y, int w, int h, Color[] pixel, int miplevel, int frame);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "Texture2DScripting::LoadRawData", HasExplicitThis = true)]
	private extern bool LoadRawTextureDataImpl(IntPtr data, ulong size);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "Texture2DScripting::LoadRawData", HasExplicitThis = true)]
	private extern bool LoadRawTextureDataImplArray(byte[] data);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "Texture2DScripting::SetPixelDataArray", HasExplicitThis = true, ThrowsException = true)]
	private extern bool SetPixelDataImplArray(Array data, int mipLevel, int elementSize, int dataArraySize, int sourceDataStartIndex = 0);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "Texture2DScripting::SetPixelData", HasExplicitThis = true, ThrowsException = true)]
	private extern bool SetPixelDataImpl(IntPtr data, int mipLevel, int elementSize, int dataArraySize, int sourceDataStartIndex = 0);

	[MethodImpl((MethodImplOptions)4096)]
	private extern IntPtr GetWritableImageData(int frame);

	[MethodImpl((MethodImplOptions)4096)]
	private extern ulong GetRawImageDataSize();

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("Texture2DScripting::GenerateAtlas")]
	private static extern void GenerateAtlasImpl(Vector2[] sizes, int padding, int atlasSize, [Out] Rect[] rect);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "GetTextureStreamingManager().ClearRequestedMipmapLevel", HasExplicitThis = true)]
	public extern void ClearRequestedMipmapLevel();

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "GetTextureStreamingManager().IsRequestedMipmapLevelLoaded", HasExplicitThis = true)]
	public extern bool IsRequestedMipmapLevelLoaded();

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "GetTextureStreamingManager().ClearMinimumMipmapLevel", HasExplicitThis = true)]
	public extern void ClearMinimumMipmapLevel();

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("Texture2DScripting::UpdateExternalTexture", HasExplicitThis = true)]
	public extern void UpdateExternalTexture(IntPtr nativeTex);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("Texture2DScripting::SetAllPixels32", HasExplicitThis = true, ThrowsException = true)]
	private extern void SetAllPixels32([Unmarshalled] Color32[] colors, int miplevel);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("Texture2DScripting::SetBlockOfPixels32", HasExplicitThis = true, ThrowsException = true)]
	private extern void SetBlockOfPixels32(int x, int y, int blockWidth, int blockHeight, [Unmarshalled] Color32[] colors, int miplevel);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("Texture2DScripting::GetRawTextureData", HasExplicitThis = true, ThrowsException = true)]
	public extern byte[] GetRawTextureData();

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("Texture2DScripting::GetPixels", HasExplicitThis = true, ThrowsException = true)]
	public extern Color[] GetPixels(int x, int y, int blockWidth, int blockHeight, [DefaultValue("0")] int miplevel);

	[ExcludeFromDocs]
	public Color[] GetPixels(int x, int y, int blockWidth, int blockHeight)
	{
		return GetPixels(x, y, blockWidth, blockHeight, 0);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("Texture2DScripting::GetPixels32", HasExplicitThis = true, ThrowsException = true)]
	public extern Color32[] GetPixels32([DefaultValue("0")] int miplevel);

	[ExcludeFromDocs]
	public Color32[] GetPixels32()
	{
		return GetPixels32(0);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("Texture2DScripting::PackTextures", HasExplicitThis = true)]
	public extern Rect[] PackTextures(Texture2D[] textures, int padding, int maximumAtlasSize, bool makeNoLongerReadable);

	public Rect[] PackTextures(Texture2D[] textures, int padding, int maximumAtlasSize)
	{
		return PackTextures(textures, padding, maximumAtlasSize, makeNoLongerReadable: false);
	}

	public Rect[] PackTextures(Texture2D[] textures, int padding)
	{
		return PackTextures(textures, padding, 2048);
	}

	[MethodImpl((MethodImplOptions)4096)]
	private extern void SetPixelImpl_Injected(int image, int mip, int x, int y, ref Color color);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void GetPixelImpl_Injected(int image, int mip, int x, int y, out Color ret);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void GetPixelBilinearImpl_Injected(int image, int mip, float u, float v, out Color ret);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void ReadPixelsImpl_Injected(ref Rect source, int destX, int destY, bool recalculateMipMaps);
}
