namespace ACT.Battle.Configs;

[AbilityTypeMetadata("伤害Require系统解锁", "Mixin", new string[] { "damage", "require", "SystemUnlock" })]
public class ConfigMixinDamageRequireSystemUnlock : ConfigMixin
{
	public CheckSystemUnLock systemUnLockPredicate;

	public override BaseAbilityMixin CreateInst(Ability ab, byte index)
	{
		return new AbilityMixinDamageRequireSystemUnlock(this, ab, index);
	}
}
