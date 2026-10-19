using System.Collections.Generic;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("LightningChain效果", "Mixin", new string[] { "lightning", "chain" })]
public class ConfigMixinLightningChain : ConfigMixin
{
	public int maxBounceCount = 3;

	public BaseFindTargets findCondition = new ComplexFoundTargets();

	public float bounceDelay;

	public ConfigAction[] onBounceActions;

	public override BaseAbilityMixin CreateInst(Ability ab, byte index)
	{
		return new AbilityMixinLightningChain(this, ab, index);
	}

	public override void CacheActionList(List<ConfigAction[]> list, ConfigAbility configAbility)
	{
		ConfigAbility.CacheActionList(list, onBounceActions, configAbility);
	}
}
