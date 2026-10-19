using System;
using ACT.Config;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class UpdraftData : StateWorldAssetData
{
	public bool showUnlockTimeline;

	[SerializeField]
	private int m_initialStateId;

	[SerializeField]
	private YooAssetReference m_AddressAssetID;

	public BoxColliderParameters triggerField;

	public bool useDynamicRegion = true;

	public Vector3 ForceDir = Vector3.up;

	public float Force = 600f;

	public override YooAssetReference addressAssetID => m_AddressAssetID;

	public override ServiceSaveTag serviceSaveTag => ServiceSaveTag.InteractObject;

	public override int initialStateId => m_initialStateId;
}
