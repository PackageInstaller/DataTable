namespace UnityEngine.Rendering.Universal;

internal static class RenderPassScheduleModeUtility
{
	internal static bool IsMobile(UniversalRenderer renderer = null)
	{
		UniversalRenderPipelineAsset asset = UniversalRenderPipeline.asset;
		if (asset != null)
		{
			return asset.actualRenderPassScheduleMode == RenderPassScheduleMode.Mobile;
		}
		if (renderer != null)
		{
			return renderer.renderPassScheduleMode == RenderPassScheduleMode.Mobile;
		}
		return false;
	}
}
