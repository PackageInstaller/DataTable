#define LOG_DEBUG
using System.Collections;
using TrueSync;

namespace AIScript.Monster._50601JinDuanLiRong;

public class Skill_NormalAttack : JinDuanLiRongSkillBase
{
	private CoroutineNode DamageCor;

	private LogicEntity target;

	private readonly string warningFx02 = "fx_warning_fan_220c_6r";

	private readonly string warningFx03 = "fx_common_base_Fire_YuJing_circular_6";

	private long warningFxID;

	protected override void OnSkillEnable()
	{
		NovaLogger.Debug("禁断丽容.普攻劈砍.开始");
	}

	protected override void OnSkillDisable()
	{
		StopEffect(warningFxID);
		StopCor(DamageCor);
		NovaLogger.Debug("禁断丽容.普攻劈砍.结束");
	}

	protected override IEnumerator DoMainLogic()
	{
		target = GetTarget();
		yield return BeginLookAt(target, 0.3, 600);
		BeginAttack(JinDuanLiRongSkillBase.NormalATKAIndex, JinDuanLiRongSkillBase.NormalATKAKey, flushInputedKeys: true, forceInterruptAttack: true);
		Skill_NormalAttack skill_NormalAttack = this;
		TSVector2 position = GetPosition();
		FP entityAngle = GetEntityAngle(_actor);
		skill_NormalAttack.PlayEffect("fx_warning_square_3side_p_2x5", 0.7f, default, position, entityAngle, 1.5f);
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
				PlayEffect(warningFx, 1f, 3, GetPosition(), default, 3f);
				yield return WaitCombo(ComboAttackType.isAnticipationEnd);
				DamageCor = StartCor(Damage(1, DeterministicShape.ShapeType.Fan, GetPosition(), default, default, 6, 220, GetTSVectToAngle(GetForward(), -40)));
			}
			CancelAttack();
			StopCor(DamageCor);
			yield return WaitTime(0.4);
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
				PlayEffect(warningFx, 1f, 3, GetPosition(), default, 3f);
				yield return WaitCombo(ComboAttackType.isAnticipationEnd);
				DamageCor = StartCor(Damage(1, DeterministicShape.ShapeType.Fan, GetPosition(), default, default, 6, 220, GetRotation()));
			}
			CancelAttack();
			yield return WaitTime(0.8);
		}
	}

	protected IEnumerator Damage(int CheckTimes, DeterministicShape.ShapeType shapeT, TSVector2 position, FP width, FP length, FP radius, FP angle, FP rotation)
	{
		for (int i = 0; i < CheckTimes; i++)
		{
			DeterministicShape shapeData = GetShapeData(shapeT, position, width, length, radius, default, angle, rotation);
			Skill_NormalAttack skill_NormalAttack = this;
			FP hitStrenth = 2;
			HitFeatureData hitFeatureData = skill_NormalAttack.GetHitFeatureData(HitBox.FeatureFlag.None, default, default, UseAtttackForward: false, default, null, null, default, default, default, default, default, default, default, default, default, null, null, null, null, hitStrenth);
			AreaHit_Simple(_actor, shapeData, hitFeatureData, 50601085, 0.5, HitBox.HurtAnimType.Small, "fx_50601JinDuanLiRong_hit_Skill01");
			yield return WaitTime(0.05);
		}
		yield return null;
	}
}
