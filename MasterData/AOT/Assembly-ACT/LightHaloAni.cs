using UnityEngine;
using UnityEngine.Rendering.Universal;

[ExecuteAlways]
public class LightHaloAni : MonoBehaviour
{
	[Range(0f, 2f)]
	public float HaloIntensity;

	private UniversalAdditionalLightData LightData;

	private void OnEnable()
	{
		LightData = GetComponent<UniversalAdditionalLightData>();
	}

	private void Update()
	{
		LightData.ACT_LightHalos.Intensity = HaloIntensity;
	}
}
