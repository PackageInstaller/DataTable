using System;
using ACT.Config;
using ACT.World.StateObject;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class TempleCheckPointData : StateWorldAssetData
{
	public YooAssetReference modelAssetID;

	public int trapState;

	public InteractType interactType;

	public BoxColliderParameters triggerField;

	public Vector3 offset;

	public override YooAssetReference addressAssetID => GameLoader.meta.templeCheckPointReferenceAssetID;

	public override ServiceSaveTag serviceSaveTag => ServiceSaveTag.InteractObject;

	public override int initialStateId => 1;
}
