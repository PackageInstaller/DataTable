using System.Collections.Generic;
using ACT.Battle;
using ACT.Battle.Configs;

namespace Battle.Configs;

[AbilityTypeMetadata("招架效果", "Mixin", new string[] { "parry" })]
public class ConfigMixinParry : ConfigMixin
{
	public ConfigAction[] parrySuccessActions;

	public override BaseAbilityMixin CreateInst(ACT.Battle.Ability ab, byte index)
	{
		return new AbilityMixinParry(this, ab, index);
	}

	public override void CacheActionList(List<ConfigAction[]> list, ConfigAbility ab)
	{
		if (parrySuccessActions != null)
		{
			ConfigAbility.CacheActionList(list, parrySuccessActions, ab);
		}
	}
}
