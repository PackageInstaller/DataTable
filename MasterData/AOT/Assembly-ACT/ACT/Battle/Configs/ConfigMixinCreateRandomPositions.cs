using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("随机Positions效果", "Mixin", new string[] { "create", "random", "positions" })]
public class ConfigMixinCreateRandomPositions : ConfigMixin
{
	public ActionCreatFlexibleEntity createConfig;

	public ConfigFunction<Vector3>[] points;

	public int invisible;

	[Header("设置不出现位置的随机范围")]
	public int min;

	public int max;

	public override BaseAbilityMixin CreateInst(Ability ab, byte index)
	{
		return new AbilityMixinCreateRandomPositionEntities(this, ab, index);
	}
}
