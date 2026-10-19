using System.Collections.Generic;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("闪避效果", "Mixin", new string[] { "dodge" })]
public class ConfigMixinDodge : ConfigMixin
{
	public enum ConfigMixinDodgeType
	{
		normal,
		dummyUseSeparateDuration
	}

	public ConfigMixinDodgeType configMixinDodgeType;

	public float ghostRemainDuration;

	public ConfigAction[] onDodgeActions;

	public ConfigAction[] onDodgeActionByQuick;

	public ConfigAction[] onDodgeActionByNoQuick;

	public float distance = 0.5f;

	public Vector3 offset = new Vector3(1f, 0f, 0f);

	public bool createDummyBoxCollider;

	public override void CacheActionList(List<ConfigAction[]> list, ConfigAbility ab)
	{
		ConfigAbility.CacheActionList(list, onDodgeActions, ab);
		ConfigAbility.CacheActionList(list, onDodgeActionByQuick, ab);
		ConfigAbility.CacheActionList(list, onDodgeActionByNoQuick, ab);
	}

	public override BaseAbilityMixin CreateInst(Ability ab, byte index)
	{
		return new AbilityMixinDodge(this, ab, index);
	}
}
