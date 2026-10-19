namespace ACT.Battle.Configs;

[AbilityTypeMetadata("仇恨效果", "Mixin", new string[] { "record", "hatred", "target", "retarget", "aim" })]
public class ConfigMixinRecordHatred : ConfigMixin
{
	public override BaseAbilityMixin CreateInst(Ability ab, byte index)
	{
		return new AbilityMixinRecordHatred(ab, index);
	}
}
