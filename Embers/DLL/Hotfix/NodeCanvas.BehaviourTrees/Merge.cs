using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.BehaviourTrees;

[Name("Merge", -1)]
[Description("Merge can accept multiple input connections and thus possible to re-use leaf nodes from multiple parents. Please note that this is experimental and can result in unexpected behaviour.")]
[Category("Decorators")]
public class Merge : BTDecorator
{
	public override int maxInConnections => -1;

	protected override Status OnExecute(Component agent, IBlackboard blackboard)
	{
		if (base.status != Status.Running)
		{
			base.decoratedConnection.Reset();
		}
		return base.decoratedConnection.Execute(agent, blackboard);
	}
}
