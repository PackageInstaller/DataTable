using System.Collections.Generic;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("弹幕效果", "Mixin", new string[] { "danmaku" })]
public class ConfigMixinDanmaku : ConfigMixin
{
	public ActionCreatFlexibleEntity flexibleEntity;

	public bool useArray;

	public ActionCreatFlexibleEntity[] flexibleEntityArray;

	public bool useMatchingProjectile;

	public ConfigFunctionMatching<ActionCreatFlexibleEntity> projectileMatching;

	[SerializeReference]
	public TransformsPattern transformsPattern;

	[SerializeReference]
	public TimeIntervalPattern timeIntervalPattern;

	public ConfigAction[] onProjectileCreate;

	public override BaseAbilityMixin CreateInst(Ability ab, byte index)
	{
		return new AbilityMixinDanmaku(this, ab, index);
	}

	public override void CacheActionList(List<ConfigAction[]> list, ConfigAbility configAbility)
	{
		flexibleEntity?.CacheActionList(list, configAbility);
		if (flexibleEntityArray != null && flexibleEntityArray.Length != 0)
		{
			ConfigAction[] actions = flexibleEntityArray;
			ConfigAbility.CacheActionList(list, actions, configAbility);
		}
		_ = useMatchingProjectile;
	}
}
