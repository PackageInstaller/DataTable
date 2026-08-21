using System.Collections.Generic;
using ParadoxNotion.Design;

namespace NodeCanvas.Framework;

[DoNotList]
public class ConditionList : ConditionTask
{
	public enum ConditionsCheckMode
	{
		AllTrueRequired,
		AnyTrueSuffice
	}

	public ConditionsCheckMode checkMode;

	public List<ConditionTask> conditions = new List<ConditionTask>();

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
				if (conditions[i] != null && conditions[i].isUserEnabled)
				{
					string text2 = "▪";
					text = text + text2 + conditions[i].summaryInfo + ((i == conditions.Count - 1) ? "" : "\n");
				}
			}
			return text;
		}
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

	protected override void OnEnable()
	{
	}

	protected override string OnInit()
	{
		return null;
	}

	protected override void OnDisable()
	{
		for (int i = 0; i < conditions.Count; i++)
		{
			conditions[i].Disable();
		}
	}

	protected override bool OnCheck()
	{
		int num = 0;
		for (int i = 0; i < conditions.Count; i++)
		{
			if (!conditions[i].isUserEnabled)
			{
				num++;
				continue;
			}
			conditions[i].Enable(base.agent, base.blackboard);
			if (conditions[i].Check(base.agent, base.blackboard))
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

	public override void OnDrawGizmosSelected()
	{
		for (int i = 0; i < conditions.Count; i++)
		{
			if (conditions[i].isUserEnabled)
			{
				conditions[i].OnDrawGizmosSelected();
			}
		}
	}

	public void AddCondition(ConditionTask condition)
	{
		if (condition is ConditionList)
		{
			foreach (ConditionTask condition2 in (condition as ConditionList).conditions)
			{
				AddCondition(condition2);
			}
			return;
		}
		conditions.Add(condition);
		condition.SetOwnerSystem(base.ownerSystem);
	}

	internal override string GetWarningOrError()
	{
		for (int i = 0; i < conditions.Count; i++)
		{
			string warningOrError = conditions[i].GetWarningOrError();
			if (warningOrError != null)
			{
				return warningOrError;
			}
		}
		return null;
	}
}
