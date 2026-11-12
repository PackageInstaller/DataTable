using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._15501;

public class Skill_Atk_BB : SkillSimpleBase
{
	private int keyIndex = 1;

	private string key_Base = "15501_Black_Main_Shoot";

	private TSVector shootOffset = new TSVector(0, 1.8, 0);

	private string evt_ShootP4 = "Shoot_P4";

	private int perkId_4 = 515504;

	private List<string> bullets_4 = new List<string> { "Bullet_15501_Summon_Main_Skill_Black_Missile_P04_1", "Bullet_15501_Summon_Main_Skill_Black_Missile_P04_2" };

	private int targetCount_4 = 2;

	private FP radius_4 = 10;

	private List<LogicEntity> monsters = new List<LogicEntity>();

	private LogicEntity target;

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		monsters.Clear();
	}

	protected override IEnumerator DoMainLogic()
	{
		target = _actor.attackTarget;
		string actionKey = key_Base;
		BeginAttack(keyIndex, actionKey, flushInputedKeys: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnCustomEvent(int comboIndex, string evt)
	{
		if (!GetPerk(perkId_4) || !evt.Equals(evt_ShootP4))
		{
			return;
		}
		CommonUtils.SearchNearTargetsByCircle(_actor, radius_4, isConfront: true, includeSelf: false, monsters);
		if (monsters.Count <= 0)
		{
			return;
		}
		TSVector2 position = _actor.tsTransform.Position + new TSVector2(shootOffset.x, shootOffset.z);
		FP y = shootOffset.y;
		for (int i = 0; i < targetCount_4; i++)
		{
			if (i < monsters.Count)
			{
				string weaponAlias = bullets_4.get_Item(i);
				AdventureActor actor = _actor;
				FP positionY = y;
				LogicEntity logicEntity = monsters.get_Item(i);
				ILRuntimeAPI.Shoot(weaponAlias, actor, position, default, positionY, logicEntity);
			}
		}
	}

	protected override void OnInterrupt(int comboIndex)
	{
		_skill.Clear();
	}
}
