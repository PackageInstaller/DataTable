using System.Collections;
using System.Collections.Generic;

namespace AIScript.Monster._10501BanShenShu;

public class Skill_CallMonster : SkillSimpleBase
{
	private readonly int ActionIndex;

	private readonly string AttackAction = "GeneralAttack";

	private List<long> FxSpawn = new List<long>();

	protected override void OnSkillDisable()
	{
		for (int i = 0; i < FxSpawn.Count; i++)
		{
			StopEffect(FxSpawn.get_Item(i));
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(ActionIndex, AttackAction, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		UseMonsterCloneActorCastSkill(1050131);
		TriggerOpLisener("Bubble3");
		yield return WaitTime(2);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
