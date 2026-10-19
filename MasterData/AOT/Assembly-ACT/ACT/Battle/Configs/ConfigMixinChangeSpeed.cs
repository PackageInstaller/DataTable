namespace ACT.Battle.Configs;

[AbilityTypeMetadata("速度效果", "Mixin", new string[] { "change", "speed" })]
public class ConfigMixinChangeSpeed : ConfigMixin
{
	public TimeType timeType;

	public float speed;

	public override BaseAbilityMixin CreateInst(Ability ab, byte index)
	{
		return new AbilityMixinChangeSpeed(this, ab, index);
	}
}
