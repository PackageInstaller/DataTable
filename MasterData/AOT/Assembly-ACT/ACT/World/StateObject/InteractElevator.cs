using System;
using System.Collections.Generic;
using ACT.Battle;
using ACT.World.Actions;
using ACT.World.Asset;
using ACT.World.Behave;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.World.StateObject;

[AddComponentMenu("ACT/StateObject/InteractElevator")]
public class InteractElevator : StateObjectBase
{
	public bool elevatorGroup;

	public ElevatorBehaveEvents elevator;

	public ElevatorBehaveEvents[] elevators;

	[NonSerialized]
	public bool auto;

	private ElevatorData m_Data;

	private List<ElevatorInfo> stopInfos;

	[NonSerialized]
	public PushImpetusData pushImpetusConfig;

	public bool obstacle;

	private bool m_Init;

	public override bool serviceSave => true;

	public override void InitStateObject(int stateId)
	{
		m_Init = true;
		if (!(entity.GetCompStateObject()?.StateWorldAssetData is ElevatorData data))
		{
			return;
		}
		m_Data = data;
		stopInfos = m_Data.stopInfos;
		auto = m_Data.auto;
		PushImpetusGameObject componentInChildren = GetComponentInChildren<PushImpetusGameObject>();
		if (componentInChildren != null)
		{
			componentInChildren.InitConfig(m_Data.pushImpetusConfig);
		}
		if (auto)
		{
			if (elevatorGroup)
			{
				for (int i = 0; i < elevators.Length; i++)
				{
					if (i >= stopInfos.Count)
					{
						elevators[i].gameObject.SetActive(value: false);
					}
					else
					{
						elevators[i].OnInit(i);
					}
				}
			}
			else
			{
				elevator.OnInit(m_Data.elevatorInitialStopId);
			}
		}
		else
		{
			elevator.OnInit(stateId);
		}
		base.InitStateObject(stateId);
	}

	protected override void HandleInitState(int stateId)
	{
		if (auto)
		{
			if (elevatorGroup)
			{
				for (int i = 0; i < elevators.Length; i++)
				{
					if (i < stopInfos.Count)
					{
						elevators[i].HandleEnterState(currentStateId);
					}
				}
			}
			else
			{
				elevator.HandleEnterState(currentStateId);
			}
		}
		else
		{
			elevator.aimIndex = currentStateId;
		}
		if (m_Data.LinkagesObjects == null)
		{
			m_Init = false;
			return;
		}
		HandleLinkObject();
		m_Init = false;
	}

	private void HandleLinkObject()
	{
		RuleManager ruleManager = MonoECS.instance.ruleManager;
		bool flag = (elevatorGroup ? elevators[0].stop : elevator.stop);
		foreach (LinkagesObjects linkagesObject in m_Data.LinkagesObjects)
		{
			if (m_Init && !linkagesObject.initSet)
			{
				continue;
			}
			int num = ruleManager.SharedGetState(linkagesObject.Object);
			if (linkagesObject.excludeState)
			{
				int[] excludeStateId = linkagesObject.excludeStateId;
				foreach (int num2 in excludeStateId)
				{
				}
			}
			if (m_Init && linkagesObject.finishInform && ((auto & flag) || !auto))
			{
				if (num != linkagesObject.setEndState)
				{
					ruleManager.SharedChangeState(linkagesObject.Object, linkagesObject.setEndState);
				}
			}
			else if (linkagesObject.startInform)
			{
				if (num != linkagesObject.setStartState)
				{
					ruleManager.SharedChangeState(linkagesObject.Object, linkagesObject.setStartState);
				}
			}
			else
			{
				if (!auto)
				{
					continue;
				}
				if (flag)
				{
					if (num != 1)
					{
						ruleManager.SharedChangeState(linkagesObject.Object, 1);
					}
				}
				else if (num != 0)
				{
					ruleManager.SharedChangeState(linkagesObject.Object, 0);
				}
			}
		}
	}

	protected override void HandleUninitState(int stateId)
	{
		base.HandleUninitState(stateId);
	}

	protected override void HandleEnterInteract()
	{
	}

	protected override void HandleExitInteract()
	{
	}

	public override void Interact(int entryIndex, Entity eb, InteractAction.InteractSource interactSource)
	{
	}

	protected override bool NeedWaitTransition(int fromStateId, int toStateId)
	{
		if (auto)
		{
			return false;
		}
		return true;
	}

	public override bool CheckStateIdValid(int stateId)
	{
		if (!auto)
		{
			if (0 <= stateId)
			{
				return stateId < stopInfos.Count;
			}
			return false;
		}
		if (0 <= stateId)
		{
			return stateId <= 5;
		}
		return false;
	}

	public void TaskFinishCallBack()
	{
		RuleManager ruleManager = MonoECS.instance.ruleManager;
		foreach (LinkagesObjects linkagesObject in m_Data.LinkagesObjects)
		{
			if (StateWorldAsset.TryGetWorldAssetBySwid(linkagesObject.Object.value, out var stateWorldAsset) && stateWorldAsset.stateObjectBase.IsWaitTransition())
			{
				stateWorldAsset.stateObjectBase.CompleteTransitionClear();
			}
			int num = ruleManager.SharedGetState(linkagesObject.Object);
			if (linkagesObject.finishInform && num != linkagesObject.setEndState)
			{
				ruleManager.SharedChangeState(linkagesObject.Object, linkagesObject.setEndState);
			}
		}
	}
}
