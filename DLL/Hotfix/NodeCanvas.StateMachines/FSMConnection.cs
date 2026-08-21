using NodeCanvas.Framework;
using UnityEngine;

namespace NodeCanvas.StateMachines;

public class FSMConnection : Connection, ITaskAssignable<ConditionTask>, ITaskAssignable, IGraphElement
{
	[SerializeField]
	private FSM.TransitionCallMode _transitionCallMode;

	[SerializeField]
	private ConditionTask _condition;

	public new ConditionTask condition
	{
		get
		{
			return _condition;
		}
		set
		{
			_condition = value;
		}
	}

	public Task task
	{
		get
		{
			return condition;
		}
		set
		{
			condition = (ConditionTask)value;
		}
	}

	public FSM.TransitionCallMode transitionCallMode
	{
		get
		{
			return _transitionCallMode;
		}
		private set
		{
			_transitionCallMode = value;
		}
	}

	public void EnableCondition(Component agent, IBlackboard blackboard)
	{
		if (condition != null)
		{
			condition.Enable(agent, blackboard);
		}
	}

	public void DisableCondition()
	{
		if (condition != null)
		{
			condition.Disable();
		}
	}

	public void PerformTransition()
	{
		(base.graph as FSM).EnterState((FSMState)base.targetNode, transitionCallMode);
	}
}
