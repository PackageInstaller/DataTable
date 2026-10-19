using UnityEngine;

namespace ACT.DialogueSystem;

public class ExitGlobalBlackScreenNode : DialogueNode
{
	[Header("黑屏淡出速度")]
	public float speed = 1f;

	[Header("等待黑屏淡出结束")]
	public bool waitOut = true;
}
