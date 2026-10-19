using System;
using ACT.Config;
using ACT.World.StateObject;

namespace ACT.World.Asset;

[Serializable]
public class RaidCheckPointData : StateWorldAssetData
{
	public YooAssetReference modelAssetID;

	public int trapState;

	public InteractType interactType;

	public override YooAssetReference addressAssetID => GameLoader.meta.raidCheckPointReferenceAssetID;

	public override ServiceSaveTag serviceSaveTag => ServiceSaveTag.InteractObject;

	public override int initialStateId => 1;
}
