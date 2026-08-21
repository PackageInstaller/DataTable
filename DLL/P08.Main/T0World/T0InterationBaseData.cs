using System;
using System.Collections.Generic;
using UnityEngine;

namespace T0World;

[Serializable]
public abstract class T0InterationBaseData
{
	[HideInInspector]
	public int treeID;

	[HideInInspector]
	public int nodeID;

	public T0WorldAIControlStateEnum aiState;

	public T0ControlerStateEnum controllerState;

	public T0InterationConditionTypeEnum conditionType = T0InterationConditionTypeEnum.None;

	public int entityID;

	public bool isFoces;

	public bool onlyOne;

	public T0CharacterIkControlerStateEnum ikState;

	public bool isMustFinish;

	public int SDKExtraTypeID = -1;

	public T0WorldConst.SDKInterationTypeEnum SDKType = T0WorldConst.SDKInterationTypeEnum.INTERATION;

	private bool isFinish;

	private bool isInit;

	private bool isDispose;

	[NonSerialized]
	public T0InterationBaseData parent;

	[NonSerialized]
	public List<T0InterationBaseData> child;

	public virtual bool isNeedSDK => false;

	public bool IsFinish
	{
		get
		{
			return isFinish;
		}
		set
		{
			isFinish = value;
		}
	}

	public bool IsInit
	{
		get
		{
			return isInit;
		}
		set
		{
			isInit = value;
		}
	}

	public bool IsDispose
	{
		get
		{
			return isDispose;
		}
		set
		{
			isDispose = value;
		}
	}

	public abstract T0InterationTypeEnum GetStateEnum();

	public virtual void StartEvent(T0WorldInteractionBehavior behaviour)
	{
	}

	public virtual void UpdateEvent(T0WorldInteractionBehavior behaviour)
	{
	}

	public virtual void FinishEvent(T0WorldInteractionBehavior behaviour)
	{
	}

	public virtual void DisposeEvent()
	{
	}

	public void SetTreeNode(T0InterationTreeNode treeNode)
	{
		treeID = treeNode.treeID;
		nodeID = treeNode.nodeID;
		parent = null;
		if (child != null)
		{
			child.Clear();
			child = null;
		}
		if (treeNode.parentNode != null)
		{
			parent = treeNode.parentNode.interationData as T0InterationBaseData;
		}
		if (treeNode.childNodeList == null)
		{
			return;
		}
		child = new List<T0InterationBaseData>();
		for (int i = 0; i < treeNode.childNodeList.Count; i++)
		{
			if (treeNode.childNodeList[i].interationData is T0InterationBaseData item)
			{
				child.Add(item);
			}
		}
	}

	public void InitData()
	{
		isFinish = false;
		isInit = false;
		isDispose = false;
	}

	public void InitEvent(T0InterationTreeNode treeNode)
	{
		InitData();
		SetTreeNode(treeNode);
	}

	public void AddAgentEvent()
	{
		T0WorldAgent agent = T0WorldScene.Scene.agentManager.GetAgent(entityID);
		if (agent != null)
		{
			agent.Blackboard.EventContext.AddEvent(this);
		}
	}

	public void ClearBrotherNode()
	{
		if (parent == null || parent.child == null)
		{
			return;
		}
		for (int i = 0; i < parent.child.Count; i++)
		{
			T0InterationBaseData t0InterationBaseData = parent.child[i];
			if (t0InterationBaseData != this)
			{
				t0InterationBaseData.IsDispose = true;
				t0InterationBaseData.DisposeEvent();
				T0WorldScene.Scene.agentManager.GetAgent(t0InterationBaseData.entityID).Blackboard.EventContext.DisposeTargetEvent(t0InterationBaseData);
			}
		}
	}

	public void OnStart(T0WorldInteractionBehavior behaviour)
	{
		if (onlyOne && T0WorldScene.Scene.dataContext.CheckIsHaveKey(GetHashCode().ToString()))
		{
			return;
		}
		IsInit = true;
		if (controllerState != T0ControlerStateEnum.none)
		{
			T0WorldScene.Scene.mWorldUI.ChangeState(controllerState);
		}
		if ((bool)behaviour && ikState != T0CharacterIkControlerStateEnum.none)
		{
			if (behaviour.mAgent is T0CharacterAgent t0CharacterAgent && t0CharacterAgent.CharacterBoard != null)
			{
				if ((bool)t0CharacterAgent.CharacterBoard.ikBehavior)
				{
					t0CharacterAgent.CharacterBoard.ikBehavior.ChangeIkState(ikState);
				}
			}
			else if (T0WorldScene.Scene.agentManager.CharacteraAgent?.CharacterBoard != null)
			{
				T0WorldScene.Scene.agentManager.CharacteraAgent.CharacterBoard.ikBehavior.ChangeIkState(ikState);
			}
		}
		StartEvent(behaviour);
		if ((bool)behaviour)
		{
			behaviour.ChangeAIState(aiState);
		}
		if (isFoces)
		{
			T0WorldScene.Scene.interactionManager.InteractContext.RegisterFocusEVent(this);
		}
	}

