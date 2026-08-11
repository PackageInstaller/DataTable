using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.BehaviourTrees;

[Category("Decorators")]
[Icon("Eye", false, "")]
[Description("Monitors the decorated child for a returned Status and executes an Action when that is the case.\nThe final Status returned to the parent can either be the original decorated child Status, or the new decorator Action Status.")]
public class Monitor : BTDecorator, ITaskAssignable<ActionTask>, ITaskAssignable, IGraphElement
{
	public enum MonitorMode
	{
		Failure = 0,
		Success = 1,
		AnyStatus = 10
	}

	public enum ReturnStatusMode
	{
		OriginalDecoratedChildStatus,
		NewDecoratorActionStatus
	}

	[Name("Monitor", 0)]
	[Tooltip("The Status to monitor for.")]
	public MonitorMode monitorMode;

	[Name("Return", 0)]
	[Tooltip("The Status to return after (and if) the Action is executed.")]
	public ReturnStatusMode returnMode;

	private Status decoratorActionStatus;

	[SerializeField]
	private ActionTask _action;

	public ActionTask action
	{
		get
		{
			return _action;
		}
		set
		{
			_action = value;
		}
	}

	public Task task
	{
		get
		{
			return action;
		}
		set
		{
			action = (ActionTask)value;
		}
	}

	protected override Status OnExecute(Component agent, IBlackboard blackboard)
	{
		if (base.decoratedConnection == null)
		{
			return Status.Optional;
		}
		Status status = base.decoratedConnection.Execute(agent, blackboard);
		if (action == null)
		{
			return status;
		}
		if (base.status != status && (0u | ((status == Status.Success && monitorMode == MonitorMode.Success) ? 1u : 0u) | ((status == Status.Failure && monitorMode == MonitorMode.Failure) ? 1u : 0u) | ((monitorMode == MonitorMode.AnyStatus && status != Status.Running) ? 1u : 0u)) != 0)
		{
			decoratorActionStatus = action.Execute(agent, blackboard);
			if (decoratorActionStatus == Status.Running)
			{
				return Status.Running;
			}
		}
		if (returnMode != ReturnStatusMode.NewDecoratorActionStatus || decoratorActionStatus == Status.Resting)
		{
			return status;
		}
		return decoratorActionStatus;
	}

	protected override void OnReset()
	{
		if (action != null)
		{
			action.EndAction(null);
			decoratorActionStatus = Status.Resting;
		}
	}
}
