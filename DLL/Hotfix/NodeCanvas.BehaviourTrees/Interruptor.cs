using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.BehaviourTrees;

[Name("Interrupt", 0)]
[Category("Decorators")]
[Description("Executes and returns the child status. If the condition is or becomes true, the child is interrupted and returns Failure.")]
[Icon("Interruptor", false, "")]
public class Interruptor : BTDecorator, ITaskAssignable<ConditionTask>, ITaskAssignable, IGraphElement
{
	[SerializeField]
	private ConditionTask _condition;

	public ConditionTask condition
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

	protected override Status OnExecute(Component agent, IBlackboard blackboard)
	{
		if (base.decoratedConnection == null)
		{
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
		if (!condition.Check(agent, blackboard))
		{
			return base.decoratedConnection.Execute(agent, blackboard);
		}
		if (base.decoratedConnection.status == Status.Running)
		{
			base.decoratedConnection.Reset();
		}
		return Status.Failure;
	}

	protected override void OnReset()
	{
		if (condition != null)
		{
			condition.Disable();
		}
	}
}
