using System;
using UnityEngine;

namespace ACT.Battle;

[Serializable]
public class MultiCameraNoiseData
{
	public YooAssetReference noiseAssetID;

	[Tooltip("持续时间 0就是默认资源自己的震动持续时间")]
	public float duration;

	[Tooltip("强度 0就是默认1")]
	public float force;

	public bool IsValid()
	{
		return noiseAssetID != null;
	}
}
