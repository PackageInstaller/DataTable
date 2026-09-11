using System.Collections.Generic;
using UnityEngine;

namespace T0World;

[DisallowMultipleComponent]
public class T0WorldAgent : MonoBehaviour, IT0WorldAgent
{
	protected IT0WorldBlackboard _blackboard;

	protected IT0WorldBehavior[] _behaviors;

	public bool IsInit { get; set; }

	public T0WorldBlackboard Blackboard => _blackboard as T0WorldBlackboard;

	public virtual T0AgentLayer GetAgentLayer()
	{
		return T0AgentLayer.Thing;
	}

	public void TriggerInteraction(T0InterationTreeType interationType = T0InterationTreeType.IDLE)
	{
		if (_blackboard == null || !Blackboard.interationList.ContainsKey(interationType))
		{
			return;
		}
		List<T0InterationTreeData> list = Blackboard.interationList[interationType];
		if (list.Count > 0)
		{
			int index = Random.Range(0, list.Count);
			T0InterationTreeData t0InterationTreeData = list[index];
			if (t0InterationTreeData != null)
			{
				T0WorldScene.Scene.interactionManager.RegisterEvent(t0InterationTreeData);
			}
		}
	}

	public void EnterInterationState(T0InterationTreeType interationType = T0InterationTreeType.IDLE)
	{
		if (_blackboard == null || Blackboard.interationList == null || !Blackboard.interationList.ContainsKey(interationType))
		{
			return;
		}
		List<T0InterationTreeData> list = Blackboard.interationList[interationType];
		bool flag = false;
		foreach (T0InterationTreeData item in list)
		{
			if (item != null && item.beginTreeNodeIndex > 0 && item.treeNodeList[item.beginTreeNodeIndex - 1].interationData is T0InterationBaseData t0InterationBaseData && t0InterationBaseData.GetStateEnum() == T0InterationTypeEnum.Condition)
			{
				T0InterationConditionBaseData t0InterationConditionBaseData = t0InterationBaseData as T0InterationConditionBaseData;
				if (t0InterationConditionBaseData.isEnterTree && t0InterationConditionBaseData.CheckIsArriveCondition())
				{
					T0WorldScene.Scene.interactionManager.RegisterEvent(item);
					flag = true;
					break;
				}
			}
		}
		if (flag)
		{
			return;
		}
		foreach (T0InterationTreeData item2 in list)
		{
			if (item2 != null && item2.beginTreeNodeIndex > 0 && item2.treeNodeList[item2.beginTreeNodeIndex - 1].interationData is T0InterationBaseData t0InterationBaseData2 && t0InterationBaseData2.GetStateEnum() != T0InterationTypeEnum.Condition)
			{
				T0WorldScene.Scene.interactionManager.RegisterEvent(item2);
			}
		}
	}

	public void TriggerTargetInteraction(int interactionTreeID)
	{
		if (_blackboard == null || Blackboard.interationList.Count <= 0)
		{
			return;
		}
		foreach (List<T0InterationTreeData> value in Blackboard.interationList.Values)
		{
			foreach (T0InterationTreeData item in value)
			{
				if (item.treeID == interactionTreeID)
				{
					T0WorldScene.Scene.interactionManager.RegisterEvent(item);
					break;
				}
			}
		}
	}

	public void SetPosAndRot(Vector3 pos, Vector3 rot)
	{
		base.transform.position = pos;
		base.transform.rotation = Quaternion.Euler(rot);
	}

	public virtual void Initialize()
	{
		if (IsInit)
		{
			return;
		}
		if (_behaviors == null)
		{
			_behaviors = GetComponents<IT0WorldBehavior>();
		}
		if (_blackboard == null)
		{
			_blackboard = GetComponent<IT0WorldBlackboard>();
			_blackboard.InitBlackboard();
		}
		if (_behaviors != null)
		{
			for (int i = 0; i < _behaviors.Length; i++)
			{
				_behaviors[i].Initialize();
			}
		}
		IsInit = true;
		T0WorldScene.Scene.agentManager.Register(this);
	}

	public virtual void FixedUpdateAgent()
	{
		if (_behaviors == null)
		{
			return;
		}
		int num = _behaviors.Length;
		if (IsInit)
		{
			for (int i = 0; i < num; i++)
			{
				_behaviors[i].FixedUpdateBehavior();
			}
		}
	}

	public virtual void UpdateAgent()
	{
		if (_behaviors == null)
		{
			return;
		}
		int num = _behaviors.Length;
		if (IsInit)
		{
			for (int i = 0; i < num; i++)
			{
				_behaviors[i].UpdateBehavior();
			}
		}
	}

	public virtual void LateUpdateAgent()
	{
		if (_behaviors == null)
		{
			return;
		}
		int num = _behaviors.Length;
		if (IsInit)
		{
			for (int i = 0; i < num; i++)
			{
				_behaviors[i].LateUpdateBehavior();
			}
		}
	}

	public virtual void DisposeAgent()
	{
		if (_behaviors != null)
		{
			for (int i = 0; i < _behaviors.Length; i++)
			{
				_behaviors[i].DestroyBehavior();
			}
			_behaviors = null;
		}
		IsInit = false;
		T0WorldScene.Scene.agentManager.UnRegister(this);
		Object.Destroy(base.gameObject);
	}

	internal void OnLowMemory()
	{
		for (int i = 0; i < _behaviors.Length; i++)
		{
			_behaviors[i].OnLowMemory();
		}
	}
}
