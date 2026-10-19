using System;
using ACT.Sound;

namespace ACT.Battle.Configs;

[Serializable]
public struct ChangeItem
{
	public float transitionTime;

	public YooAssetReference effectAssetID;

	public AudioEventReference audioSoundEvent;

	public float delayTime;
}
