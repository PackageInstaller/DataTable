using UnityEngine.Rendering;

namespace UnityEngine.Experimental.Rendering.RenderGraphModule;

public class RenderGraphContext
{
	public ScriptableRenderContext renderContext;

	public CommandBuffer cmd;

	public RenderGraphObjectPool renderGraphPool;

	public RenderGraphDefaultResources defaultResources;
}
