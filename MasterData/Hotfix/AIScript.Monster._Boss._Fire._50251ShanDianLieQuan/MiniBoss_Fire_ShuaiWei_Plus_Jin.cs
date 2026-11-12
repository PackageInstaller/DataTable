using System.Collections;

namespace AIScript.Monster._Boss._Fire._50251ShanDianLieQuan;

public class MiniBoss_Fire_ShuaiWei_Plus_Jin : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] Attack01 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.A,
		ComboInputBuffer.ActionKey._1
	};

	private readonly ComboInputBuffer.ActionKey[] Move = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.M };

	private LogicEntity Targetenemy;

	protected override IEnumerator DoMainLogic()
	{
		if (CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) > -15 && CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) < 15)
		{
			BeginAttack(1, Attack01, flushInputedKeys: true, forceInterruptAttack: true);
			yield return WaitCustomEvent("T1");
			GetEnemy();
			BeginLookAt_NotWait(Targetenemy, 0.3, 100);
			yield return WaitCustomEvent("T2");
			StopWaitLookAt();
			yield return WaitCustomEvent("C1");
			CancelAttack();
		}
		else
		{
			BeginAttack(1, Move, flushInputedKeys: true, forceInterruptAttack: true);
			GetEnemy();
			BeginLookAt(Targetenemy, 0.3, 240);
			BeginAttack(2, Attack01, flushInputedKeys: true, forceInterruptAttack: true);
			yield return WaitCustomEvent("T1");
			GetEnemy();
			BeginLookAt_NotWait(Targetenemy, 0.3, 200);
			yield return WaitCustomEvent("T2");
			StopWaitLookAt();
			yield return WaitCustomEvent("C1");
			CancelAttack();
		}
		yield return WaitCustomEvent("T3");
		if (CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) > -180 && CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) < -90)
		{
			BeginRotateAngle(180, 1000);
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
