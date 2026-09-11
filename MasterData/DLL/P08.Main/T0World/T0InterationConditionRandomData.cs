using System;
using UnityEngine;

namespace T0World;

[Serializable]
public class T0InterationConditionRandomData : T0InterationConditionBaseData
{
	public bool todayFirstNoUse;

	public int randomValue;

	private bool isRandomResult;

	private bool randomResult;

	public override void StartEvent(T0WorldInteractionBehavior behaviour)
	{
		isRandomResult = false;
	}

	public override bool CheckIsArriveCondition()
	{
		if (todayFirstNoUse && T0WorldScene.Scene.todayFirstEnter)
		{
			return false;
		}
		if (isEnterTree)
		{
			return GetRandomValue();
		}
		if (isRandomResult)
		{
			return randomResult;
		}
		isRandomResult = true;
		return GetRandomValue();
	}

	public bool GetRandomValue()
	{
		if (UnityEngine.Random.Range(1, 1000) < randomValue)
		{
			randomResult = true;
		}
		else
		{
			randomResult = false;
		}
		return randomResult;
	}
}
