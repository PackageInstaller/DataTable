using System.Collections;
using TrueSync;

namespace AIScript.Monster._10007KuangFengQingXiao;

public class Skill1_Tornado : SkillSimpleBase
{
	private readonly FP _rotateSpeed = 300;

	private readonly FP _duration = 0.8;

	private readonly FP _waitSeconds = 0;

	private readonly ComboInputBuffer.ActionKey[] _actionKeys = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.B };

	protected override IEnumerator DoMainLogic()
	{
		yield return WaitTime(0.1);
		LogicEntity attackTarget = GetAttackTarget();
		BeginLookAt_NotWait(attackTarget, _duration, _rotateSpeed);
		yield return WaitTime(_waitSeconds);
		BeginAttack(1, _actionKeys, flushInputedKeys: true);
		yield return WaitTime(1.1);
		CancelAttack();
		TSVector2 shootPosition = GetPosition() + TSVector2.Rotate(new TSVector2(0, 2f), _actor.tsTransform.Rotation);
		attackTarget = GetAttackTarget(isUpToDate: true);
		TSVector2 entityPosition = GetEntityPosition(attackTarget);
		FanMultipleShoot("Weapon_10007KuangFengQingXiao_TornadoStart", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: true, 0, 1, 0, shootPosition, 4, GetForward(), 0, AimType.Position, BulletDirectionType.BulletToTarget, 30, 10, 0, entityPosition);
		Skill1_Tornado skill1_Tornado = this;
		FP radius = 7;
		FP innerRadius = 4;
		DeterministicShape shapeData = skill1_Tornado.GetShapeData(DeterministicShape.ShapeType.Circle, entityPosition, default, default, radius, innerRadius);
		TSVector2 shapeRandomPoint = GetShapeRandomPoint(shapeData, attackTarget, isReachable: true);
		FanMultipleShoot("Weapon_10007KuangFengQingXiao_TornadoStart", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: true, 0, 1, 0, shootPosition, 4, GetForward(), 0, AimType.Position, BulletDirectionType.BulletToTarget, 30, 10, 0, shapeRandomPoint);
		Skill1_Tornado skill1_Tornado2 = this;
		innerRadius = 9;
		radius = 8;
		DeterministicShape shapeData2 = skill1_Tornado2.GetShapeData(DeterministicShape.ShapeType.Circle, shapeRandomPoint, default, default, innerRadius, radius);
		TSVector2 shapeRandomPoint2 = GetShapeRandomPoint(shapeData2, attackTarget, isReachable: true);
		if (GetLogicTagFpValue(_actor, "BossStage") == 2)
		{
			FanMultipleShoot("Weapon_10007KuangFengQingXiao_TornadoStart", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: true, 0, 1, 0, shootPosition, 4, GetForward(), 0, AimType.Position, BulletDirectionType.BulletToTarget, 30, 10, 0, shapeRandomPoint2);
		}
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
