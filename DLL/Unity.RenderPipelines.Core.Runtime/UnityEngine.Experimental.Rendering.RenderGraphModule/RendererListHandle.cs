using System.Diagnostics;
using UnityEngine.Rendering.RendererUtils;

namespace UnityEngine.Experimental.Rendering.RenderGraphModule;

[DebuggerDisplay("RendererList ({handle})")]
public struct RendererListHandle
{
	private bool m_IsValid;

	internal int handle { get; private set; }

	internal RendererListHandle(int handle)
	{
		this.handle = handle;
		m_IsValid = true;
	}

	public static implicit operator int(RendererListHandle handle)
	{
		return handle.handle;
	}

	public static implicit operator UnityEngine.Rendering.RendererUtils.RendererList(RendererListHandle rendererList)
	{
		if (!rendererList.IsValid())
		{
			return UnityEngine.Rendering.RendererUtils.RendererList.nullRendererList;
		}
		return RenderGraphResourceRegistry.current.GetRendererList(in rendererList);
	}

	public bool IsValid()
	{
		return m_IsValid;
	}
}
