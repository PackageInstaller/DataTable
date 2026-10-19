using System.Collections.Generic;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("Detect碰撞效果", "Mixin", new string[] { "detect", "collision" })]
public class ConfigMixinDetectCollision : ConfigMixin
{
	public ConfigFunction<Vector3> startPoint;

	public RaycastType raycastType;

	public Vector3[] directions;

	public float distance;

	public Bounds size;

	public float radius;

	[Tooltip("检测到环境时做的action")]
	public ConfigAction[] actions;

	public override void CacheActionList(List<ConfigAction[]> list, ConfigAbility ab)
	{
		ConfigAbility.CacheActionList(list, actions, ab);
	}

	public override BaseAbilityMixin CreateInst(Ability ab, byte index)
	{
		return new AbilityMixinDetectCollision(this, ab, index);
	}
}
