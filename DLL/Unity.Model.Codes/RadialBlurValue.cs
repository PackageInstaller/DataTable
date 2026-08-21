using UnityEngine;
using UnityEngine.Rendering;

public class RadialBlurValue : MonoBehaviour
{
	public Volume postProcessingVolume;

	[Range(0f, 10f)]
	[Tooltip("模糊半径")]
	public float RadialBlurRange;

	private RadialBlurVolume radialblur;

	private void Start()
	{
		if (!(postProcessingVolume == null) && postProcessingVolume.profile.TryGet<RadialBlurVolume>(out radialblur))
		{
			radialblur.active = true;
			radialblur.BlurRange.value = 0f;
		}
	}

	private void Update()
	{
		radialblur.BlurRange.value = RadialBlurRange;
	}
}
