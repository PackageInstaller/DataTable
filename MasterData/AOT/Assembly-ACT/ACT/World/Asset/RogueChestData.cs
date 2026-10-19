using System;
using System.Collections.Generic;
using ACT.Config;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class RogueChestData : InteractObjectDataBase
{
	public YooAssetReference wrapAsset;

	public List<StateWorldUid> connectRewards = new List<StateWorldUid>();

	public Transform dropTrans;

	public override YooAssetReference addressAssetID => wrapAsset;

	public override ServiceSaveTag serviceSaveTag => ServiceSaveTag.InteractObject;

	public override int initialStateId => 0;
}
