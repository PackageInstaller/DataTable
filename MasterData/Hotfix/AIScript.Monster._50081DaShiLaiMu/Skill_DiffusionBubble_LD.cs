using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._50081DaShiLaiMu;

public class Skill_DiffusionBubble_LD : SkillSimpleBase
{
	private int branch;

	private const int diffTag1 = 500810000;

	private const int diffTag2 = 500810001;

	private const int diffTag3 = 500810002;

	private int shootCount;

	private int bulletCount;

	private FP angle;

	private string bullet = "DiffusionBubble";

	private static readonly string _DiffusionCombo = "DiffusionBubble";

	private static readonly int DiffusionComboIndex = 4;

	private static LogicEntity Target;

	protected override IEnumerator DoMainLogic()
	{
		List<BuffEntity> buffFromTarget = GetBuffFromTarget(_actor, 0, 500810000);
		if (buffFromTarget.Count != 0)
		{
			switch (buffFromTarget.get_Item(0).buffConfig.Id)
			{
			case 500810000:
				branch = 0;
				break;
			case 500810001:
				branch = 1;
				break;
			case 500810002:
				branch = 2;
				break;
			default:
				branch = 2;
				break;
			}
		}
		else
		{
			branch = 2;
		}
		Target = GetAttackTarget(isUpToDate: true);
		if (!CheckTargetIsValid(Target))
		{
			Target = GetCurrentPlayer();
		}
		BeginAttack(DiffusionComboIndex, _DiffusionCombo, flushInputedKeys: false, forceInterruptAttack: true);
		yield return WaitTime(1.7);
		PlayEffect("fx_common_base_charge_fire_actor", 1f, 2f, GetPosition(), default, 3f);
		yield return WaitTime(0.3);
		switch (branch)
		{
		case 0:
			shootCount = 3;
			bulletCount = 6;
			angle = 60;
			break;
		case 1:
			shootCount = 2;
			bulletCount = 11;
			angle = 110;
			break;
		case 2:
			shootCount = 1;
			bulletCount = 36;
			angle = 360;
			break;
		default:
			shootCount = 1;
			bulletCount = 36;
			angle = 360;
			break;
		}
		for (int i = 0; i < shootCount; i++)
		{
			TSVector2 multiShootDirection = RotateTo(GetForward(), 360 / shootCount * i);
			FanMultipleShoot(bullet, AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: true, 0, bulletCount, 0, TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 2)), 0, multiShootDirection, 0, AimType.Default, BulletDirectionType.ActorToBullet, angle, 0, 0);
		}
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
