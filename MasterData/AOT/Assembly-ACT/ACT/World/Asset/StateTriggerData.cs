using System;
using ACT.Config;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class StateTriggerData : StateWorldAssetData
{
	public BoxColliderParameters boxCollider;

	[SerializeField]
	private int m_InitialStateId;

	public override YooAssetReference addressAssetID => GameLoader.meta.stateTriggerReferenceAssetID;

	public override ServiceSaveTag serviceSaveTag => ServiceSaveTag.InteractObject;

	public override int initialStateId => m_InitialStateId;
}
