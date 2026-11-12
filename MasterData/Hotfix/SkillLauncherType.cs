using UnityEngine;

public enum SkillLauncherType
{
	[InspectorName("角色")]
	Character,
	[InspectorName("怪物")]
	Monster,
	[InspectorName("技能")]
	Skill,
	[InspectorName("效果")]
	Effect,
	[InspectorName("虚拟角色")]
	FakeActor,
	[InspectorName("动态角色")]
	DynamicActor
}
