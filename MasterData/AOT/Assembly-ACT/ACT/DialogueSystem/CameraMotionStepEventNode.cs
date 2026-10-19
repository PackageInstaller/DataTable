using UnityEngine;

namespace ACT.DialogueSystem;

public class CameraMotionStepEventNode : ChatStepEventNode
{
	public ChatStep step = ChatStep.OnShowDialogue;

	[Header("等待结束")]
	public bool waitEnd;

	[Header("画面缩放(1 为初始画面，2 为两倍放大)")]
	[Min(0.01f)]
	public float fovScale = 1f;

	[Header("位移(画面宽高百分比)")]
	public Vector2 cameraOffset = Vector2.zero;

	[Header("动作时长")]
	[Min(0f)]
	public float cameraMotionDuration;

	[Header("曲线")]
	public UIConversationScene.BgMotionEase ease;
}
