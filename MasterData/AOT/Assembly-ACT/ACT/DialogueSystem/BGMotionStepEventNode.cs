using UnityEngine;

namespace ACT.DialogueSystem;

public class BGMotionStepEventNode : ChatStepEventNode
{
	public ChatStep step = ChatStep.OnShowDialogue;

	[Header("等待结束")]
	public bool waitEnd;

	[Header("缩放尺寸")]
	public float bgScale = 1f;

	[Header("缩放锚点(没用了)")]
	public Vector2 bgScaleAnchor = new Vector2(0.5f, 0.5f);

	[Header("位移")]
	public Vector2 bgOffset = new Vector2(0f, 0f);

	[Header("动作时长")]
	public float bgMotionDuration;

	[Header("曲线")]
	public UIConversationScene.BgMotionEase ease;
}
