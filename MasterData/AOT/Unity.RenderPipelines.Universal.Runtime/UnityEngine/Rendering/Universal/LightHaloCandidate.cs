namespace UnityEngine.Rendering.Universal;

internal readonly struct LightHaloCandidate
{
	internal readonly LightHalo haloData;

	internal readonly int visibleLightIndex;

	internal readonly Vector3 position;

	internal readonly Vector3 forward;

	internal readonly LightType lightType;

	internal LightHaloCandidate(LightHalo haloData, int visibleLightIndex, Vector3 position, Vector3 forward, LightType lightType)
	{
		this.haloData = haloData;
		this.visibleLightIndex = visibleLightIndex;
		this.position = position;
		this.forward = forward;
		this.lightType = lightType;
	}
}
