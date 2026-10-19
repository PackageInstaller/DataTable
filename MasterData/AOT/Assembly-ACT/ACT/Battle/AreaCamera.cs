using ACT.Battle.Configs;
using ACT.Battle.ECS.System;
using ACT.World;
using Bamboo.ECS;
using Cinemachine;
using UnityEngine;

namespace ACT.Battle;

public class AreaCamera : MonoTriggerEvent, ITrigger
{
	public interface IAreaCameraLogic
	{
	}

	public class AreaCameraLogicDefault : IAreaCameraLogic
	{
	}

	public class AreaCameraLogicForBlender : IAreaCameraLogic
	{
	}

	public ConditionalCamera conditionalCamera;

	protected bool isStay;

	private AreaCameraBlender m_AreaCameraBlender;

	private Collider m_Collider;

	public Collider Collider => m_Collider;

	public bool IsStay => isStay;

	public AreaCameraBlender AreaCameraBlender
	{
		get
		{
			return m_AreaCameraBlender;
		}
		set
		{
			m_AreaCameraBlender = value;
		}
	}

	private void Awake()
	{
		m_Collider = GetComponent<Collider>();
	}

	public void Start()
	{
		isStay = false;
		gameObject.layer = 0;
		if ((bool)conditionalCamera.vCamera)
		{
			conditionalCamera.vCamera.enabled = false;
			conditionalCamera.vCamera.gameObject.SetActive(value: true);
			conditionalCamera.vCamera.Priority = conditionalCamera.cameraPriority;
		}
	}

	public void OnTriggerEnter(Collider other)
	{
		if (!enabled)
		{
			return;
		}
		MonoEntity component = other.gameObject.GetComponent<MonoEntity>();
		SetCamera(component, newIsStay: true);
		if (component != null && component.entity.IsValid && component.entity.IsMonster())
		{
			Entity entity = component.entity;
			ACT.Battle.Configs.CameraType cameraType = conditionalCamera.cameraType;
			if (cameraType == ACT.Battle.Configs.CameraType.TargetGroup || cameraType == ACT.Battle.Configs.CameraType.TargetGroupCanChangeFOV)
			{
				TryBindMonsterToTargetGroup(entity);
			}
		}
	}

	public void OnTriggerExit(Collider other)
	{
		if (!enabled || conditionalCamera.vCamera == null)
		{
			return;
		}
		MonoEntity component = other.gameObject.GetComponent<MonoEntity>();
		if ((bool)component && MonoECS.instance.IsMainEntity(component.entity))
		{
			isStay = false;
			if ((bool)m_AreaCameraBlender)
			{
				conditionalCamera.vCamera.enabled = true;
			}
			else
			{
				conditionalCamera.vCamera.enabled = false;
			}
			conditionalCamera.enabled = false;
			OnExitEvt(component.entity, this);
		}
	}

	public void OnTriggerStay(Collider other)
	{
		if (enabled)
		{
			MonoEntity component = other.gameObject.GetComponent<MonoEntity>();
			if (!isStay)
			{
				SetCamera(component, newIsStay: true);
			}
		}
	}

	public void TriggerExit()
	{
		isStay = false;
		if ((bool)conditionalCamera.vCamera)
		{
			if ((bool)m_AreaCameraBlender)
			{
				conditionalCamera.vCamera.enabled = true;
			}
			else
			{
				conditionalCamera.vCamera.enabled = false;
			}
		}
		conditionalCamera.enabled = false;
	}

	public void AddExtraTagrt(CinemachineTargetGroup.Target[] targets, Transform transform)
	{
		int num = 1;
		bool flag;
		for (flag = num < targets.Length; flag && targets[num].target != null; flag = num < targets.Length)
		{
			num++;
		}
		if (flag)
		{
			targets[num].target = transform;
		}
	}

	public void SetCamera(MonoEntity monoEntity, bool newIsStay)
	{
		if ((bool)monoEntity && MonoECS.instance.IsMainEntity(monoEntity.entity))
		{
			isStay = newIsStay;
			if ((bool)m_AreaCameraBlender)
			{
				conditionalCamera.vCamera.enabled = true;
			}
			else
			{
				conditionalCamera.vCamera.enabled = isStay;
			}
			conditionalCamera.enabled = isStay;
			ACT.Battle.Configs.CameraType cameraType = conditionalCamera.cameraType;
			if (cameraType == ACT.Battle.Configs.CameraType.TargetGroup || cameraType == ACT.Battle.Configs.CameraType.TargetGroupCanChangeFOV)
			{
				BindTargetGroupOnPlayerEnter();
			}
			OnEnterEvt(monoEntity.entity, this);
		}
	}

	private void BindTargetGroupOnPlayerEnter()
	{
		CinemachineTargetGroup targertGroup = conditionalCamera.targertGroup;
		if (!targertGroup)
		{
			return;
		}
		if (targertGroup is ACTAreaCameraTargetGroup aCTAreaCameraTargetGroup)
		{
			aCTAreaCameraTargetGroup.BindFromArea(m_Collider);
			return;
		}
		bool flag = false;
		SystemCamera cameraSystem = GameManager.cameraSystem;
		for (int i = 0; i < targertGroup.m_Targets.Length; i++)
		{
			Transform target = targertGroup.m_Targets[i].target;
			if (!(target == null))
			{
				MonoEntity component = target.GetComponent<MonoEntity>();
				if ((object)component != null && component.entity.IsCharacter())
				{
					flag = true;
					targertGroup.m_Targets[i].target = cameraSystem.CameraPlayerWrapper.transform;
				}
			}
		}
		if (!flag)
		{
			targertGroup.m_Targets[0].target = cameraSystem.CameraPlayerWrapper.transform;
		}
	}

	private void TryBindMonsterToTargetGroup(Entity entity)
	{
		CinemachineTargetGroup targertGroup = conditionalCamera.targertGroup;
		if ((bool)targertGroup)
		{
			if (targertGroup is ACTAreaCameraTargetGroup aCTAreaCameraTargetGroup)
			{
				aCTAreaCameraTargetGroup.TryBindMonster(entity);
			}
			else
			{
				AddExtraTagrt(targertGroup.m_Targets, entity.GetModelTrans());
			}
		}
	}

	private void OnDisable()
	{
		MonoECS.instance?.triggerManager?.UnregisterTrigger(this);
		TriggerExit();
	}
}
