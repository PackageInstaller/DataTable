using System.Diagnostics;

namespace UnityEngine.Experimental.Rendering.RenderGraphModule;

[DebuggerDisplay("Resource ({GetType().Name}:{GetName()})")]
internal abstract class RenderGraphResource<DescType, ResType> : IRenderGraphResource where DescType : struct where ResType : class
{
	public DescType desc;

	public ResType graphicsResource;

	public override void Reset(IRenderGraphResourcePool pool)
	{
		base.Reset(pool);
		graphicsResource = null;
	}

	public override bool IsCreated()
	{
		return graphicsResource != null;
	}

	public override void ReleaseGraphicsResource()
	{
		graphicsResource = null;
	}
}
