using System;
using ACT.Config;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class ChunkTpData : StateWorldAssetData
{
	[SerializeField]
	private int m_initialStateId;

	[SerializeField]
	private YooAssetReference _interactAddressAssetID;

	[SerializeField]
	private StateWorldUid _targetChunkTpComp;

	[SerializeField]
	private Pos _targetPos;

	[SerializeField]
	private bool _faceRight;

	[SerializeField]
	[Header("角色TP前等待时间")]
	private float _startWaitTime = 0.5f;

	[SerializeField]
	[Header("角色TP后等待时间")]
	private float _endWaitTime = 0.5f;

	[SerializeField]
	[Header("指向特效的存在时间(秒)，播放时机为角色交互动作结束，等待时间开始前")]
	private float _lineRenderExistTime;

	public override YooAssetReference addressAssetID => _interactAddressAssetID;

	public override ServiceSaveTag serviceSaveTag => ServiceSaveTag.InteractObject;

	public override int initialStateId => m_initialStateId;

	public StateWorldUid TargetChunkTpComp => _targetChunkTpComp;

	public Pos TargetPos => _targetPos;

	public bool FaceRight => _faceRight;

	public float StartWaitTime => _startWaitTime;

	public float EndWaitTime => _endWaitTime;

	public float LineRenderExistTime => _lineRenderExistTime;

	public override void Bake(object assetComp)
	{
	}
}
