using System.Collections;

namespace AIScript.Monster._Boss._Fire._50251ShanDianLieQuan;

public class MiniBoss_Fire_ShuaiWei_Plus_Yuan : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] Attack01 = new ComboInputBuffer.ActionKey[3]
	{
		ComboInputBuffer.ActionKey.A,
		ComboInputBuffer.ActionKey._2,
		ComboInputBuffer.ActionKey._1
	};

	private readonly ComboInputBuffer.ActionKey[] Attack02 = new ComboInputBuffer.ActionKey[3]
	{
		ComboInputBuffer.ActionKey.A,
		ComboInputBuffer.ActionKey._2,
		ComboInputBuffer.ActionKey._2
	};

	private readonly ComboInputBuffer.ActionKey[] Attack03 = new ComboInputBuffer.ActionKey[3]
	{
		ComboInputBuffer.ActionKey.A,
		ComboInputBuffer.ActionKey._2,
		ComboInputBuffer.ActionKey._3
	};

	private long AreaEffectID;

	private LogicEntity Targetenemy;

	protected override void OnInterrupt(int comboIndex)
	{
		StopAreaEffect(AreaEffectID);
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Attack01, flushInputedKeys: true);
		yield return WaitFrame(30);
		PlayEffect("fx_m50251_base_Fire_Atk04_ElectricEnergy", 1f, 1, GetPosition(), 0, 1f, actorScale: true);
		BeginAttack(2, Attack02, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitFrame(6);
		DoDash();
		GetEnemy();
		BeginLookAt_NotWait(Targetenemy, 5, 360);
		yield return WaitDashFinish();
		CancelAttack();
		StopWaitLookAt();
		PlayEffect("fx_m50251_base_Fire_Atk04_ElectricEnergy", 1f, 1, GetPosition(), 0, 1f, actorScale: true);
		AreaEffectID = PlayAreaEffect("Area_50251_MiniBoss_Light_Skill01_Wave", GetPosition(), GetTSVectToAngle(GetForward(), 0));
		yield return WaitFrame(10);
		BeginAttack(3, Attack03, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent("Spawn");
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

	protected void DoDash()
	{
		BeginDashActorForward(1, 25, 30, 720, comboWithAttack: true, isAngle: true, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: true, triggerFriendStop: false);
	}
}
