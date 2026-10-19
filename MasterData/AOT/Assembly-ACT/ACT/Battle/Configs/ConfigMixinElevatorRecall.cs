using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("Elevator召回效果", "Mixin", new string[] { "elevator", "recall" })]
public class ConfigMixinElevatorRecall : ConfigMixin
{
	[Tooltip("移动速度")]
	public float vectory;

	[Tooltip("回溯buff的名字")]
	public string name;

	[Tooltip("特效")]
	public YooAssetReference effectReferenceAssetID;

	public override BaseAbilityMixin CreateInst(Ability ab, byte index)
	{
		return new AbilityMixinElevatorRecall(this, ab, index);
	}
}
