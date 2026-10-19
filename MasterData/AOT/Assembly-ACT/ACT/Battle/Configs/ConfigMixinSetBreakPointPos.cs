namespace ACT.Battle.Configs;

[AbilityTypeMetadata("Break点位置效果", "Mixin", new string[] { "set", "break", "point", "pos" })]
public class ConfigMixinSetBreakPointPos : ConfigMixin
{
	public WhereTargets where;

	public TargetBounds bounds;

	public override BaseAbilityMixin CreateInst(Ability ab, byte index)
	{
		return new AbilityMixinSetBreakPointPos(this, ab, index);
	}
}
