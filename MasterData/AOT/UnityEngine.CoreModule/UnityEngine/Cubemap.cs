using System;
using System.Runtime.CompilerServices;
using UnityEngine.Bindings;
using UnityEngine.Experimental.Rendering;
using UnityEngine.Internal;
using UnityEngine.Scripting;

namespace UnityEngine;

[NativeHeader("Runtime/Graphics/CubemapTexture.h")]
[ExcludeFromPreset]
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

	[NativeName("SetPixel")]
	private void SetPixelImpl(int image, int mip, int x, int y, Color color)
	{
		SetPixelImpl_Injected(image, mip, x, y, ref color);
	}

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

	[RequiredByNativeCode]
	[ExcludeFromDocs]
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

	public void Apply([DefaultValue("true")] bool updateMipmaps, [DefaultValue("false")] bool makeNoLongerReadable)
	{
		if (!isReadable)
		{
			throw CreateNonReadableException(this);
		}
		ApplyImpl(updateMipmaps, makeNoLongerReadable);
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
}
