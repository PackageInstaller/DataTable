using System.Collections;

namespace AIScript.Monster.TowerDefense.Skill;

public class Skill_ChuanSongGuai_WeightUp : SkillSimpleBase
{
	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, "Skill", flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		PlayAreaEffect("Area", GetPosition(), GetRotation());
		yield return WaitTime(2);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnSkillDisable()
	{
	}

	protected override void OnInterrupt(int comboIndex)
	{
		base.OnInterrupt(comboIndex);
		_skill?.Clear();
	}
}
