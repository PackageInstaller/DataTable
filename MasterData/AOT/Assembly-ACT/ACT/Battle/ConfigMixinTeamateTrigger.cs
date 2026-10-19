using System.Collections.Generic;
using ACT.Battle.Configs;

namespace ACT.Battle;

[AbilityTypeMetadata("队友效果", "Mixin", new string[] { "teamate", "trigger" })]
public class ConfigMixinTeamateTrigger : ConfigMixin
{
	public ActionTargetType target;

	public ListenEvtItem[] configs;

	public override BaseAbilityMixin CreateInst(Ability ab, byte index)
	{
		return new AbilityMixinTeamateTigger(this, ab, index);
	}

	public override void CacheActionList(List<ConfigAction[]> list, ConfigAbility configAbility)
	{
		ListenEvtItem[] array = configs;
		if (array != null && array.Length > 0)
		{
			array = configs;
			for (int i = 0; i < array.Length; i++)
			{
				ListenEvtItem listenEvtItem = array[i];
				ConfigAbility.CacheActionList(list, listenEvtItem.actions, configAbility);
			}
		}
	}
}
