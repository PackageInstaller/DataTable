using System;
using ACT.Battle;
using ACT.Config;

namespace ACT.World.Asset;

[Serializable]
public class RaidTrapData : StateWorldAssetData
{
	public YooAssetReference modelAssetID;

	public Alliance alliance;

	public int attackId;

	public string[] abilities;

	public MixedBox[] fields;

	public override YooAssetReference addressAssetID => GameLoader.meta.raidTrapReferenceAssetID;

	public override ServiceSaveTag serviceSaveTag => ServiceSaveTag.InteractObject;

	public override int initialStateId => 0;
}
