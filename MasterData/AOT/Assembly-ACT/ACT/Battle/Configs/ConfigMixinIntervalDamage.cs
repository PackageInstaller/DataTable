using ACT.Core;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("间隔执行间隔伤害", "Mixin", new string[] { "interval", "damage" })]
public class ConfigMixinIntervalDamage : ConfigMixin
{
	public float damageInterval;

	public Element element;

	public override BaseAbilityMixin CreateInst(Ability ab, byte index)
	{
		return new AbilityMixinIntervalDamage(this, ab, index);
	}
}
