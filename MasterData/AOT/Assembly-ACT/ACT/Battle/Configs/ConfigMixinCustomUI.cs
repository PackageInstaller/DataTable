namespace ACT.Battle.Configs;

[AbilityTypeMetadata("自定义UI效果", "Mixin", new string[] { "custom", "ui" })]
public class ConfigMixinCustomUI : ConfigMixin
{
	public override BaseAbilityMixin CreateInst(Ability ab, byte index)
	{
		return new AbilityMixinCustomUI(this, ab, index);
	}
}
