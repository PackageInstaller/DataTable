using System;

namespace UnityEngine;

[Obsolete("BlendWeights is obsolete. Use SkinWeights instead (UnityUpgradable) -> SkinWeights", true)]
public enum BlendWeights
{
	[Obsolete("BlendWeights.OneBone is obsolete. Use SkinWeights.OneBone instead (UnityUpgradable) -> SkinWeights.OneBone", true)]
	OneBone = 1,
	[Obsolete("BlendWeights.TwoBones is obsolete. Use SkinWeights.TwoBones instead (UnityUpgradable) -> SkinWeights.TwoBones", true)]
	TwoBones = 2,
	[Obsolete("BlendWeights.FourBones is obsolete. Use SkinWeights.FourBones instead (UnityUpgradable) -> SkinWeights.FourBones", true)]
	FourBones = 4
}
