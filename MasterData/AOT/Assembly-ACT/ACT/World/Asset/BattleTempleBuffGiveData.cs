using System;
using ACT.Config;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class BattleTempleBuffGiveData : StateWorldAssetData
{
	public int belongRoomIndex;

	[SerializeField]
	private int m_initialStateId;

	public override YooAssetReference addressAssetID => GameLoader.meta?.battleTempleBuffGiveReferenceAssetID;

	public override ServiceSaveTag serviceSaveTag => ServiceSaveTag.InteractObject;

	public override int initialStateId => m_initialStateId;
}
