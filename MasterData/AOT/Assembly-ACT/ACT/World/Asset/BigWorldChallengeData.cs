using System;
using ACT.Config;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class BigWorldChallengeData : StateWorldAssetData
{
	[SerializeField]
	private int m_initialStateId;

	[SerializeField]
	private YooAssetReference _interactAddressAssetID;

	[SerializeField]
	private ChallengeType _challengeType;

	[SerializeField]
	private int _challengeConfigId;

	[SerializeField]
	private Pos _switchPos;

	public override YooAssetReference addressAssetID => _interactAddressAssetID;

	public override ServiceSaveTag serviceSaveTag => ServiceSaveTag.InteractObject;

	public override int initialStateId => m_initialStateId;

	public ChallengeType ChallengeType => _challengeType;

	public int ChallengeConfigId => _challengeConfigId;

	public Pos SwitchPos => _switchPos;

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
