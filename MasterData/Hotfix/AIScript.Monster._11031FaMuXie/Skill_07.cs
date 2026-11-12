using System.Collections;
using System.Collections.Generic;

namespace AIScript.Monster._11031FaMuXie;

public class Skill_07 : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] Attack = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.G };

	private long WeaponId1;

	private long WeaponId2;

	private long WeaponId3;

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Attack, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent("Turn");
		BeginLookAt_NotWait(GetCurrentPlayer(), 0.5, 500);
		yield return WaitCustomEvent("TurnEnd");
		StopWaitLookAt();
		yield return WaitCustomEvent("Add");
		AddBuffToTarget(_actor, 110310010, 3);
		WeaponId1 = ShootWeapon("Weapon_11031FaMuXie_Skill07_1", GetPosition(), 0, default, _actor);
		if (GetMonsterTagValue(_actor, 1) == "Lv2")
		{
			WeaponId2 = ShootWeapon("Weapon_11031FaMuXie_Skill07_2", GetPosition(), 0, default, _actor);
			WeaponId3 = ShootWeapon("Weapon_11031FaMuXie_Skill07_3", GetPosition(), 0, default, _actor);
		}
		SetLogicTagListLongValue(_actor, "FaMuXieWeaponList", new List<long> { WeaponId1, WeaponId2, WeaponId3 });
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
