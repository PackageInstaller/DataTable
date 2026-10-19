using System.Collections.Generic;
using UnityEngine;

namespace ACT.Config;

public class GuideStep
{
	public int id;

	[SerializeReference]
	public List<GuideStepCondition> conditions;

	[SerializeReference]
	public List<GuideStepAction> Actions;

	[SerializeReference]
	public List<GuideStepFinishConditionConfig> Finsh;

	private bool actionsTriggered;

	public bool CheckAllConditions()
	{
		if (conditions == null || conditions.Count == 0)
		{
			return true;
		}
		foreach (GuideStepCondition condition in conditions)
		{
			if (condition == null || !condition.CheckCondition())
			{
				return false;
			}
		}
		return true;
	}

	public void ExecuteActions()
	{
		if (actionsTriggered)
		{
			return;
		}
		if (Actions == null || Actions.Count == 0)
		{
			actionsTriggered = true;
			return;
		}
		foreach (GuideStepAction action in Actions)
		{
			_ = action;
		}
		actionsTriggered = true;
	}

	public bool CheckAnyFinishCondition()
	{
		if (Finsh == null || Finsh.Count == 0)
		{
			return false;
		}
		foreach (GuideStepFinishConditionConfig item in Finsh)
		{
			if (item != null)
			{
				return true;
			}
		}
		return false;
	}

	public void Update()
	{
		if (!actionsTriggered && CheckAllConditions())
		{
			ExecuteActions();
		}
	}

	public bool IsFinished()
	{
		return CheckAnyFinishCondition();
	}

	public void Reset()
	{
		actionsTriggered = false;
	}
}
