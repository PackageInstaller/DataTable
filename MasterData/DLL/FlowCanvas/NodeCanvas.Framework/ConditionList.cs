using System.Collections.Generic;
using System.Linq;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.Framework;

[DoNotList]
public class ConditionList : ConditionTask, ISubTasksContainer
{
	public enum ConditionsCheckMode
	{
		AllTrueRequired,
		AnyTrueSuffice
	}

	public ConditionsCheckMode checkMode;

	public List<ConditionTask> conditions = new List<ConditionTask>();

	private List<ConditionTask> initialActiveConditions;

	private bool allTrueRequired => checkMode == ConditionsCheckMode.AllTrueRequired;

	protected override string info
	{
		get
		{
			if (conditions.Count == 0)
			{
				return "No Conditions";
			}
			string text = ((conditions.Count > 1) ? ("<b>(" + (allTrueRequired ? "ALL True" : "ANY True") + ")</b>\n") : string.Empty);
			for (int i = 0; i < conditions.Count; i++)
			{
				if (conditions[i] != null && (conditions[i].isActive || (initialActiveConditions != null && initialActiveConditions.Contains(conditions[i]))))
				{
					string text2 = "▪";
					text = text + text2 + conditions[i].summaryInfo + ((i == conditions.Count - 1) ? "" : "\n");
				}
			}
			return text;
		}
	}

	Task[] ISubTasksContainer.GetSubTasks()
	{
		return conditions.ToArray();
	}

	public override Task Duplicate(ITaskSystem newOwnerSystem)
	{
		ConditionList conditionList = (ConditionList)base.Duplicate(newOwnerSystem);
		conditionList.conditions.Clear();
		foreach (ConditionTask condition in conditions)
		{
			conditionList.AddCondition((ConditionTask)condition.Duplicate(newOwnerSystem));
		}
		return conditionList;
	}

	protected override string OnInit()
	{
		if (initialActiveConditions == null)
		{
			initialActiveConditions = conditions.Where((ConditionTask c) => c.isActive).ToList();
		}
		return null;
	}

	protected override void OnEnable()
	{
		for (int i = 0; i < initialActiveConditions.Count; i++)
		{
			initialActiveConditions[i].Enable(base.agent, base.blackboard);
		}
	}

	protected override void OnDisable()
	{
		for (int i = 0; i < initialActiveConditions.Count; i++)
		{
			initialActiveConditions[i].Disable();
		}
	}

	protected override bool OnCheck()
	{
		int num = 0;
		for (int i = 0; i < conditions.Count; i++)
		{
			if (!conditions[i].isActive)
			{
				num++;
			}
			else if (conditions[i].CheckCondition(base.agent, base.blackboard))
			{
				if (!allTrueRequired)
				{
					return true;
				}
				num++;
			}
			else if (allTrueRequired)
			{
				return false;
			}
		}
		return num == conditions.Count;
	}

	public override void OnDrawGizmos()
	{
		for (int i = 0; i < conditions.Count; i++)
		{
			if (conditions[i].isActive)
			{
				conditions[i].OnDrawGizmos();
			}
		}
	}

	public override void OnDrawGizmosSelected()
	{
		for (int i = 0; i < conditions.Count; i++)
		{
			if (conditions[i].isActive)
			{
				conditions[i].OnDrawGizmosSelected();
			}
		}
	}

	public void AddCondition(ConditionTask condition)
	{
		if (condition is ConditionList)
		{
			Debug.LogWarning("Adding a ConditionList within another ConditionList is not allowed for clarity");
			return;
		}
		conditions.Add(condition);
		condition.SetOwnerSystem(base.ownerSystem);
	}
}
