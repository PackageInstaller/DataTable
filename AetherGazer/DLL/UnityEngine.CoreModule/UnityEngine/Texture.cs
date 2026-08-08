using System;
using System.Runtime.CompilerServices;
using UnityEngine.Bindings;
using UnityEngine.Experimental.Rendering;
using UnityEngine.Rendering;
using UnityEngine.Scripting;

namespace UnityEngine;

[NativeHeader("Runtime/Streaming/TextureStreamingManager.h")]
[NativeHeader("Runtime/Graphics/Texture.h")]
[UsedByNativeCode]
public class Texture : Object
{
	public static readonly int GenerateAllMips = -1;

	[NativeProperty("ActiveGlobalMipmapLimit")]
	[Obsolete("masterTextureLimit has been deprecated. Use globalMipmapLimit instead (UnityUpgradable) -> globalMipmapLimit", false)]
	public static extern int masterTextureLimit
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	[NativeProperty("ActiveGlobalMipmapLimit")]
	[Obsolete("globalMipmapLimit is not supported. Use QualitySettings.globalTextureMipmapLimit or Mipmap Limit Groups instead.", false)]
	public static extern int globalMipmapLimit
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public extern int mipmapCount
	{
		[MethodImpl((MethodImplOptions)4096)]
		[NativeName("GetMipmapCount")]
		get;
	}

	[NativeProperty("AnisoLimit")]
	public static extern AnisotropicFiltering anisotropicFiltering
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public virtual GraphicsFormat graphicsFormat => GraphicsFormatUtility.GetFormat(this);

	public virtual int width
	{
		get
		{
			return GetDataWidth();
		}
		set
		{
			throw new NotImplementedException();
		}
	}

	public virtual int height
	{
		get
		{
			return GetDataHeight();
		}
		set
		{
			throw new NotImplementedException();
		}
	}

	public virtual TextureDimension dimension
	{
		get
		{
			return GetDimension();
		}
		set
		{
			throw new NotImplementedException();
		}
	}

	internal extern bool isNativeTexture
	{
		[MethodImpl((MethodImplOptions)4096)]
		[NativeName("IsNativeTexture")]
		get;
	}

	public virtual extern bool isReadable
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	public extern TextureWrapMode wrapMode
	{
		[MethodImpl((MethodImplOptions)4096)]
		[NativeName("GetWrapModeU")]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public extern TextureWrapMode wrapModeU
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public extern TextureWrapMode wrapModeV
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public extern TextureWrapMode wrapModeW
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public extern FilterMode filterMode
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public extern int anisoLevel
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public extern float mipMapBias
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public Vector2 texelSize
	{
		[NativeName("GetTexelSize")]
		get
		{
			get_texelSize_Injected(out var ret);
			return ret;
		}
	}

	public extern uint updateCount
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	internal ColorSpace activeTextureColorSpace
	{
		[VisibleToOtherModules(new string[] { "UnityEngine.UIElementsModule", "Unity.UIElements" })]
		get
		{
			return (Internal_GetActiveTextureColorSpace() == 0) ? ColorSpace.Linear : ColorSpace.Gamma;
		}
	}

	public bool isDataSRGB => Internal_GetStoredColorSpace() == TextureColorSpace.sRGB;

	public static extern ulong totalTextureMemory
	{
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction("GetTextureStreamingManager().GetTotalTextureMemory")]
		get;
	}

