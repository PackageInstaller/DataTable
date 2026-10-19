using UnityEngine;

namespace ACT.Core;

public enum CharacterDamageType
{
	Null,
	[Tooltip("强袭")]
	Striker,
	[Tooltip("攻坚")]
	Breaker,
	[Tooltip("辅助")]
	AssistStriker
}
