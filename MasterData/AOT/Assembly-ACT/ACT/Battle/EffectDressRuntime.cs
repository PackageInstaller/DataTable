using System.Collections.Generic;
using ACT.Battle.Configs;
using Bamboo.Precache;
using UnityEngine;

namespace ACT.Battle;

public class EffectDressRuntime
{
	public int dressId;

	public int dressType;

	public EffectDressRuntimeType runtimeType;

	public int version;

	public EffectDressConfigItem config;

	public EffectRuntimeItem effectRuntimeItem;

	public InstanceHandle instanceHandle;

	public GameObject instance;

	public Transform attachPoint;

	public string cueKey;

	public YooAssetReference effect;

	public string attachPointName;

	public EffectDressMotionSpawnMode motionSpawnMode;

	public List<InstanceHandle> motionInstanceHandles;

	public int systemAnimatorStateHash;

	public int systemCueLayerIndex;

	public float[] systemCueNormalizedTimes;

	public void Reset()
	{
		dressId = 0;
		dressType = 0;
		runtimeType = EffectDressRuntimeType.None;
		version = 0;
		config = null;
		effectRuntimeItem = null;
		instanceHandle = null;
		instance = null;
		attachPoint = null;
		cueKey = null;
		effect = null;
		attachPointName = null;
		motionSpawnMode = EffectDressMotionSpawnMode.AttachPointSnapshot;
		motionInstanceHandles = null;
		systemAnimatorStateHash = 0;
		systemCueLayerIndex = 0;
		systemCueNormalizedTimes = null;
	}
}
