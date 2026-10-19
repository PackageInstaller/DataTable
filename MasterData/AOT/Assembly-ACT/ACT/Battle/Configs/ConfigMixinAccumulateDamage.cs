namespace ACT.Battle.Configs;

[AbilityTypeMetadata("在窗口期累计伤害并在结束时结算", "Mixin", new string[] { "accumulate", "damage" })]
public class ConfigMixinAccumulateDamage : ConfigMixin
{
	public EAccumulateDamageType accumulateType;

	public override BaseAbilityMixin CreateInst(Ability ab, byte index)
	{
		return new AbilityMixinAccumulateDamage(this, ab, index);
	}
}
