using System.Collections;
using TrueSync;

namespace AIScript.Monster._10007KuangFengQingXiao;

public class Skill_Attack : SkillSimpleBase
{
	private readonly FP _rotateSpeed = 300;

	private readonly FP _duration = 0.8;

	private readonly FP _waitSeconds = 0;

	private readonly ComboInputBuffer.ActionKey[] _actionKeys = new ComboInputBuffer.ActionKey[1];

	private readonly string bullet1 = "Weapon_10007KuangFengQingXiao_Attack_Boss";

	private int bulletcount = 1;

	protected override IEnumerator DoMainLogic()
	{
		yield return WaitTime(0.1);
		LogicEntity attackTarget = GetAttackTarget();
		BeginLookAt_NotWait(attackTarget, _duration, _rotateSpeed);
		yield return WaitTime(_duration);
		BeginAttack(1, _actionKeys, flushInputedKeys: true);
		yield return WaitTime(0.67f);
		CancelAttack();
		yield return WaitCustomEvent("Shoot");
		TSVector2 shootPosition = GetPosition() + TSVector2.Rotate(new TSVector2(0, 0f), _actor.tsTransform.Rotation);
		if (GetLogicTagFpValue(_actor, "BossStage") == 2)
		{
			bulletcount = 2;
		}
		FanMultipleShoot(bullet1, AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, bulletcount, 0.5, shootPosition, 2, GetForward(), 0, AimType.Default, BulletDirectionType.ActorToBullet, 40, 10, 1.5f);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		yield return WaitTime(0.2);
	}
}
