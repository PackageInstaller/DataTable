using System.Collections;
using TrueSync;

namespace AIScript.Monster._10007KuangFengQingXiao;

public class Skill2_StormShoot : SkillSimpleBase
{
	private readonly FP _rotateSpeed = 300;

	private readonly FP _duration = 0.8;

	private readonly FP _waitSeconds = 0;

	private readonly ComboInputBuffer.ActionKey[] _actionKeys = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.C };

	protected override IEnumerator DoMainLogic()
	{
		yield return WaitTime(0.1);
		LogicEntity attackTarget = GetAttackTarget();
		BeginLookAt_NotWait(attackTarget, _duration, _rotateSpeed);
		yield return WaitTime(_duration);
		BeginAttack(1, _actionKeys, flushInputedKeys: true);
		CircleMultipleShoot("Weapon_10007KuangFengQingXiao_StormShoot", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: true, 1, 20, 1, GetPosition(), 1.8, GetForward(), 0, AimType.Position, BulletDirectionType.BulletToTarget, 3, 4, GetPosition());
		yield return WaitTime(2);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
		if (GetLogicTagFpValue(_actor, "BossStage") == 2)
		{
			shoot2();
			yield return WaitTime(1);
		}
		yield return WaitTime(1);
	}

	private void shoot2()
	{
		TSVector2 position = GetPosition();
		FP radius = 5;
		FP innerRadius = 4;
		FP angle = 360;
		FP rotation = 0;
		DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Fan, position, default, default, radius, innerRadius, angle, rotation);
		TSVector2 shapeRandomPoint = GetShapeRandomPoint(shapeData, _actor, isReachable: true);
		LogicEntity attackTarget = GetAttackTarget();
		GetEntityPosition(attackTarget);
		FanMultipleShoot("Weapon_10007KuangFengQingXiao_StormShoot", AdventureWeapon.MultipleShootStyle.FromLeftToRight, alignShoot: false, 0, 20, 1, shapeRandomPoint, 1.8, GetForward(), 0, AimType.Position, BulletDirectionType.BulletToTarget, 360, 3, 20, shapeRandomPoint);
	}
}
