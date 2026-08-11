using UnityEngine;

namespace Ase;

public enum EntityType : byte
{
	Unknown,
	[InspectorName("Hero")]
	HERO,
	[InspectorName("Monster")]
	MONSTER,
	[InspectorName("子弹")]
	BULLET,
	[InspectorName("NPC")]
	NPC,
	[InspectorName("交互物")]
	INTERACTIVE,
	[InspectorName("副本交互物")]
	BATTLEINTERACTIVE,
	[InspectorName("特效")]
	EFFECT,
	[InspectorName("战斗实体")]
	BATTLEENTITY,
	[InspectorName("召唤物")]
	SummonedEntity
}
