using System;

namespace UnityEngine.Experimental.Rendering.RenderGraphModule;

public struct RenderGraphExecution : IDisposable
{
	private RenderGraph renderGraph;

	internal RenderGraphExecution(RenderGraph renderGraph)
	{
		this.renderGraph = renderGraph;
	}

	public void Dispose()
	{
		renderGraph.Execute();
	}
}
