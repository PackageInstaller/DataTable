using System.Collections;
using System.Collections.Generic;
using AIScript.DynamicLevel;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.TowerDefense._16001;

public class SkillScript_Bounce : SkillSimpleBase
{
	private int keyIndex = 1;

	private string key_bounce = "BubbleDoll_Skill";

	private string evt_attack = "160_JumpBounce";

	private string areaEffect_attack = "AreaEffect_16001_TD_Bubble";

	private int perkId_2 = 1600102;

	private FP chargeRange_Defaut = 4;

	private FP chargePoint = 25;

	private int perkId_3 = 1600103;

	private readonly Dictionary<int, string> areaEffectByCastTimes_3 = new Dictionary<int, string>
	{
		{ 1, "AreaEffect_16001_TD_Bubble_P4_1" },
		{ 2, "AreaEffect_16001_TD_Bubble_P4_2" },
		{ 3, "AreaEffect_16001_TD_Bubble_P4_3" },
		{ 4, "AreaEffect_16001_TD_Bubble_P4_4" },
		{ 5, "AreaEffect_16001_TD_Bubble_P4_5" }
	};

	private int perkId_4 = 1600104;

	private int hitDamageId_4 = 80160022;

	private FP chargePoint_4 = 50;

	private string key_bounce_p4 = "BubbleDoll_Skill_1";

	private static readonly Dictionary<string, int> baselineHitDamageId = new Dictionary<string, int>();

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
	}

	protected override IEnumerator DoMainLogic()
	{
		string actionKey = (GetPerk(perkId_4) ? key_bounce_p4 : key_bounce);
		BeginAttack(keyIndex, actionKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
		base.OnCustomEvent(comboIndex, eventName);
		if (!(eventName == evt_attack))
		{
			return;
		}
		string areaAlias = GetAttackAreaEffect();
		bool overrideDamage = GetPerk(perkId_4);
		FP chargeRange = chargeRange_Defaut;
		ILRuntimeAPI.PlayAreaEffect(_actor, areaAlias, _actor.tsTransform.Position, default, (AreaEffectEntity entity) =>
		{
			SetupAreaDamage(entity, areaAlias, overrideDamage);
		}, null, (AreaEffectEntity entity) =>
		{
			if (entity != null)
			{
				chargeRange = entity.GetAreaRadius();
			}
			if (chargeRange < chargeRange_Defaut)
			{
				chargeRange = chargeRange_Defaut;
			}
		});
		if (GetPerk(perkId_2))
		{
			ChargeFriendlyInRange(chargeRange);
		}
	}

	private string GetAttackAreaEffect()
	{
		if (GetPerk(perkId_3))
		{
			int key = _actor.logicVariable.GetLogicTagValue(Action_Summon.logicTag_CastTimes).AsInt();
			if (areaEffectByCastTimes_3.TryGetValue(key, out var value))
			{
				return value;
			}
		}
		return areaEffect_attack;
	}

	private void SetupAreaDamage(AreaEffectEntity areaEffect, string alias, bool overrideDamage)
	{
		AreaEffect_AttackComponent areaEffect_AttackComponent = areaEffect?.GetAreaEffectComponent<AreaEffect_AttackComponent>();
		if (!(areaEffect_AttackComponent == null))
		{
			if (!baselineHitDamageId.TryGetValue(alias, out var value))
			{
				value = areaEffect_AttackComponent.hitDamageId;
				baselineHitDamageId.set_Item(alias, value);
			}
			areaEffect_AttackComponent.hitDamageId = (overrideDamage ? hitDamageId_4 : value);
		}
	}

	private void ChargeFriendlyInRange(FP chargeRange)
	{
		FP percent = (GetPerk(perkId_4) ? chargePoint_4 : chargePoint);
		List<LogicEntity> dynamicActors = ModuleController<AdventureModuleController>.Instance.levelInstance.dynamicActors;
		TSVector2 position = _actor.tsTransform.Position;
		for (int i = 0; i < dynamicActors.Count; i++)
		{
			if (dynamicActors.get_Item(i) is TowerDefenseCharacterActor { IsActive: not false } towerDefenseCharacterActor && TSVector2.Distance(position, towerDefenseCharacterActor.tsTransform.Position) <= chargeRange)
			{
				towerDefenseCharacterActor.skillMgr.ModifyEnergyByPercent(towerDefenseCharacterActor.mainSkillId, percent);
			}
		}
	}

	protected override void OnInterrupt(int comboIndex)
	{
		base.OnInterrupt(comboIndex);
		_skill?.Clear();
	}
}
