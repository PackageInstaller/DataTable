using UnityEngine.Scripting;

namespace UnityEngine.Rendering;

[RequiredByNativeCode]
public class OnDemandRendering
{
	private static int m_RenderFrameInterval = 1;

	public static int renderFrameInterval => m_RenderFrameInterval;

	[RequiredByNativeCode]
	internal static void GetRenderFrameInterval(out int frameInterval)
	{
		frameInterval = renderFrameInterval;
	}
}
