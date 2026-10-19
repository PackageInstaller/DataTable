using System.Collections.Generic;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("Holding护盾效果", "Mixin", new string[] { "holding", "shield" })]
public class ConfigMixinHoldingShield : ConfigMixin
{
	[Tooltip("护盾值的名字")]
	public string dynamicName = "ShieldPt";

	[Tooltip("护盾值的id")]
	public int id;

	[Tooltip("当前护盾值")]
	public DynamicFloat value;

	[Tooltip("最小护盾值")]
	public DynamicFloat minValue;

	[Tooltip("最大护盾值")]
	public DynamicFloat maxValue;

	[Tooltip("需要执行的动作")]
	public ConfigAction[] configActions;

	public ConfigPredicate[] predicates;

	public override void CacheActionList(List<ConfigAction[]> list, ConfigAbility ab)
	{
		ConfigAbility.CacheActionList(list, configActions, ab);
	}

	public override BaseAbilityMixin CreateInst(Ability ab, byte index)
	{
		return new AbilityMixinHoldingShield(this, ab, index);
	}
}
