using System.Collections;
using TrueSync;

namespace AIScript.Monster.Activity.BreakOut;

public class Monser_3_TouShouBoss_Attack : SkillSimpleBase
{
	private TSVector2 SelfPos;

	protected override IEnumerator DoMainLogic()
	{
		yield return BeginLookAtByPos(GetEntityPosition(GetAttackTarget()), 0, 180);
		BeginAttack(1, "Shoot", flushInputedKeys: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
		if (eventName == "Shoot")
		{
			SelfPos = GetPosition();
			LogicEntity attackTarget = GetAttackTarget();
			FP radius = Distance(SelfPos, GetEntityPosition(attackTarget));
			TSVector2 multiShootDirection = RotateTo(GetForward(), CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true));
			FanMultipleShoot("Weapon_50051DanZhuTouShou_Fire_TouShouFireBallBO", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 3, 0, SelfPos, 1.5, multiShootDirection, 0, AimType.Default, BulletDirectionType.BulletToTarget, 30, radius, 0);
		}
	}
}
