using System.Collections;
using TrueSync;

namespace AIScript.Monster._50141TaLu;

public class Skill_RayAttack_Earth : SkillSimpleBase
{
	private static readonly string LinkFxPath = "lineFX";

	private static readonly string LinkEndFxPath = "lineEndFX";

	private static readonly string BulletFxPath = "bulletFX";

	private static readonly string LandFxPath = "landFX";

	private static readonly string LandFxPath2 = "landFX2";

	private static readonly string HitFxPath = "hitFX";

	private static readonly FP LockRadius = 12;

	private static readonly FP LockAngle = 150;

	private static readonly FP LockDuration = 3;

	private static readonly FP PrepareAttackDuration = 2;

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
		Skill_RayAttack_Earth skill_RayAttack_Earth = this;
		TSVector2 position = GetPosition();
		FP lockRadius = LockRadius;
		FP lockAngle = LockAngle;
		FP rotation = GetRotation();
		DeterministicShape lockShape = skill_RayAttack_Earth.GetShapeData(DeterministicShape.ShapeType.Fan, position, default, default, lockRadius, default, lockAngle, rotation);
		while (CheckTargetIsValid(attackTarget) && GetTargetsFromShape(lockShape, null, includeSelf: false, attackTarget).Count > 0 && lockingTime < LockDuration)
		{
			targetPosition = GetEntityPositionObsoleted(attackTarget);
			lockingTime += _actor.LogicDeltaTime;
			yield return null;
		}
		StopEffect(_lockFxId);
		Skill_RayAttack_Earth skill_RayAttack_Earth2 = this;
		Skill_RayAttack_Earth skill_RayAttack_Earth3 = this;
		string linkEndFxPath = LinkEndFxPath;
		TSVector2 targetPosition2 = targetPosition;
		rotation = 0;
		skill_RayAttack_Earth2._lockendFxId = skill_RayAttack_Earth3.PlayLinkEffect(linkEndFxPath, useCustomSource: false, null, default, default, null, targetPosition2, rotation);
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
		TSVector2 AttackForward = Position - GetPosition();
		Skill_RayAttack_Earth skill_RayAttack_Earth = this;
		FP attackRadius = AttackRadius;
		DeterministicShape attackShape = skill_RayAttack_Earth.GetShapeData(DeterministicShape.ShapeType.Circle, Position, default, default, attackRadius);
		Skill_RayAttack_Earth skill_RayAttack_Earth2 = this;
		attackRadius = 2.5;
		FP innerRadius = 1;
		FP angle = 120;
		FP tSVectToAngle = GetTSVectToAngle(AttackForward, 0);
		skill_RayAttack_Earth2.GetShapeData(DeterministicShape.ShapeType.Fan, Position, default, default, attackRadius, innerRadius, angle, tSVectToAngle);
		Skill_RayAttack_Earth skill_RayAttack_Earth3 = this;
		tSVectToAngle = 3;
		HitFeatureData attackData = skill_RayAttack_Earth3.GetHitFeatureData(HitBox.FeatureFlag.None, default, default, UseAtttackForward: false, default, null, null, default, default, default, default, default, default, default, default, default, null, null, null, null, tSVectToAngle);
		Skill_RayAttack_Earth skill_RayAttack_Earth4 = this;
		string bulletFxPath = BulletFxPath;
		TSVector2 targetPosition = Position;
		tSVectToAngle = 0;
		skill_RayAttack_Earth4.PlayLinkEffect(bulletFxPath, useCustomSource: false, null, default, default, null, targetPosition, tSVectToAngle);
		yield return WaitFrame(2);
		PlayEffect(LandFxPath, 1f, default, Position);
		Skill_RayAttack_Earth skill_RayAttack_Earth5 = this;
		string landFxPath = LandFxPath2;
		targetPosition = Position;
		tSVectToAngle = GetTSVectToAngle(AttackForward, 0);
		skill_RayAttack_Earth5.PlayEffect(landFxPath, 1f, default, targetPosition, tSVectToAngle);
		Skill_RayAttack_Earth skill_RayAttack_Earth6 = this;
		string landFxPath2 = LandFxPath2;
		targetPosition = Position;
		tSVectToAngle = GetTSVectToAngle(AttackForward, 120);
		skill_RayAttack_Earth6.PlayEffect(landFxPath2, 1f, default, targetPosition, tSVectToAngle);
		Skill_RayAttack_Earth skill_RayAttack_Earth7 = this;
		string landFxPath3 = LandFxPath2;
		targetPosition = Position;
		tSVectToAngle = GetTSVectToAngle(AttackForward, 240);
		skill_RayAttack_Earth7.PlayEffect(landFxPath3, 1f, default, targetPosition, tSVectToAngle);
		yield return WaitFrame(1);
		AreaHit_Simple(_actor, attackShape, attackData, AttackDamage, 0.5, HitBox.HurtAnimType.Large, "HittedFX");
		CircleMultipleShoot("ParabolaWeapon_50141Talu_Earth", alignShootDelay: 0, duration: 0, shootPosition: Position, shootPositionY: 0, bulletDirectionOffset: 0, multipleShootStyle: AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, bulletCount: 3, multiShootDirection: RotateTo(TSVector2.up, GetRandomValue(0, 360)), aimType: AimType.Default, bulletDirectionType: BulletDirectionType.ActorToBullet, radius: 3, innerRadius: 1);
		StopEffect(_lockendFxId);
	}
}
