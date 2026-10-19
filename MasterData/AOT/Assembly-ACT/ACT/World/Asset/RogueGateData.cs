using System;
using ACT.Config;

namespace ACT.World.Asset;

[Serializable]
public class RogueGateData : InteractObjectDataBase
{
	public YooAssetReference wrapAsset;

	public int gateIndex;

	public override YooAssetReference addressAssetID => wrapAsset;

	public override ServiceSaveTag serviceSaveTag => ServiceSaveTag.InteractObject;

	public override int initialStateId => 0;
}
