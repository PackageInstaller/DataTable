using System;
using ACT.Config;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class SlimeMouldData : StateWorldAssetData
{
	[SerializeField]
	private int m_initialStateId;

	[SerializeField]
	private YooAssetReference _interactAddressAssetID;

	public YooAssetReference headPrefabAssetID;

	public YooAssetReference bodyPrefabAssetID;

	public float groupDelay = 0.15f;

	public float itemDelay = 0.05f;

	[SerializeField]
	private SlimeMouldGroupData[] _slimeMouldGroups;

	public override YooAssetReference addressAssetID => _interactAddressAssetID;

	public override ServiceSaveTag serviceSaveTag => ServiceSaveTag.InteractObject;

	public override int initialStateId => m_initialStateId;

	public SlimeMouldGroupData[] SlimeMouldGroups => _slimeMouldGroups;

	public override void Bake(object assetComp)
	{
	}
}
