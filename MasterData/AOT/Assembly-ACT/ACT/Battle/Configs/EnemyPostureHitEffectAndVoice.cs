using System;
using ACT.Sound;
using FMODUnity;

namespace ACT.Battle.Configs;

[Serializable]
public class EnemyPostureHitEffectAndVoice
{
	public YooAssetReference monsterPostureBornEffectAssetID;

	public EventReference postureBornVoice;

	public AudioEventReference audioPostureBornVoice;

	public YooAssetReference monsterPostureHitEffectAssetID;

	public EventReference postureHitVoice;

	public AudioEventReference audioPostureHitVoice;

	public YooAssetReference monsterPostureBreakEffectAssetID;

	public EventReference postureBreakVoice;

	public AudioEventReference audioPostureBreakVoice;
}
