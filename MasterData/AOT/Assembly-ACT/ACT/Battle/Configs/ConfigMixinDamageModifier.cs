using System.Collections.Generic;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("伤害修正效果", "Mixin", new string[] { "damage", "modifier" })]
public class ConfigMixinDamageModifier : ConfigMixin
{
	public DamageModifierSide side;

	public int priority;

	public ModifyDamageType modifyType;

	public bool overrideValue;

	public ConfigFunction<float> modifyValue;

	public ConfigPredicate condition;

	public override BaseAbilityMixin CreateInst(Ability ab, byte index)
	{
		return new AbilityMixinDamageModifier(this, ab, index);
	}

	public override void CacheActionList(List<ConfigAction[]> list, ConfigAbility configAbility)
	{
	}

	private bool CanOverride()
	{
		ModifyDamageType modifyDamageType = modifyType;
		if ((uint)(modifyDamageType - 5) <= 2u || modifyDamageType == ModifyDamageType.FinalPhaseAdd)
		{
			return true;
		}
		return false;
	}
}
