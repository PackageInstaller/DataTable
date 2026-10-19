using System;
using ACT.Sound;
using FMODUnity;

namespace ACT.Battle.Configs;

[Serializable]
public class PostureHitEffectAndVoice
{
	public YooAssetReference smallMonsterPostureBornEffectAssetID;

	public YooAssetReference normalMonsterPostureBornEffectAssetID;

	public YooAssetReference bigMonsterPostureBornEffectAssetID;

	public YooAssetReference giantMonsterPostureBornEffectAssetID;

	public EventReference postureBornVoice;

	public AudioEventReference audioPostureBornVoice;

	public YooAssetReference smallMonsterPostureHitEffectAssetID;

	public YooAssetReference normalMonsterPostureHitEffectAssetID;

	public YooAssetReference bigMonsterPostureHitEffectAssetID;

	public YooAssetReference giantMonsterPostureHitEffectAssetID;

	public EventReference postureHitVoice;

	public AudioEventReference audioPostureHitVoice;

	public YooAssetReference smallMonsterPostureBreakEffectAssetID;

	public YooAssetReference normalMonsterPostureBreakEffectAssetID;

	public YooAssetReference bigMonsterPostureBreakEffectAssetID;

	public YooAssetReference giantMonsterPostureBreakEffectAssetID;

	public EventReference postureBreakVoice;

	public AudioEventReference audioPostureBreakVoice;
}
