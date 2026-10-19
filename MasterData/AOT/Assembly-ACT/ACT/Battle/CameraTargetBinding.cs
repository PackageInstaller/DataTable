using ACT.Battle.Configs;
using ACT.Battle.ECS.System;
using Bamboo.ECS;
using Cinemachine;
using UnityEngine;

namespace ACT.Battle;

public class CameraTargetBinding : MonoBehaviour
{
	[SerializeField]
	private ACT.Battle.Configs.CameraType _cameraType;

	[SerializeField]
	private bool _isLookAt;

	[SerializeField]
	private string _followPoint;

	[SerializeField]
	private CinemachineTargetGroup _targetGroup;

	private CinemachineVirtualCameraBase _vCamera;

	private void Awake()
	{
		_vCamera = GetComponent<CinemachineVirtualCameraBase>();
		BindingCamera(_vCamera, _cameraType, _isLookAt, _followPoint, _targetGroup);
	}

	public static void BindingCamera(CinemachineVirtualCameraBase vCamera, ACT.Battle.Configs.CameraType cameraType, bool isLookAt, string followPoint, CinemachineTargetGroup targetGroup)
	{
		if (!vCamera)
		{
			return;
		}
		SystemCamera cameraSystem = GameManager.cameraSystem;
		switch (cameraType)
		{
		case ACT.Battle.Configs.CameraType.FollowOwner:
			vCamera.Follow = cameraSystem.CameraPlayerWrapper.transform;
			if (isLookAt)
			{
				vCamera.LookAt = cameraSystem.CameraPlayerWrapper.transform;
			}
			break;
		case ACT.Battle.Configs.CameraType.FollowPoint:
		{
			Transform lookAt = (vCamera.Follow = MonoECS.instance.mainEntity.GetRootTransform().Find(followPoint));
			if (isLookAt)
			{
				vCamera.LookAt = lookAt;
			}
			break;
		}
		case ACT.Battle.Configs.CameraType.TargetGroup:
			vCamera.Follow = targetGroup.gameObject.transform;
			if (isLookAt)
			{
				vCamera.LookAt = targetGroup.gameObject.transform;
			}
			break;
		case ACT.Battle.Configs.CameraType.SelfTarget:
			break;
		}
	}
}
