using System;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using Unity.Collections;
using Unity.Collections.LowLevel.Unsafe;
using UnityEngine.Bindings;
using UnityEngine.Experimental.Rendering;
using UnityEngine.Internal;
using UnityEngine.Scripting;

namespace UnityEngine;

[ExcludeFromPreset]
[NativeHeader("Runtime/Graphics/CubemapTexture.h")]
public sealed class Cubemap : Texture
{
	public extern TextureFormat format
	{
		[MethodImpl((MethodImplOptions)4096)]
		[NativeName("GetTextureFormat")]
		get;
	}

	public override extern bool isReadable
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

	internal extern bool loadAllMips
	{
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction(Name = "GetTextureStreamingManager().GetLoadAllMips", HasExplicitThis = true)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction(Name = "GetTextureStreamingManager().SetLoadAllMips", HasExplicitThis = true)]
		set;
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

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("CubemapScripting::Create")]
	private static extern bool Internal_CreateImpl([Writable] Cubemap mono, int ext, int mipCount, GraphicsFormat format, TextureColorSpace colorSpace, TextureCreationFlags flags, IntPtr nativeTex);

	private static void Internal_Create([Writable] Cubemap mono, int ext, int mipCount, GraphicsFormat format, TextureColorSpace colorSpace, TextureCreationFlags flags, IntPtr nativeTex)
	{
		if (!Internal_CreateImpl(mono, ext, mipCount, format, colorSpace, flags, nativeTex))
		{
			throw new UnityException("Failed to create texture because of invalid parameters.");
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "CubemapScripting::Apply", HasExplicitThis = true)]
	private extern void ApplyImpl(bool updateMipmaps, bool makeNoLongerReadable);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("CubemapScripting::UpdateExternalTexture", HasExplicitThis = true)]
	public extern void UpdateExternalTexture(IntPtr nativeTexture);

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

	[MethodImpl((MethodImplOptions)4096)]
	[NativeName("FixupEdges")]
	public extern void SmoothEdges([DefaultValue("1")] int smoothRegionWidthInPixels);

	public void SmoothEdges()
	{
		SmoothEdges(1);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "CubemapScripting::GetPixels", HasExplicitThis = true, ThrowsException = true)]
	public extern Color[] GetPixels(CubemapFace face, int miplevel);

	public Color[] GetPixels(CubemapFace face)
	{
		return GetPixels(face, 0);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "CubemapScripting::SetPixels", HasExplicitThis = true, ThrowsException = true)]
	public extern void SetPixels([Unmarshalled] Color[] colors, CubemapFace face, int miplevel);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "CubemapScripting::SetPixelDataArray", HasExplicitThis = true, ThrowsException = true)]
	private extern bool SetPixelDataImplArray(Array data, int mipLevel, int face, int elementSize, int dataArraySize, int sourceDataStartIndex = 0);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "CubemapScripting::SetPixelData", HasExplicitThis = true, ThrowsException = true)]
	private extern bool SetPixelDataImpl(IntPtr data, int mipLevel, int face, int elementSize, int dataArraySize, int sourceDataStartIndex = 0);

	public void SetPixels(Color[] colors, CubemapFace face)
	{
		SetPixels(colors, face, 0);
	}

	[MethodImpl((MethodImplOptions)4096)]
	private extern IntPtr GetWritableImageData(int frame);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "GetTextureStreamingManager().ClearRequestedMipmapLevel", HasExplicitThis = true)]
	public extern void ClearRequestedMipmapLevel();

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "GetTextureStreamingManager().IsRequestedMipmapLevelLoaded", HasExplicitThis = true)]
	public extern bool IsRequestedMipmapLevelLoaded();

	internal bool ValidateFormat(TextureFormat format, int width)
	{
		bool flag = ValidateFormat(format);
		if (flag && TextureFormat.PVRTC_RGB2 <= format && format <= TextureFormat.PVRTC_RGBA4 && !Mathf.IsPowerOfTwo(width))
		{
			throw new UnityException($"'{format.ToString()}' demands texture to have power-of-two dimensions");
		}
		return flag;
	}

	internal bool ValidateFormat(GraphicsFormat format, int width)
	{
		bool flag = ValidateFormat(format, FormatUsage.Sample);
		if (flag && GraphicsFormatUtility.IsPVRTCFormat(format) && !Mathf.IsPowerOfTwo(width))
		{
			throw new UnityException($"'{format.ToString()}' demands texture to have power-of-two dimensions");
		}
		return flag;
	}

	[ExcludeFromDocs]
	public Cubemap(int width, DefaultFormat format, TextureCreationFlags flags)
		: this(width, SystemInfo.GetGraphicsFormat(format), flags)
	{
	}

	[ExcludeFromDocs]
	public Cubemap(int width, DefaultFormat format, TextureCreationFlags flags, int mipCount)
		: this(width, SystemInfo.GetGraphicsFormat(format), flags, mipCount)
	{
	}

	[ExcludeFromDocs]
	[RequiredByNativeCode]
	public Cubemap(int width, GraphicsFormat format, TextureCreationFlags flags)
		: this(width, format, flags, Texture.GenerateAllMips)
	{
	}

	[ExcludeFromDocs]
	public Cubemap(int width, GraphicsFormat format, TextureCreationFlags flags, int mipCount)
	{
		if (ValidateFormat(format, width))
		{
			ValidateIsNotCrunched(flags);
			Internal_Create(this, width, mipCount, format, GetTextureColorSpace(format), flags, IntPtr.Zero);
		}
	}

	internal Cubemap(int width, TextureFormat textureFormat, int mipCount, IntPtr nativeTex, bool createUninitialized)
	{
		if (ValidateFormat(textureFormat, width))
		{
			GraphicsFormat graphicsFormat = GraphicsFormatUtility.GetGraphicsFormat(textureFormat, isSRGB: false);
			TextureCreationFlags textureCreationFlags = ((mipCount != 1) ? TextureCreationFlags.MipChain : TextureCreationFlags.None);
			if (GraphicsFormatUtility.IsCrunchFormat(textureFormat))
			{
				textureCreationFlags |= TextureCreationFlags.Crunch;
			}
			if (createUninitialized)
			{
				textureCreationFlags |= TextureCreationFlags.DontInitializePixels | TextureCreationFlags.DontUploadUponCreate;
			}
			ValidateIsNotCrunched(textureCreationFlags);
			Internal_Create(this, width, mipCount, graphicsFormat, GetTextureColorSpace(linear: true), textureCreationFlags, nativeTex);
		}
	}

	public Cubemap(int width, TextureFormat textureFormat, bool mipChain)
		: this(width, textureFormat, (!mipChain) ? 1 : Texture.GenerateAllMips, IntPtr.Zero, createUninitialized: false)
	{
	}

	public Cubemap(int width, TextureFormat textureFormat, bool mipChain, [DefaultValue("false")] bool createUninitialized)
		: this(width, textureFormat, (!mipChain) ? 1 : Texture.GenerateAllMips, IntPtr.Zero, createUninitialized)
	{
	}

	public Cubemap(int width, TextureFormat format, int mipCount)
		: this(width, format, mipCount, IntPtr.Zero, createUninitialized: false)
	{
	}

	public Cubemap(int width, TextureFormat format, int mipCount, [DefaultValue("false")] bool createUninitialized)
		: this(width, format, mipCount, IntPtr.Zero, createUninitialized)
	{
	}

	public static Cubemap CreateExternalTexture(int width, TextureFormat format, bool mipmap, IntPtr nativeTex)
	{
		if (nativeTex == IntPtr.Zero)
		{
			throw new ArgumentException("nativeTex can not be null");
		}
		return new Cubemap(width, format, (!mipmap) ? 1 : Texture.GenerateAllMips, nativeTex, createUninitialized: false);
	}

	public void SetPixelData<T>(T[] data, int mipLevel, CubemapFace face, [DefaultValue("0")] int sourceDataStartIndex = 0)
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
		SetPixelDataImplArray(data, mipLevel, (int)face, Marshal.SizeOf(data[0]), data.Length, sourceDataStartIndex);
	}

	public unsafe void SetPixelData<T>(NativeArray<T> data, int mipLevel, CubemapFace face, [DefaultValue("0")] int sourceDataStartIndex = 0) where T : struct
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
		SetPixelDataImpl((IntPtr)data.GetUnsafeReadOnlyPtr(), mipLevel, (int)face, UnsafeUtility.SizeOf<T>(), data.Length, sourceDataStartIndex);
	}

	public unsafe NativeArray<T> GetPixelData<T>(int mipLevel, CubemapFace face) where T : struct
	{
		if (!isReadable)
		{
			throw CreateNonReadableException(this);
		}
		if (mipLevel < 0 || mipLevel >= base.mipmapCount)
		{
			throw new ArgumentException("The passed in miplevel " + mipLevel + " is invalid. The valid range is 0 through " + (base.mipmapCount - 1));
		}
		if (face < CubemapFace.PositiveX || face >= (CubemapFace)6)
		{
			throw new ArgumentException("The passed in face " + face.ToString() + " is invalid. The valid range is 0 through 5.");
		}
		if (GetWritableImageData(0).ToInt64() == 0)
		{
			throw new UnityException("Texture '" + base.name + "' has no data.");
		}
		ulong pixelDataOffset = GetPixelDataOffset(base.mipmapCount, (int)face);
		ulong pixelDataOffset2 = GetPixelDataOffset(mipLevel, (int)face);
		ulong pixelDataSize = GetPixelDataSize(mipLevel, (int)face);
		int num = UnsafeUtility.SizeOf<T>();
		ulong num2 = pixelDataSize / (ulong)num;
		if (num2 > int.MaxValue)
		{
			throw CreateNativeArrayLengthOverflowException();
		}
		IntPtr intPtr = new IntPtr((long)GetWritableImageData(0) + ((long)pixelDataOffset * (long)face + (long)pixelDataOffset2));
		return NativeArrayUnsafeUtility.ConvertExistingDataToNativeArray<T>((void*)intPtr, (int)num2, Allocator.None);
	}

	[ExcludeFromDocs]
	public void SetPixel(CubemapFace face, int x, int y, Color color)
	{
		SetPixel(face, x, y, color, 0);
	}

	public void SetPixel(CubemapFace face, int x, int y, Color color, [DefaultValue("0")] int mip)
	{
		if (!isReadable)
		{
			throw CreateNonReadableException(this);
		}
		SetPixelImpl((int)face, mip, x, y, color);
	}

	[ExcludeFromDocs]
	public Color GetPixel(CubemapFace face, int x, int y)
	{
		return GetPixel(face, x, y, 0);
	}

	public Color GetPixel(CubemapFace face, int x, int y, [DefaultValue("0")] int mip)
	{
		if (!isReadable)
		{
			throw CreateNonReadableException(this);
		}
		return GetPixelImpl((int)face, mip, x, y);
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

	private static void ValidateIsNotCrunched(TextureCreationFlags flags)
	{
		if ((flags &= TextureCreationFlags.Crunch) != TextureCreationFlags.None)
		{
			throw new ArgumentException("Crunched Cubemap is not supported for textures created from script.");
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	private extern void SetPixelImpl_Injected(int image, int mip, int x, int y, ref Color color);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void GetPixelImpl_Injected(int image, int mip, int x, int y, out Color ret);
}
