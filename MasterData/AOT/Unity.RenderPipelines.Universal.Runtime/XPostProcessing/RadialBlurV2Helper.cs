using UnityEngine;
using UnityEngine.Rendering;

namespace XPostProcessing;

[ExecuteAlways]
public class RadialBlurV2Helper : MonoBehaviour
{
	public bool alwaysUpdate;

	public Volume volume;

	private void OnEnable()
	{
		UpdateCenter();
	}

	private void Update()
	{
		if (alwaysUpdate)
		{
			UpdateCenter();
		}
	}

	private void UpdateCenter()
	{
		if (volume.profile.TryGet<RadialBlurV2>(out var component))
		{
			Vector3 vector = Camera.main.WorldToViewportPoint(transform.position);
			component.SetCenter(vector.x, vector.y);
		}
	}
}
