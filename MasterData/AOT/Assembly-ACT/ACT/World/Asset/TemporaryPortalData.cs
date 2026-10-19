using System;
using ACT.Config;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class TemporaryPortalData : InteractObjectDataBase
{
	public YooAssetReference wrapAssetID;

	[SerializeField]
	private int m_initialStateId;

	public override YooAssetReference addressAssetID => wrapAssetID;

	public override ServiceSaveTag serviceSaveTag => ServiceSaveTag.InteractObject;

	public override int initialStateId => m_initialStateId;

	public override Vector3 GetTeleportPos()
	{
		return base.GetTeleportPos();
	}

	public override bool IsServiceSaveState(int stateId)
	{
		return true;
	}
}
