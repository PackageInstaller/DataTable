namespace ACT.Battle.Configs;

[AbilityTypeMetadata("携带效果", "Mixin", new string[] { "carry", "move", "movement", "position", "velocity" })]
public class ConfigMixinCarry : ConfigMixin
{
	public override BaseAbilityMixin CreateInst(Ability ab, byte index)
	{
		return new AbilityMixinCarry(this, ab, index);
	}
}
