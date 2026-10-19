using System;
using ACT.Config;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class BossChallengeData : InteractObjectDataBase
{
	public YooAssetReference wrapAssetID;

	public int bossPoint = 10101;

	[SerializeField]
	private int m_initialStateId;

	public override YooAssetReference addressAssetID => wrapAssetID;

	public override ServiceSaveTag serviceSaveTag => ServiceSaveTag.InteractObject;

	public override int initialStateId => m_initialStateId;

	public override void Bake(object baker)
	{
	}
}