	public static extern ulong desiredTextureMemory
	{
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction("GetTextureStreamingManager().GetDesiredTextureMemory")]
		get;
	}

	public static extern ulong targetTextureMemory
	{
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction("GetTextureStreamingManager().GetTargetTextureMemory")]
		get;
	}

	public static extern ulong currentTextureMemory
	{
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction("GetTextureStreamingManager().GetCurrentTextureMemory")]
		get;
	}

	public static extern ulong nonStreamingTextureMemory
	{
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction("GetTextureStreamingManager().GetNonStreamingTextureMemory")]
		get;
	}

	public static extern ulong streamingMipmapUploadCount
	{
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction("GetTextureStreamingManager().GetStreamingMipmapUploadCount")]
		get;
	}

	public static extern ulong streamingRendererCount
	{
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction("GetTextureStreamingManager().GetStreamingRendererCount")]
		get;
	}

	public static extern ulong streamingTextureCount
	{
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction("GetTextureStreamingManager().GetStreamingTextureCount")]
		get;
	}

	public static extern ulong nonStreamingTextureCount
	{
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction("GetTextureStreamingManager().GetNonStreamingTextureCount")]
		get;
	}

	public static extern ulong streamingTexturePendingLoadCount
	{
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction("GetTextureStreamingManager().GetStreamingTexturePendingLoadCount")]
		get;
	}

	public static extern ulong streamingTextureLoadingCount
	{
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction("GetTextureStreamingManager().GetStreamingTextureLoadingCount")]
		get;
	}

	public static extern bool streamingTextureForceLoadAll
	{
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction(Name = "GetTextureStreamingManager().GetForceLoadAll")]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction(Name = "GetTextureStreamingManager().SetForceLoadAll")]
		set;
	}

	public static extern bool streamingTextureDiscardUnusedMips
	{
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction(Name = "GetTextureStreamingManager().GetDiscardUnusedMips")]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction(Name = "GetTextureStreamingManager().SetDiscardUnusedMips")]
		set;
	}

	public static extern bool allowThreadedTextureCreation
	{
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction(Name = "Texture2DScripting::IsCreateTextureThreadedEnabled")]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction(Name = "Texture2DScripting::EnableCreateTextureThreaded")]
		set;
	}

	protected Texture()
	{
	}

	[MethodImpl((MethodImplOptions)4096)]
	[NativeName("SetGlobalAnisoLimits")]
	public static extern void SetGlobalAnisotropicFilteringLimits(int forcedMin, int globalMax);

	[MethodImpl((MethodImplOptions)4096)]
	private extern int GetDataWidth();

	[MethodImpl((MethodImplOptions)4096)]
	private extern int GetDataHeight();

	[MethodImpl((MethodImplOptions)4096)]
	private extern TextureDimension GetDimension();

	[MethodImpl((MethodImplOptions)4096)]
	public extern IntPtr GetNativeTexturePtr();

	[Obsolete("Use GetNativeTexturePtr instead.", false)]
	public int GetNativeTextureID()
	{
		return (int)GetNativeTexturePtr();
	}

	[MethodImpl((MethodImplOptions)4096)]
	public extern void IncrementUpdateCount();

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod("GetActiveTextureColorSpace")]
	private extern int Internal_GetActiveTextureColorSpace();

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod("GetStoredColorSpace")]
	private extern TextureColorSpace Internal_GetStoredColorSpace();

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("GetTextureStreamingManager().SetStreamingTextureMaterialDebugProperties")]
	public static extern void SetStreamingTextureMaterialDebugProperties();

	[MethodImpl((MethodImplOptions)4096)]
	internal extern ulong GetPixelDataSize(int mipLevel, int element = 0);

	[MethodImpl((MethodImplOptions)4096)]
	internal extern ulong GetPixelDataOffset(int mipLevel, int element = 0);

	internal TextureColorSpace GetTextureColorSpace(bool linear)
	{
		return (!linear) ? TextureColorSpace.sRGB : TextureColorSpace.Linear;
	}

	internal TextureColorSpace GetTextureColorSpace(GraphicsFormat format)
	{
		return GetTextureColorSpace(!GraphicsFormatUtility.IsSRGBFormat(format));
	}

	internal bool ValidateFormat(RenderTextureFormat format)
	{
		if (SystemInfo.SupportsRenderTextureFormat(format))
		{
			return true;
		}
		Debug.LogError($"RenderTexture creation failed. '{format.ToString()}' is not supported on this platform. Use 'SystemInfo.SupportsRenderTextureFormat' C# API to check format support.", this);
		return false;
	}

	internal bool ValidateFormat(TextureFormat format)
	{
		if (SystemInfo.SupportsTextureFormat(format))
		{
			return true;
		}
		if (GraphicsFormatUtility.IsCompressedFormat(format) && GraphicsFormatUtility.CanDecompressFormat(GraphicsFormatUtility.GetGraphicsFormat(format, isSRGB: false)))
		{
			Debug.LogWarning($"'{format.ToString()}' is not supported on this platform. Decompressing texture. Use 'SystemInfo.SupportsTextureFormat' C# API to check format support.", this);
			return true;
		}
		Debug.LogError($"Texture creation failed. '{format.ToString()}' is not supported on this platform. Use 'SystemInfo.SupportsTextureFormat' C# API to check format support.", this);
		return false;
	}

	internal bool ValidateFormat(GraphicsFormat format, FormatUsage usage)
	{
		if (usage != FormatUsage.Render && (format == GraphicsFormat.ShadowAuto || format == GraphicsFormat.DepthAuto))
		{
			Debug.LogWarning($"'{format.ToString()}' is not allowed because it is an auto format and not an exact format. Use GraphicsFormatUtility.GetDepthStencilFormat to get an exact depth/stencil format.", this);
			return false;
		}
		if (SystemInfo.IsFormatSupported(format, usage))
		{
			return true;
		}
		Debug.LogError($"Texture creation failed. '{format.ToString()}' is not supported for {usage.ToString()} usage on this platform. Use 'SystemInfo.IsFormatSupported' C# API to check format support.", this);
		return false;
	}

	internal UnityException CreateNonReadableException(Texture t)
	{
		return new UnityException($"Texture '{t.name}' is not readable, the texture memory can not be accessed from scripts. You can make the texture readable in the Texture Import Settings.");
	}

	internal UnityException CreateNativeArrayLengthOverflowException()
	{
		return new UnityException("Failed to create NativeArray, length exceeds the allowed maximum of Int32.MaxValue. Use a larger type as template argument to reduce the array length.");
	}

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private extern void get_texelSize_Injected(out Vector2 ret);
}
