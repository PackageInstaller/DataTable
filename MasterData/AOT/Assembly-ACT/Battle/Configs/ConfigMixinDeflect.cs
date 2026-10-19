using System.Collections.Generic;
using ACT.Battle;
using ACT.Battle.Configs;

namespace Battle.Configs;

[AbilityTypeMetadata("Deflect效果", "Mixin", new string[] { "deflect" })]
public class ConfigMixinDeflect : ConfigMixin
{
	public ConfigAction[] deflectSuccessActions;

	public override BaseAbilityMixin CreateInst(ACT.Battle.Ability ab, byte index)
	{
		return new AbilityMixinDeflect(this, ab, index);
	}

	public override void CacheActionList(List<ConfigAction[]> list, ConfigAbility ab)
	{
		if (deflectSuccessActions != null)
		{
			ConfigAbility.CacheActionList(list, deflectSuccessActions, ab);
		}
	}
}
