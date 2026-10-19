namespace ACT.Battle.Configs;

[AbilityTypeMetadata("Freeze效果", "Mixin", new string[] { "freeze" })]
public class ConfigMixinFreeze : ConfigMixin
{
	public override BaseAbilityMixin CreateInst(Ability ab, byte index)
	{
		return new AbilityMixinFreeze(this, ab, index);
	}
}
