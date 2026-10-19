using System;
using System.Runtime.CompilerServices;
using UnityEngine.Bindings;
using UnityEngine.Experimental.Rendering;
using UnityEngine.Internal;
using UnityEngine.Scripting;

namespace UnityEngine;

[NativeHeader("Runtime/Graphics/Texture3D.h")]
[ExcludeFromPreset]
public sealed class Texture3D : Texture
{
	public override extern bool isReadable
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
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

	[ExcludeFromDocs]
	public Texture3D(int width, int height, int depth, DefaultFormat format, TextureCreationFlags flags)
		: this(width, height, depth, SystemInfo.GetGraphicsFormat(format), flags)
	{
	}

	[ExcludeFromDocs]
	public Texture3D(int width, int height, int depth, DefaultFormat format, TextureCreationFlags flags, int mipCount)
		: this(width, height, depth, SystemInfo.GetGraphicsFormat(format), flags, mipCount)
	{
	}

	[ExcludeFromDocs]
	[RequiredByNativeCode]
	public Texture3D(int width, int height, int depth, GraphicsFormat format, TextureCreationFlags flags)
		: this(width, height, depth, format, flags, Texture.GenerateAllMips)
	{
	}

	[ExcludeFromDocs]
	public Texture3D(int width, int height, int depth, GraphicsFormat format, TextureCreationFlags flags, [DefaultValue("Texture.GenerateAllMips")] int mipCount)
	{
		if (ValidateFormat(format, FormatUsage.Sample))
		{
			ValidateIsNotCrunched(flags);
			Internal_Create(this, width, height, depth, mipCount, format, GetTextureColorSpace(format), flags, IntPtr.Zero);
		}
	}

	[ExcludeFromDocs]
	public Texture3D(int width, int height, int depth, TextureFormat textureFormat, int mipCount)
		: this(width, height, depth, textureFormat, mipCount, IntPtr.Zero)
	{
	}

	public Texture3D(int width, int height, int depth, TextureFormat textureFormat, int mipCount, [DefaultValue("IntPtr.Zero")] IntPtr nativeTex)
		: this(width, height, depth, textureFormat, mipCount, nativeTex, createUninitialized: false)
	{
	}

	public Texture3D(int width, int height, int depth, TextureFormat textureFormat, int mipCount, [DefaultValue("IntPtr.Zero")] IntPtr nativeTex, [DefaultValue("false")] bool createUninitialized)
	{
		if (ValidateFormat(textureFormat))
		{
			GraphicsFormat format = GraphicsFormatUtility.GetGraphicsFormat(textureFormat, isSRGB: false);
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
			Internal_Create(this, width, height, depth, mipCount, format, GetTextureColorSpace(linear: true), textureCreationFlags, nativeTex);
		}
	}

	[ExcludeFromDocs]
	public Texture3D(int width, int height, int depth, TextureFormat textureFormat, bool mipChain)
		: this(width, height, depth, textureFormat, (!mipChain) ? 1 : Texture.GenerateAllMips)
	{
	}

	public Texture3D(int width, int height, int depth, TextureFormat textureFormat, bool mipChain, [DefaultValue("false")] bool createUninitialized)
		: this(width, height, depth, textureFormat, (!mipChain) ? 1 : Texture.GenerateAllMips, IntPtr.Zero, createUninitialized)
	{
	}

	public Texture3D(int width, int height, int depth, TextureFormat textureFormat, bool mipChain, [DefaultValue("IntPtr.Zero")] IntPtr nativeTex)
		: this(width, height, depth, textureFormat, (!mipChain) ? 1 : Texture.GenerateAllMips, nativeTex)
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
	public void Apply()
	{
		Apply(updateMipmaps: true, makeNoLongerReadable: false);
	}

	private static void ValidateIsNotCrunched(TextureCreationFlags flags)
	{
		if ((flags &= TextureCreationFlags.Crunch) != TextureCreationFlags.None)
		{
			throw new ArgumentException("Crunched Texture3D is not supported.");
		}
	}
}
