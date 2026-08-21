using System;
using UnityEngine.Rendering;

namespace UnityEngine.Experimental.Rendering.RenderGraphModule;

public struct RenderGraphBuilder : IDisposable
{
	private RenderGraphPass m_RenderPass;

	private RenderGraphResourceRegistry m_Resources;

	private RenderGraph m_RenderGraph;

	private bool m_Disposed;

	public TextureHandle UseColorBuffer(in TextureHandle input, int index)
	{
		CheckResource(in input.handle, dontCheckTransientReadWrite: true);
		m_Resources.IncrementWriteCount(in input.handle);
		m_RenderPass.SetColorBuffer(input, index);
		return input;
	}

	public TextureHandle UseDepthBuffer(in TextureHandle input, DepthAccess flags)
	{
		CheckResource(in input.handle, dontCheckTransientReadWrite: true);
		if ((flags & DepthAccess.Write) != 0)
		{
			m_Resources.IncrementWriteCount(in input.handle);
		}
		if ((flags & DepthAccess.Read) != 0 && !m_Resources.IsRenderGraphResourceImported(in input.handle) && m_Resources.TextureNeedsFallback(in input))
		{
			WriteTexture(in input);
		}
		m_RenderPass.SetDepthBuffer(input, flags);
		return input;
	}

	public TextureHandle ReadTexture(in TextureHandle input)
	{
		CheckResource(in input.handle);
		if (!m_Resources.IsRenderGraphResourceImported(in input.handle) && m_Resources.TextureNeedsFallback(in input))
		{
			TextureDesc textureResourceDesc = m_Resources.GetTextureResourceDesc(in input.handle);
			if (!textureResourceDesc.bindTextureMS)
			{
				if (textureResourceDesc.dimension == TextureXR.dimension)
				{
					return m_RenderGraph.defaultResources.blackTextureXR;
				}
				if (textureResourceDesc.dimension == TextureDimension.Tex3D)
				{
					return m_RenderGraph.defaultResources.blackTexture3DXR;
				}
				return m_RenderGraph.defaultResources.blackTexture;
			}
			if (!textureResourceDesc.clearBuffer)
			{
				m_Resources.ForceTextureClear(in input.handle, Color.black);
			}
			WriteTexture(in input);
		}
		m_RenderPass.AddResourceRead(in input.handle);
		return input;
	}

	public TextureHandle WriteTexture(in TextureHandle input)
	{
		CheckResource(in input.handle);
		m_Resources.IncrementWriteCount(in input.handle);
		m_RenderPass.AddResourceWrite(in input.handle);
		return input;
	}

	public TextureHandle ReadWriteTexture(in TextureHandle input)
	{
		CheckResource(in input.handle);
		m_Resources.IncrementWriteCount(in input.handle);
		m_RenderPass.AddResourceWrite(in input.handle);
		m_RenderPass.AddResourceRead(in input.handle);
		return input;
	}

	public TextureHandle CreateTransientTexture(in TextureDesc desc)
	{
		TextureHandle result = m_Resources.CreateTexture(in desc, m_RenderPass.index);
		m_RenderPass.AddTransientResource(in result.handle);
		return result;
	}

	public TextureHandle CreateTransientTexture(in TextureHandle texture)
	{
		TextureDesc desc = m_Resources.GetTextureResourceDesc(in texture.handle);
		TextureHandle result = m_Resources.CreateTexture(in desc, m_RenderPass.index);
		m_RenderPass.AddTransientResource(in result.handle);
		return result;
	}

	public RendererListHandle UseRendererList(in RendererListHandle input)
	{
		m_RenderPass.UseRendererList(input);
		return input;
	}

	public ComputeBufferHandle ReadComputeBuffer(in ComputeBufferHandle input)
	{
		CheckResource(in input.handle);
		m_RenderPass.AddResourceRead(in input.handle);
		return input;
	}

	public ComputeBufferHandle WriteComputeBuffer(in ComputeBufferHandle input)
	{
		CheckResource(in input.handle);
		m_RenderPass.AddResourceWrite(in input.handle);
		m_Resources.IncrementWriteCount(in input.handle);
		return input;
	}

	public ComputeBufferHandle CreateTransientComputeBuffer(in ComputeBufferDesc desc)
	{
		ComputeBufferHandle result = m_Resources.CreateComputeBuffer(in desc, m_RenderPass.index);
		m_RenderPass.AddTransientResource(in result.handle);
		return result;
	}

	public ComputeBufferHandle CreateTransientComputeBuffer(in ComputeBufferHandle computebuffer)
	{
		ComputeBufferDesc desc = m_Resources.GetComputeBufferResourceDesc(in computebuffer.handle);
		ComputeBufferHandle result = m_Resources.CreateComputeBuffer(in desc, m_RenderPass.index);
		m_RenderPass.AddTransientResource(in result.handle);
		return result;
	}

	public void SetRenderFunc<PassData>(RenderFunc<PassData> renderFunc) where PassData : class, new()
	{
		((RenderGraphPass<PassData>)m_RenderPass).renderFunc = renderFunc;
	}

	public void EnableAsyncCompute(bool value)
	{
		m_RenderPass.EnableAsyncCompute(value);
	}

	public void AllowPassCulling(bool value)
	{
		m_RenderPass.AllowPassCulling(value);
	}

	public void Dispose()
	{
		Dispose(disposing: true);
	}

	public void AllowRendererListCulling(bool value)
	{
		m_RenderPass.AllowRendererListCulling(value);
	}

	public RendererListHandle DependsOn(in RendererListHandle input)
	{
		m_RenderPass.UseRendererList(input);
		return input;
	}

	internal RenderGraphBuilder(RenderGraphPass renderPass, RenderGraphResourceRegistry resources, RenderGraph renderGraph)
	{
		m_RenderPass = renderPass;
		m_Resources = resources;
		m_RenderGraph = renderGraph;
		m_Disposed = false;
	}

	private void Dispose(bool disposing)
	{
		if (!m_Disposed)
		{
			m_RenderGraph.OnPassAdded(m_RenderPass);
			m_Disposed = true;
		}
	}

	private void CheckResource(in ResourceHandle res, bool dontCheckTransientReadWrite = false)
	{
	}

	internal void GenerateDebugData(bool value)
	{
		m_RenderPass.GenerateDebugData(value);
	}
}
