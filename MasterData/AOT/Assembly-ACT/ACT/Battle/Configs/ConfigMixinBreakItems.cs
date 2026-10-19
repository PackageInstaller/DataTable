using System.Collections.Generic;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("BreakItems效果", "Mixin", new string[] { "break", "items" })]
public class ConfigMixinBreakItems : ConfigMixin
{
	public ActionCreatFlexibleEntity[] items;

	public float time;

	public ConfigAction[] onSuccess;

	public ConfigAction[] onFailed;

	public ConfigAction[] onTimeOut;

	public override void CacheActionList(List<ConfigAction[]> list, ConfigAbility configAbility)
	{
		if (items != null)
		{
			ActionCreatFlexibleEntity[] array = items;
			for (int i = 0; i < array.Length; i++)
			{
				array[i].CacheActionList(list, configAbility);
			}
		}
		if (onSuccess != null)
		{
			ConfigAbility.CacheActionList(list, onSuccess, configAbility);
		}
		if (onFailed != null)
		{
			ConfigAbility.CacheActionList(list, onFailed, configAbility);
		}
		if (onTimeOut != null)
		{
			ConfigAbility.CacheActionList(list, onTimeOut, configAbility);
		}
		base.CacheActionList(list, configAbility);
	}

	public override BaseAbilityMixin CreateInst(Ability ab, byte index)
	{
		return new AbilityMixinBreakItems(ab, index, this);
	}
}
