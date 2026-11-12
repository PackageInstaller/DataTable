using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._30931HaSaNa;

public class SkillScript_RushAttack : SkillScript_MeeleBase
{
	private readonly string comboTag = "Attack_4_Ready";

	private readonly FP rotateDuration = 0.5;

	private readonly FP rotateSpeed = 50;

	private readonly FP waitTimeAfterRotate = 0.5;

	private readonly string comboTag_Strength = "Attack_4";

	private readonly int buffId_Strength = 309310010;

	private readonly string eventName_RemoveStrengthBuff = "HammerEnd";

	private readonly FP rotateSpeed_Charge_Strength = 30;

	private readonly FP loopTime_Charge_Strength = 0.75;

	private readonly FP rushSpeed_Rush_Strength = 10;

	private readonly FP maxRushTime_Rush_Strengt = 3;

	private readonly FP rotateSpeed_Rush_Strength = 450;

	private readonly FP checkFanRadius_Rush_Strength = 8;

	private readonly FP checkFanAngle_Rush_Strength = 45;

	private readonly FP AdditionalDis_Normal = 4;

	private readonly FP AdditionalDis_Strength = 8;

	private FP rushDistance;

	private FP AdditionalDis;

	protected override IEnumerator DoMainLogic()
	{
		yield return BeginLookAt(GetAttackTarget(), 0.25, 999);
		BeginAttack(1, comboTag, flushInputedKeys: true);
		if (_isStrength)
		{
			AdditionalDis = AdditionalDis_Strength;
		}
		else
		{
			AdditionalDis = AdditionalDis_Normal;
		}
		if (!_isStrength)
		{
			yield return BeginLookAtMonsterTarget(rotateDuration, rotateSpeed);
			yield return StartCor(FastDashAndAttack());
		}
		else
		{
			BeginLookAtMonsterTarget(999, rotateSpeed_Charge_Strength);
			yield return WaitCombo(ComboAttackType.isAnticipationEnd);
			AddBuffToTarget(_actor, buffId_Strength);
			yield return WaitTime(loopTime_Charge_Strength);
			StopWaitLookAt();
			yield return StartCor(FastDashAndAttack());
			BeginAttack(2, comboTag_Strength, flushInputedKeys: true, forceInterruptAttack: true);
			BeginDashActorForward(1, rushSpeed_Rush_Strength, 999, 999, comboWithAttack: true, isAngle: true, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
			BeginLookAtMonsterTarget(999, rotateSpeed_Rush_Strength);
			FP rushTime = 0;
			while (rushTime < maxRushTime_Rush_Strengt && !CheckTargetInShape())
			{
				rushTime += _actor.LogicDeltaTime;
				yield return null;
			}
			StopDash();
			BeginLookAtMonsterTarget(0.25, 150);
			CancelAttack();
		}
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
		base.OnCustomEvent(comboIndex, eventName);
		if (string.Equals(eventName, eventName_RemoveStrengthBuff))
		{
			RemoveBuffFromTarget(_actor, buffId_Strength);
		}
	}

	private bool CheckTargetInShape()
	{
		LogicEntity attackTarget = GetAttackTarget(isUpToDate: true);
		TSVector2 position = GetPosition();
		FP radius = checkFanRadius_Rush_Strength;
		FP angle = checkFanAngle_Rush_Strength;
		FP rotation = GetRotation();
		DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Fan, position, default, default, radius, default, angle, rotation);
		List<LogicEntity> targetsFromShape = GetTargetsFromShape(shapeData, null, includeSelf: false, attackTarget);
		if (targetsFromShape != null && targetsFromShape.Count > 0)
		{
			return true;
		}
		return false;
	}

	private IEnumerator FastDashAndAttack()
	{
		FP distanceWithTarget = GetDistanceWithTarget(GetAttackTarget(isUpToDate: true));
		SkillScript_RushAttack skillScript_RushAttack = this;
		float duration = (float)waitTimeAfterRotate;
		TSVector2 position = GetPosition();
		FP rotation = GetRotation();
		skillScript_RushAttack.PlayEarlyWarningEffect("fx_warning_dash_3x20", duration, default, position, rotation);
		yield return WaitTime(waitTimeAfterRotate);
		rushDistance = distanceWithTarget + AdditionalDis;
		CancelAttack();
		SetCloseBlockEnable();
		long DashloopFast = PlayEffect("fx_m30391_base_Attack_4_knife_dash");
		BeginAttack(3, "Attack_2_1", flushInputedKeys: true, forceInterruptAttack: true);
		BeginDashActorForward(1, rushDistance / 0.1, rushDistance, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		SkillScript_RushAttack skillScript_RushAttack2 = this;
		TSVector2 position2 = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, rushDistance / 2));
		FP width = 2.5;
		FP length = rushDistance;
		rotation = GetRotation();
		DeterministicShape shapeData = skillScript_RushAttack2.GetShapeData(DeterministicShape.ShapeType.Rectangle, position2, width, length, default, default, default, rotation);
		SkillScript_RushAttack skillScript_RushAttack3 = this;
		FP knockBackForce = 10;
		FP knockBackDistance = 2;
		rotation = 0.25;
		FP hitStrenth = 4;
		HitFeatureData hitFeatureData = skillScript_RushAttack3.GetHitFeatureData(HitBox.FeatureFlag.KnockBack | HitBox.FeatureFlag.Stiff, knockBackForce, knockBackDistance, UseAtttackForward: true, default, null, null, rotation, default, default, default, default, default, default, default, default, null, null, null, null, hitStrenth);
		AreaHit_Simple(_actor, shapeData, hitFeatureData, 30931022, 0, HitBox.HurtAnimType.Small, "fx_common_hit_earth_magic");
		yield return WaitDashFinish();
		SetCloseBlockDisable();
		StopEffect(DashloopFast);
		BeginLookAt_NotWait(GetAttackTarget(isUpToDate: true), 0.1, 9999);
	}
}
