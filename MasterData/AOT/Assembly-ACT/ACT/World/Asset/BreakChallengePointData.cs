using System;
using ACT.Config;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class BreakChallengePointData : StateWorldAssetData
{
	[SerializeField]
	private int m_initialStateId;

	[SerializeField]
	private YooAssetReference _interactAddressAssetID;

	[SerializeField]
	private int _breakChallengeConfigId;

	public override YooAssetReference addressAssetID => _interactAddressAssetID;

	public override ServiceSaveTag serviceSaveTag => ServiceSaveTag.InteractObject;

	public override int initialStateId => m_initialStateId;

	public int BreakChallengeConfigId => _breakChallengeConfigId;

	public override void Bake(object assetComp)
	{
	}

	public override bool IsServiceSaveState(int stateId)
	{
		if (stateId != 0)
		{
			return stateId == 2;
		}
		return true;
	}
}
