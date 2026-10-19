using System.Collections.Generic;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("材质效果", "Mixin", new string[] { "mat", "override" })]
public class ConfigMixinMatOverride : ConfigMixin
{
	public enum MatType
	{
		Custom,
		Preset
	}

	public MatType matType;

	public Dictionary<MonsterWeigtType, Material> material;

	public AnimationCurve customCurve;

	public uint uintmaterialPreset;

	public override BaseAbilityMixin CreateInst(Ability ab, byte index)
	{
		return new AbilityMatOverride(this, ab, index);
	}
}
