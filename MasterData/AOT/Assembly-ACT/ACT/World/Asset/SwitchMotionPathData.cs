using System;
using ACT.Config;
using ACT.MultiPlayer;
using ACT.World.StateObject;
using Cinemachine;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class SwitchMotionPathData : StateWorldAssetData
{
	[Serializable]
	public class SwitchPoint
	{
		[Serializable]
		public struct CamProperties
		{
			public float fov;

			public float cameraDistance;

			public Bounds confinerVolume;
		}

		[HideInInspector]
		public Vector3 position;

		[Tooltip("目标位置")]
		public Transform transform;

		[Tooltip("进入动作的朝向")]
		public FaceDir enterDir;

		[Tooltip("退出动作的朝向")]
		public FaceDir exitDir;

		[Tooltip("自身碰撞盒区域")]
		public BoxCollider trigger;

		[HideInInspector]
		public Vector3 triggerCenter;

		[HideInInspector]
		public Vector3 triggerSize;

		[Tooltip("相机damping时间")]
		public float cameraDamping = 1f;

		public CamProperties cameraProperties;

		[Tooltip("拖入目标相机")]
		public CinemachineVirtualCamera vc;

		public bool useCameraProperties;

		public int mapLayer;
	}

	public YooAssetReference m_addressAssetID;

	internal int m_initialStateId;

	public SwitchPoint target;

	public InteractEntry entryConfig;

	[SerializeField]
	private bool _hideTrigger;

	public override YooAssetReference addressAssetID => m_addressAssetID;

	public override ServiceSaveTag serviceSaveTag => ServiceSaveTag.InteractObject;

	public override int initialStateId => m_initialStateId;

	public bool HideTrigger => _hideTrigger;

	public override void Bake(object assetComp)
	{
		target.position = target.transform.position;
		target.triggerCenter = target.trigger.center;
		target.triggerSize = target.trigger.size;
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
