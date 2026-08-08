using System.Collections.Generic;
using System.Linq;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.Framework;

[DoNotList]
public class ActionList : ActionTask, ISubTasksContainer
{
	public enum ActionsExecutionMode
	{
		ActionsRunInSequence,
		ActionsRunInParallel
	}

	public ActionsExecutionMode executionMode;

	public List<ActionTask> actions = new List<ActionTask>();

	private List<ActionTask> initialActiveActions;

	private int currentActionIndex;

	private readonly List<int> finishedIndeces = new List<int>();

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
				if (actionTask != null && (actionTask.isActive || (initialActiveActions != null && initialActiveActions.Contains(actionTask))))
				{
					string text2 = (actionTask.isPaused ? "<b>||</b> " : (actionTask.isRunning ? "► " : "▪"));
					text = text + text2 + actionTask.summaryInfo + ((i == actions.Count - 1) ? "" : "\n");
				}
			}
			return text;
		}
	}

	Task[] ISubTasksContainer.GetSubTasks()
	{
		return actions.ToArray();
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
		if (initialActiveActions == null)
		{
			initialActiveActions = actions.Where((ActionTask a) => a.isActive).ToList();
		}
		return null;
	}

	protected override void OnExecute()
	{
		finishedIndeces.Clear();
		currentActionIndex = 0;
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
				if (finishedIndeces.Contains(j))
				{
					continue;
				}
				if (!actions[j].isActive)
				{
					finishedIndeces.Add(j);
					continue;
				}
				switch (actions[j].ExecuteAction(base.agent, base.blackboard))
				{
				case Status.Failure:
					EndAction(success: false);
					return;
				case Status.Success:
					finishedIndeces.Add(j);
					break;
				}
			}
			if (finishedIndeces.Count == actions.Count)
			{
				EndAction(success: true);
			}
			break;
		}
		case ActionsExecutionMode.ActionsRunInSequence:
		{
			for (int i = currentActionIndex; i < actions.Count; i++)
			{
				if (actions[i].isActive)
				{
					switch (actions[i].ExecuteAction(base.agent, base.blackboard))
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
			if (actions[i].isActive)
			{
				actions[i].EndAction(null);
			}
		}
	}

	protected override void OnPause()
	{
		for (int i = 0; i < actions.Count; i++)
		{
			if (actions[i].isActive)
			{
				actions[i].PauseAction();
			}
		}
	}

	public override void OnDrawGizmos()
	{
		for (int i = 0; i < actions.Count; i++)
		{
			if (actions[i].isActive)
			{
				actions[i].OnDrawGizmos();
			}
		}
	}

	public override void OnDrawGizmosSelected()
	{
		for (int i = 0; i < actions.Count; i++)
		{
			if (actions[i].isActive)
			{
				actions[i].OnDrawGizmosSelected();
			}
		}
	}

	public void AddAction(ActionTask action)
	{
		if (action is ActionList)
		{
			Debug.LogWarning("Adding an ActionList within another ActionList is not allowed for clarity");
			return;
		}
		actions.Add(action);
		action.SetOwnerSystem(base.ownerSystem);
	}
}
