using System.Collections;
using TrueSync;

namespace AIScript.Monster._50020ShaYuFaShi;

public class Skill_Circle_Tutorial : SkillSimpleBase
{
	protected override void OnSkillEnable()
	{
		SetImmuneControlEnable();
	}

	protected override void OnSkillDisable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		LogicEntity target = GetCurrentPlayer();
		yield return WaitTime(1);
		BeginAttack(1, "Skill", flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		while (GetBuffFromTarget(target, 911210210).Count > 0)
		{
			PlayAreaEffect("AreaEffect_Meteor", GetEntityPositionObsoleted(target), 0);
			Skill_Circle_Tutorial skill_Circle_Tutorial = this;
			TSVector2 entityPositionObsoleted = GetEntityPositionObsoleted(target);
			skill_Circle_Tutorial.PlayEarlyWarningEffect("fx_common_base_Dark_YuJing_circular_2", 0.9f, default, entityPositionObsoleted);
			yield return WaitTime(1.2);
		}
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
		while (GetBuffFromTarget(target, 911210220).Count > 0)
		{
			yield return null;
		}
		BeginAttack(1, "Skill", flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		while (GetBuffFromTarget(target, 911210210).Count > 0)
		{
			PlayAreaEffect("AreaEffect_Meteor", GetEntityPositionObsoleted(target), 0);
			Skill_Circle_Tutorial skill_Circle_Tutorial2 = this;
			TSVector2 entityPositionObsoleted = GetEntityPositionObsoleted(target);
			skill_Circle_Tutorial2.PlayEarlyWarningEffect("fx_common_base_Dark_YuJing_circular_2", 0.9f, default, entityPositionObsoleted);
			yield return WaitTime(0.35);
		}
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
