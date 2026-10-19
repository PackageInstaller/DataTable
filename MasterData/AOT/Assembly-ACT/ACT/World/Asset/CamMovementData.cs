using System;
using ACT.Config;
using ACT.World.Behave;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class CamMovementData : InteractObjectDataBase
{
	[SerializeField]
	internal int m_initialStateId;

	[SerializeField]
	private YooAssetReference m_AddressAssetID;

	public CamMovementBehaveData behaveData;

	public override int initialStateId => m_initialStateId;

	public override YooAssetReference addressAssetID => m_AddressAssetID;

	public override ServiceSaveTag serviceSaveTag => ServiceSaveTag.InteractObject;

	public override void Bake(object assetComp)
	{
		base.Bake(assetComp);
	}
}
