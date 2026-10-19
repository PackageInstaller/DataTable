using System.Collections.Generic;

namespace CombatStats.Runtime;

public sealed class CharacterStatsAggregate
{
	public int CharacterId { get; }

	public long TotalDamage { get; private set; }

	public int HitCount { get; private set; }

	public int CritCount { get; private set; }

	public float FieldTime { get; private set; }

	public Dictionary<int, SkillStatsAggregate> Skills { get; } = new Dictionary<int, SkillStatsAggregate>();

	public CharacterStatsAggregate(int characterId)
	{
		CharacterId = characterId;
	}

	public void Add(DamageRecord record)
	{
		TotalDamage += record.DamageValue;
		HitCount++;
		if (record.IsCrit)
		{
			CritCount++;
		}
		if (!Skills.TryGetValue(record.SkillId, out var value))
		{
			value = new SkillStatsAggregate(record.SkillId);
			Skills.Add(record.SkillId, value);
		}
		value.Add(record);
	}

	public void AddFieldTime(float time)
	{
		FieldTime += time;
	}
}
