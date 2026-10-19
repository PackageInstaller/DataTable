using System;
using ACT.Config;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class LightWallData : StateWorldAssetData
{
	[SerializeField]
	private YooAssetReference m_AddressAssetID;

	[SerializeField]
	private int m_initialStateId;

	public Vector2 sizeXY;

	public LayerMask colliderLayer;

	public float maxLength;

	public override YooAssetReference addressAssetID => m_AddressAssetID;

	public override ServiceSaveTag serviceSaveTag => ServiceSaveTag.InteractObject;

	public override int initialStateId => m_initialStateId;
}
