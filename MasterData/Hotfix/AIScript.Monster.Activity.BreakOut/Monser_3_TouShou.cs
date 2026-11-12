using System.Collections;
using TrueSync;

namespace AIScript.Monster.Activity.BreakOut;

public class Monser_3_TouShou : SkillSimpleBase
{
	private TSVector2 SelfPos;

	protected override IEnumerator DoMainLogic()
	{
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
			CircleMultipleShoot("Weapon_50051DanZhuTouShou_Fire_TouShouFireBallBO", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 0, SelfPos, 1.5, multiShootDirection, 0, AimType.Position, BulletDirectionType.BulletToTarget, radius, 0, GetEntityPosition(attackTarget));
		}
	}
}
