using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._50141TaLu;

public class Skill_RayAttack_Water : SkillSimpleBase
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

	private static readonly FP AttackRadius = 1;

	private static readonly int AttackDamage = 50141011;

	private static readonly FP LookAtDuration = 1;

	private static readonly FP LookAtRotateSpeed = 360;

	private static readonly ComboInputBuffer.ActionKey[] Attack_Combo = new ComboInputBuffer.ActionKey[1];

	private long _lockFxId;

	private long _lockendFxId;

	protected override IEnumerator DoMainLogic()
	{
		LogicEntity attackTarget = GetAttackTarget();
		BeginAttack(1, Attack_Combo, flushInputedKeys: true, forceInterruptAttack: true);
		BeginLookAt(attackTarget, LookAtDuration, LookAtRotateSpeed);
		yield return WaitCustomEvent("Lock");
		StopWaitLookAt();
		attackTarget = GetAttackTarget(isUpToDate: true);
		_lockFxId = PlayLinkEffect(LinkFxPath, useCustomSource: false, null, default, default, attackTarget);
		FP lockingTime = 0;
		TSVector2 targetPosition = default;
		Skill_RayAttack_Water skill_RayAttack_Water = this;
		TSVector2 position = GetPosition();
		FP lockRadius = LockRadius;
		FP lockAngle = LockAngle;
		FP rotation = GetRotation();
		DeterministicShape lockShape = skill_RayAttack_Water.GetShapeData(DeterministicShape.ShapeType.Fan, position, default, default, lockRadius, default, lockAngle, rotation);
		while (CheckTargetIsValid(attackTarget) && GetTargetsFromShape(lockShape, null, includeSelf: false, attackTarget).Count > 0 && lockingTime < LockDuration)
		{
			targetPosition = GetEntityPositionObsoleted(attackTarget);
			lockingTime += _actor.LogicDeltaTime;
			yield return null;
		}
		StopEffect(_lockFxId);
		Skill_RayAttack_Water skill_RayAttack_Water2 = this;
		Skill_RayAttack_Water skill_RayAttack_Water3 = this;
		string linkEndFxPath = LinkEndFxPath;
		TSVector2 targetPosition2 = targetPosition;
		rotation = 0;
		skill_RayAttack_Water2._lockendFxId = skill_RayAttack_Water3.PlayLinkEffect(linkEndFxPath, useCustomSource: false, null, default, default, null, targetPosition2, rotation);
		PlayEarlyWarningEffect("EarlyWarningFX", (float)PrepareAttackDuration, default, targetPosition, default, 0.5f);
		yield return WaitTime(PrepareAttackDuration - 0.3);
		PlayEffect(HitFxPath);
		yield return WaitTime(0.3);
		CancelAttack();
		yield return WaitCustomEvent("Attack");
		yield return StartCor(RayAttack(targetPosition));
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnSkillDisable()
	{
		StopEffect(_lockFxId);
		StopEffect(_lockendFxId);
	}

	private IEnumerator RayAttack(TSVector2 Position)
	{
		Skill_RayAttack_Water skill_RayAttack_Water = this;
		FP attackRadius = AttackRadius;
		DeterministicShape attackShape = skill_RayAttack_Water.GetShapeData(DeterministicShape.ShapeType.Circle, Position, default, default, attackRadius);
		Skill_RayAttack_Water skill_RayAttack_Water2 = this;
		List<int> buffIdsForTarget = new List<int> { 501411110 };
		attackRadius = 3;
		HitFeatureData attackData = skill_RayAttack_Water2.GetHitFeatureData(HitBox.FeatureFlag.AddBuffForTarget, default, default, UseAtttackForward: false, default, null, null, default, default, default, default, default, default, default, default, default, null, buffIdsForTarget, null, null, attackRadius);
		Skill_RayAttack_Water skill_RayAttack_Water3 = this;
		string bulletFxPath = BulletFxPath;
		TSVector2 targetPosition = Position;
		attackRadius = 0;
		skill_RayAttack_Water3.PlayLinkEffect(bulletFxPath, useCustomSource: false, null, default, default, null, targetPosition, attackRadius);
		yield return WaitFrame(2);
		PlayEffect(LandFxPath, 1f, default, Position);
		yield return WaitFrame(1);
		AreaHit_Simple(_actor, attackShape, attackData, AttackDamage, 0.5, HitBox.HurtAnimType.Large, "HittedFX");
		StopEffect(_lockendFxId);
	}
}
