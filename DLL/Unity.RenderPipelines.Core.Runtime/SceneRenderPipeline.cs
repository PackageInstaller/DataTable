using UnityEngine;
using UnityEngine.Rendering;

[ExecuteAlways]
public class SceneRenderPipeline : MonoBehaviour
{
	public RenderPipelineAsset renderPipelineAsset;

	private void OnEnable()
	{
		GraphicsSettings.renderPipelineAsset = renderPipelineAsset;
	}

	private void OnValidate()
	{
		GraphicsSettings.renderPipelineAsset = renderPipelineAsset;
	}
}
