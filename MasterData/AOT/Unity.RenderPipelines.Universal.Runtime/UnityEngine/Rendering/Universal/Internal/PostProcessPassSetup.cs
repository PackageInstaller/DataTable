namespace UnityEngine.Rendering.Universal.Internal;

internal readonly struct PostProcessPassSetup
{
	internal readonly RenderTextureDescriptor descriptor;

	internal readonly RenderTargetHandle depth;

	internal readonly RenderTargetHandle internalLut;

	internal readonly bool resolveToScreen;

	internal readonly bool hasFinalPass;

	internal readonly bool needSRGBConversion;

	internal readonly bool ownsDisplayRescale;

	internal readonly bool useNativePostToScreen;

	internal PostProcessPassSetup(in RenderTextureDescriptor descriptor, in RenderTargetHandle depth, in RenderTargetHandle internalLut, bool resolveToScreen, bool hasFinalPass, bool needSRGBConversion, bool ownsDisplayRescale, bool useNativePostToScreen)
	{
		this.descriptor = descriptor;
		this.depth = depth;
		this.internalLut = internalLut;
		this.resolveToScreen = resolveToScreen;
		this.hasFinalPass = hasFinalPass;
		this.needSRGBConversion = needSRGBConversion;
		this.ownsDisplayRescale = ownsDisplayRescale;
		this.useNativePostToScreen = useNativePostToScreen;
	}
}
