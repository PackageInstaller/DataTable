using ACT.Battle.Configs;
using Bamboo.ECS;
using Bamboo.Precache;
using Cinemachine;
using Fundamental;
using UnityEngine;

namespace ACT.Battle.ECS.System;

public class CameraRuntimeItem
{
	public Entity caster;

	public GameObject go;

	public YooAssetReference assetReferenceAssetID;

	public CinemachineVirtualCamera virtualCamera;

	private InstanceHandle instanceHandle;

	public void Reset()
	{
		caster = default;
		if (instanceHandle != null)
		{
			PrecacheManager.Instance.ReleaseInstanceHandle(instanceHandle);
			instanceHandle = null;
		}
		go = null;
		assetReferenceAssetID = null;
		if (virtualCamera != null)
		{
			virtualCamera.Priority = 0;
			virtualCamera = null;
		}
	}

	public void OnLoad(InstanceHandle handler, YooAssetReference asset, CameraConfig config, Vector3 pos)
	{
		instanceHandle = handler;
		go = handler.Result;
		go.gameObject.transform.SetParent(null);
		go.transform.position = pos;
		assetReferenceAssetID = asset;
		virtualCamera = go.GetComponentInChildren<CinemachineVirtualCamera>(includeInactive: true);
		virtualCamera.Priority = virtualCamera.defaultPriority;
		switch (config.tgType)
		{
		case ACT.Battle.Configs.CameraType.None:
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"{caster} 的相机 {go} 相机类型不能为 none ");
			}
			break;
		case ACT.Battle.Configs.CameraType.SelfTarget:
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"{caster} 的相机 {go} 相机类型不能为 SelfTarget ");
			}
			break;
		case ACT.Battle.Configs.CameraType.Static:
		{
			CinemachineVirtualCamera cinemachineVirtualCamera = virtualCamera;
			Transform follow = (virtualCamera.LookAt = null);
			cinemachineVirtualCamera.Follow = follow;
			break;
		}
		case ACT.Battle.Configs.CameraType.FollowOwner:
		{
			if (caster.IsCharacter())
			{
				virtualCamera.Follow = Singleton<GameManager>.instance.ecsManager.systemCamera.CameraPlayerWrapper.transform;
				break;
			}
			Transform modelTrans = caster.GetModelTrans();
			virtualCamera.Follow = modelTrans;
			virtualCamera.LookAt = modelTrans;
			break;
		}
		case ACT.Battle.Configs.CameraType.FollowPoint:
		{
			MonoEntity mono = caster.GetMono();
			if (mono.TryGetAttachPoint(config.followPoint, out var attackPoint))
			{
				virtualCamera.Follow = attackPoint;
			}
			else
			{
				_ = "FollowPoint没有找到挂点" + config.followPoint;
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError("log");
				}
			}
			if (mono.TryGetAttachPoint(config.followPoint, out var attackPoint2))
			{
				virtualCamera.LookAt = attackPoint2;
			}
			else if (LuminApplication.LogEnabled)
			{
				Debug.LogWarning("LookAtPoint没有找到挂点" + config.followPoint);
			}
			break;
		}
		case ACT.Battle.Configs.CameraType.TargetGroup:
			break;
		}
	}
}
