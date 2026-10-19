namespace ACT.Battle.Configs;

[AbilityTypeMetadata("黑粘液Swamp效果", "Mixin", new string[] { "black", "viscous", "swamp" })]
public class ConfigMixinBlackViscousSwamp : ConfigMixin
{
	public override BaseAbilityMixin CreateInst(Ability ab, byte index)
	{
		return new AbilityMixinBlackViscousSwamp(this, ab, index);
	}
}
