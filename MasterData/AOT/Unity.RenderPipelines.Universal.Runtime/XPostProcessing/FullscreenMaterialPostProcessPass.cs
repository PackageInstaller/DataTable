using System.Collections.Generic;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

namespace XPostProcessing;

internal static class FullscreenMaterialPostProcessPass
{
	private const string ProfilerTag = "FullscreenMaterialPostProcess";

	internal static bool RenderBeforeUberPost(ref ScriptableRenderContext context, CommandBuffer cmd, UniversalRenderer renderer, ref RenderTargetIdentifier source, ref RenderTargetIdentifier destination)
	{
		List<FullscreenMaterialPostProcessController> activeControllers = FullscreenMaterialPostProcessRuntime.GetActiveControllers();
		if (activeControllers.Count == 0)
		{
			return false;
		}
		cmd.BeginSample("FullscreenMaterialPostProcess");
		bool result = false;
		for (int i = 0; i < activeControllers.Count; i++)
		{
			FullscreenMaterialPostProcessController fullscreenMaterialPostProcessController = activeControllers[i];
			if (!(fullscreenMaterialPostProcessController == null) && !(fullscreenMaterialPostProcessController.Material == null))
			{
				fullscreenMaterialPostProcessController.ApplyWeightProperty();
				cmd.Blit(source, destination, fullscreenMaterialPostProcessController.Material, fullscreenMaterialPostProcessController.PassIndex);
				result = true;
				renderer.SwapColorBuffer();
				source = renderer.cameraColorTarget;
				destination = renderer.GetCameraColorFrontBuffer(cmd);
			}
		}
		cmd.EndSample("FullscreenMaterialPostProcess");
		context.ExecuteCommandBuffer(cmd);
		cmd.Clear();
		return result;
	}
}
