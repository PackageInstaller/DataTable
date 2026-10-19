using ACT.Config;
using UnityEngine;

namespace ACT.World.Asset;

public class SceneRouterData : StateWorldAssetData
{
	[SerializeField]
	private YooAssetReference _sceneAsset;

	public BoxColliderParameters _triggerField;

	public override YooAssetReference addressAssetID => _sceneAsset;

	public override ServiceSaveTag serviceSaveTag => ServiceSaveTag.NotSave;

	public override int initialStateId => 0;
}
