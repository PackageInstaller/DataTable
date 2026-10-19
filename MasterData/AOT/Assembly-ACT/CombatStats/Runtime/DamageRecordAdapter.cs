using System;
using ACT.Battle;
using Bamboo.ECS;
using UnityEngine;

namespace CombatStats.Runtime;

public sealed class DamageRecordAdapter
{
	private readonly IAttackDataAccessor accessor;

	public DamageRecordAdapter(IAttackDataAccessor accessor)
	{
		this.accessor = accessor ?? throw new ArgumentNullException("accessor");
	}

	public bool TryCreateRecord(AttackData attackData, out DamageRecord record)
	{
		record = null;
		if (attackData == null)
		{
			return false;
		}
		record = new DamageRecord
		{
			CharacterId = attackData.attacker.GetCompCharacter().characterSource.Id(),
			SkillId = attackData.skillID,
			DamageValue = Mathf.RoundToInt(attackData.damage),
			IsCrit = attackData.critical,
			Timestamp = Time.unscaledTime
		};
		return true;
	}
}
