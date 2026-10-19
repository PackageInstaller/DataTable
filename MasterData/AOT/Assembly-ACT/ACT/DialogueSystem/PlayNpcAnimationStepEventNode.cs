using UnityEngine;

namespace ACT.DialogueSystem;

public class PlayNpcAnimationStepEventNode : ChatStepEventNode
{
	public enum ActionType
	{
		[InspectorName("直接播放指定状态")]
		AnimationName,
		[InspectorName("设置Bool参数")]
		Bool,
		[InspectorName("设置Int参数")]
		Int,
		[InspectorName("设置Float参数")]
		Float,
		[InspectorName("设置Trigger")]
		Trigger
	}

	public int npcId;

	public ActionType type;

	public string animationName;

	public bool boolValue;

	public float floatValue;

	public int intValue;
}
