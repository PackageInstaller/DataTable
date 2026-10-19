namespace UnityEngine.Rendering.Universal;

public static class LightExtensions
{
	public static UniversalAdditionalLightData GetUniversalAdditionalLightData(this Light light)
	{
		GameObject gameObject = light.gameObject;
		if (!gameObject.TryGetComponent<UniversalAdditionalLightData>(out var component))
		{
			return gameObject.AddComponent<UniversalAdditionalLightData>();
		}
		return component;
	}
}
