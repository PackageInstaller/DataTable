using UnityEngine;

namespace ACT.DialogueSystem;

public class BlackScreenNode : DialogueNode
{
	public long key;

	[Header("黑屏文字内容")]
	[TextArea(8, 8)]
	public string text;

	[Header("黑屏淡入淡出速度")]
	public float speed = 1f;

	[Header("黑屏持续时间(s)")]
	public float duration = 2f;

	[Header("等待黑屏淡出结束")]
	public bool waitOut = true;
}
