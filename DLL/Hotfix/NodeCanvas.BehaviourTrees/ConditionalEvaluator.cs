using NodeCanvas.Framework;
using ParadoxNotion;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.BehaviourTrees;

[Name("Conditional", 0)]
[Category("Decorators")]
[Description("Executes and returns the child status only if the condition is true. Returns Failure if the condition is false.")]
[Icon("Accessor", false, "")]
public class ConditionalEvaluator : BTDecorator, ITaskAssignable<ConditionTask>, ITaskAssignable, IGraphElement
{
	[Name("Dynamic", 0)]
	[Tooltip("If enabled, the condition is re-evaluated per frame and the child is aborted if the condition becomes false.")]
	public bool isDynamic;

	[Tooltip("The status that will be returned if the assigned condition is or becomes false.")]
	public CompactStatus conditionFailReturn;

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
		if (isDynamic)
		{
			if (condition.Check(agent, blackboard))
			{
				return base.decoratedConnection.Execute(agent, blackboard);
			}
			base.decoratedConnection.Reset();
			return (Status)conditionFailReturn;
		}
		if (base.status != Status.Running)
		{
			accessed = condition.Check(agent, blackboard);
		}
		if (!accessed)
		{
			return (Status)conditionFailReturn;
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
