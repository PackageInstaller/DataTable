namespace ACT.Battle.Configs;

[AbilityTypeMetadata("伤害Require血色落雷平台", "Mixin", new string[] { "damage", "require", "BloodThunderPlatform" })]
public class ConfigMixinDamageRequireBreakableByBloodThunderPlatform : ConfigMixin
{
	public override BaseAbilityMixin CreateInst(Ability ab, byte index)
	{
		return new AbilityMixinDamageRequireBreakableByBloodThunderPlatform(this, ab, index);
	}
}
