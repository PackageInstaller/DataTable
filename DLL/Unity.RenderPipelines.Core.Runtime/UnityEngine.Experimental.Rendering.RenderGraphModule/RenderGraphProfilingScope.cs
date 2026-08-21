using System;
using UnityEngine.Rendering;

namespace UnityEngine.Experimental.Rendering.RenderGraphModule;

public struct RenderGraphProfilingScope : IDisposable
{
	private bool m_Disposed;

	private ProfilingSampler m_Sampler;

	private RenderGraph m_RenderGraph;

	public RenderGraphProfilingScope(RenderGraph renderGraph, ProfilingSampler sampler)
	{
		m_RenderGraph = renderGraph;
		m_Sampler = sampler;
		m_Disposed = false;
		renderGraph.BeginProfilingSampler(sampler);
	}

	public void Dispose()
	{
		Dispose(disposing: true);
	}

	private void Dispose(bool disposing)
	{
		if (!m_Disposed)
		{
			if (disposing)
			{
				m_RenderGraph.EndProfilingSampler(m_Sampler);
			}
			m_Disposed = true;
		}
	}
}
