using System;
using UnityEngine;

[Flags]
public enum SkillPhaseFeatureFlag
{
	None = 0,
	Move = 1,
	Normal = 2,
	Skill1 = 4,
	Skill2 = 8,
	Dodge = 0x10,
	Ultimate = 0x20,
	CertainSkillId = 0x40,
	[InspectorName("装弹行为")]
	LoadBullet = 0x80,
	All = Move | Normal | Skill1 | Skill2 | Dodge | Ultimate | CertainSkillId | LoadBullet
}
