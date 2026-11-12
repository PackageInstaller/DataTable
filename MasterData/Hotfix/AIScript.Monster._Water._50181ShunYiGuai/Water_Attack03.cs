using System.Collections;

namespace AIScript.Monster._Water._50181ShunYiGuai;

public class Water_Attack03 : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Attack03 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.C };

	private LogicEntity Targetenemy;

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Attack03, flushInputedKeys: true, forceInterruptAttack: true);
		GetEnemy();
		BeginLookAt_NotWait(Targetenemy, 4, 240);
		yield return WaitCustomEvent("Fire");
		UseMonsterCloneActorCastSkill(5018130);
		yield return WaitCustomEvent("FireEnd");
		CancelAttack();
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
