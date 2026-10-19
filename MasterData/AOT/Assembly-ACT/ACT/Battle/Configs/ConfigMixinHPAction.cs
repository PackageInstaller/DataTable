using System.Collections.Generic;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("生命值效果", "Mixin", new string[] { "hp" })]
public class ConfigMixinHPAction : ConfigMixin
{
	public Dictionary<int, ConfigAction[]> hpActions = new Dictionary<int, ConfigAction[]>();

	public override void CacheActionList(List<ConfigAction[]> list, ConfigAbility ab)
	{
		foreach (KeyValuePair<int, ConfigAction[]> hpAction in hpActions)
		{
			ConfigAbility.CacheActionList(list, hpAction.Value, ab);
		}
	}

	public override BaseAbilityMixin CreateInst(Ability ab, byte index)
	{
		return new AbilityMixinHPAction(this, ab, index);
	}
}
