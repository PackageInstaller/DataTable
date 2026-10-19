using System;
using ACT.Config;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class TempleRewardPointData : StateWorldAssetData
{
	public YooAssetReference modelAssetID;

	[SerializeField]
	private int m_initialStateId;

	public override YooAssetReference addressAssetID => GameLoader.meta.TempleRewardPointReferenceAssetID;

	public override ServiceSaveTag serviceSaveTag => ServiceSaveTag.InteractObject;

	public override int initialStateId => m_initialStateId;
}
