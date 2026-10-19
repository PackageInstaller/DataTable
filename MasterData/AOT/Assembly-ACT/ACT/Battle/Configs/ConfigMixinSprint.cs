namespace ACT.Battle.Configs;

[AbilityTypeMetadata("冲刺效果", "Mixin", new string[] { "sprint", "move", "movement", "position", "velocity" })]
public class ConfigMixinSprint : ConfigMixin
{
	public override BaseAbilityMixin CreateInst(Ability ab, byte index)
	{
		return new AbilityMixinSprint(this, ab, index);
	}
}
