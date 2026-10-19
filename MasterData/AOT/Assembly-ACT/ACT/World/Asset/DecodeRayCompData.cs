using System;
using ACT.Config;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class DecodeRayCompData : StateWorldAssetData
{
	[SerializeField]
	[Tooltip("初始状态")]
	private int m_initialStateId;

	public YooAssetReference wrapAssetID;

	public override YooAssetReference addressAssetID => wrapAssetID;

	public override ServiceSaveTag serviceSaveTag => ServiceSaveTag.InteractObject;

	public override int initialStateId => m_initialStateId;
}
