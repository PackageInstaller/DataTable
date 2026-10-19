using System.Collections.Generic;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("材质效果", "Mixin", new string[] { "material" })]
public class ConfigMixinMaterial : ConfigMixin
{
	[Tooltip("启用互斥优先级")]
	public bool exclusivePriority;

	[Tooltip("优先级")]
	public int priority;

	[Tooltip("权重类型与材质映射")]
	public Dictionary<MonsterWeigtType, Material> material;

	public override BaseAbilityMixin CreateInst(Ability ab, byte index)
	{
		return new AbilityMixinMaterial(this, ab, index);
	}
}
