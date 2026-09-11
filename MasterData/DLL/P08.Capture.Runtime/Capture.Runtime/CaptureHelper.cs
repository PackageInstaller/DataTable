namespace Capture.Runtime;

public class CaptureHelper
{
	public static string CaptureScene = "Levels/Capture";

	public static string CameraController = "CaptureGame/Logic/CameraController";

	public static string RoleInstPath = "CaptureGame/Char/{0}_capture_tpose";

	public static string PlaceHolderInstPath = "CaptureGame/Placeholder/Holder";

	public static StageSerializeOptions StageDataSerializeOption = StageSerializeOptions.Json;

	public static ICaptureStageSerializer GetStageSerializer()
	{
		_ = StageDataSerializeOption;
		_ = 1;
		return new JsonSerializerHandler();
	}

	public static string GetStageFileNameByStageId(int stageId)
	{
		return "Capture02_Multi";
	}
}
