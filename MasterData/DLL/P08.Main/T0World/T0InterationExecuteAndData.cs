using System;
using System.Collections.Generic;
using UnityEngine;

namespace T0World;

[Serializable]
public class T0InterationExecuteAndData : T0InterationLogicBaseData
{
	public List<int> checkIDList;

	[HideInInspector]
	private List<T0InterationConditionBaseData> checkDataList;

	public override void StartEvent(T0WorldInteractionBehavior behaviour)
	{
		if (checkDataList == null)
		{
			checkDataList = new List<T0InterationConditionBaseData>();
		}
		foreach (List<T0InterationTreeData> value in behaviour.mAgent.Blackboard.interationList.Values)
		{
			foreach (T0InterationTreeData item2 in value)
			{
				if (item2.treeID != treeID)
				{
					continue;
				}
				foreach (int checkID in checkIDList)
				{
					if (item2.treeNodeList[checkID - 1].interationData is T0InterationConditionBaseData item)
					{
						checkDataList.Add(item);
					}
				}
			}
		}
	}

	public override void UpdateEvent(T0WorldInteractionBehavior behaviour)
	{
		bool flag = true;
		foreach (T0InterationConditionBaseData checkData in checkDataList)
		{
			flag = checkData.CheckIsArriveCondition();
			if (!flag)
			{
				break;
			}
		}
		if (flag)
		{
			base.IsFinish = true;
		}
	}

	public override void DisposeEvent()
	{
		checkDataList.Clear();
	}
}
