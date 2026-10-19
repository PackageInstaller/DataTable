namespace ACT.Battle.Configs;

[AbilityTypeMetadata("仇恨效果", "Mixin", new string[] { "hatred", "target", "retarget", "aim" })]
public class ConfigMixinHatred : ConfigMixin
{
	public override BaseAbilityMixin CreateInst(Ability ab, byte index)
	{
		return new AbilityMixinHatred(ab, index);
	}
}
