using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._15501;

public class Skill_AtkBase_LB : SkillSimpleBase
{
	private int perkId_3 = 515503;

	private string evt_shoot_3 = "Shoot_P3";

	private List<string> bullets_3 = new List<string> { "Bullet_15501_Summon_Attack_Black_Missile_P03_1", "Bullet_15501_Summon_Attack_Black_Missile_P03_2", "Bullet_15501_Summon_Attack_Black_Missile_P03_3", "Bullet_15501_Summon_Attack_Black_Missile_P03_4" };

	private TSVector shootOffset_3 = new TSVector(0, 1.8, 0);

	private int targetCount_3 = 4;

	private FP radius_3 = 10;

	private int perkId_8 = 515508;

	private int clearEvt = CommonHelper.StringToHash("clearEvt");

	private List<LogicEntity> monsters = new List<LogicEntity>();

	private AdventureActor summoner;

	protected virtual string keyBase => string.Empty;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		summoner = (_actor as MonsterAdventureActor).monsterSummonInfo.SummonActor;
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		monsters.Clear();
	}

	protected override IEnumerator DoMainLogic()
	{
		if (GetPerk(perkId_8))
		{
			AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
			adventureActorCustomEvent.eventHashCode = clearEvt;
			summoner.DispatchEvent(adventureActorCustomEvent);
		}
		_ = _actor.monsterTarget;
		string actionKey = keyBase;
		BeginAttack(1, actionKey, flushInputedKeys: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnCustomEvent(int comboIndex, string evt)
	{
		if (!GetPerk(perkId_3) || !evt.Equals(evt_shoot_3))
		{
			return;
		}
		CommonUtils.SearchNearTargetsByCircle(_actor, radius_3, isConfront: true, includeSelf: false, monsters);
		if (monsters.Count <= 0)
		{
			return;
		}
		TSVector2 position = _actor.tsTransform.Position + new TSVector2(shootOffset_3.x, shootOffset_3.z);
		FP y = shootOffset_3.y;
		for (int i = 0; i < targetCount_3; i++)
		{
			if (i < monsters.Count)
			{
				string weaponAlias = bullets_3.get_Item(i);
				AdventureActor actor = _actor;
				FP positionY = y;
				LogicEntity target = monsters.get_Item(i);
				ILRuntimeAPI.Shoot(weaponAlias, actor, position, default, positionY, target);
			}
		}
	}

	protected override void OnInterrupt(int comboIndex)
	{
		_skill.Clear();
	}
}
