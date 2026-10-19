using UnityEngine;

namespace ACT.Battle.Configs;

public class ConfigChangeCharacter : ScriptableObject
{
	public ChangeItem show;

	public ChangeItem hide;

	public YooAssetReference connectEffectAssetID;

	public float connectEffectDelayTime;

	public float delayHideTime;
}
