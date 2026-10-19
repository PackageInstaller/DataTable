using UnityEngine;

namespace ACT.DialogueSystem;

public class ShowCenterTextNode : DialogueNode
{
	public int index;

	[Header("显示速度")]
	public float speed = 0.5f;

	[Header("是否可以自动下一句")]
	public bool autoNext = true;

	[Header("自动下一句的延迟(若自动播放), <0默认0.5")]
	public float autoNextDelay = 0.5f;
}
