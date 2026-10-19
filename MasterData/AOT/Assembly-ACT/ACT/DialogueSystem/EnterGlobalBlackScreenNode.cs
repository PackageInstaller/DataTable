using UnityEngine;

namespace ACT.DialogueSystem;

public class EnterGlobalBlackScreenNode : DialogueNode
{
	[Header("黑屏淡入速度")]
	public float speed = 1f;

	[Header("必定执行")]
	public bool mustDo = true;
}
