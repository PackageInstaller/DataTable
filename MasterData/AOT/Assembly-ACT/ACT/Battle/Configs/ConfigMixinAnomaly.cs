using System.Collections.Generic;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("异常效果", "Mixin", new string[] { "anomaly" })]
public class ConfigMixinAnomaly : ConfigMixin
{
	[Tooltip("状态类型的效果技能名字")]
	public Dictionary<AnomalyType, string> anomalyAbilityName = new Dictionary<AnomalyType, string>();

	public override BaseAbilityMixin CreateInst(Ability ab, byte index)
	{
		return new AbilityMixinAnomaly(this, ab, index);
	}
}
