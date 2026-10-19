using System;
using ACT.Config;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class TimelineData : InteractObjectDataBase
{
	[SerializeField]
	private int m_initialStateId;

	public YooAssetReference wrapAssetID;

	public YooAssetReference timelineAssetAssetID;

	public override YooAssetReference addressAssetID => wrapAssetID;

	public override ServiceSaveTag serviceSaveTag => ServiceSaveTag.Transfer;

	public override int initialStateId => m_initialStateId;

	public override void Bake(object baker)
	{
	}
}
