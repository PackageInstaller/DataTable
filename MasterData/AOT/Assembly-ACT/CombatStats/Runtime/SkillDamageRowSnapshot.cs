using System;

namespace CombatStats.Runtime;

[Serializable]
public sealed class SkillDamageRowSnapshot
{
	public int CharacterId;

	public int SkillId;

	public string SkillDisplayName;

	public long TotalDamage;

	public int HitCount;

	public int CritCount;

	public float CritRate;

	public float DamageShare;

	public int DamageType;

	public float DamageShareOfTop;
}
