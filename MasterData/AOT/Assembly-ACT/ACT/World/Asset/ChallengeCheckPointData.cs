using System;
using System.Collections.Generic;
using ACT.Config;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class ChallengeCheckPointData : StateWorldAssetData
{
	[SerializeField]
	private int m_initialStateId;

	public YooAssetReference wrapAssetID;

	public List<Pos> points;

	public override YooAssetReference addressAssetID => wrapAssetID;

	public override ServiceSaveTag serviceSaveTag => ServiceSaveTag.InteractObject;

	public override int initialStateId => m_initialStateId;

	public override void Bake(object assetComp)
	{
		points.Bake(assetComp);
	}

	public override bool IsServiceSaveState(int stateId)
	{
		return false;
	}
}
