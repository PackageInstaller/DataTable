using System;
using ACT.Battle.Configs;
using Bamboo.ECS;
using Cinemachine;
using UnityEngine;

namespace ACT.Battle;

[Serializable]
public struct ConditionalCamera
{
	public int cameraPriority;

	public CinemachineVirtualCameraBase vCamera;

	public ACT.Battle.Configs.CameraType cameraType;

	public string followPoint;

	public CinemachineTargetGroup targertGroup;

	public bool isLookAt;

	private bool m_enabled;

	public bool enabled
	{
		get
		{
			return m_enabled;
		}
		set
		{
			if (m_enabled != value)
			{
				m_enabled = value;
				RefreshVCam();
			}
		}
	}

	private void RefreshVCam()
	{
		if (!vCamera)
		{
			return;
		}
		vCamera.Priority = cameraPriority;
		switch (cameraType)
		{
		case ACT.Battle.Configs.CameraType.FollowOwner:
		{
			CameraPlayerWrapper cameraPlayerWrapper = GameManager.cameraSystem?.CameraPlayerWrapper;
			if ((bool)cameraPlayerWrapper)
			{
				Transform transform2 = cameraPlayerWrapper.transform;
				vCamera.Follow = transform2;
				if (isLookAt)
				{
					vCamera.LookAt = transform2;
				}
			}
			break;
		}
		case ACT.Battle.Configs.CameraType.FollowPoint:
		{
			Transform rootTransform = (MonoECS.instance?.mainEntity ?? default(Entity)).GetRootTransform();
			if ((bool)rootTransform)
			{
				Transform transform3 = (string.IsNullOrEmpty(followPoint) ? null : rootTransform.Find(followPoint));
				vCamera.Follow = transform3;
				if (isLookAt)
				{
					vCamera.LookAt = transform3;
				}
			}
			break;
		}
		case ACT.Battle.Configs.CameraType.TargetGroup:
			if ((bool)targertGroup)
			{
				Transform transform = targertGroup.transform;
				vCamera.Follow = transform;
				vCamera.LookAt = transform;
			}
			break;
		case ACT.Battle.Configs.CameraType.SelfTarget:
			break;
		}
	}
}
