using System;
using System.Collections.Generic;
using Bamboo.ECS;
using Fundamental;
using Runtime.Battle.ECS.System.SystemInteract;
using UnityEngine;
using UnityEngine.Events;

namespace ACT.Battle;

[RequireComponent(typeof(MonoTriggerInteract))]
public class TriggerMultiCameraNoise : MonoBehaviour
{
	public List<MultiCameraNoiseData> configs;

	[Tooltip("Update 中重复触发配置里所有的震屏资源效果的间隔，与单次震屏 duration 无关")]
	public float interval = 0.2f;

	[SerializeField]
	private MonoTriggerInteract _triggerInteract;

	private bool _active;

	private float _timer;

	private void Awake()
	{
		if (_triggerInteract == null)
		{
			_triggerInteract = GetComponent<MonoTriggerInteract>();
		}
		if (!(_triggerInteract == null))
		{
			MonoTriggerInteract triggerInteract = _triggerInteract;
			triggerInteract.OnTriggerEnterCallback = (UnityAction<Collider>)Delegate.Combine(triggerInteract.OnTriggerEnterCallback, new UnityAction<Collider>(OnEnter));
			MonoTriggerInteract triggerInteract2 = _triggerInteract;
			triggerInteract2.OnTriggerExitCallback = (UnityAction<Collider>)Delegate.Combine(triggerInteract2.OnTriggerExitCallback, new UnityAction<Collider>(OnExit));
		}
	}

	private void OnDestroy()
	{
		if (_triggerInteract != null)
		{
			MonoTriggerInteract triggerInteract = _triggerInteract;
			triggerInteract.OnTriggerEnterCallback = (UnityAction<Collider>)Delegate.Remove(triggerInteract.OnTriggerEnterCallback, new UnityAction<Collider>(OnEnter));
			MonoTriggerInteract triggerInteract2 = _triggerInteract;
			triggerInteract2.OnTriggerExitCallback = (UnityAction<Collider>)Delegate.Remove(triggerInteract2.OnTriggerExitCallback, new UnityAction<Collider>(OnExit));
		}
		StopAndUnload();
	}

	private void Update()
	{
		if (_active)
		{
			_timer += GameManager.timeSystem.GetCurrentDeltaTime();
			if (!(_timer < interval))
			{
				_timer = 0f;
				PlayOnce();
			}
		}
	}

	private void OnEnter(Collider other)
	{
		List<MultiCameraNoiseData> list = configs;
		if (list != null && list.Count > 0)
		{
			_timer = 0f;
			_active = true;
			PlayOnce();
		}
	}

	private void OnExit(Collider other)
	{
		StopAndUnload();
	}

	private void StopAndUnload()
	{
		if (!_active)
		{
			return;
		}
		_active = false;
		_timer = 0f;
		if (configs == null)
		{
			return;
		}
		for (int i = 0; i < configs.Count; i++)
		{
			MultiCameraNoiseData multiCameraNoiseData = configs[i];
			if (multiCameraNoiseData != null && multiCameraNoiseData.IsValid())
			{
				Singleton<CameraNoiseManager>.instance.UnloadCameraNoise(multiCameraNoiseData.noiseAssetID);
			}
		}
	}

	private void PlayOnce()
	{
		Entity mainEntity = MonoECS.instance.mainEntity;
		if (mainEntity == null)
		{
			return;
		}
		Transform modelTrans = mainEntity.GetModelTrans();
		if ((object)modelTrans == null)
		{
			return;
		}
		for (int i = 0; i < configs.Count; i++)
		{
			MultiCameraNoiseData multiCameraNoiseData = configs[i];
			if (multiCameraNoiseData != null && multiCameraNoiseData.IsValid())
			{
				float force = ((multiCameraNoiseData.force == 0f) ? 1f : multiCameraNoiseData.force);
				Singleton<CameraNoiseManager>.instance.TriggerCameraNoise(CameraNoiseType.LevelTrigger, modelTrans.position, multiCameraNoiseData.noiseAssetID, Vector3.zero, multiCameraNoiseData.duration, force);
			}
		}
	}
}
