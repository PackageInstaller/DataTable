using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.BehaviourTrees;

[Name("Action", 0)]
[Description("Executes an action and returns Success or Failure when the action is finished.\nReturns Running until the action is finished.")]
[Icon("Action", false, "")]
public class ActionNode : BTNode, ITaskAssignable<ActionTask>, ITaskAssignable, IGraphElement
{
	[SerializeField]
	private ActionTask _action;

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

	public override string name => base.name.ToUpper();

	protected override Status OnExecute(Component agent, IBlackboard blackboard)
	{
		if (action == null)
		{
			return Status.Optional;
		}
		if (base.status == Status.Resting || base.status == Status.Running)
		{
			return action.Execute(agent, blackboard);
		}
		return base.status;
	}

	protected override void OnReset()
	{
		action?.EndAction(null);
	}
}
