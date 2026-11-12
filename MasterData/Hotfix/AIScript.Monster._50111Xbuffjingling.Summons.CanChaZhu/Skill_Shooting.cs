using System.Collections;
using TrueSync;

namespace AIScript.Monster._50111Xbuffjingling.Summons.CanChaZhu;

public class Skill_Shooting : SkillSimpleBase
{
	protected override IEnumerator DoMainLogic()
	{
		LogicEntity target = GetTarget();
		int shootCount = (int)(long)GetLogicTagFpValue(_actor, "ShootCount");
		yield return BeginLookAt(target, 0.5, 360);
		BeginAttack(0, new ComboInputBuffer.ActionKey[1], flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(0.3);
		PlayEffect("fx_monster_base_waring", 1f, 1, GetPosition(), default, 1.5f);
		yield return WaitTime(0.2);
		for (int i = 0; i < shootCount; i++)
		{
			Shooting(1, 120 + i * 15);
			yield return WaitTime(0.25);
		}
		SetLogicTagFpValue(_actor, "ShootCount", 1);
	}

	private LogicEntity GetTarget()
	{
		LogicEntity logicEntity = null;
		if (CheckTargetIsValid(GetAttackTarget()))
		{
			return GetAttackTarget();
		}
		return GetCurrentPlayer();
	}

	private void Shooting(int bulletCount, FP angle)
	{
		string bulletAlias = "50111BuffJingLing_bulletc_earth";
		TSVector2 forward = GetForward();
		TSVector2 multiShootDirection = RotateTo(forward, angle);
		TSVector2 multiShootDirection2 = RotateTo(forward, -angle);
		FanMultipleShoot(bulletAlias, AdventureWeapon.MultipleShootStyle.FromLeftToRight, alignShoot: true, 0, bulletCount, 0, GetPosition(), 0.5, multiShootDirection, 0, AimType.Default, BulletDirectionType.ActorToBullet, 20, 0, 1.5);
		FanMultipleShoot(bulletAlias, AdventureWeapon.MultipleShootStyle.FromRightToLeft, alignShoot: true, 0, bulletCount, 0, GetPosition(), 0.5, multiShootDirection2, 0, AimType.Default, BulletDirectionType.ActorToBullet, 20, 0, 1.5);
	}
}
