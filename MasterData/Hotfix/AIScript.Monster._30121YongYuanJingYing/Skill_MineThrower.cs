using System.Collections;
using TrueSync;

namespace AIScript.Monster._30121YongYuanJingYing;

public class Skill_MineThrower : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Attack = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.D };

	private static readonly string BulletName = "Skill2_Bullet";

	private TSVector2 SelfPos;

	private TSVector2 TargetPos;

	protected FP shootOffsetX = 0.75;

	protected FP shootOffsetY = 1.15;

	protected FP shootHeight = 2.6;

	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		LogicEntity target = GetAttackTarget();
		BeginLookAt_NotWait(target, 0.5, 300);
		yield return WaitTime(0.5);
		BeginAttack(1, Attack, flushInputedKeys: true);
		AimAtTarget(target, 160);
		yield return WaitTime(1.57);
		CancelAim();
		SelfPos = GetPosition();
		FP fP = Distance(SelfPos, GetEntityPositionObsoleted(GetAttackTarget()));
		RotateTo(GetForward(), CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true));
		if (fP < 5)
		{
			TargetPos = GetPosition() + TSVector2.Rotate(new TSVector2(0, 6), _actor.tsTransform.Rotation);
		}
		else
		{
			TargetPos = GetEntityPositionObsoleted(GetCurrentPlayer());
		}
		Skill_MineThrower skill_MineThrower = this;
		Skill_MineThrower skill_MineThrower2 = this;
		TSVector2 targetPos = TargetPos;
		FP radius = 4;
		FP innerRadius = 0;
		TSVector2 shapeRandomPoint = skill_MineThrower.GetShapeRandomPoint(skill_MineThrower2.GetShapeData(DeterministicShape.ShapeType.Circle, targetPos, default, default, radius, innerRadius), GetCurrentPlayer(), isReachable: true);
		_ = SelfPos + TSVector2.Rotate(new TSVector2(0, 1.15), _actor.tsTransform.Rotation);
		CircleMultipleShoot(BulletName, AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 0, SelfPos, 2.6, GetForward(), 0, AimType.Position, BulletDirectionType.ActorToBullet, 30, 0, shapeRandomPoint);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		yield return WaitTime(0.5);
	}
}
