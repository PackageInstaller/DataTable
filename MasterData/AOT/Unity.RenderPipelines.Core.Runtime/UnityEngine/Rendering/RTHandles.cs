using UnityEngine.Experimental.Rendering;

namespace UnityEngine.Rendering;

public static class RTHandles
{
	private static RTHandleSystem s_DefaultInstance = new RTHandleSystem();

	public static RTHandle Alloc(int width, int height, int slices = 1, DepthBits depthBufferBits = DepthBits.None, GraphicsFormat colorFormat = GraphicsFormat.R8G8B8A8_SRGB, FilterMode filterMode = FilterMode.Point, TextureWrapMode wrapMode = TextureWrapMode.Repeat, TextureDimension dimension = TextureDimension.Tex2D, bool enableRandomWrite = false, bool useMipMap = false, bool autoGenerateMips = true, bool isShadowMap = false, int anisoLevel = 1, float mipMapBias = 0f, MSAASamples msaaSamples = MSAASamples.None, bool bindTextureMS = false, bool useDynamicScale = false, RenderTextureMemoryless memoryless = RenderTextureMemoryless.None, VRTextureUsage vrUsage = VRTextureUsage.None, string name = "")
	{
		return s_DefaultInstance.Alloc(width, height, slices, depthBufferBits, colorFormat, filterMode, wrapMode, dimension, enableRandomWrite, useMipMap, autoGenerateMips, isShadowMap, anisoLevel, mipMapBias, msaaSamples, bindTextureMS, useDynamicScale, memoryless, vrUsage, name);
	}

	public static RTHandle Alloc(in RenderTextureDescriptor descriptor, FilterMode filterMode = FilterMode.Point, TextureWrapMode wrapMode = TextureWrapMode.Repeat, bool isShadowMap = false, int anisoLevel = 1, float mipMapBias = 0f, string name = "")
	{
		return s_DefaultInstance.Alloc(descriptor.width, descriptor.height, descriptor.volumeDepth, (DepthBits)descriptor.depthBufferBits, descriptor.graphicsFormat, filterMode, wrapMode, descriptor.dimension, descriptor.enableRandomWrite, descriptor.useMipMap, descriptor.autoGenerateMips, isShadowMap, anisoLevel, mipMapBias, (MSAASamples)descriptor.msaaSamples, descriptor.bindMS, descriptor.useDynamicScale, descriptor.memoryless, descriptor.vrUsage, name);
	}

	public static RTHandle Alloc(RenderTexture tex)
	{
		return s_DefaultInstance.Alloc(tex);
	}

	public static void Release(RTHandle rth)
	{
		s_DefaultInstance.Release(rth);
	}
}
