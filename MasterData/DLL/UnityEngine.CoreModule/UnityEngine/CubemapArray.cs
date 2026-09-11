using System;
using System.Runtime.CompilerServices;
using UnityEngine.Bindings;
using UnityEngine.Experimental.Rendering;
using UnityEngine.Internal;
using UnityEngine.Scripting;

namespace UnityEngine;

[NativeHeader("Runtime/Graphics/CubemapArrayTexture.h")]
[ExcludeFromPreset]
public sealed class CubemapArray : Texture
{
	public override extern bool isReadable
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("CubemapArrayScripting::Create")]
	private static extern bool Internal_CreateImpl([Writable] CubemapArray mono, int ext, int count, int mipCount, GraphicsFormat format, TextureColorSpace colorSpace, TextureCreationFlags flags);

	private static void Internal_Create([Writable] CubemapArray mono, int ext, int count, int mipCount, GraphicsFormat format, TextureColorSpace colorSpace, TextureCreationFlags flags)
	{
		if (!Internal_CreateImpl(mono, ext, count, mipCount, format, colorSpace, flags))
		{
			throw new UnityException("Failed to create cubemap array texture because of invalid parameters.");
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "CubemapArrayScripting::Apply", HasExplicitThis = true)]
	private extern void ApplyImpl(bool updateMipmaps, bool makeNoLongerReadable);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "CubemapArrayScripting::SetPixels", HasExplicitThis = true, ThrowsException = true)]
	public extern void SetPixels([Unmarshalled] Color[] colors, CubemapFace face, int arrayElement, int miplevel);

	public void SetPixels(Color[] colors, CubemapFace face, int arrayElement)
	{
		SetPixels(colors, face, arrayElement, 0);
	}

	[ExcludeFromDocs]
	public CubemapArray(int width, int cubemapCount, DefaultFormat format, TextureCreationFlags flags)
		: this(width, cubemapCount, SystemInfo.GetGraphicsFormat(format), flags)
	{
	}

	[ExcludeFromDocs]
	public CubemapArray(int width, int cubemapCount, DefaultFormat format, TextureCreationFlags flags, [DefaultValue("Texture.GenerateAllMips")] int mipCount)
		: this(width, cubemapCount, SystemInfo.GetGraphicsFormat(format), flags, mipCount)
	{
	}

	[RequiredByNativeCode]
	public CubemapArray(int width, int cubemapCount, GraphicsFormat format, TextureCreationFlags flags)
		: this(width, cubemapCount, format, flags, Texture.GenerateAllMips)
	{
	}

	[ExcludeFromDocs]
	public CubemapArray(int width, int cubemapCount, GraphicsFormat format, TextureCreationFlags flags, [DefaultValue("Texture.GenerateAllMips")] int mipCount)
	{
		if (ValidateFormat(format, FormatUsage.Sample))
		{
			ValidateIsNotCrunched(flags);
			Internal_Create(this, width, cubemapCount, mipCount, format, GetTextureColorSpace(format), flags);
		}
	}

	public CubemapArray(int width, int cubemapCount, TextureFormat textureFormat, int mipCount, bool linear, [DefaultValue("false")] bool createUninitialized)
	{
		if (ValidateFormat(textureFormat))
		{
			GraphicsFormat format = GraphicsFormatUtility.GetGraphicsFormat(textureFormat, !linear);
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
			Internal_Create(this, width, cubemapCount, mipCount, format, GetTextureColorSpace(linear), textureCreationFlags);
		}
	}

	public CubemapArray(int width, int cubemapCount, TextureFormat textureFormat, int mipCount, bool linear)
		: this(width, cubemapCount, textureFormat, mipCount, linear, createUninitialized: false)
	{
	}

	public CubemapArray(int width, int cubemapCount, TextureFormat textureFormat, bool mipChain, [DefaultValue("false")] bool linear, [DefaultValue("false")] bool createUninitialized)
		: this(width, cubemapCount, textureFormat, (!mipChain) ? 1 : Texture.GenerateAllMips, linear, createUninitialized)
	{
	}

	[ExcludeFromDocs]
	public CubemapArray(int width, int cubemapCount, TextureFormat textureFormat, bool mipChain, [DefaultValue("false")] bool linear)
		: this(width, cubemapCount, textureFormat, (!mipChain) ? 1 : Texture.GenerateAllMips, linear)
	{
	}

	public CubemapArray(int width, int cubemapCount, TextureFormat textureFormat, bool mipChain)
		: this(width, cubemapCount, textureFormat, (!mipChain) ? 1 : Texture.GenerateAllMips, linear: false)
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
			throw new ArgumentException("Crunched TextureCubeArray is not supported.");
		}
	}
}
