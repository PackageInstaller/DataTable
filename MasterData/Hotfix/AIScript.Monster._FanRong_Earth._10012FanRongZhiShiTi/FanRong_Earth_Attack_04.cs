using System.Collections;

namespace AIScript.Monster._FanRong_Earth._10012FanRongZhiShiTi;

public class FanRong_Earth_Attack_04 : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] Attack01 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.D };

	private LogicEntity Targetenemy;

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Attack01, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent("T1");
		GetEnemy();
		BeginLookAt_NotWait(Targetenemy, 0.25, 260);
		yield return WaitCustomEvent("T2");
		StopWaitLookAt();
		yield return WaitCustomEvent("C1");
		CancelAttack();
		yield return WaitCustomEvent("T3");
		if (CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) > -90 && CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) < 0)
		{
			GetEnemy();
			BeginLookAt_NotWait(Targetenemy, 0.25, 200);
		}
		else if (CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) >= 0 && CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) <= 90)
		{
			BeginRotateAngle(-1, 450);
		}
		else
		{
			BeginRotateAngle(-100, 450);
		}
		yield return WaitCustomEvent("T4");
		StopWaitLookAt();
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