	public void OnUpdate(T0WorldInteractionBehavior behaviour)
	{
		if (IsInit && (T0WorldScene.Scene.interactionManager.InteractContext.CheckIsCanProcess(this) || GetStateEnum() == T0InterationTypeEnum.Hub))
		{
			UpdateEvent(behaviour);
		}
	}

	public T0SDKData GetBaseSDKData()
	{
		return new T0SDKData
		{
			sdkType = (int)SDKType,
			sdkExtraType = SDKExtraTypeID,
			entityID = entityID,
			treeID = treeID,
			nodeID = nodeID
		};
	}

	public virtual void SendSDK(T0WorldInteractionBehavior behaviour)
	{
		T0SDKData baseSDKData = GetBaseSDKData();
		T0SDKSystem.SendSDKData(behaviour, baseSDKData);
	}

	public virtual void OnFinish(T0WorldInteractionBehavior behaviour)
	{
		if (isNeedSDK)
		{
			SendSDK(behaviour);
		}
		IsDispose = true;
		FinishEvent(behaviour);
		T0WorldScene.Scene.interactionManager.InteractContext.ClearFocusEvent();
		ClearBrotherNode();
		T0WorldAgent agent = T0WorldScene.Scene.agentManager.GetAgent(entityID);
		if (agent != null)
		{
			agent.Blackboard.EventContext.DisposeAllEvent();
		}
		if (CheckIsBreak())
		{
			return;
		}
		AddChildEvent();
		if (child == null || child.Count == 0)
		{
			if (agent != null && agent.Blackboard.EventContext.GetWaitEventCount() > 0)
			{
				agent.Blackboard.EventContext.RunWaitEvent();
			}
			else
			{
				if ((bool)behaviour)
				{
					behaviour.ChangeAIState(T0WorldAIControlStateEnum.open);
				}
				if ((bool)T0WorldScene.Scene.mWorldUI)
				{
					T0WorldScene.Scene.mWorldUI.ChangeState(T0ControlerStateEnum.normal);
				}
				T0WorldScene.Scene.agentManager.RefreshFurnitureAgentEvent();
			}
		}
		if (onlyOne)
		{
			T0WorldScene.Scene.dataContext.RecordCount(GetHashCode().ToString());
		}
	}

	public bool CheckIsBreak()
	{
		bool result = false;
		if (child != null)
		{
			foreach (T0InterationBaseData item in child)
			{
				int num = item.entityID;
				T0WorldAgent agent = T0WorldScene.Scene.agentManager.GetAgent(num);
				if (agent == null)
				{
					continue;
				}
				int num2 = agent.Blackboard.EventContext.GetTreeID();
				int num3 = item.treeID;
				if (num2 <= 0 || num2 == num3)
				{
					continue;
				}
				bool flag = false;
				foreach (T0InterationBaseData interationEvent in agent.Blackboard.EventContext.interationEventList)
				{
					if (interationEvent.GetStateEnum() == T0InterationTypeEnum.Break)
					{
						interationEvent.IsFinish = true;
						flag = true;
						break;
					}
				}
				if (!flag)
				{
					return false;
				}
				agent.Blackboard.EventContext.AddWaitEvent(item);
				result = true;
			}
		}
		return result;
	}

	private bool CheckEntityIsRunningOtherTree(T0InterationBaseData childEvent)
	{
		T0WorldAgent agent = T0WorldScene.Scene.agentManager.GetAgent(childEvent.entityID);
		if (agent == null)
		{
			return false;
		}
		int num = agent.Blackboard.EventContext.GetTreeID();
		int num2 = childEvent.treeID;
		if (num > 0 && num != num2)
		{
			return agent.Blackboard.EventContext.CheckIsHaveMustFinishEvent();
		}
		return false;
	}

	public virtual void AddChildEvent()
	{
		if (child == null)
		{
			return;
		}
		foreach (T0InterationBaseData item in child)
		{
			if (CheckEntityIsRunningOtherTree(item))
			{
				T0WorldScene.Scene.agentManager.GetAgent(item.entityID).Blackboard.EventContext.AddWaitEvent(item);
				continue;
			}
			item.InitData();
			T0WorldAgent agent = T0WorldScene.Scene.agentManager.GetAgent(item.entityID);
			if (agent == null)
			{
				item.OnStart(null);
				item.OnFinish(null);
				break;
			}
			agent.Blackboard.EventContext.AddEvent(item);
			if (item.parent == null)
			{
				item.parent = this;
			}
			if (item.isFoces)
			{
				T0WorldScene.Scene.interactionManager.InteractContext.RegisterFocusEVent(item);
			}
		}
	}
}
