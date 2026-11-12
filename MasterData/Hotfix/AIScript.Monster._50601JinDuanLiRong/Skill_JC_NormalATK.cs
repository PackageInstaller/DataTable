#define LOG_DEBUG
using System.Collections;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._50601JinDuanLiRong;

public class Skill_JC_NormalATK : JinDuanLiRongSkillBase
{
	private CoroutineNode DamageCor;

	private TSVector2 selfForward;

	private LogicEntity target;

	private FP AngleBetween;

	private int KickTimes;

	private Dash dash;

	private readonly int DashIndex = 10;

	protected override void OnSkillEnable()
	{
		KickTimes = 0;
		NovaLogger.Debug("禁断丽容.剪刀吹风填充.开始");
	}

	protected override void OnSkillDisable()
	{
		StopCor(DamageCor);
		NovaLogger.Debug("禁断丽容.剪刀吹风填充.结束");
	}

	protected override IEnumerator DoMainLogic()
	{
		target = GetCurrentPlayer();
		yield return StartCor(Move());
		yield return StartCor(Attack());
		if (Distance(GetPosition(), TSVector2.zero) >= 12)
		{
			NovaLogger.Debug("禁断丽容.剪刀吹风填充.位于场边向场景中心移动");
			yield return StartCor(Appel2Zero());
		}
		else
		{
			yield return StartCor(Attack());
		}
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
		yield return null;
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
			if (fP <= 4)
			{
				FP fP2 = fP;
				NovaLogger.Debug("禁断丽容.距离结果.贴身" + fP2.ToString());
				TSVector2 tSVector = TransLocalPosToWorldPos(GetPosition(), GetPosition() - GetEntityPositionObsoleted(GetCurrentPlayer()), new TSVector2(0, 6));
				TSVector2 direction = RotateTo(tSVector, GetRandomValue(50, 80) * j);
				FP fP3 = Distance(tSVector, GetPosition());
				FP speed = fP3 / 0.3;
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
				if (fP <= 7 && fP > 4)
				{
					fP2 = fP;
					NovaLogger.Debug("禁断丽容.距离结果.中距离" + fP2.ToString());
					GetEntityPositionObsoleted(GetCurrentPlayer());
					fP3 = 8;
					speed = fP3 / 0.3;
					if (AngleBetween > 0)
					{
						direction = RotateTo(GetEntityPositionObsoleted(GetCurrentPlayer()) - GetPosition(), 40);
						BeginAttack(JinDuanLiRongSkillBase.AppelLIndex, JinDuanLiRongSkillBase.AppelLKey, flushInputedKeys: true, forceInterruptAttack: true);
					}
					else
					{
						direction = RotateTo(GetEntityPositionObsoleted(GetCurrentPlayer()) - GetPosition(), -40);
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
				speed = fP3 / 0.3;
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
		yield return StartCor(BreakATKFlow());
		InterruptSkill();
		yield return null;
	}

	protected IEnumerator Attack()
	{
		FP fP = Distance(GetPosition(), GetEntityPositionObsoleted(GetCurrentPlayer()));
		int j = ((TSRandom.Range(0, 2) != 0) ? 1 : (-1));
		if (KickTimes > 0)
		{
			if (fP < 8 && j > 0)
			{
				j = ((TSRandom.Range(0, 2) != 0) ? 1 : (-1));
				yield return StartCor(KickFlow());
				if (Distance(GetPosition(), GetEntityPositionObsoleted(GetCurrentPlayer())) >= 8 && j > 0)
				{
					yield return StartCor(BreakATKFlow());
				}
			}
			else
			{
				yield return StartCor(BreakATKFlow());
			}
		}
		else
		{
			yield return StartCor(KickFlow());
		}
		yield return null;
	}

	protected IEnumerator Damage()
	{
		for (int i = 0; i < 1; i++)
		{
			DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Fan, GetPosition(), default, default, 10, default, 240, GetRotation());
			HitFeatureData hitFeatureData = GetHitFeatureData(HitBox.FeatureFlag.None, default, default, UseAtttackForward: false, default, null, null, default, default, default, default, default, default, default, default, default, null, null, null, null, 2);
			AreaHit_Simple(_actor, shapeData, hitFeatureData, 50601094, 0.5, HitBox.HurtAnimType.Small, "fx_50601JinDuanLiRong_hit_Skill01");
			yield return WaitTime(0.05);
		}
		yield return null;
	}

	protected IEnumerator KickFlow()
	{
		BeginAttack(JinDuanLiRongSkillBase.KickIndex, JinDuanLiRongSkillBase.KickKey, flushInputedKeys: true, forceInterruptAttack: true);
		BeginLookAt_NotWait(target, 0.3, 225);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		if (GetLogicTagToggleValue(_actor, "appelIsDone"))
		{
			PlayEffect("fx_50601JinDuanLiRong_base_Skill03_A_warning", 1.6f, default, GetPosition(), GetRotation());
			yield return WaitTime(0.6);
			SetLogicTagToggleValue(_actor, "appelIsDone", value: false);
		}
		else
		{
			PlayEffect("fx_50601JinDuanLiRong_base_Skill03_A_warning", 0.8f, default, GetPosition(), GetRotation());
			yield return WaitTime(1.2);
		}
		CancelAttack();
		PlayEffect(warningFx, 1f, 3, GetPosition(), default, 3f);
		yield return WaitTime(0.3);
		DamageCor = StartCor(Damage());
		KickTimes++;
		yield return WaitTime(0.4);
		BeginLookAt_NotWait(target, 0.4, 450);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected IEnumerator BreakATKFlow()
	{
		switch (GetAiType())
		{
		case 0:
			yield return StartCor(BreakATKRing());
			break;
		case 1:
			yield return StartCor(BreakATK());
			break;
		case 2:
			yield return StartCor(BreakATK());
			break;
		default:
			NovaLogger.Debug("禁断丽容.剪刀填充.难度标签异常默认为简单");
			yield return StartCor(BreakATKRing());
			break;
		}
	}

	private IEnumerator BreakATK()
	{
		BeginAttack(JinDuanLiRongSkillBase.breakATKIndex, JinDuanLiRongSkillBase.breakATKKey, flushInputedKeys: true, forceInterruptAttack: true);
		PlayEffect("fx_common_base_Fire_YuJing_circular_8", 0.7f, default, GetPosition());
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		PlayEffect(warningFx, 1f, 3, GetPosition(), default, 3f);
		yield return WaitTime(0.2);
		CancelAttack();
		yield return WaitTime(0.1);
		PlayAreaEffect("BreakExplosive", GetPosition(), GetRotation());
		int num = 1;
		int bulletCount = 36;
		FP angle = 360;
		for (int i = 0; i < num; i++)
		{
			TSVector2 multiShootDirection = RotateTo(GetForward(), 360 / num * i);
			FanMultipleShoot("50601JinDuanLiRong_DiffusionBubble", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: true, 0, bulletCount, 0, GetPosition(), 0, multiShootDirection, 0, AimType.Default, BulletDirectionType.ActorToBullet, angle, 0, 8);
			PlayWwiseSound("mon_50601_JC2_greencircle");
		}
		BeginAttack(JinDuanLiRongSkillBase.breakEndIndex, JinDuanLiRongSkillBase.breakEndKey, flushInputedKeys: true, forceInterruptAttack: true);
		ModelNodeShow("comb", isShow: false);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private IEnumerator BreakATKRing()
	{
		BeginAttack(JinDuanLiRongSkillBase.breakATKIndex, JinDuanLiRongSkillBase.breakATKKey, flushInputedKeys: true, forceInterruptAttack: true);
		PlayEffect("fx_common_base_red_fan_360c_5r_14r", 0.5f, default, GetPosition());
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		yield return WaitTime(0.4);
		PlayEffect(warningFx, 1f, 3, GetPosition(), default, 3f);
		yield return WaitTime(0.3);
		CancelAttack();
		BeginAttack(JinDuanLiRongSkillBase.breakEndIndex, JinDuanLiRongSkillBase.breakEndKey, flushInputedKeys: true, forceInterruptAttack: true);
		PlayEffect("fx_50601JinDuanLiRong_base_RingATK_1", 1f, default, GetPosition());
		Damage();
		ModelNodeShow("comb", isShow: false);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
