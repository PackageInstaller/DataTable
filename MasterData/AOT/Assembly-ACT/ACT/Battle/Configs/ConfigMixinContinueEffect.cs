using System.Collections.Generic;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("Continue特效效果", "Mixin", new string[] { "continue", "effect" })]
public class ConfigMixinContinueEffect : ConfigMixin
{
	[HideInInspector]
	public float intervalTime;

	public ConfigFunction<float> intervalFunction = new ConstFloat
	{
		value = new DynamicFloat
		{
			source = ParamSource.Const,
			value = 0.02f
		}
	};

	public bool useIntervalFunctionArray;

	public ConfigFunction<float>[] intervalFunctionArray;

	public ConfigFunction<float> maxCount = new ConstFloat
	{
		value = new DynamicFloat
		{
			source = ParamSource.Const,
			value = 1E+09f
		}
	};

	public bool firstDoNeedIntervalTime;

	public bool casterDieRemoveDo = true;

	[HideInInspector]
	public bool inactiveRoleDoActions;

	public ConfigAction[] OnContinueHit;

	public ConfigAction[] toRemoveActions;

	public ConfigAction[] onDieActions;

	public MotionState[] removeMotion;

	public override void CacheActionList(List<ConfigAction[]> list, ConfigAbility ab)
	{
		if (OnContinueHit != null && OnContinueHit.Length != 0)
		{
			ConfigAbility.CacheActionList(list, OnContinueHit, ab);
		}
		if (toRemoveActions != null && toRemoveActions.Length != 0)
		{
			ConfigAbility.CacheActionList(list, toRemoveActions, ab);
		}
		if (onDieActions != null && onDieActions.Length != 0)
		{
			ConfigAbility.CacheActionList(list, onDieActions, ab);
		}
	}

	public override BaseAbilityMixin CreateInst(Ability ab, byte index)
	{
		return new AbilityMixinContinueEffect(this, ab, index);
	}
}
