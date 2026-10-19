using System;
using System.Collections.Generic;
using ACT.Config;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class HiddenRoomData : StateWorldAssetData
{
	public int unlockFogId;

	public List<int> unlockChunkIds;

	public int lightHouseId;

	[SerializeField]
	private BoxCollider boxCollider;

	public Vector3 colliderSize;

	public Vector3 colliderCenter;

	[SerializeField]
	private YooAssetReference m_AddressAssetID;

	public int m_initialStateId;

	public override YooAssetReference addressAssetID => m_AddressAssetID;

	public override ServiceSaveTag serviceSaveTag => ServiceSaveTag.InteractObject;

	public override int initialStateId => m_initialStateId;
}
