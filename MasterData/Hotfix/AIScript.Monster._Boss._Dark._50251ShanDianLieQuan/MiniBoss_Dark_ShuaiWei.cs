using System.Collections;

namespace AIScript.Monster._Boss._Dark._50251ShanDianLieQuan;

public class MiniBoss_Dark_ShuaiWei : SkillSimpleBase
{
	private readonly string ShuaiWei = "ShuaiWei";

	private readonly ComboInputBuffer.ActionKey[] Move = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.M };

	private LogicEntity Targetenemy;

	protected override IEnumerator DoMainLogic()
	{
		if (CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) > -15 && CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) < 15)
		{
			BeginAttack(1, ShuaiWei, flushInputedKeys: true, forceInterruptAttack: true);
			yield return WaitCustomEvent("T1");
			GetEnemy();
			BeginLookAt_NotWait(Targetenemy, 0.2, 100);
			yield return WaitCustomEvent("T2");
			StopWaitLookAt();
			yield return WaitCustomEvent("C1");
			CancelAttack();
		}
		else
		{
			BeginAttack(1, Move, flushInputedKeys: true, forceInterruptAttack: true);
			GetEnemy();
			yield return BeginLookAt(Targetenemy, 0.3, 240);
			BeginAttack(2, ShuaiWei, flushInputedKeys: true, forceInterruptAttack: true);
			yield return WaitCustomEvent("T1");
			GetEnemy();
			BeginLookAt_NotWait(Targetenemy, 0.2, 200);
			yield return WaitCustomEvent("T2");
			StopWaitLookAt();
			yield return WaitCustomEvent("C1");
			CancelAttack();
		}
		yield return WaitCustomEvent("T3");
		if (CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) > -180 && CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) < -90)
		{
			BeginRotateAngle(180, 800);
		}
		else
		{
			GetEnemy();
			BeginLookAt_NotWait(Targetenemy, 0.4, 720);
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
