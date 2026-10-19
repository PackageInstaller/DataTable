using UnityEngine;

namespace ACT.DialogueSystem;

public class ShakeStepEventNode : ChatStepEventNode
{
	public ChatStep step = ChatStep.OnShowDialogue;

	[Header("等待结束")]
	public bool waitEnd;

	[Header("句子结束时清理震动")]
	public bool finishOnExit = true;

	[Header("震动时间")]
	public float duration;

	[Header("震动强度")]
	public Vector2 strength = new Vector2(0.2f, 0.2f);

	[Header("震动频率")]
	public int vibrato = 10;
}
