using System.Collections;
using TrueSync;

namespace AIScript.Monster._Earth._50311DaWuGui;

public class Earth_Attack06 : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] Atk = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.F };

	private TSVector2 SelfPos;

	private TSVector2 ShootPos;

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Atk, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent("Turn01");
		BeginLookAt_NotWait(GetCurrentPlayer(), 0.3, 120);
		yield return WaitCustomEvent("Spawn");
		SelfPos = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 2));
		ShootPos = GetEntityPositionObsoleted(GetCurrentPlayer()) - SelfPos;
		Wave01();
		yield return WaitCustomEvent("Shoot");
		Shoot01();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected void Wave01()
	{
		FanMultipleShoot("Bullet_50311_DaWuGui_Skill06_Wave", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 3, 0, SelfPos, 0, ShootPos, 0, AimType.Default, BulletDirectionType.ActorToBullet, 360, 0, 0);
	}

	protected void Shoot01()
	{
		if (GetBuffNum(_actor, 503110002) >= 1)
		{
			FanMultipleShoot("Bullet_50311_DaWuGui_Skill06", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 3, 0, SelfPos, 0, ShootPos, 0, AimType.Default, BulletDirectionType.ActorToBullet, 360, 0, 0);
		}
		else
		{
			FanMultipleShoot("Bullet_50311_DaWuGui_Skill06", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 3, 0, SelfPos, 0, ShootPos, 0, AimType.Default, BulletDirectionType.ActorToBullet, 360, 0, 0);
		}
	}
}
