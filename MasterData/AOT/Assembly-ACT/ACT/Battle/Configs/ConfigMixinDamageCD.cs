namespace ACT.Battle.Configs;

[AbilityTypeMetadata("伤害冷却效果", "Mixin", new string[] { "damage", "cd" })]
public class ConfigMixinDamageCD : ConfigMixin
{
	public float cd;

	public override BaseAbilityMixin CreateInst(Ability ab, byte index)
	{
		return new AbilityMixinDamageCD(this, ab, index);
	}
}
