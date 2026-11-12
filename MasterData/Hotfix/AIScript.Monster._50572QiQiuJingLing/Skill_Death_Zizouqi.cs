using System.Collections;
using TrueSync;

namespace AIScript.Monster._50572QiQiuJingLing;

public class Skill_Death_Zizouqi : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Spawn_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey._1 };

	private static readonly ComboInputBuffer.ActionKey[] Expansion2to3_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.H };

	private static readonly ComboInputBuffer.ActionKey[] Death_Blast_Combo_3 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.F };

	private static readonly int BulletAmount_Lv2 = 8;

	private FP SkillMode = 1;

	private ComboInputBuffer.ActionKey[] DeathCombo;

	private int BulletAmount;

	private TSVector2 ShootDirection;

	protected override void OnSkillEnable()
	{
		DeathCombo = Death_Blast_Combo_3;
		BulletAmount = BulletAmount_Lv2;
		ShootDirection = RotateTo(GetPosition() - GetEntityPosition(GetAttackTarget()), 360 / (2 * BulletAmount));
	}

	protected override void OnSkillDisable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(3, DeathCombo, flushInputedKeys: true);
		AddBuffToTarget(_actor, 505729902);
		yield return WaitCustomEvent("Blast");
		PlayWwiseSound("mon_50572_charge_splitbullet");
		CircleMultipleShoot("Weapon_Shoot", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: true, 0, BulletAmount, 0, GetPosition(), 1.5, ShootDirection, 0, AimType.Default, BulletDirectionType.ActorToBullet, 0, 0);
		SetHideModelEnable();
		SendDeclareDeadEvent();
		yield return WaitTime(1);
	}
}
