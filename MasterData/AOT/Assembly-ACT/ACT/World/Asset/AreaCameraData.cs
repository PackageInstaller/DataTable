using System;
using ACT.Config;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class AreaCameraData : StateWorldAssetData
{
	[SerializeField]
	private YooAssetReference m_AddressAssetID;

	[SerializeField]
	private int m_initialStateId;

	public BoxColliderParameters triggerField;

	public BoxColliderParameters conFinerField;

	public float cameraDistance;

	public Vector3 trackedObjectOffset;

	public override YooAssetReference addressAssetID => m_AddressAssetID;

	public override ServiceSaveTag serviceSaveTag => ServiceSaveTag.InteractObject;

	public override int initialStateId => m_initialStateId;
}
