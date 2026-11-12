using System.Collections;
using TrueSync;

namespace AIScript.Monster._10007KuangFengQingXiao;

public class Skill3_GuideShoot : SkillSimpleBase
{
	private readonly FP _rotateSpeed = 300;

	private readonly FP _duration = 0.8;

	private readonly FP _waitSeconds = 0;

	private readonly ComboInputBuffer.ActionKey[] _actionKeys = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.D,
		ComboInputBuffer.ActionKey.D
	};

	private readonly string bullet1 = "Weapon_10007KuangFengQingXiao_GuideShoot";

	private readonly string bullet2 = "Weapon_10007KuangFengQingXiao_GuideShootPlus";

	private readonly string bullet3 = "Weapon_10007KuangFengQingXiao_GuideShootPlus2";

	protected override IEnumerator DoMainLogic()
	{
		yield return WaitTime(0.1);
		LogicEntity attackTarget = GetAttackTarget();
		BeginLookAt_NotWait(attackTarget, _duration, _rotateSpeed);
		yield return WaitTime(_duration);
		BeginAttack(1, _actionKeys, flushInputedKeys: true);
		doshoot();
		yield return WaitCombo(ComboAttackType.isComboFinish);
		yield return WaitTime(2);
	}

	private void doshoot()
	{
		TSVector2 shootPosition = GetPosition() + TSVector2.Rotate(new TSVector2(0, 0f), _actor.tsTransform.Rotation);
		LogicEntity attackTarget = GetAttackTarget(isUpToDate: true);
		GetEntityPosition(attackTarget);
		if (GetLogicTagFpValue(_actor, "BossStage") == 2)
		{
			FanMultipleShoot(bullet1, AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: true, 1, 6, 0.9, shootPosition, 1.8, GetForward(), 0, AimType.Default, BulletDirectionType.ActorToBullet, 270, 10, 2);
		}
		else
		{
			FanMultipleShoot(bullet1, AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: true, 1, 6, 0.9, shootPosition, 1.8, GetForward(), 0, AimType.Default, BulletDirectionType.ActorToBullet, 270, 10, 3);
		}
	}
}
