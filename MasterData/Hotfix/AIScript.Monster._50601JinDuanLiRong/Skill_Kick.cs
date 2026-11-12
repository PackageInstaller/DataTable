#define LOG_DEBUG
using System.Collections;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._50601JinDuanLiRong;

public class Skill_Kick : JinDuanLiRongSkillBase
{
	private FP AngleBetween;

	private CoroutineNode DamageCor;

	private LogicEntity target;

	private Dash dash;

	private readonly int DashIndex = 10;

	protected override void OnSkillEnable()
	{
		NovaLogger.Debug("禁断丽容.横踢技能.开始");
	}

	protected override void OnSkillDisable()
	{
		StopCor(DamageCor);
		NovaLogger.Debug("禁断丽容.横踢技能.结束");
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
		yield return StartCor(Move());
		yield return StartCor(KickFlow());
	}

	protected IEnumerator Damage()
	{
		for (int i = 0; i < 1; i++)
		{
			DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Fan, GetPosition(), default, default, 10, default, 240, GetRotation());
			HitFeatureData hitFeatureData = GetHitFeatureData(HitBox.FeatureFlag.None, default, default, UseAtttackForward: false, default, null, null, default, default, default, default, default, default, default, default, default, null, null, null, null, 2);
			AreaHit_Simple(_actor, shapeData, hitFeatureData, 50601086, 0.5, HitBox.HurtAnimType.Small, "fx_50601JinDuanLiRong_hit_Skill01");
			yield return WaitTime(0.05);
		}
		yield return null;
	}

	protected IEnumerator BackJump()
	{
		yield return BeginLookAtByPos(GetEntityPositionObsoleted(target), 0.05, 3600);
		BeginAttack(JinDuanLiRongSkillBase.JumpBackIndex, JinDuanLiRongSkillBase.JumpBackKey, flushInputedKeys: true, forceInterruptAttack: true);
		SetCloseBlockEnable();
		SetSearchedImmunityEnable();
		TSVector2 forward = GetForward();
		TSVector2 Direction = RotateTo(forward, 180);
		FP speed = 20.0;
		FP DIST = 10;
		FP angleLimit = 360;
		dash = BeginDash(DashIndex, Direction, speed, DIST, angleLimit, comboWithAttack: true, isAngle: false, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		yield return WaitTime(0.4);
		SetSearchedImmunityDisable();
		for (int i = 0; i < 15; i++)
		{
			StopDash();
			speed += (FP)(-2.0);
			if (speed <= 0)
			{
				break;
			}
			BeginDash(DashIndex, Direction, speed, DIST, angleLimit, comboWithAttack: true, isAngle: false, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false, 0.2);
			yield return WaitTime(0.02);
		}
		SetCloseBlockDisable();
		yield return WaitCombo(ComboAttackType.isComboFinish);
		yield return StartCor(KickFlow());
	}

	protected IEnumerator Appel()
	{
		Distance(GetPosition(), GetEntityPositionObsoleted(GetCurrentPlayer()));
		_ = TSVector2.zero;
		_ = (FP)0;
		_ = (FP)0;
		_ = TSVector2.zero;
		int i = 0;
		int j = ((TSRandom.Range(0, 2) != 0) ? 1 : (-1));
		while (i < 2)
		{
			NovaLogger.Debug("禁断丽容.剪刀吹风填充.垫步开始");
			FP fP = Distance(GetPosition(), GetEntityPositionObsoleted(GetCurrentPlayer()));
			AngleBetween = AngleBetween2TSVector(GetForward(), GetEntityPositionObsoleted(GetCurrentPlayer()) - GetPosition(), signed: true);
			if (fP <= 5)
			{
				FP fP2 = fP;
				NovaLogger.Debug("禁断丽容.距离结果.贴身" + fP2.ToString());
				TSVector2 tSVector = TransLocalPosToWorldPos(GetPosition(), GetPosition() - GetEntityPositionObsoleted(GetCurrentPlayer()), new TSVector2(0, 4));
				TSVector2 direction = RotateTo(tSVector, GetRandomValue(50, 80) * j);
				FP fP3 = Distance(tSVector, GetPosition());
				FP speed = fP3 / 0.35;
				if (j > 0)
				{
					BeginAttack(JinDuanLiRongSkillBase.AppelRIndex, JinDuanLiRongSkillBase.AppelRKey, flushInputedKeys: true, forceInterruptAttack: true);
				}
				else
				{
					BeginAttack(JinDuanLiRongSkillBase.AppelLIndex, JinDuanLiRongSkillBase.AppelLKey, flushInputedKeys: true, forceInterruptAttack: true);
				}
				BeginDash(10, direction, speed, fP3, 99999, comboWithAttack: true, isAngle: true, notChangeForward: true, triggerObstacleStop: true, triggerEnemyStop: false, triggerFriendStop: false);
				BeginLookAtByPos_NotWait(GetEntityPositionObsoleted(GetCurrentPlayer()), 0.25, 720);
				yield return WaitDashFinish();
				StopLookAt();
			}
			else
			{
				FP fP2;
				TSVector2 direction;
				FP fP3;
				FP speed;
				if (fP <= 7)
				{
					fP2 = fP;
					NovaLogger.Debug("禁断丽容.距离结果.中距离" + fP2.ToString());
					GetEntityPositionObsoleted(GetCurrentPlayer());
					fP3 = 8;
					speed = fP3 / 0.35;
					if (AngleBetween > 0)
					{
						direction = RotateTo(GetEntityPositionObsoleted(GetCurrentPlayer()) - GetPosition(), 30);
						BeginAttack(JinDuanLiRongSkillBase.AppelLIndex, JinDuanLiRongSkillBase.AppelLKey, flushInputedKeys: true, forceInterruptAttack: true);
					}
					else
					{
						direction = RotateTo(GetEntityPositionObsoleted(GetCurrentPlayer()) - GetPosition(), -30);
						BeginAttack(JinDuanLiRongSkillBase.AppelRIndex, JinDuanLiRongSkillBase.AppelRKey, flushInputedKeys: true, forceInterruptAttack: true);
					}
					BeginDash(10, direction, speed, fP3, 99999, comboWithAttack: true, isAngle: true, notChangeForward: true, triggerObstacleStop: true, triggerEnemyStop: false, triggerFriendStop: false);
					BeginLookAtByPos_NotWait(GetEntityPositionObsoleted(GetCurrentPlayer()), 0.25, 720);
					yield return WaitDashFinish();
					StopLookAt();
					break;
				}
				fP2 = fP;
				NovaLogger.Debug("禁断丽容.距离结果.远距离" + fP2.ToString());
				TSVector2 tSVector = GetEntityPositionObsoleted(GetCurrentPlayer());
				direction = RotateTo(tSVector - GetPosition(), 40 * j);
				fP3 = TSMath.Clamp(Distance(direction, GetPosition()), 4, 10);
				speed = fP3 / 0.35;
				if (j < 0)
				{
					BeginAttack(JinDuanLiRongSkillBase.AppelRIndex, JinDuanLiRongSkillBase.AppelRKey, flushInputedKeys: true, forceInterruptAttack: true);
				}
				else
				{
					BeginAttack(JinDuanLiRongSkillBase.AppelLIndex, JinDuanLiRongSkillBase.AppelLKey, flushInputedKeys: true, forceInterruptAttack: true);
				}
				BeginDash(10, direction, speed, fP3, 99999, comboWithAttack: true, isAngle: true, notChangeForward: true, triggerObstacleStop: true, triggerEnemyStop: false, triggerFriendStop: false);
				BeginLookAtByPos_NotWait(tSVector, 0.25, 720);
				yield return WaitDashFinish();
				StopLookAt();
			}
			yield return null;
			i++;
			j *= -1;
		}
		yield return null;
	}

	protected IEnumerator Appel2Zero()
	{
		_ = TSVector2.zero;
		_ = (FP)0;
		_ = (FP)0;
		_ = TSVector2.zero;
		int i = 0;
		int j = ((TSRandom.Range(0, 2) != 0) ? 1 : (-1));
		while (i < 2)
		{
			TSVector2 zero = TSVector2.zero;
			TSVector2 tSVector = RotateTo(zero - GetPosition(), GetRandomValue(10, 30) * j);
			FP fP = TSMath.Clamp(Distance(tSVector, GetPosition()), 4, 8);
			FP speed = fP / 0.3;
			if (j < 0)
			{
				BeginAttack(JinDuanLiRongSkillBase.AppelRIndex, JinDuanLiRongSkillBase.AppelRKey, flushInputedKeys: true, forceInterruptAttack: true);
			}
			else
			{
				BeginAttack(JinDuanLiRongSkillBase.AppelLIndex, JinDuanLiRongSkillBase.AppelLKey, flushInputedKeys: true, forceInterruptAttack: true);
			}
			BeginDash(10, tSVector, speed, fP, 99999, comboWithAttack: true, isAngle: true, notChangeForward: true, triggerObstacleStop: true, triggerEnemyStop: false, triggerFriendStop: false, 0.2);
			BeginLookAtByPos_NotWait(zero, 0.25, 720);
			yield return WaitDashFinish();
			StopLookAt();
			i++;
			j *= -1;
		}
		yield return StartCor(KickFlow());
		yield return null;
	}

	protected IEnumerator KickFlow()
	{
		BeginAttack(JinDuanLiRongSkillBase.KickIndex, JinDuanLiRongSkillBase.KickKey, flushInputedKeys: true, forceInterruptAttack: true);
		BeginLookAtByPos_NotWait(GetEntityPositionObsoleted(target), 0.3, 450);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		PlayEffect("fx_50601JinDuanLiRong_base_Skill03_A_warning", 0.8f, default, GetPosition(), GetRotation());
		yield return WaitTime(1.2);
		CancelAttack();
		PlayEffect(warningFx, 1f, 3, GetPosition(), default, 3f);
		yield return WaitTime(0.3);
		DamageCor = StartCor(Damage());
		yield return WaitTime(0.4);
		BeginLookAtByPos_NotWait(GetEntityPositionObsoleted(target), 0.4, 450);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
