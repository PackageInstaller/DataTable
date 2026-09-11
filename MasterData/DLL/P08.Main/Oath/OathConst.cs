namespace Oath;

public static class OathConst
{
	public enum OathSceneMode
	{
		CAPTURE = 1,
		OATH,
		SHARE,
		BOOK_RE
	}

	public enum OathLuaCheckCondition
	{
		OATH_MEET = 1
	}

	private const string modelAssetPath = "Oath/Model/{0}_Oath_Model";

	private const string characterDataPath = "Oath/Data/{0}/OathCharacterData";

	private const string captureDataPath = "Oath/Data/{0}/{0}_Capture_Data";

	private const string faceAssetPath = "Oath/FaceTimeline/{0}/{1}";

	private const string ringGuideAssetPath = "Widget/System/Hero_Oath/Indicator/OathIndicator_{0}";

	private const string filterPerfabPath = "Oath/Common/{0}/CaptureFilterContent";

	public const string Lua_EnterHideUIMode = "OathToLuaBridge.OathEnterCaptureHideUIMode";

	public const string Lua_CheckConditionFunction = "OathToLuaBridge.OathCheckConditionMeet";

	public const string Lua_EmitterEventFunction = "OathToLuaBridge.OathEmitterEvent";

	public const string Luat_ExitSceneFunction = "OathToLuaBridge.OathExitScene";

	public const string Lua_SendFinishOathProtoFunction = "OathToLuaBridge.OathFinsh";

	public const string LUA_RecordSDKEventFunction = "OathToLuaBridge.OathRecordSDK";

	public static string GetModelAssetPath(int charaterID)
	{
		return $"Oath/Model/{charaterID}_Oath_Model";
	}

	public static string GetCharacterDataPath(int charaterID)
	{
		return $"Oath/Data/{charaterID}/OathCharacterData";
	}

	public static string GetCaptureDataPath(int charaterID)
	{
		return string.Format("Oath/Data/{0}/{0}_Capture_Data", charaterID, charaterID);
	}

	public static string GetFaceAssetPath(int charaterID, string faceName)
	{
		return $"Oath/FaceTimeline/{charaterID}/{faceName}";
	}

	public static string GetRingGuideEffectPath(int charaterID)
	{
		return $"Widget/System/Hero_Oath/Indicator/OathIndicator_{charaterID}";
	}

	public static string GetFilterPerfabPath(int charaterID)
	{
		return $"Oath/Common/{charaterID}/CaptureFilterContent";
	}
}
