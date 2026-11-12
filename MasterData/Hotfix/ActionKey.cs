using UnityEngine;

public enum ActionKey
{
	[InspectorName("无")]
	None,
	[InspectorName("闪避")]
	A,
	[InspectorName("技能1")]
	B,
	[InspectorName("技能2")]
	C,
	[InspectorName("大招")]
	D,
	[InspectorName("普攻")]
	Normal,
	[InspectorName("切换上一个角色")]
	SwitchPreActor,
	[InspectorName("切换下一个角色")]
	SwitchNextActor,
	[InspectorName("互动")]
	Interactive,
	[InspectorName("切换目标")]
	SwitchNextTarget,
	[InspectorName("放大招&切换上一个角色")]
	SwitchPreWithUltra,
	[InspectorName("放大招&切换下一个角色")]
	SwitchNextWithUltra
}
