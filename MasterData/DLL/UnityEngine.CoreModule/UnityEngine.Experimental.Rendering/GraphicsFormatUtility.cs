#define UNITY_ASSERTIONS
using System;
using System.Runtime.CompilerServices;
using UnityEngine.Bindings;
using UnityEngine.Rendering;

namespace UnityEngine.Experimental.Rendering;

[NativeHeader("Runtime/Graphics/Format.h")]
[NativeHeader("Runtime/Graphics/GraphicsFormatUtility.bindings.h")]
[NativeHeader("Runtime/Graphics/TextureFormat.h")]
public class GraphicsFormatUtility
{
	private static readonly GraphicsFormat[] tableNoStencil;

	private static readonly GraphicsFormat[] tableStencil;

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("GetGraphicsFormat_Native_Texture")]
	internal static extern GraphicsFormat GetFormat([NotNull("NullExceptionObject")] Texture texture);

	public static GraphicsFormat GetGraphicsFormat(TextureFormat format, bool isSRGB)
	{
		return GetGraphicsFormat_Native_TextureFormat(format, isSRGB);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(IsThreadSafe = true)]
	private static extern GraphicsFormat GetGraphicsFormat_Native_TextureFormat(TextureFormat format, bool isSRGB);

	public static GraphicsFormat GetGraphicsFormat(RenderTextureFormat format, bool isSRGB)
	{
		return GetGraphicsFormat_Native_RenderTextureFormat(format, isSRGB);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(IsThreadSafe = false)]
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
		minimumDepthBits = ((minimumDepthBits != 0) ? ((minimumDepthBits <= 16) ? 16 : ((minimumDepthBits > 24) ? 32 : 24)) : 0);
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
	private static extern bool IsCompressedFormat_Native_TextureFormat(TextureFormat format);

	public static bool IsCompressedFormat(TextureFormat format)
	{
		return IsCompressedFormat_Native_TextureFormat(format);
	}

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
	public static extern bool IsDepthStencilFormat(GraphicsFormat format);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(IsThreadSafe = true)]
	public static extern bool IsPVRTCFormat(GraphicsFormat format);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("IsCompressedCrunchTextureFormat", IsThreadSafe = true)]
	public static extern bool IsCrunchFormat(TextureFormat format);

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

	static GraphicsFormatUtility()
	{
		//IL_0022: Field data (rva=0x4b0) could not be found in any section!
		//IL_0022: Field data (rva=0x4b0) could not be found in any section!
		//IL_000c: Field data (rva=0x498) could not be found in any section!
		//IL_000c: Field data (rva=0x498) could not be found in any section!
		GraphicsFormat[] array = new GraphicsFormat[5];
		RuntimeHelpers.InitializeArray(array, (RuntimeFieldHandle)/*OpCode not supported: LdMemberToken*/);
		tableNoStencil = array;
		GraphicsFormat[] array2 = new GraphicsFormat[5];
		RuntimeHelpers.InitializeArray(array2, (RuntimeFieldHandle)/*OpCode not supported: LdMemberToken*/);
		tableStencil = array2;
	}
}
