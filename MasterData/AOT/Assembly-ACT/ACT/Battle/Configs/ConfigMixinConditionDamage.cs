namespace ACT.Battle.Configs;

[AbilityTypeMetadata("Condition伤害效果", "Mixin", new string[] { "condition", "damage" })]
public class ConfigMixinConditionDamage : ConfigMixin
{
	public ConfigPredicate[] configPredicateList;

	public override BaseAbilityMixin CreateInst(Ability ab, byte index)
	{
		return new AbilityMixinConditionDamage(this, ab, index);
	}
}
