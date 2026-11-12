using System.Collections;
using TrueSync;

namespace AIScript.Monster._50141TaLu;

public class Skill_RayAttack_Dark : SkillSimpleBase
{
	private static readonly string LinkFxPath = "lineFX";

	private static readonly string LinkEndFxPath = "lineEndFX";

	private static readonly string BulletFxPath = "bulletFX";

	private static readonly string LandFxPath = "landFX";

	private static readonly string HitFxPath = "hitFX";

	private static readonly FP LockRadius = 12;

	private static readonly FP LockRadiusTwice = 20;

	private static readonly FP LockAngle = 150;

	private static readonly FP LockDuration = 3;

	private static readonly FP LockDurationTwice = 1;

	private static readonly FP PrepareAttackDuration = 0.5;

	private static readonly FP AttackRadius = 1;

	private static readonly int AttackDamage = 50141011;

	private static readonly FP LookAtDuration = 1;

	private static readonly FP LookAtRotateSpeed = 360;

	private static readonly ComboInputBuffer.ActionKey[] Attack_Combo = new ComboInputBuffer.ActionKey[1];

	private long _lockFxId;

	private long _lockFxId2;

	private long _lockendFxId;

	private long _lockendFxId2;

	private bool IsAttackTwice;

	private bool IsTwiceAttackEnd;

	protected override void OnSkillEnable()
	{
		IsAttackTwice = false;
		IsTwiceAttackEnd = false;
	}

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
		Skill_RayAttack_Dark skill_RayAttack_Dark = this;
		TSVector2 position = GetPosition();
		FP lockRadius = LockRadius;
		FP lockAngle = LockAngle;
		FP rotation = GetRotation();
		DeterministicShape lockShape = skill_RayAttack_Dark.GetShapeData(DeterministicShape.ShapeType.Fan, position, default, default, lockRadius, default, lockAngle, rotation);
		while (CheckTargetIsValid(attackTarget) && GetTargetsFromShape(lockShape, null, includeSelf: false, attackTarget).Count > 0 && lockingTime < LockDuration)
		{
			targetPosition = GetEntityPositionObsoleted(attackTarget);
			lockingTime += _actor.LogicDeltaTime;
			yield return null;
		}
		Skill_RayAttack_Dark skill_RayAttack_Dark2 = this;
		TSVector2 position2 = GetPosition();
		rotation = LockRadiusTwice;
		lockAngle = LockAngle;
		lockRadius = GetRotation();
		DeterministicShape shapeData = skill_RayAttack_Dark2.GetShapeData(DeterministicShape.ShapeType.Fan, position2, default, default, rotation, default, lockAngle, lockRadius);
		if (GetTargetsFromShape(shapeData, null, includeSelf: false, attackTarget).Count > 0)
		{
			StartCor(AttackTwice(attackTarget, shapeData));
			IsAttackTwice = true;
		}
		StopEffect(_lockFxId);
		Skill_RayAttack_Dark skill_RayAttack_Dark3 = this;
		Skill_RayAttack_Dark skill_RayAttack_Dark4 = this;
		string linkEndFxPath = LinkEndFxPath;
		TSVector2 targetPosition2 = targetPosition;
		lockRadius = 0;
		skill_RayAttack_Dark3._lockendFxId = skill_RayAttack_Dark4.PlayLinkEffect(linkEndFxPath, useCustomSource: false, null, default, default, null, targetPosition2, lockRadius);
		PlayEarlyWarningEffect("EarlyWarningFX", (float)PrepareAttackDuration, default, targetPosition, default, 0.5f);
		yield return WaitTime(PrepareAttackDuration - 0.3);
		PlayEffect(HitFxPath);
		yield return WaitTime(0.3);
		if (!IsAttackTwice)
		{
			CancelAttack();
			yield return WaitCustomEvent("Attack");
			yield return StartCor(RayAttack(targetPosition, _lockendFxId));
			yield return WaitCombo(ComboAttackType.isComboFinish);
		}
		else
		{
			yield return StartCor(RayAttack(targetPosition, _lockendFxId));
			while (!IsTwiceAttackEnd)
			{
				yield return null;
			}
		}
	}

	protected override void OnSkillDisable()
	{
		StopEffect(_lockFxId);
		StopEffect(_lockendFxId);
		StopEffect(_lockendFxId2);
	}

	private IEnumerator RayAttack(TSVector2 Position, long LockEndFXID)
	{
		Skill_RayAttack_Dark skill_RayAttack_Dark = this;
		FP attackRadius = AttackRadius;
		DeterministicShape attackShape = skill_RayAttack_Dark.GetShapeData(DeterministicShape.ShapeType.Circle, Position, default, default, attackRadius);
		Skill_RayAttack_Dark skill_RayAttack_Dark2 = this;
		attackRadius = 3;
		HitFeatureData attackData = skill_RayAttack_Dark2.GetHitFeatureData(HitBox.FeatureFlag.None, default, default, UseAtttackForward: false, default, null, null, default, default, default, default, default, default, default, default, default, null, null, null, null, attackRadius);
		Skill_RayAttack_Dark skill_RayAttack_Dark3 = this;
		string bulletFxPath = BulletFxPath;
		TSVector2 targetPosition = Position;
		attackRadius = 0;
		skill_RayAttack_Dark3.PlayLinkEffect(bulletFxPath, useCustomSource: false, null, default, default, null, targetPosition, attackRadius);
		yield return WaitFrame(2);
		PlayEffect(LandFxPath, 1f, default, Position);
		yield return WaitFrame(1);
		AreaHit_Simple(_actor, attackShape, attackData, AttackDamage, 0.5, HitBox.HurtAnimType.Large, "HittedFX");
		StopEffect(LockEndFXID);
	}

	private IEnumerator AttackTwice(LogicEntity attackTarget, DeterministicShape lockShape)
	{
		FP lockingTime = 0;
		TSVector2 targetPosition = default;
		_lockFxId2 = PlayLinkEffect(LinkFxPath, useCustomSource: false, null, default, default, attackTarget);
		while (CheckTargetIsValid(attackTarget) && GetTargetsFromShape(lockShape, null, includeSelf: false, attackTarget).Count > 0 && lockingTime < LockDurationTwice)
		{
			targetPosition = GetEntityPositionObsoleted(attackTarget);
			lockingTime += _actor.LogicDeltaTime;
			yield return null;
		}
		StopEffect(_lockFxId2);
		Skill_RayAttack_Dark skill_RayAttack_Dark = this;
		Skill_RayAttack_Dark skill_RayAttack_Dark2 = this;
		string linkEndFxPath = LinkEndFxPath;
		TSVector2 targetPosition2 = targetPosition;
		FP targetPositionY = 0;
		skill_RayAttack_Dark._lockendFxId2 = skill_RayAttack_Dark2.PlayLinkEffect(linkEndFxPath, useCustomSource: false, null, default, default, null, targetPosition2, targetPositionY);
		PlayEarlyWarningEffect("EarlyWarningFX", (float)PrepareAttackDuration, default, targetPosition, default, 0.5f);
		yield return WaitTime(PrepareAttackDuration - 0.3);
		PlayEffect(HitFxPath);
		yield return WaitTime(0.3);
		CancelAttack();
		yield return WaitCustomEvent("Attack");
		yield return StartCor(RayAttack(targetPosition, _lockendFxId2));
		yield return WaitCombo(ComboAttackType.isComboFinish);
		IsTwiceAttackEnd = true;
	}
}
