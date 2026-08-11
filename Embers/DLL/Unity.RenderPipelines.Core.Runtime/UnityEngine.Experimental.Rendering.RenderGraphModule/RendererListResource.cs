using UnityEngine.Rendering.RendererUtils;

namespace UnityEngine.Experimental.Rendering.RenderGraphModule;

internal struct RendererListResource
{
	public UnityEngine.Rendering.RendererUtils.RendererListDesc desc;

	public UnityEngine.Rendering.RendererUtils.RendererList rendererList;

	internal RendererListResource(in UnityEngine.Rendering.RendererUtils.RendererListDesc desc)
	{
		this.desc = desc;
		rendererList = default(UnityEngine.Rendering.RendererUtils.RendererList);
	}
}
