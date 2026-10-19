using System;
using ACT.Config;
using ACT.Sound;
using FMODUnity;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class PortalData : StateWorldAssetData
{
	[SerializeField]
	private int m_initialStateId;

	[SerializeField]
	private YooAssetReference _interactAddressAssetID;

	[SerializeField]
	private YooAssetReference _modelAssetID;

	[SerializeField]
	private Pos _sitPos;

	[SerializeField]
	private EventReference _bgmName;

	[SerializeField]
	private EventReference _ambName;

	[SerializeField]
	private AudioEventReference _audioBgmName;

	[SerializeField]
	private AudioEventReference _audioAmbName;

	[SerializeField]
	[Range(0f, 1f)]
	private float _ambParamValue;

	public override YooAssetReference addressAssetID => _interactAddressAssetID;

	public override ServiceSaveTag serviceSaveTag => ServiceSaveTag.Transfer;

	public override int initialStateId => m_initialStateId;

	public YooAssetReference ModelAssetID => _modelAssetID;

	public Pos SitPos => _sitPos;

	public EventReference BgmName => _bgmName;

	public EventReference AmbName => _ambName;

	public AudioEventReference AudioBgmName => _audioBgmName;

	public AudioEventReference AudioAmbName => _audioAmbName;

	public float AmbParamValue => _ambParamValue;

	public override Vector3 GetSpawnPos()
	{
		return initPos;
	}

	public override Vector3 GetTeleportPos()
	{
		return SitPos;
	}

	public override bool IsServiceSaveState(int stateId)
	{
		if (stateId == 1)
		{
			return false;
		}
		return base.IsServiceSaveState(stateId);
	}

	public override void Bake(object assetComp)
	{
	}
}
