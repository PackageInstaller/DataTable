using System.Collections;
using TrueSync;

namespace AIScript.Monster._15510FengNiao;

public class Skill_Flower_Shoot : SkillSimpleBase
{
	private TSVector2 ShootStartPosition;

	private long AimLineFX;

	private long AimLineFX2;

	private LogicEntity MasterBird;

	private bool IsBossRush;

	private int BulletAmount;

	private FP Phase;

	protected override void OnSkillEnable()
	{
		StartCor(CheckUltraSkill());
		MasterBird = GetTargetByTeammateIndex(0).get_Item(0);
		IsBossRush = GetLogicTagToggleValue(MasterBird, "IsBossRush");
		Phase = GetLogicTagFpValue(MasterBird, "BattleStage");
		BulletAmount = 1;
		if (IsBossRush && Phase == 3)
		{
			BulletAmount = 2;
		}
		SetLogicTagToggleValue(_actor, "Shoot", value: false);
	}

	protected override void OnSkillDisable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		if (BulletAmount == 2)
		{
			Skill_Flower_Shoot skill_Flower_Shoot = this;
			Skill_Flower_Shoot skill_Flower_Shoot2 = this;
			TSVector2 position = GetPosition();
			FP angle = GetRotation() - 15;
			skill_Flower_Shoot.AimLineFX = skill_Flower_Shoot2.PlayEffect("AimLine", 1f, default, position, angle, 1.5f);
			Skill_Flower_Shoot skill_Flower_Shoot3 = this;
			Skill_Flower_Shoot skill_Flower_Shoot4 = this;
			position = GetPosition();
			angle = GetRotation() + 15;
			skill_Flower_Shoot3.AimLineFX2 = skill_Flower_Shoot4.PlayEffect("AimLine", 1f, default, position, angle, 1.5f);
		}
		else
		{
			Skill_Flower_Shoot skill_Flower_Shoot5 = this;
			Skill_Flower_Shoot skill_Flower_Shoot6 = this;
			TSVector2 position = GetPosition();
			FP angle = GetRotation();
			skill_Flower_Shoot5.AimLineFX = skill_Flower_Shoot6.PlayEffect("AimLine", 1f, default, position, angle, 1.5f);
		}
		PlayEffect("StraightShootFX");
		ShootStartPosition = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 1.8));
		yield return WaitTime(0.65);
		StopEffect(AimLineFX);
		if (BulletAmount == 2)
		{
			StopEffect(AimLineFX2);
		}
		yield return WaitTime(0.3);
		FanMultipleShoot("Weapon_StraightBird", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, BulletAmount, 0, ShootStartPosition, 0, GetForward(), 0, AimType.Default, BulletDirectionType.BulletToTarget, 30, 1, 0);
		yield return WaitTime(1);
	}

	private IEnumerator CheckUltraSkill()
	{
		while (!GetLogicTagToggleValue(MasterBird, "InterruptShootSkill"))
		{
			yield return null;
		}
		InterruptSkill();
	}
}
