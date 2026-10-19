namespace CombatStats.Runtime;

public sealed class SkillStatsAggregate
{
	public int SkillId { get; }

	public long TotalDamage { get; private set; }

	public int HitCount { get; private set; }

	public int CritCount { get; private set; }

	public SkillStatsAggregate(int skillId)
	{
		SkillId = skillId;
	}

	public void Add(DamageRecord record)
	{
		TotalDamage += record.DamageValue;
		HitCount++;
		if (record.IsCrit)
		{
			CritCount++;
		}
	}
}
