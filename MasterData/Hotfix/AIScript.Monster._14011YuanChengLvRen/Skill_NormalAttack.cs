using System.Collections;
using TrueSync;

namespace AIScript.Monster._14011YuanChengLvRen;

public class Skill_NormalAttack : SkillSimpleBase
{
	private static readonly FP _rotateSpeed = 240;

	private static readonly FP _duration = 0.8;

	private static readonly string bulletPath = "Weapon_14011_GuideBullet";

	private static readonly ComboInputBuffer.ActionKey[] _actionKeys = new ComboInputBuffer.ActionKey[1];

	protected override IEnumerator DoMainLogic()
	{
		LogicEntity attackTarget = GetAttackTarget();
		BeginAttack(1, _actionKeys, flushInputedKeys: true);
		BeginLookAt_NotWait(attackTarget, 0.6, _rotateSpeed);
		yield return WaitTime(1.01);
		TSVector2 targetPosition = _actor.tsTransform.Position + TSVector2.Rotate(new TSVector2(0, 7), _actor.tsTransform.Rotation);
		TSVector2 startPosition = _actor.tsTransform.Position + TSVector2.Rotate(new TSVector2(0.5f, 0.5f), _actor.tsTransform.Rotation);
		TSVector2 startPosition2 = _actor.tsTransform.Position + TSVector2.Rotate(new TSVector2(-0.5f, 0.5f), _actor.tsTransform.Rotation);
		TSVector2 entityForward = GetEntityForward(_actor);
		Shoot1(startPosition, targetPosition, entityForward);
		Shoot2(startPosition2, targetPosition, entityForward);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		_skill.Clear();
	}

	private void Shoot1(TSVector2 _startPosition1, TSVector2 _targetPosition, TSVector2 _shootDirection)
	{
		FanMultipleShoot(bulletPath, AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: true, 0, 1, 0, _startPosition1, 1.1, _shootDirection, 60, AimType.Position, BulletDirectionType.ActorToBullet, 30, 5, 0, _targetPosition);
	}

	private void Shoot2(TSVector2 _startPosition2, TSVector2 _targetPosition, TSVector2 _shootDirection)
	{
		FanMultipleShoot(bulletPath, AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: true, 0, 1, 0, _startPosition2, 1.1, _shootDirection, 0, AimType.Position, BulletDirectionType.ActorToBullet, 30, 5, 0, _targetPosition);
	}
}
