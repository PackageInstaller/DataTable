using System;
using System.Runtime.CompilerServices;
using UnityEngine.Bindings;
using UnityEngine.Experimental.Rendering;
using UnityEngine.Internal;
using UnityEngine.Scripting;

namespace UnityEngine;

[ExcludeFromPreset]
[NativeHeader("Runtime/Graphics/Texture3D.h")]
public sealed class Texture3D : Texture
{
	public override extern bool isReadable
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	[ExcludeFromDocs]
	public Texture3D(int width, int height, int depth, DefaultFormat format, TextureCreationFlags flags)
		: this(width, height, depth, SystemInfo.GetGraphicsFormat(format), flags)
	{
	}

	[ExcludeFromDocs]
	[RequiredByNativeCode]
	public Texture3D(int width, int height, int depth, GraphicsFormat format, TextureCreationFlags flags)
		: this(width, height, depth, format, flags, Texture.GenerateAllMips)
	{
	}

	[ExcludeFromDocs]
	public Texture3D(int width, int height, int depth, GraphicsFormat format, TextureCreationFlags flags, [DefaultValue("-1")] int mipCount)
	{
		if (ValidateFormat(format, FormatUsage.Sample))
		{
			ValidateIsNotCrunched(flags);
			Internal_Create(this, width, height, depth, mipCount, format, GetTextureColorSpace(format), flags, IntPtr.Zero);
		}
	}

	[ExcludeFromDocs]
	public Texture3D(int width, int height, int depth, TextureFormat textureFormat, int mipCount)
	{
		if (ValidateFormat(textureFormat))
		{
			GraphicsFormat format = GraphicsFormatUtility.GetGraphicsFormat(textureFormat, isSRGB: false);
			TextureCreationFlags textureCreationFlags = ((mipCount != 1) ? TextureCreationFlags.MipChain : TextureCreationFlags.None);
			if (GraphicsFormatUtility.IsCrunchFormat(textureFormat))
			{
				textureCreationFlags |= TextureCreationFlags.Crunch;
			}
			ValidateIsNotCrunched(textureCreationFlags);
			Internal_Create(this, width, height, depth, mipCount, format, GetTextureColorSpace(linear: true), textureCreationFlags, IntPtr.Zero);
		}
	}

	public Texture3D(int width, int height, int depth, TextureFormat textureFormat, int mipCount, [DefaultValue("IntPtr.Zero")] IntPtr nativeTex)
	{
		if (ValidateFormat(textureFormat))
		{
			GraphicsFormat format = GraphicsFormatUtility.GetGraphicsFormat(textureFormat, isSRGB: false);
			TextureCreationFlags textureCreationFlags = ((mipCount != 1) ? TextureCreationFlags.MipChain : TextureCreationFlags.None);
			if (GraphicsFormatUtility.IsCrunchFormat(textureFormat))
			{
				textureCreationFlags |= TextureCreationFlags.Crunch;
			}
			ValidateIsNotCrunched(textureCreationFlags);
			Internal_Create(this, width, height, depth, mipCount, format, GetTextureColorSpace(linear: true), textureCreationFlags, nativeTex);
		}
	}

	[ExcludeFromDocs]
	public Texture3D(int width, int height, int depth, TextureFormat textureFormat, bool mipChain)
		: this(width, height, depth, textureFormat, (!mipChain) ? 1 : (-1))
	{
	}

	public Texture3D(int width, int height, int depth, TextureFormat textureFormat, bool mipChain, [DefaultValue("IntPtr.Zero")] IntPtr nativeTex)
		: this(width, height, depth, textureFormat, (!mipChain) ? 1 : (-1), nativeTex)
	{
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

	public void SetPixel(int x, int y, int z, Color color, [DefaultValue("0")] int mipLevel)
	{
		if (!isReadable)
		{
			throw CreateNonReadableException(this);
		}
		SetPixelImpl(mipLevel, x, y, z, color);
	}

	private static void ValidateIsNotCrunched(TextureCreationFlags flags)
	{
		if ((flags &= TextureCreationFlags.Crunch) != TextureCreationFlags.None)
		{
			throw new ArgumentException("Crunched Texture3D is not supported.");
		}
	}

	[NativeName("SetPixel")]
	private void SetPixelImpl(int mip, int x, int y, int z, Color color)
	{
		SetPixelImpl_Injected(mip, x, y, z, ref color);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("Texture3DScripting::Create")]
	private static extern bool Internal_CreateImpl([Writable] Texture3D mono, int w, int h, int d, int mipCount, GraphicsFormat format, TextureColorSpace colorSpace, TextureCreationFlags flags, IntPtr nativeTex);

	private static void Internal_Create([Writable] Texture3D mono, int w, int h, int d, int mipCount, GraphicsFormat format, TextureColorSpace colorSpace, TextureCreationFlags flags, IntPtr nativeTex)
	{
		if (!Internal_CreateImpl(mono, w, h, d, mipCount, format, colorSpace, flags, nativeTex))
		{
			throw new UnityException("Failed to create texture because of invalid parameters.");
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "Texture3DScripting::Apply", HasExplicitThis = true)]
	private extern void ApplyImpl(bool updateMipmaps, bool makeNoLongerReadable);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "Texture3DScripting::SetPixels", HasExplicitThis = true, ThrowsException = true)]
	public extern void SetPixels([Unmarshalled] Color[] colors, int miplevel);

	public void SetPixels(Color[] colors)
	{
		SetPixels(colors, 0);
	}

	[MethodImpl((MethodImplOptions)4096)]
	private extern void SetPixelImpl_Injected(int mip, int x, int y, int z, ref Color color);
}
