using System;
using ACT.Config;
using ACT.MultiPlayer;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class PathSwitchInteractData : StateWorldAssetData
{
	[SerializeField]
	private YooAssetReference _addressAssetId;

	private int _initialStateId;

	[SerializeField]
	private PathSwitchInteractEntryType _interactType;

	[SerializeField]
	private PathSwitchInteractConfig _interactConfig = new PathSwitchInteractConfig();

	[SerializeField]
	private PathSwitchButtonConfig _buttonConfig = new PathSwitchButtonConfig();

	[SerializeField]
	private BoxColliderParameters _trigger = new BoxColliderParameters();

	[SerializeField]
	private PathSwitchInteractMode _switchMode;

	[SerializeField]
	[Tooltip("交互开始时的角色朝向。强制跑步模式也使用该朝向。")]
	private FaceDir _enterFaceDir;

	[SerializeField]
	[Tooltip("传送或无黑屏移动完成后的角色朝向。")]
	private FaceDir _exitFaceDir;

	[SerializeField]
	private Pos _targetTransform;

	[SerializeField]
	[Tooltip("-1 表示当前 Active Chunk；其他值会按跨 Chunk 传送处理。")]
	private int _chunkId = -1;

	[SerializeField]
	private float _blackFadeDuration = 0.5f;

	[SerializeField]
	private float _rotateDuration = 0.5f;

	[SerializeField]
	private float _dissolveDuration = 0.5f;

	public override YooAssetReference addressAssetID => _addressAssetId;

	public override ServiceSaveTag serviceSaveTag => ServiceSaveTag.InteractObject;

	public override int initialStateId => _initialStateId;

	public PathSwitchInteractEntryType InteractType => _interactType;

	public PathSwitchInteractConfig InteractConfig => _interactConfig;

	public PathSwitchButtonConfig ButtonConfig => _buttonConfig;

	public BoxColliderParameters Trigger => _trigger;

	public PathSwitchInteractMode SwitchMode => _switchMode;

	public FaceDir EnterFaceDir => _enterFaceDir;

	public FaceDir ExitFaceDir => _exitFaceDir;

	public Pos TargetPosition => _targetTransform;

	public int ChunkId => _chunkId;

	public float RotateDuration => _rotateDuration;

	public float DissolveDuration => _dissolveDuration;

	public float BlackFadeDuration => _blackFadeDuration;

	private bool UsesButton => _interactType == PathSwitchInteractEntryType.Button;

	private bool IsBlackScreenTeleport => _switchMode == PathSwitchInteractMode.BlackScreenTeleport;

	private bool IsMoveWithoutBlackScreen => _switchMode == PathSwitchInteractMode.MoveWithoutBlackScreen;

	public override void Bake(object assetComp)
	{
		base.Bake(assetComp);
	}

	public override bool IsServiceSaveState(int stateId)
	{
		if (stateId != 0)
		{
			return stateId == -1;
		}
		return true;
	}
}
