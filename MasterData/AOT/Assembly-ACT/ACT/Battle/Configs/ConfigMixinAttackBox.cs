using System.Collections.Generic;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("攻击Box效果", "Mixin", new string[] { "attack", "box" })]
public class ConfigMixinAttackBox : ConfigMixin
{
	public MixinTimer mixinTimer;

	public BaseFindTargets findTargets;

	public FindTargetType findTargetType;

	public ConfigAction[] configActions;

	public ConfigFunction<float> hitCD = new ConstFloat
	{
		value = new DynamicFloat
		{
			source = ParamSource.Const,
			value = 0.1f
		}
	};

	public override BaseAbilityMixin CreateInst(Ability ab, byte index)
	{
		return new AbilityMixinAttackBox(this, ab, index);
	}

	public override void CacheActionList(List<ConfigAction[]> list, ConfigAbility ab)
	{
		if (configActions != null && configActions.Length != 0)
		{
			ConfigAbility.CacheActionList(list, configActions, ab);
		}
	}
}
