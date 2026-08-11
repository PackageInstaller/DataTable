using System.Collections.Generic;
using ParadoxNotion.Design;

namespace NodeCanvas.Framework;

[DoNotList]
public class ActionList : ActionTask
{
	public enum ActionsExecutionMode
	{
		ActionsRunInSequence,
		ActionsRunInParallel
	}

	public ActionsExecutionMode executionMode;

	public List<ActionTask> actions = new List<ActionTask>();

	private int currentActionIndex;

	private List<bool> finishedIndeces;

	protected override string info
	{
		get
		{
			if (actions.Count == 0)
			{
				return "No Actions";
			}
			string text = ((actions.Count > 1) ? string.Format("<b>({0})</b>\n", (executionMode == ActionsExecutionMode.ActionsRunInSequence) ? "In Sequence" : "In Parallel") : string.Empty);
			for (int i = 0; i < actions.Count; i++)
			{
				ActionTask actionTask = actions[i];
				if (actionTask != null && actionTask.isUserEnabled)
				{
					string text2 = (actionTask.isPaused ? "<b>||</b> " : (actionTask.isRunning ? "► " : "▪"));
					text = text + text2 + actionTask.summaryInfo + ((i == actions.Count - 1) ? "" : "\n");
				}
			}
			return text;
		}
	}

	public override Task Duplicate(ITaskSystem newOwnerSystem)
	{
		ActionList actionList = (ActionList)base.Duplicate(newOwnerSystem);
		actionList.actions.Clear();
		foreach (ActionTask action in actions)
		{
			actionList.AddAction((ActionTask)action.Duplicate(newOwnerSystem));
		}
		return actionList;
	}

	protected override string OnInit()
	{
		finishedIndeces = new List<bool>();
		return null;
	}

	protected override void OnExecute()
	{
		currentActionIndex = 0;
		if (finishedIndeces != null)
		{
			finishedIndeces.Clear();
		}
		else
		{
			finishedIndeces = new List<bool>();
		}
		for (int i = 0; i < actions.Count; i++)
		{
			finishedIndeces.Add(item: false);
		}
	}

	protected override void OnUpdate()
	{
		if (actions.Count == 0)
		{
			EndAction();
			return;
		}
		switch (executionMode)
		{
		case ActionsExecutionMode.ActionsRunInParallel:
		{
			for (int j = 0; j < actions.Count; j++)
			{
				if (finishedIndeces[j])
				{
					continue;
				}
				if (!actions[j].isUserEnabled)
				{
					finishedIndeces[j] = true;
					continue;
				}
				switch (actions[j].Execute(base.agent, base.blackboard))
				{
				case Status.Failure:
					EndAction(success: false);
					return;
				case Status.Success:
					finishedIndeces[j] = true;
					break;
				}
			}
			bool flag = true;
			for (int k = 0; k < actions.Count; k++)
			{
				flag &= finishedIndeces[k];
			}
			if (flag)
			{
				EndAction(success: true);
			}
			break;
		}
		case ActionsExecutionMode.ActionsRunInSequence:
		{
			for (int i = currentActionIndex; i < actions.Count; i++)
			{
				if (actions[i].isUserEnabled)
				{
					switch (actions[i].Execute(base.agent, base.blackboard))
					{
					case Status.Failure:
						EndAction(success: false);
						return;
					case Status.Running:
						currentActionIndex = i;
						return;
					}
				}
			}
			EndAction(success: true);
			break;
		}
		}
	}

	protected override void OnStop()
	{
		for (int i = 0; i < actions.Count; i++)
		{
			if (actions[i].isUserEnabled)
			{
				actions[i].EndAction(null);
			}
		}
	}

	protected override void OnPause()
	{
		for (int i = 0; i < actions.Count; i++)
		{
			if (actions[i].isUserEnabled)
			{
				actions[i].Pause();
			}
		}
	}

	protected override void CheckIsExecuteOnGraphStop(bool isExecuteStopLogic)
	{
		base.CheckIsExecuteOnGraphStop(isExecuteStopLogic);
		foreach (ActionTask action in actions)
		{
			action.OnGraphStopLogic(isExecuteStopLogic);
		}
	}

	public override void OnDrawGizmosSelected()
	{
		for (int i = 0; i < actions.Count; i++)
		{
			if (actions[i].isUserEnabled)
			{
				actions[i].OnDrawGizmosSelected();
			}
		}
	}

	public void AddAction(ActionTask action)
	{
		if (action is ActionList)
		{
			foreach (ActionTask action2 in (action as ActionList).actions)
			{
				AddAction(action2);
			}
			return;
		}
		actions.Add(action);
		action.SetOwnerSystem(base.ownerSystem);
	}

	internal override string GetWarningOrError()
	{
		for (int i = 0; i < actions.Count; i++)
		{
			string warningOrError = actions[i].GetWarningOrError();
			if (warningOrError != null)
			{
				return warningOrError;
			}
		}
		return null;
	}
}
