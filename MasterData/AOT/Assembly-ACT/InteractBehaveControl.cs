using System.Collections.Generic;
using ACT;
using ACT.Battle;
using ACT.World.Actions;
using ACT.World.Asset;
using ACT.World.Behave;
using ACT.World.StateObject;
using Bamboo.ECS;
using UnityEngine;
using UnityEngine.ResourceManagement.AsyncOperations;

public class InteractBehaveControl : StateObjectBase
{
	public BehaveControlBaseBehaveEvent behave;

	public Transform root;

	private InteractBehaveControlData m_Data;

	private Transform m_Root;

	public Entity ControlEb { get; protected set; }

	public override bool serviceSave => true;

	public override async void InitStateObject(int stateId)
	{
		m_Data = entity.GetCompStateObject().StateWorldAssetData as InteractBehaveControlData;
		base.InitStateObject(stateId);
		bool active = true;
		Vector3 pos = m_Data.initPos;
		if (stateId < 1000)
		{
			switch (stateId)
			{
			case -1:
				active = false;
				break;
			case 2:
			{
				List<EventInfo> behavePosInfos = m_Data.behavePosInfos;
				pos = behavePosInfos[behavePosInfos.Count - 1].pos.value;
				break;
			}
			}
		}
		else
		{
			int index = stateId - 1000;
			pos = m_Data.behavePosInfos[index].pos.value;
		}
		switch (m_Data.behaveType)
		{
		case BehaveType.PointMove:
		{
			BehaveControlHandleBehaveEvent behaveControlHandleBehaveEvent = root.gameObject.GetComponent<BehaveControlHandleBehaveEvent>();
			if (behaveControlHandleBehaveEvent == null)
			{
				behaveControlHandleBehaveEvent = root.gameObject.AddComponent<BehaveControlHandleBehaveEvent>();
			}
			behaveControlHandleBehaveEvent.interactBehaveControl = this;
			behave = behaveControlHandleBehaveEvent;
			break;
		}
		case BehaveType.Follow:
		{
			BehaveControlFollowBehaveEvent behaveControlFollowBehaveEvent = root.gameObject.AddComponent<BehaveControlFollowBehaveEvent>();
			behaveControlFollowBehaveEvent.interactBehaveControl = this;
			behave = behaveControlFollowBehaveEvent;
			break;
		}
		default:
			behave = root.gameObject.AddComponent<BehaveControlBaseBehaveEvent>();
			break;
		}
		ControlEb = GameManager.entities.factory.CreateCommonEntity();
		string entityConfigPath = m_Data.entityConfigPath;
		await MonoECS.instance.SpawnCommon(ControlEb, pos, entityConfigPath, m_Data.isLeft, active);
		m_Root = ControlEb.GetRootTransform();
		Transform transform = base.transform;
		transform.SetParent(m_Root, worldPositionStays: false);
		transform.localPosition = Vector3.zero;
		transform.localScale = Vector3.one;
		transform.localRotation = Quaternion.identity;
		CompStateObject? compStateObject = ControlEb.GetCompStateObject();
		compStateObject.StateObjectBase = this;
		compStateObject.StateWorldAssetData = m_Data;
		behave.Init(stateId);
		RefreshState(m_Data.stateId);
	}

	protected override void HandleChangeState(int fromStateId, int toStateId)
	{
		base.HandleChangeState(fromStateId, toStateId);
	}

	public override void ReleaseStateObject()
	{
		base.ReleaseStateObject();
		MonoECS.instance.TryRemoveBehave(ControlEb);
	}

	private void SetGo(AsyncOperationHandle<GameObject> handle)
	{
	}

	protected override void HandleUninitState(int stateId)
	{
		base.HandleUninitState(stateId);
	}

	protected override bool NeedWaitTransition(int fromStateId, int toStateId)
	{
		return false;
	}

	public override bool CheckStateIdValid(int stateId)
	{
		return true;
	}

	protected override void HandleEnterInteract()
	{
	}

	protected override void HandleExitInteract()
	{
	}

	protected override void HandleInitState(int stateId)
	{
		if (ControlEb.IsValid && ControlEb.IsBehaveAvailable())
		{
			RefreshState(stateId);
		}
	}

	private void RefreshState(int stateId)
	{
		switch (stateId)
		{
		case -1:
			MonoECS.instance.EntityDither(ControlEb, 1f, isShow: false);
			ControlEb.SetActive(value: false);
			ControlEb.GetRoot().SetActive(value: false);
			ControlEb.Teleport(m_Data.initPos);
			break;
		case 0:
			ControlEb.GetCompTime().physicsScale = 0f;
			ControlEb.GetRoot().SetActive(value: true);
			ControlEb.Teleport(m_Data.initPos);
			ControlEb.SetBool("StartPanic", value: false);
			break;
		case 1:
			ControlEb.GetRoot().SetActive(value: true);
			ControlEb.GetCompTime().physicsScale = 1f;
			if (Vector3.Distance(ControlEb.GetCompTransform().physicsPosition, m_Data.initPos) > 1f)
			{
				ControlEb.SetFaceLeft(m_Data.isLeft);
				ControlEb.GetCompPhysics().SetDirImmediately();
				ControlEb.Teleport(m_Data.initPos);
			}
			if (!ControlEb.IsActive())
			{
				MonoECS.instance.EntityDither(ControlEb, 1f, isShow: true);
				ControlEb.SetActive(value: true);
			}
			break;
		default:
			if (!ControlEb.IsActive())
			{
				MonoECS.instance.EntityDither(ControlEb, 1f, isShow: true);
				ControlEb.SetActive(value: true);
			}
			break;
		}
		behave.RefreshRunState(stateId);
	}

	public void ChangeState(int state)
	{
		NetEnterState(state);
	}

	public override void Interact(int entryIndex, Entity eb, InteractAction.InteractSource interactSource)
	{
	}
}
