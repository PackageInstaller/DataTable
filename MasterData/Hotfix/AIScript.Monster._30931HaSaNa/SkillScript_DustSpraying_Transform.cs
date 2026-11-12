using System.Collections;
using TrueSync;

namespace AIScript.Monster._30931HaSaNa;

public class SkillScript_DustSpraying_Transform : SkillScript_TransformBase
{
	private readonly string comboTag = "ShaJuRen_Attack_3";

	private readonly FP duration = 0.75;

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, comboTag, flushInputedKeys: true);
		BeginLookAtMonsterTarget(1.5, 180);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		yield return WaitTime(duration);
		BeginLookAtMonsterTarget(0.15, 800);
		CancelAttack();
		yield return WaitTime(0.1);
		BeginAttack(2, "ShaJuRen_Attack_3_Fast", flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		yield return WaitTime(duration);
		BeginLookAtMonsterTarget(0.15, 800);
		CancelAttack();
		yield return WaitTime(0.1);
		BeginAttack(3, "ShaJuRen_Attack_3_Fast", flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		yield return WaitTime(duration);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
