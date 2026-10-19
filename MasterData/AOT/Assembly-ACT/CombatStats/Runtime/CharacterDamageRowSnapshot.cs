using System;

namespace CombatStats.Runtime;

[Serializable]
public sealed class CharacterDamageRowSnapshot
{
	public int CharacterId;

	public int CharacterNameId;

	public long TotalDamage;

	public float Dps;

	public int HitCount;

	public int CritCount;

	public float CritRate;

	public float DamageShare;

	public int DamageType;

	public float DamageShareOfTop;
}
