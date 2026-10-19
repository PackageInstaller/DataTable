using System.Collections.Generic;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("时间效果", "Mixin", new string[] { "delay", "time" })]
public class ConfigMixinDelayTime : ConfigMixin
{
	[Tooltip("延迟")]
	public float delayTime;

	[Tooltip("延迟后执行的操作")]
	public ConfigAction[] OnDelay;

	public override void CacheActionList(List<ConfigAction[]> list, ConfigAbility ab)
	{
		ConfigAbility.CacheActionList(list, OnDelay, ab);
	}

	public override BaseAbilityMixin CreateInst(Ability ab, byte index)
	{
		return new AbilityMixinDelayTime(this, ab, index);
	}
}
