using UnityEngine.Rendering;

namespace UnityEngine.Experimental.Rendering.RenderGraphModule;

public struct RenderGraphParameters
{
	public string executionName;

	public int currentFrameIndex;

	public bool rendererListCulling;

	public ScriptableRenderContext scriptableRenderContext;

	public CommandBuffer commandBuffer;
}
