using System;
using UnityEngine;
using UnityEngine.Serialization;

namespace ACT.World.Data.Audios;

[Serializable]
public struct OverrideSceneAudioData : IOverrideSceneAudioData
{
	[FormerlySerializedAs("_overrideType")]
	[SerializeField]
	[HideInInspector]
	private OverrideSceneSoundType __overrideType;

	[FormerlySerializedAs("_bgmSoundAddress")]
	[SerializeField]
	[HideInInspector]
	private string __bgmSoundAddress;

	[FormerlySerializedAs("_bgmState")]
	[SerializeField]
	[HideInInspector]
	private int __bgmState;

	[FormerlySerializedAs("_envSoundAddress")]
	[SerializeField]
	[HideInInspector]
	private string __envSoundAddress;

	[FormerlySerializedAs("_reverbAddress")]
	[SerializeField]
	[HideInInspector]
	private string __reverbAddress;

	[FormerlySerializedAs("_stepMaterialId")]
	[SerializeField]
	[HideInInspector]
	private int __stepMaterialId;

	public bool IsChangeBGM => IsMatchMode(__overrideType, OverrideSceneSoundType.BGM);

	public bool IsChangeBGMState => IsMatchMode(__overrideType, OverrideSceneSoundType.BGMState);

	public bool IsChangeEnv => IsMatchMode(__overrideType, OverrideSceneSoundType.Env);

	public bool IsChangeReverb => IsMatchMode(__overrideType, OverrideSceneSoundType.Reverb);

	public bool IsChangeStepMaterial => IsMatchMode(__overrideType, OverrideSceneSoundType.StepMat);

	public string BgmSoundAddress => __bgmSoundAddress;

	public int BgmState => __bgmState;

	public string EnvSoundAddress => __envSoundAddress;

	public string ReverbAddress => __reverbAddress;

	public int StepMaterialId => __stepMaterialId;

	public OverrideSceneSoundType OverrideType => __overrideType;

	private static bool IsMatchMode(OverrideSceneSoundType nowValue, OverrideSceneSoundType target)
	{
		return (nowValue & target) == target;
	}
}
