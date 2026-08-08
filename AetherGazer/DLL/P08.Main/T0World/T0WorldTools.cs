namespace T0World;

public static class T0WorldTools
{
	private static int characterID => T0WorldScene.Scene.characterID;

	public static string CaptureAssetPath => $"T0World/Data/{characterID}/{characterID}_Capture_Data";

	public static string MapAssetPath => $"T0World/Data/{characterID}/{characterID}_Map_Data";

	public static string MainModelAssetPath => $"T0World/Model/{characterID}/{characterID}_Main_Charater";

	public static string CaptureModelAssetPath => $"T0World/Model/{characterID}/{characterID}_Capture_Charater";

	public static string PlayerAssetPath => $"T0World/Prefab/{characterID}/T0WorldPlayer";

	public static string PlayerCameraAssetPath => $"T0World/Prefab/{characterID}/T0WorldCamera";

	public static string CaptureFilterAssetPath => $"T0World/Filter/{characterID}/CaptureFilterContent";

	public static string GetFaceAssetPath(string faceName)
	{
		return $"T0World/FaceTimeline/{characterID}/{faceName}";
	}

	public static bool IsNeedStopManualAnimator()
	{
		if (characterID == 108502)
		{
			return true;
		}
		return false;
	}
}
