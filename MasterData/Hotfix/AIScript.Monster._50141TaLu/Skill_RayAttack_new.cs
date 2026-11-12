#define LOG_DEBUG
using System.Collections;
using TrueSync;
using UnityEngine;

namespace AIScript.Monster._50141TaLu;

public class Skill_RayAttack_new : SkillSimpleBase
{
	private static readonly string LinkFxPath = "lineFX";

	private static readonly string LinkEndFxPath = "lineEndFX";

	private static readonly string BulletFxPath = "bulletFX";

	private static readonly string LandFxPath = "landFX";

	private static readonly string HitFxPath = "hitFX";

	private static readonly FP LockRadius = 12;

	private static readonly FP LockAngle = 150;

	private static readonly FP LockDuration = 3;

	private static readonly FP PrepareAttackDuration = 0.5;

	private static readonly FP AttackRadius = 1.5;

	private static readonly int AttackDamage = 50141011;

	private static readonly FP LookAtDuration = 1;

	private static readonly FP LookAtRotateSpeed = 360;

	private static readonly ComboInputBuffer.ActionKey[] ActionKey = new ComboInputBuffer.ActionKey[1];

	private static readonly string StartLockEvent = "Lock";

	private static readonly string RayAttackEvent = "Attack";

	private long _lockFxId;

	private long _lockendFxId;

	private long _scanFxId;

	private long _scanEyeFxId;

	protected override IEnumerator DoMainLogic()
	{
		LogicEntity attackTarget = GetAttackTarget();
		if (attackTarget == null)
		{
			yield break;
		}
		BeginAttack(1, ActionKey);
		BeginLookAt(attackTarget, LookAtDuration, LookAtRotateSpeed);
		yield return WaitCustomEvent(StartLockEvent);
		StopLookAt();
		attackTarget = GetAttackTarget();
		if (!(attackTarget == null))
		{
			Skill_RayAttack_new skill_RayAttack_new = this;
			Skill_RayAttack_new skill_RayAttack_new2 = this;
			string linkFxPath = LinkFxPath;
			LogicEntity target = attackTarget;
			skill_RayAttack_new._lockFxId = skill_RayAttack_new2.PlayLinkEffect(linkFxPath, useCustomSource: false, null, default, default, target);
			NovaLogger.Debug("RaylockTarget = " + attackTarget.name);
			FP lockingTime = 0;
			TSVector2 targetPosition = default;
			Skill_RayAttack_new skill_RayAttack_new3 = this;
			TSVector2 position = GetPosition();
			FP lockRadius = LockRadius;
			FP lockAngle = LockAngle;
			FP rotation = GetRotation();
			DeterministicShape lockShape = skill_RayAttack_new3.GetShapeData(DeterministicShape.ShapeType.Fan, position, default, default, lockRadius, default, lockAngle, rotation);
			DebugDrawUtils.DebugFan(_actor.transform.position, LockRadius.AsFloat(), 0f, LockAngle.AsFloat(), _actor.transform.rotation, Color.red, 1f);
			while (attackTarget != null && GetTargetsFromShape(lockShape, null, includeSelf: false, attackTarget).Count > 0 && lockingTime < LockDuration)
			{
				targetPosition = GetEntityPositionObsoleted(attackTarget);
				lockingTime += _actor.LogicDeltaTime;
				yield return null;
				attackTarget = GetAttackTarget();
			}
			StopEffect(_lockFxId);
			if (!(targetPosition == default(TSVector2)))
			{
				Skill_RayAttack_new skill_RayAttack_new4 = this;
				Skill_RayAttack_new skill_RayAttack_new5 = this;
				string linkEndFxPath = LinkEndFxPath;
				TSVector2 targetPosition2 = targetPosition;
				rotation = 0;
				skill_RayAttack_new4._lockendFxId = skill_RayAttack_new5.PlayLinkEffect(linkEndFxPath, useCustomSource: false, null, default, default, null, targetPosition2, rotation);
				PlayEarlyWarningEffect("EarlyWarningFX", (float)PrepareAttackDuration, default, targetPosition, default, 0.5f);
				yield return WaitTime(PrepareAttackDuration - 0.3);
				PlayEffect(HitFxPath);
				yield return WaitTime(0.3);
				CancelAttack();
				yield return WaitCustomEvent(RayAttackEvent);
				Skill_RayAttack_new skill_RayAttack_new6 = this;
				TSVector2 position2 = targetPosition;
				rotation = AttackRadius;
				DeterministicShape attackShape = skill_RayAttack_new6.GetShapeData(DeterministicShape.ShapeType.Circle, position2, default, default, rotation);
				Skill_RayAttack_new skill_RayAttack_new7 = this;
				rotation = 3;
				HitFeatureData attackData = skill_RayAttack_new7.GetHitFeatureData(HitBox.FeatureFlag.None, default, default, UseAtttackForward: false, default, null, null, default, default, default, default, default, default, default, default, default, null, null, null, null, rotation);
				Skill_RayAttack_new skill_RayAttack_new8 = this;
				string bulletFxPath = BulletFxPath;
				targetPosition2 = targetPosition;
				rotation = 0;
				skill_RayAttack_new8.PlayLinkEffect(bulletFxPath, useCustomSource: false, null, default, default, null, targetPosition2, rotation);
				yield return WaitFrame(2);
				PlayEffect(LandFxPath, 1f, 0, targetPosition, 0);
				yield return WaitFrame(1);
				AreaHit_Simple(_actor, attackShape, attackData, AttackDamage, 0.5, HitBox.HurtAnimType.Large);
				StopEffect(_lockendFxId);
				yield return WaitCombo(ComboAttackType.isComboFinish);
			}
		}
	}

	protected override void OnSkillDisable()
	{
		StopEffect(_scanFxId);
		StopEffect(_scanEyeFxId);
		StopEffect(_lockFxId);
		StopEffect(_lockendFxId);
	}
}
