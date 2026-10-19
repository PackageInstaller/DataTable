using System;
using System.Collections.Generic;
using UnityEngine;

namespace ACT.Battle.Configs;

public class ConfigSkinBattleMapping : LuminSerializedScriptableObject
{
	public AnimationClip[] moveAnimations = Array.Empty<AnimationClip>();

	public AnimationClip[] attackAnimations = Array.Empty<AnimationClip>();

	public Dictionary<YooAssetReference, YooAssetReference> effects = new Dictionary<YooAssetReference, YooAssetReference>();

	public YooAssetReference timeline;
}
