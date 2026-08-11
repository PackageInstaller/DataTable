using System;
using System.Diagnostics;
using UnityEngine.Rendering;

namespace UnityEngine.Experimental.Rendering.RenderGraphModule;

[DebuggerDisplay("TextureResource ({desc.name})")]
internal class TextureResource : RenderGraphResource<TextureDesc, RTHandle>
{
	private static int m_TextureCreationIndex;

	public override string GetName()
	{
		if (imported && !shared)
		{
			if (graphicsResource == null)
			{
				return "null resource";
			}
			return graphicsResource.name;
		}
		return desc.name;
	}

	public override void CreatePooledGraphicsResource()
	{
		int hashCode = desc.GetHashCode();
		if (graphicsResource != null)
		{
			throw new InvalidOperationException($"Trying to create an already created resource ({GetName()}). Resource was probably declared for writing more than once in the same pass.");
		}
		TexturePool obj = m_Pool as TexturePool;
		if (!obj.TryGetResource(hashCode, out graphicsResource))
		{
			CreateGraphicsResource();
		}
		cachedHash = hashCode;
		obj.RegisterFrameAllocation(cachedHash, graphicsResource);
	}

	public override void ReleasePooledGraphicsResource(int frameIndex)
	{
		if (graphicsResource == null)
		{
			throw new InvalidOperationException("Tried to release a resource (" + GetName() + ") that was never created. Check that there is at least one pass writing to it first.");
		}
		if (m_Pool is TexturePool texturePool)
		{
			texturePool.ReleaseResource(cachedHash, graphicsResource, frameIndex);
			texturePool.UnregisterFrameAllocation(cachedHash, graphicsResource);
		}
		Reset(null);
	}

	public override void CreateGraphicsResource(string name = "")
	{
		if (name == "")
		{
			name = $"RenderGraphTexture_{m_TextureCreationIndex++}";
		}
		switch (desc.sizeMode)
		{
		case TextureSizeMode.Explicit:
			graphicsResource = RTHandles.Alloc(desc.width, desc.height, desc.slices, desc.depthBufferBits, desc.colorFormat, desc.filterMode, desc.wrapMode, desc.dimension, desc.enableRandomWrite, desc.useMipMap, desc.autoGenerateMips, desc.isShadowMap, desc.anisoLevel, desc.mipMapBias, desc.msaaSamples, desc.bindTextureMS, desc.useDynamicScale, desc.memoryless, name);
			break;
		case TextureSizeMode.Scale:
			graphicsResource = RTHandles.Alloc(desc.scale, desc.slices, desc.depthBufferBits, desc.colorFormat, desc.filterMode, desc.wrapMode, desc.dimension, desc.enableRandomWrite, desc.useMipMap, desc.autoGenerateMips, desc.isShadowMap, desc.anisoLevel, desc.mipMapBias, desc.msaaSamples, desc.bindTextureMS, desc.useDynamicScale, desc.memoryless, name);
			break;
		case TextureSizeMode.Functor:
			graphicsResource = RTHandles.Alloc(desc.func, desc.slices, desc.depthBufferBits, desc.colorFormat, desc.filterMode, desc.wrapMode, desc.dimension, desc.enableRandomWrite, desc.useMipMap, desc.autoGenerateMips, desc.isShadowMap, desc.anisoLevel, desc.mipMapBias, desc.msaaSamples, desc.bindTextureMS, desc.useDynamicScale, desc.memoryless, name);
			break;
		}
	}

	public override void ReleaseGraphicsResource()
	{
		if (graphicsResource != null)
		{
			graphicsResource.Release();
		}
		base.ReleaseGraphicsResource();
	}

	public override void LogCreation(RenderGraphLogger logger)
	{
		logger.LogLine($"Created Texture: {desc.name} (Cleared: {desc.clearBuffer})");
	}

	public override void LogRelease(RenderGraphLogger logger)
	{
		logger.LogLine("Released Texture: " + desc.name);
	}
}
