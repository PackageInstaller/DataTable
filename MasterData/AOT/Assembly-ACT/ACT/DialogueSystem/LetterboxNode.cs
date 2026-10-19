using UnityEngine;

namespace ACT.DialogueSystem;

public class LetterboxNode : DialogueNode
{
	[Header("上")]
	public bool showTop = true;

	[Range(0f, 100f)]
	public float topPercent = 20f;

	[Header("下")]
	public bool showBottom = true;

	[Range(0f, 100f)]
	public float bottomPercent = 20f;

	[Header("动画设置")]
	public float fadeInTime = 1f;

	public float fadeOutTime = 1f;

	public bool wait = true;
}
