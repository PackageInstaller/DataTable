using System;
using UnityEngine;

namespace ACT.Battle.Configs;

[Serializable]
public class EffectDressConfigItem
{
	public int dressId;

	public int roleId;

	[HideInInspector]
	public int dressType;

	public EffectDressRuntimeType runtimeType;

	public YooAssetReference effect;

	[HideInInspector]
	public string attachPoint;

	public string cueKey;

	public string systemAnimatorStateName;

	public float[] systemCueNormalizedTimes = new float[1] { 0.3f };

	[HideInInspector]
	public int systemCueLayerIndex;

	[HideInInspector]
	public EffectDressMotionSpawnMode motionSpawnMode = EffectDressMotionSpawnMode.OwnerGround;

	public Vector3 localPosition;

	[HideInInspector]
	public Vector3 localEulerAngles;

	[HideInInspector]
	public Vector3 localScale = Vector3.one;

	public bool overrideSystemModelTrailVelocity;

	public Vector3 systemModelTrailVelocity = Vector3.back;

	[HideInInspector]
	public bool useWorldSpaceTrailVelocity;

	public bool activeWithAttachPoint;

	public bool useOwnerTimeScale = true;

	[HideInInspector]
	public float groundCheckLength = 20f;

	public string displayName => $"{dressId} / Role:{roleId} / {runtimeType}";

	private bool IsPersistentFollow => runtimeType == EffectDressRuntimeType.PersistentFollow;

	private bool IsPersistentTrail => runtimeType == EffectDressRuntimeType.PersistentTrail;

	private bool IsMotionFootprint => runtimeType == EffectDressRuntimeType.MotionFootprint;

	private bool ShowAttachPoint
	{
		get
		{
			if (!IsPersistentFollow && !IsPersistentTrail)
			{
				if (IsMotionFootprint)
				{
					return motionSpawnMode != EffectDressMotionSpawnMode.OwnerGround;
				}
				return false;
			}
			return true;
		}
	}

	private bool ShowGroundCheck
	{
		get
		{
			if (IsMotionFootprint)
			{
				return motionSpawnMode != EffectDressMotionSpawnMode.AttachPointSnapshot;
			}
			return false;
		}
	}

	private bool ShowSystemModelTrailVelocity
	{
		get
		{
			if (IsPersistentTrail)
			{
				return overrideSystemModelTrailVelocity;
			}
			return false;
		}
	}
}
