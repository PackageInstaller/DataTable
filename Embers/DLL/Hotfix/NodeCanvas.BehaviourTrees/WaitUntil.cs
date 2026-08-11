using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.BehaviourTrees;

[Category("Decorators")]
[Description("Returns Running until the assigned condition becomes true, after which the decorated child is executed.")]
[Icon("Halt", false, "")]
public class WaitUntil : BTDecorator, ITaskAssignable<ConditionTask>, ITaskAssignable, IGraphElement
{
	[SerializeField]
	private ConditionTask _condition;

	private bool accessed;

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

	private ConditionTask condition
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

	protected override Status OnExecute(Component agent, IBlackboard blackboard)
	{
		if (base.decoratedConnection == null)
		{
			if (condition != null)
			{
				if (base.status == Status.Resting)
				{
					condition.Enable(agent, blackboard);
				}
				if (!condition.Check(agent, blackboard))
				{
					return Status.Running;
				}
				return Status.Success;
			}
			return Status.Optional;
		}
		if (condition == null)
		{
			return base.decoratedConnection.Execute(agent, blackboard);
		}
		if (base.status == Status.Resting)
		{
			condition.Enable(agent, blackboard);
		}
		if (accessed)
		{
			return base.decoratedConnection.Execute(agent, blackboard);
		}
		if (condition.Check(agent, blackboard))
		{
			accessed = true;
		}
		if (!accessed)
		{
			return Status.Running;
		}
		return base.decoratedConnection.Execute(agent, blackboard);
	}

	protected override void OnReset()
	{
		if (condition != null)
		{
			condition.Disable();
		}
		accessed = false;
	}
}
