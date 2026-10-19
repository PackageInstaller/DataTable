using System;
using ACT.Config;
using ACT.World.StateObject;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class RaidRewardPointData : StateWorldAssetData
{
	public string[] abilities;

	public bool raidBossChallengeRewardPoint;

	public YooAssetReference modelAssetID;

	public InteractType InteractType;

	[SerializeField]
	private int m_initialStateId;

	public override YooAssetReference addressAssetID
	{
		get
		{
			if (!raidBossChallengeRewardPoint)
			{
				return GameLoader.meta.raidRewardPointReferenceAssetID;
			}
			return GameLoader.meta.raidBossChallengeRewardPointReferenceAssetID;
		}
	}

	public override ServiceSaveTag serviceSaveTag => ServiceSaveTag.InteractObject;

	public override int initialStateId => m_initialStateId;
}
