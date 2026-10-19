using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("AuraField效果", "Mixin", new string[] { "aura", "field" })]
public class ConfigMixinAuraField : ConfigMixin
{
	public bool leaveAreaRemoveAbility;

	public bool rangePosCanUpdate = true;

	public Vector3 range;

	public ConfigFunction<Vector3> center;

	public WhereTargets where;

	public string[] abilities;

	public string ability;

	public override BaseAbilityMixin CreateInst(Ability ab, byte index)
	{
		return new AbilityMixinAuraField(this, ab, index);
	}
}
