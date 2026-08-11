namespace UnityEngine.Rendering;

public static class XRUtils
{
	public static void DrawOcclusionMesh(CommandBuffer cmd, Camera camera, bool stereoEnabled = true)
	{
		if (XRGraphics.enabled && camera.stereoEnabled && stereoEnabled)
		{
			RectInt normalizedCamViewport = new RectInt(0, 0, camera.pixelWidth, camera.pixelHeight);
			cmd.DrawOcclusionMesh(normalizedCamViewport);
		}
	}
}
