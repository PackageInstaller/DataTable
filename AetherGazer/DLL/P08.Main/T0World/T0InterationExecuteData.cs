using System;
using System.Collections.Generic;
using UnityEngine;

namespace T0World;

[Serializable]
public class T0InterationExecuteData : T0InterationLogicBaseData
{
	public T0InterationExecuteEnum executeType = T0InterationExecuteEnum.Random;

	public bool isNeedFrequencyList;

	public List<int> frequencyList;

	private int frequencyLen;

	private bool useFocus;

	public override void StartEvent(T0WorldInteractionBehavior behaviour)
	{
		base.IsFinish = true;
		frequencyLen = 0;
		foreach (int frequency in frequencyList)
		{
			frequencyLen += frequency;
		}
	}

	public override void AddChildEvent()
	{
		switch (executeType)
		{
		case T0InterationExecuteEnum.Random:
			RandomChildEvent();
			break;
		case T0InterationExecuteEnum.Sequence:
			SequenceChildEvent();
			break;
		}
		AddOtherChild();
	}

	public void AddOtherChild()
	{
		for (int i = logicChildCount; i < child.Count; i++)
		{
			T0InterationBaseData t0InterationBaseData = child[i];
			if (t0InterationBaseData != null)
			{
				t0InterationBaseData.InitData();
				T0WorldScene.Scene.agentManager.GetAgent(t0InterationBaseData.entityID).Blackboard.EventContext.AddEvent(t0InterationBaseData);
				if (t0InterationBaseData.isFoces || useFocus)
				{
					T0WorldScene.Scene.interactionManager.InteractContext.RegisterFocusEVent(t0InterationBaseData);
				}
			}
		}
	}

	public void RandomChildEvent()
	{
		if (child == null)
		{
			return;
		}
		int index = UnityEngine.Random.Range(0, logicChildCount);
		T0InterationBaseData t0InterationBaseData = child[index];
		if (t0InterationBaseData != null)
		{
			t0InterationBaseData.InitData();
			T0WorldScene.Scene.agentManager.GetAgent(t0InterationBaseData.entityID).Blackboard.EventContext.AddEvent(t0InterationBaseData);
			if (t0InterationBaseData.isFoces)
			{
				useFocus = true;
				T0WorldScene.Scene.interactionManager.InteractContext.RegisterFocusEVent(t0InterationBaseData);
			}
		}
	}

	public void SequenceChildEvent()
	{
		if (child == null || logicChildCount <= 0)
		{
			return;
		}
		int recordCount = T0WorldScene.Scene.dataContext.GetRecordCount(GetHashCode().ToString());
		int index;
		if (isNeedFrequencyList && frequencyList != null && frequencyList.Count > 0)
		{
			index = 0;
			int num = recordCount % frequencyLen;
			for (int i = 0; i < frequencyList.Count; i++)
			{
				if (num < frequencyList[i])
				{
					index = i;
					break;
				}
				num -= frequencyList[i];
			}
		}
		else
		{
			index = recordCount % logicChildCount;
		}
		T0InterationBaseData t0InterationBaseData = child[index];
		if (t0InterationBaseData != null)
		{
			t0InterationBaseData.InitData();
			T0WorldScene.Scene.agentManager.GetAgent(t0InterationBaseData.entityID).Blackboard.EventContext.AddEvent(t0InterationBaseData);
			if (t0InterationBaseData.isFoces)
			{
				useFocus = true;
				T0WorldScene.Scene.interactionManager.InteractContext.RegisterFocusEVent(t0InterationBaseData);
			}
		}
		T0WorldScene.Scene.dataContext.RecordCount(GetHashCode().ToString());
	}
}
