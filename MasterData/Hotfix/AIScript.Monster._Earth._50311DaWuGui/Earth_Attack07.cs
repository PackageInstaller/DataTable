using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._Earth._50311DaWuGui;

public class Earth_Attack07 : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] Atk_1 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.G,
		ComboInputBuffer.ActionKey._1
	};

	private readonly ComboInputBuffer.ActionKey[] Atk_2 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.G,
		ComboInputBuffer.ActionKey._2
	};

	private readonly ComboInputBuffer.ActionKey[] Atk_3 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.G,
		ComboInputBuffer.ActionKey._3
	};

	protected override void OnInterrupt(int comboIndex)
	{
		List<LogicEntity> targetByTeammateIndex = GetTargetByTeammateIndex(2);
		ClearActors(targetByTeammateIndex);
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Atk_1, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent("D01");
		DoShoot01();
		yield return WaitCustomEvent("D02");
		DoShoot02();
		yield return WaitCustomEvent("D03");
		DoShoot03();
		yield return WaitCustomEvent("StartEnd");
		BeginAttack(2, Atk_2, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(1);
		CancelAttack();
		BeginAttack(3, Atk_3, flushInputedKeys: true, forceInterruptAttack: true);
		SetCloseBlockEnable();
		SetUnparalleledEnable();
		yield return WaitCustomEvent("InAir");
		Teleport(new TSVector2(1, 1));
		SummonTeammate(2, new TSVector2(1, 1), GetForward());
		yield return WaitTime(0.65);
		CancelAttack();
		BeginLookAt_NotWait(GetCurrentPlayer(), 0.15, 3600);
		yield return WaitCustomEvent("Block");
		SetCloseBlockDisable();
		SetUnparalleledDisable();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected void DoShoot01()
	{
		TSVector2 shootPosition = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(-2.3, -3.1));
		if (GetBuffNum(_actor, 503110002) >= 1)
		{
			FanMultipleShoot("Bullet_50311_DaWuGui_Skill07", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 9, 0, shootPosition, 0, RotateTo(GetForward(), 100), 0, AimType.Default, BulletDirectionType.ActorToBullet, 160, 0, 0);
		}
		else
		{
			FanMultipleShoot("Bullet_50311_DaWuGui_Skill07", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 5, 0, shootPosition, 0, RotateTo(GetForward(), 100), 0, AimType.Default, BulletDirectionType.ActorToBullet, 160, 0, 0);
		}
	}

	protected void DoShoot02()
	{
		TSVector2 shootPosition = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(1.8, -3));
		if (GetBuffNum(_actor, 503110002) >= 1)
		{
			FanMultipleShoot("Bullet_50311_DaWuGui_Skill07", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 9, 0, shootPosition, 0, RotateTo(GetForward(), 280), 0, AimType.Default, BulletDirectionType.ActorToBullet, 160, 0, 0);
		}
		else
		{
			FanMultipleShoot("Bullet_50311_DaWuGui_Skill07", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 5, 0, shootPosition, 0, RotateTo(GetForward(), 280), 0, AimType.Default, BulletDirectionType.ActorToBullet, 160, 0, 0);
		}
	}

	protected void DoShoot03()
	{
		TSVector2 shootPosition = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(-1.5, -3.1));
		if (GetBuffNum(_actor, 503110002) >= 1)
		{
			FanMultipleShoot("Bullet_50311_DaWuGui_Skill07", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 15, 0, shootPosition, 0, RotateTo(GetForward(), 0), 0, AimType.Default, BulletDirectionType.ActorToBullet, 360, 0, 0);
		}
		else
		{
			FanMultipleShoot("Bullet_50311_DaWuGui_Skill07", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 10, 0, shootPosition, 0, RotateTo(GetForward(), 0), 0, AimType.Default, BulletDirectionType.ActorToBullet, 360, 0, 0);
		}
	}
}
