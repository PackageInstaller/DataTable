using UnityEngine;
using UnityEngine.Rendering;

namespace Yarn.Unity;

[ExecuteInEditMode]
public class SampleRenderDetector : MonoBehaviour
{
	private void Awake()
	{
		if ((bool)GraphicsSettings.renderPipelineAsset)
		{
			Debug.LogWarning("These samples were created using the built in render pipeline, things will not appear correctly. You should upgrade the materials to be compatible.");
		}
	}
}
