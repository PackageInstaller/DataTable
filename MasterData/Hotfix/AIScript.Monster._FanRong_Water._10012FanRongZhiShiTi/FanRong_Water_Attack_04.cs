using System.Collections;

namespace AIScript.Monster._FanRong_Water._10012FanRongZhiShiTi;

public class FanRong_Water_Attack_04 : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] Attack01 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.D };

	private readonly string Combo01 = "C1";

	private readonly string Turn01 = "T1";

	private readonly string Turn02 = "T2";

	private readonly string Turn03 = "T3";

	private readonly string Turn04 = "T4";

	private LogicEntity Targetenemy;

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Attack01, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent(Turn01);
		GetEnemy();
		BeginLookAt_NotWait(Targetenemy, 0.25, 260);
		yield return WaitCustomEvent(Turn02);
		StopWaitLookAt();
		yield return WaitCustomEvent(Combo01);
		CancelAttack();
		yield return WaitCustomEvent(Turn03);
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
		yield return WaitCustomEvent(Turn04);
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
