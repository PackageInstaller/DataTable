using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.BehaviourTrees;

[Name("Optional", 0)]
[Category("Decorators")]
[Description("Executes the decorated child as normal and returns an Optional status, thus making it optional to the parent node in regards to what status is returned.\nThis has the same effect as disabling the node, but instead it executes normaly.")]
[Icon("UpwardsArrow", false, "")]
public class Optional : BTDecorator
{
	protected override Status OnExecute(Component agent, IBlackboard blackboard)
	{
		if (base.decoratedConnection == null)
		{
			return Status.Optional;
		}
		if (base.status == Status.Resting)
		{
			base.decoratedConnection.Reset();
		}
		base.status = base.decoratedConnection.Execute(agent, blackboard);
		if (base.status != Status.Running)
		{
			return Status.Optional;
		}
		return Status.Running;
	}
}
