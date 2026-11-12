#define LOG_DEBUG
using System.Collections;
using TrueSync;

namespace AIScript.Monster._50601JinDuanLiRong;

public class Skill_Charge : JinDuanLiRongSkillBase
{
	private CoroutineNode DamageCor;

	private LogicEntity target;

	private FP maxSpeed;

	private FP speed;

	private FP distance;

	protected override void OnSkillEnable()
	{
		maxSpeed = 0;
		speed = 0;
		NovaLogger.Debug("禁断丽容.冲锋技能.开始");
	}

	protected override void OnSkillDisable()
	{
		StopCor(DamageCor);
		NovaLogger.Debug("禁断丽容.冲锋技能.结束");
	}

	protected override IEnumerator DoMainLogic()
	{
		if (CheckTargetIsValid(GetAttackTarget()))
		{
			target = GetAttackTarget();
		}
		else
		{
			target = GetCurrentPlayer();
		}
		BeginAttack(JinDuanLiRongSkillBase.chargeIndex, JinDuanLiRongSkillBase.chargeKey, flushInputedKeys: true, forceInterruptAttack: true);
		BeginLookAt_NotWait(target, 0.5, 360);
		if (Distance(GetPosition(), GetEntityPositionObsoleted(target)) <= 5.5)
		{
			NovaLogger.Debug("禁断丽容.冲锋技能.两者相对距离为" + Distance(GetPosition(), GetEntityPositionObsoleted(target)).ToString());
			yield return WaitCombo(ComboAttackType.isAnticipationEnd);
			yield return WaitTime(0.1);
		}
		else
		{
			NovaLogger.Debug("禁断丽容.冲锋技能.两者相对距离为" + Distance(GetPosition(), GetEntityPositionObsoleted(target)).ToString());
			yield return WaitTime(1.1);
		}
		CancelAttack();
		yield return WaitTime(0.16);
		PlayEffect(warningFx, 1f, 3, GetPosition(), default, 3f);
		yield return WaitTime(0.3);
		bool dashBranch = false;
		if (Distance(GetPosition(), GetEntityPositionObsoleted(target)) <= 5.5)
		{
			dashBranch = true;
			distance = 10;
			maxSpeed = 25;
		}
		else
		{
			distance = 27;
			maxSpeed = 40;
		}
		if (GetMonsterTagValue(_actor, 1) == "BossRush")
		{
			dashBranch = true;
			distance = 8;
			maxSpeed = 25;
		}
		DamageCor = StartCor(Damage());
		for (int i = 0; i < 11; i++)
		{
			if (i < 7)
			{
				if (dashBranch)
				{
					speed = TSMath.Clamp(speed + 8f, 0, 50);
				}
				else
				{
					speed = TSMath.Clamp(speed + 14f, 0, 80);
					BeginLookAt_NotWait(target, 0.02, 150);
				}
			}
			else if (dashBranch)
			{
				speed = TSMath.Clamp(speed - 6f, 0, 100);
			}
			else
			{
				speed = TSMath.Clamp(speed - 20f, 0, 100);
				BeginLookAt_NotWait(target, 0.02, 150);
			}
			BeginDashActorForward(10, speed, distance, 2, comboWithAttack: true, isAngle: true, notChangeForward: false, triggerObstacleStop: true, triggerEnemyStop: false, triggerFriendStop: false);
			yield return WaitTime(0.02);
			if (speed <= 0)
			{
				StopLookAt();
				StopDash();
				break;
			}
			StopDash();
			StopLookAt();
		}
		StopCor(DamageCor);
		StopDash();
		StopLookAt();
		yield return WaitTime(0.55);
		BeginLookAt_NotWait(target, 0.4, 400);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected IEnumerator Damage()
	{
		for (int i = 0; i < 10000; i++)
		{
			DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Rectangle, TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 3.5)), 2, 7, default, default, default, GetRotation());
			Skill_Charge skill_Charge = this;
			FP hitStrenth = 2;
			HitFeatureData hitFeatureData = skill_Charge.GetHitFeatureData(HitBox.FeatureFlag.None, default, default, UseAtttackForward: false, default, null, null, default, default, default, default, default, default, default, default, default, null, null, null, null, hitStrenth);
			AreaHit_Simple(_actor, shapeData, hitFeatureData, 50601087, 0.5, HitBox.HurtAnimType.Small, "fx_50601JinDuanLiRong_hit_Skill01");
			yield return WaitTime(0.05);
		}
		yield return null;
	}
}
