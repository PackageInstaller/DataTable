using System.Collections.Generic;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("Glide parachute model", "Mixin", new string[] { "glide", "parachute", "model" })]
public class ConfigMixinGlideParachute : ConfigMixin
{
	public YooAssetReference parachutePrefab;

	public GlideParachuteOffsetConfig offsetConfig;

	public bool useAttachPoint = true;

	public string attachPointName = "glide_parachute";

	public int exitReleaseDelayMs = 200;

	public Vector3 localEulerAngles;

	public Vector3 localScale = Vector3.one;

	[HideInInspector]
	public string openTrigger = "Open";

	public bool refreshPositionInLateUpdate;

	public bool fallbackToColliderHeight = true;

	public override BaseAbilityMixin CreateInst(Ability ab, byte index)
	{
		return new AbilityMixinGlideParachute(this, ab, index);
	}

	public override void Precache(List<YooAssetReference> addlist)
	{
		if (parachutePrefab != null && parachutePrefab.RuntimeKeyIsValid())
		{
			addlist.Add(parachutePrefab);
		}
	}
}
