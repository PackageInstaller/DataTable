using System;
using ACT.Config;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class ExplorationRobotData : InteractObjectDataBase, IMiniGameData
{
	[SerializeField]
	private YooAssetReference m_AddressAssetID;

	[SerializeField]
	internal int m_initialStateId = -1;

	[SerializeField]
	private SeparateSegmentConfigs.Difficulty _difficulty;

	public bool UseMiniGame => true;

	public override bool isStatic => false;

	public override YooAssetReference addressAssetID => m_AddressAssetID;

	public override ServiceSaveTag serviceSaveTag => ServiceSaveTag.InteractObject;

	public override int initialStateId => m_initialStateId;

	public SeparateSegmentConfigs.Difficulty Difficulty => _difficulty;
}
