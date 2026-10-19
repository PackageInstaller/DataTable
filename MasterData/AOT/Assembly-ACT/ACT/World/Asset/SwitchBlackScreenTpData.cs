using System;
using ACT.Config;
using ACT.MultiPlayer;
using ACT.World.StateObject;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class SwitchBlackScreenTpData : StateWorldAssetData
{
	[Serializable]
	public class BlackScreenTpSwitchTarget
	{
		[SerializeField]
		[HideInInspector]
		private Vector3 _position;

		[SerializeField]
		[HideInInspector]
		internal Vector3 _triggerCenter;

		[SerializeField]
		[HideInInspector]
		internal Vector3 _triggerSize;

		[SerializeField]
		[Tooltip("进入动作的朝向")]
		private FaceDir _enterDir;

		[SerializeField]
		[Tooltip("退出动作的朝向")]
		private FaceDir _exitDir;

		[SerializeField]
		private float _rotateTime = 0.5f;

		[SerializeField]
		private float _fadeDuration = 0.5f;

		[SerializeField]
		private int _chunkId;

		[SerializeField]
		private Vector3 _tpPos;

		public Vector3 Position => _position;

		public Vector3 TriggerCenter => _triggerCenter;

		public Vector3 TriggerSize => _triggerSize;

		public float RotateTime => _rotateTime;

		public FaceDir EnterDir => _enterDir;

		public FaceDir ExitDir => _exitDir;

		public float FadeDuration => _fadeDuration;

		public int ChunkId => _chunkId;

		public Vector3 TpPos => _tpPos;
	}

	public YooAssetReference m_addressAssetID;

	internal int m_initialStateId;

	[SerializeField]
	private BlackScreenTpSwitchTarget _switchPoint;

	public InteractEntry entryConfig;

	public override YooAssetReference addressAssetID => m_addressAssetID;

	public override ServiceSaveTag serviceSaveTag => ServiceSaveTag.InteractObject;

	public override int initialStateId => m_initialStateId;

	public BlackScreenTpSwitchTarget SwitchPoint => _switchPoint;

	public override bool IsServiceSaveState(int stateId)
	{
		if (stateId != 0)
		{
			return stateId == -1;
		}
		return true;
	}
}
