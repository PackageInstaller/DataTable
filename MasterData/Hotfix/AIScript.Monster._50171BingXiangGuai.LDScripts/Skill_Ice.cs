using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._50171BingXiangGuai.LDScripts;

public class Skill_Ice : SkillBase
{
	private readonly int areaRadius = 12;

	private readonly int average_Radius = 2;

	private readonly int average_Angle = 3;

	private readonly FP angleOffset = 60;

	private readonly string atkFx = "fx_50171BingXiangGuai_base_Nattack_5_90";

	private readonly string hittedFx = "fx_50171BingXiangGuai_hit_Nattack";

	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		target = GetTarget();
		BeginAttack(generalATKIndex, generalATKKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		List<TSVector2> list = new List<TSVector2>();
		for (int i = 0; i < average_Radius; i++)
		{
			for (int j = 0; j < average_Angle; j++)
			{
				list.Add(TransLocalPosToWorldPos(TSVector2.zero, RotateTo(TSVector2.up, 360 / average_Angle * j + angleOffset * i), new TSVector2(0, areaRadius / average_Radius * (i + 1))));
			}
		}
		foreach (TSVector2 item in list)
		{
			yield return WaitTime(GetRandomValue(0.1, 0.7));
			FanMultipleShoot("50171BingXiangGuai_IceBullet", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 0, GetPosition(), 2.5, GetForward(), 0, AimType.Position, BulletDirectionType.ActorToBullet, 0, 3, 0, item);
		}
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
