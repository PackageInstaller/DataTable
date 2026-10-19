namespace ACT.Battle.Configs;

[AbilityTypeMetadata("技能生命周期效果", "Mixin", new string[] { "ability", "lifetime" })]
public class ConfigMixinAbilityLifetime : ConfigMixin
{
	public string[] motions;

	public override BaseAbilityMixin CreateInst(Ability ab, byte index)
	{
		return new AbilityMixinAbilityLifeTime(this, ab, index);
	}
}
