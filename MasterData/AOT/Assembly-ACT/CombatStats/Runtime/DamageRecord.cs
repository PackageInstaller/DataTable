using System;

namespace CombatStats.Runtime;

[Serializable]
public sealed class DamageRecord
{
	public int CharacterId;

	public int SkillId;

	public long DamageValue;

	public bool IsCrit;

	public float Timestamp;
}
