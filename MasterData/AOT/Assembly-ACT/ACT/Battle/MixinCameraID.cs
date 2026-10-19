using ACT.Battle.Configs;
using ACT.Battle.ECS.System;
using ACT.Event;
using ACT.World;
using Bamboo.ECS;
using Cinemachine;
using Fundamental;
using UnityEngine;

namespace ACT.Battle;

public class MixinCameraID : MonoTriggerEvent, ITrigger
{
	public ConditionalCamera conditionalCamera;

	public bool isStay;

	public bool needStop;

	[Header("下方参数自动生成")]
	public int triggerID;

	public float xDis;

	public float yDis;

	private BoxCollider boxCollider;

	private void Awake()
	{
		xDis = (yDis = float.MaxValue);
		boxCollider = GetComponent<BoxCollider>();
		isStay = (needStop = false);
	}

	private void Update()
	{
		if (needStop)
		{
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.BattleCharacterChange, ChangeCamFollow);
		}
	}

	private void Start()
	{
		isStay = (needStop = false);
		gameObject.layer = 0;
		if ((bool)conditionalCamera.vCamera)
		{
			conditionalCamera.vCamera.enabled = false;
			conditionalCamera.vCamera.gameObject.SetActive(value: true);
			conditionalCamera.vCamera.Priority = conditionalCamera.cameraPriority;
		}
	}

	private void OnTriggerEnter(Collider other)
	{
		SetCamera(other, out var monoEntity);
		if (!(monoEntity == null) && !(monoEntity.entity != MonoECS.instance.mainEntity))
		{
			CompTransform compTransform = monoEntity.entity.GetCompTransform();
			xDis = Mathf.Min(Mathf.Abs(compTransform.physicsPosition.x - (boxCollider.bounds.center.x - boxCollider.bounds.size.x / 2f)), Mathf.Abs(compTransform.physicsPosition.x - (boxCollider.bounds.center.x + boxCollider.bounds.size.x / 2f)));
			yDis = Mathf.Min(Mathf.Abs(compTransform.physicsPosition.y - (boxCollider.bounds.center.y - boxCollider.bounds.size.y / 2f)), Mathf.Abs(compTransform.physicsPosition.y - (boxCollider.center.y + boxCollider.bounds.size.y / 2f)));
		}
	}

	private void OnTriggerStay(Collider other)
	{
		if (!isStay)
		{
			SetCamera(other, out var _);
		}
		MonoEntity component = other.gameObject.GetComponent<MonoEntity>();
		if (!(component == null) && !(component.entity != MonoECS.instance.mainEntity))
		{
			CompTransform compTransform = component.entity.GetCompTransform();
			xDis = Mathf.Min(Mathf.Abs(compTransform.physicsPosition.x - (boxCollider.bounds.center.x - boxCollider.bounds.size.x / 2f)), Mathf.Abs(compTransform.physicsPosition.x - (boxCollider.bounds.center.x + boxCollider.bounds.size.x / 2f)));
			yDis = Mathf.Min(Mathf.Abs(compTransform.physicsPosition.y - (boxCollider.bounds.center.y - boxCollider.bounds.size.y / 2f)), Mathf.Abs(compTransform.physicsPosition.y - (boxCollider.bounds.center.y + boxCollider.bounds.size.y / 2f)));
		}
	}

	private void OnTriggerExit(Collider other)
	{
		xDis = (yDis = float.MaxValue);
		MonoEntity component = other.gameObject.GetComponent<MonoEntity>();
		if (component != null && component.entity == MonoECS.instance.mainEntity && conditionalCamera.vCamera != null)
		{
			isStay = false;
			OnExitEvt(component.entity, this);
		}
	}

	public void ChangeCamFollow(BaseEventContent obj)
	{
		Transform modelTrans = ((BattleCharacterChangeEvt)obj).newEb.GetModelTrans();
		switch (conditionalCamera.cameraType)
		{
		case ACT.Battle.Configs.CameraType.FollowOwner:
			conditionalCamera.vCamera.Follow = modelTrans;
			if (conditionalCamera.isLookAt)
			{
				conditionalCamera.vCamera.LookAt = modelTrans;
			}
			break;
		case ACT.Battle.Configs.CameraType.TargetGroup:
			ACTAreaCameraTargetGroup.RefreshPlayerSlot(conditionalCamera.targertGroup);
			break;
		case ACT.Battle.Configs.CameraType.None:
		case ACT.Battle.Configs.CameraType.FollowPoint:
		case ACT.Battle.Configs.CameraType.SelfTarget:
		case ACT.Battle.Configs.CameraType.Static:
			break;
		}
	}

	private void SetTagrt(CinemachineTargetGroup.Target[] targets, Transform transform)
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

	private void SetCamera(Collider collision, out MonoEntity monoEntity)
	{
		monoEntity = collision.gameObject.GetComponent<MonoEntity>();
		if (monoEntity == null || monoEntity.entity != MonoECS.instance.mainEntity || conditionalCamera.vCamera == null)
		{
			return;
		}
		isStay = true;
		needStop = false;
		conditionalCamera.vCamera.enabled = true;
		conditionalCamera.enabled = true;
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.BattleCharacterChange, ChangeCamFollow);
		SystemCamera cameraSystem = GameManager.cameraSystem;
		switch (conditionalCamera.cameraType)
		{
		case ACT.Battle.Configs.CameraType.TargetGroup:
			if (conditionalCamera.targertGroup is ACTAreaCameraTargetGroup aCTAreaCameraTargetGroup)
			{
				aCTAreaCameraTargetGroup.BindFromArea(boxCollider);
			}
			else
			{
				ACTAreaCameraTargetGroup.RefreshPlayerSlot(conditionalCamera.targertGroup);
			}
			break;
		case ACT.Battle.Configs.CameraType.FollowOwner:
			conditionalCamera.vCamera.Follow = cameraSystem.CameraPlayerWrapper.transform;
			break;
		case ACT.Battle.Configs.CameraType.None:
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"{conditionalCamera} 的相机类型为 none");
			}
			break;
		case ACT.Battle.Configs.CameraType.SelfTarget:
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("不要用 SelfTarget");
			}
			break;
		}
		OnEnterEvt(monoEntity.entity, this);
	}

	public void TriggerExit()
	{
		xDis = (yDis = float.MaxValue);
		isStay = false;
	}
}
