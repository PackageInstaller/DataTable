using System;
using ACT.Config;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class WildBossCollectionData : StateWorldAssetData
{
	[SerializeField]
	private int m_initialStateId;

	[SerializeField]
	private YooAssetReference _interactAddressAssetID;

	[SerializeField]
	private StateWorldUid _wildBossUid;

	public override YooAssetReference addressAssetID => _interactAddressAssetID;

	public override ServiceSaveTag serviceSaveTag => ServiceSaveTag.InteractObject;

	public override int initialStateId => m_initialStateId;

	public StateWorldUid WildBossUid => _wildBossUid;

	public override void Bake(object assetComp)
	{
	}
}
