#define LOG_DEBUG
using System.Collections;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._50601JinDuanLiRong;

public class Skill_FA_NormalATK : JinDuanLiRongSkillBase
{
	private string hitEffect = "fx_50601JinDuanLiRong_hit_Skill01";

	private string diffusionBubble = "50601JinDuanLiRong_DiffusionBubble";

	private string sound = "mon_50601_JC2_greencircle";

	private bool appelIsDone;

	private CoroutineNode DamageCor;

	private TSVector2 selfForward;

	private LogicEntity target;

	private FP AngleBetween;

	private readonly string warningFx02 = "fx_warning_fan_220c_6r";

	private readonly string warningFx03 = "fx_common_base_Fire_YuJing_circular_6";

	private long warningFxID;

	private Dash dash;

	private readonly int DashIndex = 10;

	protected override void OnSkillEnable()
	{
		appelIsDone = false;
		NovaLogger.Debug("禁断丽容.剪刀吹风填充.开始");
	}

	protected override void OnSkillDisable()
	{
		StopEffect(warningFxID);
		StopCor(DamageCor);
		NovaLogger.Debug("禁断丽容.剪刀吹风填充.结束");
	}

	protected override IEnumerator DoMainLogic()
	{
		target = GetCurrentPlayer();
		yield return StartCor(Move());
		yield return StartCor(AttackFlow());
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
		yield return StartCor(BreakATKFlow());
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
				FP speed = fP3 / 0.2;
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
					speed = fP3 / 0.25;
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
				speed = fP3 / 0.25;
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

	protected IEnumerator AttackFlow()
	{
		int num = ((TSRandom.Range(0, 2) != 0) ? 1 : (-1));
		if (num > 0)
		{
			yield return StartCor(KickFlow());
			yield break;
		}
		yield return BeginLookAt(target, 0.3, 600);
		BeginAttack(JinDuanLiRongSkillBase.NormalATKAIndex, JinDuanLiRongSkillBase.NormalATKAKey, flushInputedKeys: true, forceInterruptAttack: true);
		Skill_FA_NormalATK skill_FA_NormalATK = this;
		TSVector2 position = GetPosition();
		FP entityAngle = GetEntityAngle(_actor);
		skill_FA_NormalATK.PlayEffect("fx_warning_square_3side_p_2x5", 0.7f, default, position, entityAngle, 1.5f);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		CancelAttack();
		yield return WaitTime(0.49);
		PlayEffect(warningFx, 1f, 3, GetPosition(), default, 3f);
		yield return WaitTime(0.3);
		DamageCor = StartCor(Damage(1, DeterministicShape.ShapeType.Rectangle, TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 3.5)), 3, 7, default, default, GetRotation()));
		yield return WaitTime(0.36);
		if (AngleBetween2TSVector(GetForward(), GetEntityPositionObsoleted(target) - GetPosition(), signed: true) < 0)
		{
			BeginAttack(JinDuanLiRongSkillBase.NormalATKA2BRIndex, JinDuanLiRongSkillBase.NormalATKA2BRKey, flushInputedKeys: true, forceInterruptAttack: true);
			_ = (FP)0;
			if ((int)(long)GetRandomValue(0, 1.5, isInt: true) != 0 && GetMonsterTagValue(_actor, 1) != "BossRush")
			{
				warningFxID = PlayEffect(warningFx03, 0.6f, default, GetPosition(), GetRotation());
				PlayEffect("fx_50601JinDuanLiRong_base_Skill01_A_Start_collect", 1f, default, default, default, 1f, actorScale: true);
				yield return WaitTime(0.8);
				BeginAttack(JinDuanLiRongSkillBase.NormalATKBRWaitIndex, JinDuanLiRongSkillBase.NormalATKBRWaitKey, flushInputedKeys: true, forceInterruptAttack: true);
				yield return WaitTime(0.52);
				BeginAttack(JinDuanLiRongSkillBase.NormalATKBRIndex, JinDuanLiRongSkillBase.NormalATKBRKey, flushInputedKeys: true, forceInterruptAttack: true);
				yield return WaitTime(0.3);
				PlayEffect(warningFx, 1f, 3, GetPosition(), default, 3f);
				yield return WaitTime(0.3);
				FP fP = 360;
				FP fP2 = 0.35;
				BeginRotateAngle_NotWait(fP, fP / fP2);
				DamageCor = StartCor(Damage(3, DeterministicShape.ShapeType.Circle, GetPosition(), default, default, 6, default, default));
				yield return WaitTime(fP2);
			}
			else
			{
				warningFxID = PlayEffect(warningFx02, 1f, default, GetPosition(), GetTSVectToAngle(GetForward(), -40));
				yield return WaitTime(0.8);
				BeginAttack(JinDuanLiRongSkillBase.NormalATKBRIndex, JinDuanLiRongSkillBase.NormalATKBRKey, flushInputedKeys: true, forceInterruptAttack: true);
				yield return WaitTime(0.56);
				PlayEffect(warningFx, 1f, 3, GetPosition(), default, 3f);
				yield return WaitTime(0.3);
				DamageCor = StartCor(Damage(1, DeterministicShape.ShapeType.Fan, GetPosition(), default, default, 6, 220, GetTSVectToAngle(GetForward(), -40)));
			}
			CancelAttack();
			StopCor(DamageCor);
			yield return WaitTime(0.4);
			AngleBetween = AngleBetween2TSVector(GetForward(), GetEntityPositionObsoleted(GetCurrentPlayer()) - GetPosition(), signed: true);
			num = ((TSRandom.Range(0, 2) != 0) ? 1 : (-1));
			if (TSMath.Abs(AngleBetween) > 80 && num > 0)
			{
				yield return WaitCombo(ComboAttackType.isComboFinish);
				yield return StartCor(BreakATKFlow());
			}
			else
			{
				BeginLookAtByPos_NotWait(GetEntityPositionObsoleted(target), 0.4, 450);
				yield return WaitCombo(ComboAttackType.isComboFinish);
			}
		}
		else
		{
			BeginAttack(JinDuanLiRongSkillBase.NormalATKA2BLIndex, JinDuanLiRongSkillBase.NormalATKA2BLRKey, flushInputedKeys: true, forceInterruptAttack: true);
			_ = (FP)0;
			if ((int)(long)GetRandomValue(0, 1.5, isInt: true) != 0 && GetMonsterTagValue(_actor, 1) != "BossRush")
			{
				warningFxID = PlayEffect(warningFx03, 0.6f, default, GetPosition(), GetRotation());
				PlayEffect("fx_50601JinDuanLiRong_base_Skill01_A_Start_collect", 1f, default, default, default, 1f, actorScale: true);
				yield return WaitTime(0.7);
				BeginAttack(JinDuanLiRongSkillBase.NormalATKBLWaitIndex, JinDuanLiRongSkillBase.NormalATKBLWaitKey, flushInputedKeys: true, forceInterruptAttack: true);
				yield return WaitTime(0.52);
				BeginAttack(JinDuanLiRongSkillBase.NormalATKBLIndex, JinDuanLiRongSkillBase.NormalATKBLKey, flushInputedKeys: true, forceInterruptAttack: true);
				yield return WaitTime(0.3);
				PlayEffect(warningFx, 1f, 3, TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(-0.5, -0.5)), default, 3f);
				yield return WaitTime(0.3);
				FP fP3 = -360;
				FP fP4 = 0.35;
				BeginRotateAngle_NotWait(fP3, TSMath.Abs(fP3 / fP4));
				DamageCor = StartCor(Damage(3, DeterministicShape.ShapeType.Circle, GetPosition(), default, default, 6, default, default));
				yield return WaitTime(fP4);
			}
			else
			{
				warningFxID = PlayEffect(warningFx02, 1f, default, GetPosition(), GetRotation());
				yield return WaitTime(0.7);
				BeginAttack(JinDuanLiRongSkillBase.NormalATKBLIndex, JinDuanLiRongSkillBase.NormalATKBLKey, flushInputedKeys: true, forceInterruptAttack: true);
				PlayEffect(warningFx, 1f, 3, TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(-0.5, -0.5)), default, 3f);
				yield return WaitCombo(ComboAttackType.isAnticipationEnd);
				DamageCor = StartCor(Damage(1, DeterministicShape.ShapeType.Fan, GetPosition(), default, default, 6, 220, GetRotation()));
			}
			CancelAttack();
			yield return WaitTime(0.8);
			AngleBetween = AngleBetween2TSVector(GetForward(), GetEntityPositionObsoleted(GetCurrentPlayer()) - GetPosition(), signed: true);
			num = ((TSRandom.Range(0, 2) != 0) ? 1 : (-1));
			if (TSMath.Abs(AngleBetween) > 80 && num > 0)
			{
				yield return WaitCombo(ComboAttackType.isComboFinish);
				yield return StartCor(BreakATKFlow());
			}
			else
			{
				BeginLookAtByPos_NotWait(GetEntityPositionObsoleted(target), 0.4, 450);
				yield return WaitCombo(ComboAttackType.isComboFinish);
			}
		}
	}

	protected IEnumerator Damage(int CheckTimes, DeterministicShape.ShapeType shapeT, TSVector2 position, FP width, FP length, FP radius, FP angle, FP rotation)
	{
		for (int i = 0; i < CheckTimes; i++)
		{
			DeterministicShape shapeData = GetShapeData(shapeT, position, width, length, radius, default, angle, rotation);
			Skill_FA_NormalATK skill_FA_NormalATK = this;
			FP hitStrenth = 2;
			HitFeatureData hitFeatureData = skill_FA_NormalATK.GetHitFeatureData(HitBox.FeatureFlag.None, default, default, UseAtttackForward: false, default, null, null, default, default, default, default, default, default, default, default, default, null, null, null, null, hitStrenth);
			AreaHit_Simple(_actor, shapeData, hitFeatureData, 50601085, 0.5, HitBox.HurtAnimType.Small, hitEffect);
			yield return WaitTime(0.05);
		}
		yield return null;
	}

	protected IEnumerator Damage()
	{
		for (int i = 0; i < 1; i++)
		{
			DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Fan, GetPosition(), default, default, 10, default, 240, GetRotation());
			HitFeatureData hitFeatureData = GetHitFeatureData(HitBox.FeatureFlag.None, default, default, UseAtttackForward: false, default, null, null, default, default, default, default, default, default, default, default, default, null, null, null, null, 2);
			AreaHit_Simple(_actor, shapeData, hitFeatureData, 50601096, 0.5, HitBox.HurtAnimType.Small, hitEffect);
			yield return WaitTime(0.05);
		}
		yield return null;
	}

	protected IEnumerator BreakATKFlow()
	{
		BeginAttack(JinDuanLiRongSkillBase.breakATKIndex, JinDuanLiRongSkillBase.breakATKKey, flushInputedKeys: true, forceInterruptAttack: true);
		PlayEffect("fx_common_base_Fire_YuJing_circular_8", 0.7f, default, GetPosition());
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		CancelAttack();
		PlayEffect(warningFx, 1f, 3, GetPosition(), default, 3f);
		yield return WaitTime(0.3);
		PlayAreaEffect("BreakExplosive", GetPosition(), GetRotation());
		int num = 1;
		int bulletCount = 36;
		FP angle = 360;
		for (int i = 0; i < num; i++)
		{
			TSVector2 multiShootDirection = RotateTo(GetForward(), 360 / num * i);
			FanMultipleShoot(diffusionBubble, AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: true, 0, bulletCount, 0, GetPosition(), 0, multiShootDirection, 0, AimType.Default, BulletDirectionType.ActorToBullet, angle, 0, 8);
			PlayWwiseSound(sound);
		}
		BeginAttack(JinDuanLiRongSkillBase.breakEndIndex, JinDuanLiRongSkillBase.breakEndKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected IEnumerator KickFlow()
	{
		BeginAttack(JinDuanLiRongSkillBase.KickIndex, JinDuanLiRongSkillBase.KickKey, flushInputedKeys: true, forceInterruptAttack: true);
		BeginLookAt_NotWait(target, 0.3, 400);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		if (appelIsDone)
		{
			PlayEffect("fx_50601JinDuanLiRong_base_Skill03_A_warning", 1.6f, default, GetPosition(), GetRotation());
			yield return WaitTime(0.5);
			PlayEffect(warningFx, 1f, 3, GetPosition(), default, 3f);
			yield return WaitTime(0.1);
			appelIsDone = false;
		}
		else
		{
			PlayEffect("fx_50601JinDuanLiRong_base_Skill03_A_warning", 0.8f, default, GetPosition(), GetRotation());
			yield return WaitTime(1.1);
			PlayEffect(warningFx, 1f, 3, GetPosition(), default, 3f);
			yield return WaitTime(0.1);
		}
		CancelAttack();
		yield return WaitTime(0.2);
		DamageCor = StartCor(Damage());
		yield return WaitTime(0.4);
		BeginLookAt_NotWait(target, 0.4, 450);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
