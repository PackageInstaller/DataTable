namespace ACT.Battle.Configs;

[AbilityTypeMetadata("冷却修正效果", "Mixin", new string[] { "change", "cd", "modifier" })]
public class ConfigMixinChangeCDModifier : ConfigMixin
{
	public ConfigFunction<float> addCD = new ConstFloat
	{
		value = new DynamicFloat
		{
			source = ParamSource.Const,
			value = 1f
		}
	};

	public override BaseAbilityMixin CreateInst(Ability ab, byte index)
	{
		return new AbilityMixinChangeCDModifier(this, ab, index);
	}
}
