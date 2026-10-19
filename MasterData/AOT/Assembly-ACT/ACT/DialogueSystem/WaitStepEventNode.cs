using UnityEngine;

namespace ACT.DialogueSystem;

public class WaitStepEventNode : ChatStepEventNode
{
	public ChatStep step = ChatStep.OnShowDialogue;

	[Header("等待时间")]
	public float duration;
}
