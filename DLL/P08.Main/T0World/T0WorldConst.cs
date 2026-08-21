namespace T0World;

public static class T0WorldConst
{
	public enum SDKInterationTypeEnum
	{
		ENTER_SCENE = 1,
		EXIT_SCENE = 2,
		INTERATION = 4,
		ENTER_CAPTURE = 5,
		HIDE_UI = 6,
		SHOW_UI = 7,
		SCENE_CHANGE = 8,
		EXPAND_INTERATION = 9,
		EXIT_CURRENT = 10
	}

	public enum SDKCaptureTypeEnum
	{
		CAPTURE = 1,
		EXIT_CAPTURE
	}

	public enum T0characterIDEnum
	{
		SKULD = 108502,
		HORUS = 104402
	}

	public const string faceAssetPath = "T0World/FaceTimeline/{0}/{1}";

	public const string captureAssetPath = "T0World/Data/{0}/{1}_Capture_Data";

	public const string mapAssetPath = "T0World/Data/{0}/{1}_Map_Data";

	public const string mainModelAssetPath = "T0World/Model/{0}/{1}_Main_Charater";

	public const string captureModelAssetPath = "T0World/Model/{0}/{1}_Capture_Charater";

	public const string playerAssetPath = "T0World/Prefab/{0}/T0WorldPlayer";

	public const string playerCameraAssetPath = "T0World/Prefab/{0}/T0WorldCamera";

	public const string captureFilterAssetPath = "T0World/Filter/{0}/CaptureFilterContent";

	public const string captureSurpriseBeginStateKey = "CaptureSurpriseBeginState";

	public const string captureSurpriseEndStateKey = "captureSurpriseEndStateKey";

	public const string captureSurpriseCountKey = "CaptureCount";

	public const int captureSurpriseCount = 3;

	public const int adminEntityID = -1;

	public const int NULL_ENTITY_ID = -2;

	public const string luaRecordSDKInterationFuncName = "RecordT0WorldInterationSDK";

	public const string luaRecordSDKCaptureFuncName = "RecordT0WorldCaptureSDK";

	public const string luaViewControllerChangeFuncName = "T0WorldViewControllerModeChange";

	public const string Lua_CheckConditionFunction = "T0WorldCheckConditionMeet";

	public const string Lua_EmitterEventFunction = "T0WorldEmitterEvent";

	public const string Lua_SetHelpKeyFunction = "T0_WORLD_SET_HELP_KEY";
}
