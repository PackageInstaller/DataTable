namespace ACT.Battle.Configs;

[AbilityTypeMetadata("移动限制效果", "Mixin", new string[] { "movement", "restrict", "move", "position", "velocity" })]
public class ConfigMixinMovementRestrict : ConfigMixin
{
	public float disabledAlpha;

	public bool abilityForbidSwitch;

	public MotionInputKey[] disabledMotionKeys;

	public MotionState[] removeMotion;

	public override BaseAbilityMixin CreateInst(Ability ab, byte index)
	{
		return new AbilityMixinMovementRestrict(this, ab, index);
	}
}
