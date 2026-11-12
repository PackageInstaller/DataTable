using System.Collections;
using TrueSync;

namespace AIScript.Monster._30121YongYuanJingYing;

public class Skill_TripleShoot : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Attack_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.B };

	private static readonly string windbullet = "Skill3_Bullet";

	protected readonly string eventShoot = "Shoot";

	protected TSVector2 bulletOffset = new TSVector2(0, 5);

	protected int _buttleCount;

	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
		_buttleCount = 0;
	}

	protected override IEnumerator DoMainLogic()
	{
		LogicEntity target = GetAttackTarget();
		BeginLookAt_NotWait(target, 1, 300);
		yield return WaitTime(1);
		BeginAttack(1, Attack_Combo, flushInputedKeys: true, forceInterruptAttack: true);
		AimAtTarget(target, 120);
		yield return WaitCustomEvent(eventShoot);
		while (_buttleCount < 2)
		{
			Shoot1();
			_buttleCount++;
			yield return WaitCustomEvent(eventShoot);
		}
		Shoot1();
		CancelAim();
		yield return WaitCustomEvent("ShootEnd");
		CancelAttack();
		_buttleCount = 0;
		yield return WaitTime(0.5);
	}

	private void Shoot1()
	{
		LogicEntity attackTarget = GetAttackTarget();
		if (!(attackTarget == null))
		{
			attackTarget = GetCurrentPlayer();
			TSVector2 position = attackTarget.tsTransform.Position;
			position = ((!(Distance(GetPosition(), GetEntityPositionObsoleted(GetAttackTarget())) < 5)) ? GetEntityPositionObsoleted(attackTarget) : (GetPosition() + TSVector2.Rotate(new TSVector2(0, 6), _actor.tsTransform.Rotation)));
			TSVector2 position2 = position;
			FP radius = 2;
			FP innerRadius = 0;
			TSVector2 shapeRandomPoint = GetShapeRandomPoint(GetShapeData(DeterministicShape.ShapeType.Circle, position2, default, default, radius, innerRadius), attackTarget, isReachable: true);
			TSVector2 position3 = GetPosition();
			TSVector2 entityForward = GetEntityForward(_actor);
			FanMultipleShoot(windbullet, AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: true, 0, 1, 0, position3, 4, entityForward, 60, AimType.Position, BulletDirectionType.ActorToBullet, 30, 5, 0, shapeRandomPoint);
		}
	}
}
