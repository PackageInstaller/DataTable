using System;
using ACT.Config;
using ACT.Sound;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class BlackViscousSwampData : StateWorldAssetData, IGetBlackViscousAbDuration
{
	[SerializeField]
	private int m_initialStateId;

	[SerializeField]
	private YooAssetReference _interactAddressAssetID;

	[SerializeField]
	private YooAssetReference _abilityEntityAssetID;

	[SerializeField]
	private float _blackViscousAbilityDuration = 0.5f;

	[SerializeField]
	private YooAssetReference _rippleAssetID;

	[SerializeField]
	[Header("黑质下沉音效")]
	private AudioEventReference _sinkingSound;

	public override YooAssetReference addressAssetID => _interactAddressAssetID;

	public override ServiceSaveTag serviceSaveTag => ServiceSaveTag.InteractObject;

	public override int initialStateId => m_initialStateId;

	public YooAssetReference AbilityEntityAssetID => _abilityEntityAssetID;

	public YooAssetReference RippleAssetID => _rippleAssetID;

	public AudioEventReference SinkingSound => _sinkingSound;

	public override void Bake(object assetComp)
	{
	}

	public float GetAbilityDuration()
	{
		return _blackViscousAbilityDuration;
	}
}
