using NodeCanvas.Framework;
using ParadoxNotion;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.BehaviourTrees;

[Category("Composites")]
[Description("Quick way to execute the left or the right child, based on a Condition Task.")]
[Icon("Condition", false, "")]
[Color("b3ff7f")]
public class BinarySelector : BTNode, ITaskAssignable<ConditionTask>, ITaskAssignable, IGraphElement
{
	[Tooltip("If true, the condition will be re-evaluated per frame.")]
	public bool dynamic;

	[SerializeField]
	private ConditionTask _condition;

	private int succeedIndex;

	public override int maxOutConnections => 2;

	public override Alignment2x2 commentsAlignment => Alignment2x2.Right;

	public override string name => base.name.ToUpper();

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
		if (condition == null || base.outConnections.Count < 2)
		{
			return Status.Optional;
		}
		if (base.status == Status.Resting)
		{
			condition.Enable(agent, blackboard);
		}
		if (dynamic || base.status == Status.Resting)
		{
			int num = succeedIndex;
			succeedIndex = ((!condition.Check(agent, blackboard)) ? 1 : 0);
			if (succeedIndex != num)
			{
				base.outConnections[num].Reset();
			}
		}
		return base.outConnections[succeedIndex].Execute(agent, blackboard);
	}

	protected override void OnReset()
	{
		if (condition != null)
		{
			condition.Disable();
		}
	}
}
