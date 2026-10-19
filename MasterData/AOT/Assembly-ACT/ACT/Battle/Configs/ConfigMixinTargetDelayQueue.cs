using System.Collections.Generic;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("目标延迟Queue效果", "Mixin", new string[] { "target", "delay", "queue", "retarget", "aim" })]
public class ConfigMixinTargetDelayQueue : ConfigMixin
{
	public BaseFindTargets baseFindTargets;

	public FindTargetType findTargetType;

	public ConfigFunction<float> configFunction = new ConstFloat
	{
		value = new DynamicFloat
		{
			source = ParamSource.Const,
			value = 1f
		}
	};

	public ConfigFunction<float> delayTime = new ConstFloat
	{
		value = new DynamicFloat
		{
			source = ParamSource.Const,
			value = 0.1f
		}
	};

	public ConfigAction[] configActions;

	public override BaseAbilityMixin CreateInst(Ability ab, byte index)
	{
		return new AbilityMixinTargetDelayQueue(this, ab, index);
	}

	public override void CacheActionList(List<ConfigAction[]> list, ConfigAbility ab)
	{
		if (configActions != null && configActions.Length != 0)
		{
			ConfigAbility.CacheActionList(list, configActions, ab);
		}
	}
}
