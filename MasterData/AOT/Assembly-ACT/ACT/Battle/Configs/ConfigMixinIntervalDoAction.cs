using System.Collections.Generic;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("间隔执行间隔", "Mixin", new string[] { "interval", "do" })]
public class ConfigMixinIntervalDoAction : ConfigMixin
{
	public float interval;

	public bool casterDieRemoveDo;

	public bool inactiveRoleDoActions;

	public ConfigAction[] intervalDoActions;

	public ConfigAction[] toRemoveActions;

	public ConfigAction[] onDieActions;

	public MotionState[] removeMotion;

	public override void CacheActionList(List<ConfigAction[]> list, ConfigAbility ab)
	{
		if (intervalDoActions != null && intervalDoActions.Length != 0)
		{
			ConfigAbility.CacheActionList(list, intervalDoActions, ab);
		}
		if (toRemoveActions != null && intervalDoActions.Length != 0)
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
		return new AbilityMixinIntervalDoAction(this, ab, index);
	}
}
