using System.Collections;
using TrueSync;

namespace AIScript.Monster._13011YuanChengHuiFeng;

public class Skill_ShootCureWeapon : SkillSimpleBase
{
	protected override IEnumerator DoMainLogic()
	{
		LogicEntity _target = GetCurrentPlayer();
		BeginAttack(1, "Cure", flushInputedKeys: true);
		BeginLookAt_NotWait(_target, 999, 120);
		yield return WaitCustomEvent("Shoot");
		StopWaitLookAt();
		Shoot("HealWeaponEP9_1", TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 1)), 0.9, 0, GetForward(), AimType.Target, BulletDirectionType.BulletToTarget, default, _target);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		yield return WaitTime(1);
		_actor.DestroySelf();
	}
}
