using UnityEngine;

namespace ACT.DialogueSystem;

public class ColorScreenNode : DialogueNode
{
	[Header("开关")]
	public bool active = true;

	[Header("颜色")]
	public Color color = Color.black;

	[Header("渐入渐出速度")]
	public float speed = 1f;
}
