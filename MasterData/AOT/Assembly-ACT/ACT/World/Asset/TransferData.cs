using System;
using ACT.Config;
using ACT.Sound;
using FMODUnity;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class TransferData : InteractObjectDataBase
{
	public Vector3 position;

	public Transform transform;

	public EventReference bgmName;

	public AudioEventReference audioBgmName;

	public EventReference ambName;

	public AudioEventReference audioAmbName;

	[Range(0f, 1f)]
	public float ambParamValue;

	[SerializeField]
	private int m_initialStateId;

	public override YooAssetReference addressAssetID => GameLoader.meta.transferReferenceAssetID;

	public override ServiceSaveTag serviceSaveTag => ServiceSaveTag.Transfer;

	public override int initialStateId => m_initialStateId;

	public override void Bake(object baker)
	{
	}

	public override Vector3 GetSpawnPos()
	{
		return position;
	}

	public override Vector3 GetTeleportPos()
	{
		return position;
	}
}
