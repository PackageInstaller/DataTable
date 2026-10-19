using System.Collections.Generic;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("监听事件", "Mixin", new string[] { "listen", "evt" })]
public class ConfigMixinListenEvt : ConfigMixin
{
	public float cd;

	public ListenEvtItem[] configs;

	public override void CacheActionList(List<ConfigAction[]> list, ConfigAbility ab)
	{
		if (configs != null)
		{
			for (int i = 0; i < configs.Length; i++)
			{
				ConfigAbility.CacheActionList(list, configs[i].actions, ab);
			}
		}
	}

	public override BaseAbilityMixin CreateInst(Ability ab, byte index)
	{
		return new AbilityMixinListenEvt(this, ab, index);
	}
}
