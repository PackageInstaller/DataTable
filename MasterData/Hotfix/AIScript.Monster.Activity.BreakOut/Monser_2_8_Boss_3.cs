using System.Collections;
using TrueSync;

namespace AIScript.Monster.Activity.BreakOut;

public class Monser_2_8_Boss_3 : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Teleport01 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.T,
		ComboInputBuffer.ActionKey._1
	};

	private static readonly ComboInputBuffer.ActionKey[] Teleport02 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.T,
		ComboInputBuffer.ActionKey._2
	};

	private static readonly ComboInputBuffer.ActionKey[] Attack03 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.C };

	private TSVector2 SkillPos;

	private string Point1 = "MoveTo1";

	private string Point2 = "MoveTo2";

	private string Point3 = "MoveTo3";

	private string Point4 = "MoveTo4";

	protected override IEnumerator DoMainLogic()
	{
		yield return WaitTime(4);
		BeginAttack(1, Teleport01, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent("Disappear");
		SetHideModelEnable();
		SetUnparalleledEnable();
		SkillPos = GetPlaceHolderPosition(Point4);
		Teleport(SkillPos);
		yield return WaitTime(0.15);
		BeginAttack(1, Teleport02, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent("Appear");
		SetUnparalleledDisable();
		SetHideModelDisable();
		yield return WaitCombo(ComboAttackType.isComboFinish);
		GetPlaceHolderPosition("Target1");
		BeginLookAtCameraDir(DirectionType.Down, default, 400);
		yield return WaitTime(0.6);
		yield return WaitTime(0.8);
		DoShoot05();
		yield return WaitTime(2);
		DoShoot04();
		yield return WaitTime(2);
		DoShoot03();
		yield return WaitTime(3);
		yield return WaitTime(3);
	}

	protected void DoShoot03()
	{
		TSVector2 shootPosition = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(9, 4));
		CircleMultipleShoot("Bullet_50181_ShunYiGuai_Fire_Skill03_2_BO2", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 0, shootPosition, 1.2, GetForward(), 0, AimType.Default, BulletDirectionType.ActorToBullet, 0, 0);
	}

	protected void DoShoot04()
	{
		TSVector2 shootPosition = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 4));
		CircleMultipleShoot("Bullet_50181_ShunYiGuai_Fire_Skill03_2_BO2", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 0, shootPosition, 1.2, GetForward(), 0, AimType.Default, BulletDirectionType.ActorToBullet, 0, 0);
	}

	protected void DoShoot05()
	{
		TSVector2 shootPosition = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(-9, 4));
		CircleMultipleShoot("Bullet_50181_ShunYiGuai_Fire_Skill03_2_BO2", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 0, shootPosition, 1.2, GetForward(), 0, AimType.Default, BulletDirectionType.ActorToBullet, 0, 0);
	}
}
