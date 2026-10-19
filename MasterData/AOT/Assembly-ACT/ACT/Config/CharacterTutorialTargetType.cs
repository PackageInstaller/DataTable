using UnityEngine;

namespace ACT.Config;

public enum CharacterTutorialTargetType
{
	[InspectorName("配置角色Id")]
	ConfigCharacterId,
	[InspectorName("副本首个试用角色")]
	RaidFirstTryRole,
	[InspectorName("当前操控角色")]
	CurrentControlled,
	[InspectorName("队伍槽位")]
	TeamSlot,
	[InspectorName("任意队伍成员")]
	AnyTeamMember
}
