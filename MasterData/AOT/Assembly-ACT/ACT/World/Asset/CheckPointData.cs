using System;
using ACT.Config;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class CheckPointData : StateWorldAssetData
{
	public YooAssetReference m_addressAssetID;

	public BoxCollider trigger;

	[HideInInspector]
	public Bounds bounds;

	public override YooAssetReference addressAssetID => m_addressAssetID;

	public override ServiceSaveTag serviceSaveTag => ServiceSaveTag.InteractObject;

	public override int initialStateId { get; }

	public override void Bake(object assetComp)
	{
		bounds.center = trigger.center;
		bounds.size = trigger.bounds.size;
		base.Bake(assetComp);
	}
}
