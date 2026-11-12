using System.Collections;
using System.Collections.Generic;

namespace AIScript.Monster._70061WuYu;

public class Skill_Death : SkillSimpleBase
{
	private static readonly string DeathKey = "Death";

	private List<LogicEntity> _entities = new List<LogicEntity>();

	protected override void OnSkillEnable()
	{
		_entities.Clear();
	}

	protected override IEnumerator DoMainLogic()
	{
		SendDeclareDeadEvent();
		_entities.AddRange(GetTargetsByFaction(isFriend: true));
		if (_entities.Count > 0)
		{
			KillActors(_entities);
			_entities.Clear();
			_entities.AddRange(GetTargetsByFaction(isFriend: true));
			if (_entities.Count > 0)
			{
				ClearActors(_entities);
			}
		}
		BeginAttack(0, DeathKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
