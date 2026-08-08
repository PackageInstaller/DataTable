namespace UnityEngine.Rendering;

internal static class CameraEventUtils
{
	public static bool IsValid(CameraEvent value)
	{
		return value >= CameraEvent.BeforeDepthTexture && value <= CameraEvent.AfterHaloAndLensFlares;
	}
}
