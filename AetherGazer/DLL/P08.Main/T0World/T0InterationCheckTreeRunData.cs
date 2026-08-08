using System;
using UnityEngine;

namespace T0World;

[Serializable]
public class T0InterationCheckTreeRunData : T0InterationConditionBaseData
{
	public int checkTreeID;

	public int checkEntityID;

	private T0WorldBlackboard blackboard;

	public bool op;

	public override void UpdateEvent(T0WorldInteractionBehavior behaviour)
	{
		if (blackboard == null)
		{
			Transform trsByEntityID = T0WorldHelper.GetTrsByEntityID(checkEntityID);
			blackboard = trsByEntityID.GetComponent<T0WorldBlackboard>();
		}
		bool flag = false;
		foreach (T0InterationBaseData interationEvent in blackboard.EventContext.interationEventList)
		{
			if (interationEvent.treeID == checkTreeID)
			{
				flag = true;
				break;
			}
		}
		if (flag == op)
		{
			base.IsFinish = true;
		}
	}

	public override bool CheckIsArriveCondition()
	{
		return false;
	}
}
