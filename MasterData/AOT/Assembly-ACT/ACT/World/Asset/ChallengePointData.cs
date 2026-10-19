using System;
using ACT.Config;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class ChallengePointData : InteractObjectDataBase
{
	[SerializeField]
	private int m_initialStateId;

	public YooAssetReference wrapAssetID;

	public YooAssetReference bpAssetAssetID;

	public override YooAssetReference addressAssetID => wrapAssetID;

	public override ServiceSaveTag serviceSaveTag => ServiceSaveTag.InteractObject;

	public override int initialStateId => m_initialStateId;
}
