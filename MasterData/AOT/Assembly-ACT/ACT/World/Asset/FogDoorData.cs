using System;
using ACT.Config;
using UnityEngine;
using UnityEngine.Localization;

namespace ACT.World.Asset;

[Serializable]
public class FogDoorData : StateWorldAssetData
{
	[SerializeField]
	private int m_initialStateId;

	[SerializeField]
	private YooAssetReference _interactAddressAssetID;

	[SerializeField]
	private YooAssetReference _timelineAsset;

	[SerializeField]
	private Pos _modelRoot;

	[SerializeField]
	private Pos _checkPoint;

	[SerializeField]
	private Pos _teleportPoint;

	[SerializeField]
	private int _chunkId;

	[SerializeField]
	private MixedBox[] _leaveFields;

	[SerializeField]
	private BoxColliderParameters _triggerFiled;

	public int weight;

	public LocalizedString name;

	public int iconId;

	[SerializeField]
	private int _tipIcon;

	[SerializeField]
	[Header("交互提示位置")]
	private Pos _tipIconPos;

	public override YooAssetReference addressAssetID => _interactAddressAssetID;

	public override ServiceSaveTag serviceSaveTag => ServiceSaveTag.InteractObject;

	public override int initialStateId => m_initialStateId;

	public YooAssetReference timelineAsset => _timelineAsset;

	public Pos ModelRoot => _modelRoot;

	public Pos CheckPoint => _checkPoint;

	public Pos TeleportPoint => _teleportPoint;

	public int ChunkId => _chunkId;

	public MixedBox[] LeaveFields => _leaveFields;

	public BoxColliderParameters TriggerFiled => _triggerFiled;

	public int TipIcon => _tipIcon;

	public Pos TipIconPos => _tipIconPos;

	public override void Bake(object assetComp)
	{
	}
}
