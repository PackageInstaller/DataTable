using System.Collections;
using TrueSync;

namespace AIScript.Monster._73001KuiLeiShi;

public class Skill_HealAura_10_1 : SkillSimpleBase
{
	private LogicEntity Targetenemy;

	private readonly string combo_key1 = "Buff";

	private string tag1 = "Mark1";

	private string tag2 = "Mark2";

	private string tag3 = "Mark3";

	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		GetEnemy();
		BeginLookAt_NotWait(Targetenemy, 0.5, 7200);
		yield return WaitTime(0.5);
		BeginAttack(1, combo_key1, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(0.4);
		TSVector2 entityPosition = GetEntityPosition(GetCurrentPlayer());
		string monsterTagValue = GetMonsterTagValue(_actor, 1);
		if (monsterTagValue == tag1)
		{
			SummonTeammate(2, GetPosition(), entityPosition - GetPosition());
		}
		else if (monsterTagValue == tag2)
		{
			SummonTeammate(4, GetPosition(), entityPosition - GetPosition());
		}
		else if (monsterTagValue == tag3)
		{
			SummonTeammate(5, GetPosition(), entityPosition - GetPosition());
		}
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private void GetEnemy()
	{
		Targetenemy = GetAttackTarget();
		if (Targetenemy == null)
		{
			Targetenemy = GetCurrentPlayer();
		}
	}
}
