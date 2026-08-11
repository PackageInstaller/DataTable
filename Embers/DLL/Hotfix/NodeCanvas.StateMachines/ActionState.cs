using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.StateMachines;

[Name("Action State", 100)]
[Description("Execute a number of Action Tasks OnEnter. All actions will be stoped OnExit. This state is Finished when all Actions are finished as well")]
public class ActionState : FSMState, ITaskAssignable, IGraphElement
{
	[SerializeField]
	private ActionList _actionList;

	[SerializeField]
	private bool _repeatStateActions;

	public Task task
	{
		get
		{
			return actionList;
		}
		set
		{
			actionList = (ActionList)value;
		}
	}

	public ActionList actionList
	{
		get
		{
			return _actionList;
		}
		set
		{
			_actionList = value;
		}
	}

	public bool repeatStateActions
	{
		get
		{
			return _repeatStateActions;
		}
		set
		{
			_repeatStateActions = value;
		}
	}

	public override void OnValidate(Graph assignedGraph)
	{
		if (actionList == null)
		{
			actionList = (ActionList)Task.Create(typeof(ActionList), assignedGraph);
			actionList.executionMode = ActionList.ActionsExecutionMode.ActionsRunInParallel;
		}
	}

	protected override void OnEnter()
	{
		OnUpdate();
	}

	protected override void OnUpdate()
	{
		Status status = actionList.Execute(base.graphAgent, base.graphBlackboard);
		if (!repeatStateActions && status != Status.Running)
		{
			Finish(status);
		}
	}

	protected override void OnExit()
	{
		actionList.EndAction(null);
	}

	protected override void OnPause()
	{
		actionList.Pause();
	}
}
