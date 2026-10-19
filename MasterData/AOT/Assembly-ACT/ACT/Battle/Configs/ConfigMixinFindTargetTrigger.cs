using System.Collections.Generic;
using ACT.Utility;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("按目标查找结果触发进入、停留、离开动作", "Mixin", new string[] { "find", "target", "trigger", "retarget", "aim" })]
public class ConfigMixinFindTargetTrigger : ConfigMixin
{
	public BaseFindTargets findCondition;

	public AllianceCondition alliance;

	public FilterEntityType filterEntityType = GameUtility.defaultFilterEntityType;

	private FilterCantBeAttackType filterCantBeAttackType;

	public bool canBeAttack;

	public ConfigAction[] onTriggerEnter;

	public ConfigAction[] onTriggerStay;

	public ConfigAction[] onTriggerExit;

	public override BaseAbilityMixin CreateInst(Ability ab, byte index)
	{
		return new AbilityMixinFindTargetTrigger(this, ab, index);
	}

	public override void CacheActionList(List<ConfigAction[]> list, ConfigAbility configAbility)
	{
		ConfigAbility.CacheActionList(list, onTriggerEnter, configAbility);
		ConfigAbility.CacheActionList(list, onTriggerStay, configAbility);
		ConfigAbility.CacheActionList(list, onTriggerExit, configAbility);
	}
}
