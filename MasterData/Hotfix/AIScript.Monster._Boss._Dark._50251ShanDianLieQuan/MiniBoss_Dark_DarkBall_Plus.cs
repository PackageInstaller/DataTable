using System.Collections;
using TrueSync;

namespace AIScript.Monster._Boss._Dark._50251ShanDianLieQuan;

public class MiniBoss_Dark_DarkBall_Plus : SkillSimpleBase
{
	private readonly string Charge = "DarkBall_Charge";

	private readonly string Fire = "DarkBall_Fire";

	private readonly ComboInputBuffer.ActionKey[] Move = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.M };

	private LogicEntity Targetenemy;

	private string DarkBall;

	protected override void OnSkillEnable()
	{
		if (GetMonsterTagValue(_actor, 1) == "Hard")
		{
			DarkBall = "Bullet_50251_MiniBoss_Dark_01";
		}
		else
		{
			DarkBall = "Bullet_50251_MiniBoss_Dark_02";
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		GetEnemy();
		if (CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) < -15 || CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) > 15)
		{
			BeginAttack(1, Move, flushInputedKeys: true, forceInterruptAttack: true);
			yield return BeginLookAt(Targetenemy, 0.5, 360);
		}
		BeginAttack(2, Charge, flushInputedKeys: true, forceInterruptAttack: true);
		BeginLookAt_NotWait(Targetenemy, 3, 240);
		yield return WaitTime(1.7);
		StopLookAt();
		BeginAttack(3, Fire, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent("Fire");
		DarkBallFire();
		CancelAttack();
		yield return WaitCustomEvent("T1");
		BeginLookAt_NotWait(Targetenemy, 1, 360);
		yield return WaitCustomEvent("T2");
		StopLookAt();
		yield return WaitCombo(ComboAttackType.isComboFinish);
		BeginAttack(3, Move, flushInputedKeys: true, forceInterruptAttack: true);
		GetEnemy();
		yield return BeginLookAt(Targetenemy, 1, 60);
	}

	private void GetEnemy()
	{
		Targetenemy = GetAttackTarget();
		if (Targetenemy == null)
		{
			Targetenemy = GetCurrentPlayer();
		}
	}

	private void DarkBallFire()
	{
		Shoot(DarkBall, TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 2.5)), 1, 0, GetForward(), AimType.Position);
	}
}
