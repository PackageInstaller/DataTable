namespace UnityEngine.Rendering.Universal;

public static class ComponentUtility
{
	public static bool IsUniversalCamera(Camera camera)
	{
		return camera.GetComponent<UniversalAdditionalCameraData>() != null;
	}

	public static bool IsUniversalLight(Light light)
	{
		return light.GetComponent<UniversalAdditionalLightData>() != null;
	}
}
