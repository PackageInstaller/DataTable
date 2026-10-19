using UnityEngine;

namespace ACT.DialogueSystem;

public class HideBgNode : ChatStepEventNode
{
	public ChatStep step = ChatStep.OnShowDialogue;

	[Header("背景消失速度")]
	public float speed = 1f;

	[Header("等背景完全消失")]
	public bool wait;
}
