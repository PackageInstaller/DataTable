#define UNITY_ASSERTIONS
using System;
using System.Runtime.CompilerServices;
using UnityEngine.Bindings;
using UnityEngine.Rendering;

namespace UnityEngine.Experimental.Rendering;

[NativeHeader("Runtime/Graphics/Format.h")]
[NativeHeader("Runtime/Graphics/TextureFormat.h")]
[NativeHeader("Runtime/Graphics/GraphicsFormatUtility.bindings.h")]
public class GraphicsFormatUtility
{
	private static readonly GraphicsFormat[] tableNoStencil = new GraphicsFormat[5]
	{
		GraphicsFormat.None,
		GraphicsFormat.D16_UNorm,
		GraphicsFormat.D16_UNorm,
		GraphicsFormat.D24_UNorm,
		GraphicsFormat.D32_SFloat
	};

	private static readonly GraphicsFormat[] tableStencil = new GraphicsFormat[5]
	{
		GraphicsFormat.None,
		GraphicsFormat.D24_UNorm_S8_UInt,
		GraphicsFormat.D24_UNorm_S8_UInt,
		GraphicsFormat.D24_UNorm_S8_UInt,
		GraphicsFormat.D32_SFloat_S8_UInt
	};

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("GetTextureGraphicsFormat")]
	internal static extern GraphicsFormat GetFormat([NotNull("NullExceptionObject")] Texture texture);

	public static GraphicsFormat GetGraphicsFormat(TextureFormat format, bool isSRGB)
	{
		return GetGraphicsFormat_Native_TextureFormat(format, isSRGB);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(IsThreadSafe = true)]
	private static extern GraphicsFormat GetGraphicsFormat_Native_TextureFormat(TextureFormat format, bool isSRGB);

	public static TextureFormat GetTextureFormat(GraphicsFormat format)
	{
		return GetTextureFormat_Native_GraphicsFormat(format);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(IsThreadSafe = true)]
	private static extern TextureFormat GetTextureFormat_Native_GraphicsFormat(GraphicsFormat format);

	public static GraphicsFormat GetGraphicsFormat(RenderTextureFormat format, bool isSRGB)
	{
		return GetGraphicsFormat_Native_RenderTextureFormat(format, isSRGB);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction]
	private static extern GraphicsFormat GetGraphicsFormat_Native_RenderTextureFormat(RenderTextureFormat format, bool isSRGB);

	public static GraphicsFormat GetGraphicsFormat(RenderTextureFormat format, RenderTextureReadWrite readWrite)
	{
		bool flag = QualitySettings.activeColorSpace == ColorSpace.Linear;
		bool isSRGB = ((readWrite == RenderTextureReadWrite.Default) ? flag : (readWrite == RenderTextureReadWrite.sRGB));
		return GetGraphicsFormat(format, isSRGB);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(IsThreadSafe = true)]
	private static extern GraphicsFormat GetDepthStencilFormatFromBitsLegacy_Native(int minimumDepthBits);

	internal static GraphicsFormat GetDepthStencilFormat(int minimumDepthBits)
	{
		return GetDepthStencilFormatFromBitsLegacy_Native(minimumDepthBits);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(IsThreadSafe = true)]
	public static extern int GetDepthBits(GraphicsFormat format);

	public static GraphicsFormat GetDepthStencilFormat(int minimumDepthBits, int minimumStencilBits)
	{
		if (minimumDepthBits == 0 && minimumStencilBits == 0)
		{
			return GraphicsFormat.None;
		}
		if (minimumDepthBits < 0 || minimumStencilBits < 0)
		{
			throw new ArgumentException("Number of bits in DepthStencil format can't be negative.");
		}
		if (minimumDepthBits > 32)
		{
			throw new ArgumentException("Number of depth buffer bits cannot exceed 32.");
		}
		if (minimumStencilBits > 8)
		{
			throw new ArgumentException("Number of stencil buffer bits cannot exceed 8.");
		}
		minimumDepthBits = ((minimumDepthBits <= 16) ? 16 : ((minimumDepthBits > 24) ? 32 : 24));
		if (minimumStencilBits != 0)
		{
			minimumStencilBits = 8;
		}
		Debug.Assert(tableNoStencil.Length == tableStencil.Length);
		GraphicsFormat[] array = ((minimumStencilBits > 0) ? tableStencil : tableNoStencil);
		int num = minimumDepthBits / 8;
		for (int i = num; i < array.Length; i++)
		{
			GraphicsFormat graphicsFormat = array[i];
			if (SystemInfo.IsFormatSupported(graphicsFormat, FormatUsage.Render))
			{
				return graphicsFormat;
			}
		}
		return GraphicsFormat.None;
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(IsThreadSafe = true)]
	public static extern bool IsSRGBFormat(GraphicsFormat format);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(IsThreadSafe = true)]
	public static extern GraphicsFormat GetSRGBFormat(GraphicsFormat format);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(IsThreadSafe = true)]
	public static extern GraphicsFormat GetLinearFormat(GraphicsFormat format);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(IsThreadSafe = true)]
	public static extern RenderTextureFormat GetRenderTextureFormat(GraphicsFormat format);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(IsThreadSafe = true)]
	public static extern uint GetComponentCount(GraphicsFormat format);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(IsThreadSafe = true)]
	public static extern string GetFormatString(GraphicsFormat format);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("IsAnyCompressedTextureFormat", true)]
	internal static extern bool IsCompressedTextureFormat(TextureFormat format);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(IsThreadSafe = true)]
	private static extern bool CanDecompressFormat(GraphicsFormat format, bool wholeImage);

	internal static bool CanDecompressFormat(GraphicsFormat format)
	{
		return CanDecompressFormat(format, wholeImage: true);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(IsThreadSafe = true)]
	public static extern bool IsAlphaOnlyFormat(GraphicsFormat format);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(IsThreadSafe = true)]
	public static extern bool IsDepthFormat(GraphicsFormat format);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(IsThreadSafe = true)]
	public static extern bool IsStencilFormat(GraphicsFormat format);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(IsThreadSafe = true)]
	public static extern bool IsPVRTCFormat(GraphicsFormat format);

	public static bool IsCrunchFormat(TextureFormat format)
	{
		return format == TextureFormat.DXT1Crunched || format == TextureFormat.DXT5Crunched || format == TextureFormat.ETC_RGB4Crunched || format == TextureFormat.ETC2_RGBA8Crunched;
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(IsThreadSafe = true)]
	public static extern FormatSwizzle GetSwizzleR(GraphicsFormat format);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(IsThreadSafe = true)]
	public static extern FormatSwizzle GetSwizzleG(GraphicsFormat format);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(IsThreadSafe = true)]
	public static extern FormatSwizzle GetSwizzleB(GraphicsFormat format);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(IsThreadSafe = true)]
	public static extern FormatSwizzle GetSwizzleA(GraphicsFormat format);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(IsThreadSafe = true)]
	public static extern uint GetBlockSize(GraphicsFormat format);
}
