using System;
using ACT.Config;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class RaidCollectionData : StateWorldAssetData
{
	public string[] abilities;

	public bool raidBossChallengeRewardPoint;

	public YooAssetReference modelAssetID;

	[SerializeField]
	private int m_initialStateId;

	public override YooAssetReference addressAssetID => GameLoader.meta.raidCollectorReferenceAssetID;

	public override ServiceSaveTag serviceSaveTag => ServiceSaveTag.RaidCollection;

	public override int initialStateId => m_initialStateId;
}
