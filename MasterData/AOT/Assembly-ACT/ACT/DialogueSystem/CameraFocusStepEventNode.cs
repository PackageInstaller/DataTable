namespace ACT.DialogueSystem;

public class CameraFocusStepEventNode : ChatStepEventNode
{
	public ChatStep step = ChatStep.OnBeforeShowDialogue;

	public DialogueEnvironmentCameraStateType cameraFocusType;

	public string key;
}
