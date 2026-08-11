using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.BehaviourTrees;

[Name("Condition", 0)]
[Description("Checks a condition and returns Success or Failure.")]
[Icon("Condition", false, "")]
public class ConditionNode : BTNode, ITaskAssignable<ConditionTask>, ITaskAssignable, IGraphElement
{
	[SerializeField]
	private ConditionTask _condition;

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

	public override string name => base.name.ToUpper();

	protected override Status OnExecute(Component agent, IBlackboard blackboard)
	{
		if (condition == null)
		{
			return Status.Optional;
		}
		if (base.status == Status.Resting)
		{
			condition.Enable(agent, blackboard);
		}
		if (!condition.Check(agent, blackboard))
		{
			return Status.Failure;
		}
		return Status.Success;
	}

	protected override void OnReset()
	{
		if (condition != null)
		{
			condition.Disable();
		}
	}
}
