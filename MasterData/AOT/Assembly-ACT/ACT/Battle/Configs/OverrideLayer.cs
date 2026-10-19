using System;
using UnityEngine;

namespace ACT.Battle.Configs;

[Serializable]
public struct OverrideLayer
{
	[Tooltip("要覆盖的Layer索引（从0开始），例如分层受击动画层通常是第1层")]
	public int layerIndex;

	public string comment;

	[Tooltip("用于替代该Layer原始AvatarMask的覆盖版本")]
	public AvatarMask overrideMask;
}
