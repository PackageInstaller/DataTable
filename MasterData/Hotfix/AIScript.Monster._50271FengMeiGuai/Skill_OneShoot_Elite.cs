using System.Collections;
using System.Collections.Generic;

namespace AIScript.Monster._50271FengMeiGuai;

public class Skill_OneShoot_Elite : SkillSimpleBase
{
	private LogicEntity target;

	private Dictionary<string, string> bulletAliasDic = new Dictionary<string, string>
	{
		{ "Wind", "FengMeiGuai_skill01_bullet_wind" },
		{ "Dark", "FengMeiGuai_skill01_bullet_dark" },
		{ "Earth", "FengMeiGuai_skill01_bullet_earth" },
		{ "Fire", "FengMeiGuai_skill01_bullet_fire" },
		{ "Light", "FengMeiGuai_skill01_bullet_light" },
		{ "Common", "FengMeiGuai_skill01_bullet_common" },
		{ "Water", "FengMeiGuai_skill01_bullet_water" }
	};

	private readonly int OneShootIndex;

	private readonly string OneShootKey = "OneShoot";

	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		if (CheckTargetIsValid(GetAttackTarget()))
		{
			target = GetAttackTarget();
		}
		else
		{
			target = GetCurrentPlayer();
		}
		BeginLookAt_NotWait(target, 3, 80);
		BeginAttack(OneShootIndex, OneShootKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		yield return WaitTime(0.35);
		PlayEffect("fx_common_base_charge_fire_actor", 1f, 2, GetPosition(), default, 1.5f);
		yield return WaitTime(0.15);
		CancelAttack();
		yield return WaitTime(0.15);
		ShootBullet();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private void ShootBullet()
	{
		string monsterTagValue = GetMonsterTagValue(_actor, 1);
		if (!bulletAliasDic.TryGetValue(monsterTagValue, out var value))
		{
			value = bulletAliasDic.get_Item("Wind");
		}
		FanMultipleShoot(value, AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 0, GetPosition(), 0.5, GetForward(), 0, AimType.Default, BulletDirectionType.ActorToBullet, 5, 0, 3);
	}
}
