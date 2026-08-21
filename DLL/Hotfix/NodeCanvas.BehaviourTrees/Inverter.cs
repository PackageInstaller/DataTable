using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.BehaviourTrees;

[Name("Invert", 0)]
[Category("Decorators")]
[Description("Inverts Success to Failure and Failure to Success.")]
[Icon("Remap", false, "")]
public class Inverter : BTDecorator
{
	protected override Status OnExecute(Component agent, IBlackboard blackboard)
	{
		if (base.decoratedConnection == null)
		{
			return Status.Optional;
		}
		base.status = base.decoratedConnection.Execute(agent, blackboard);
		return base.status switch
		{
			Status.Success => Status.Failure, 
			Status.Failure => Status.Success, 
			_ => base.status, 
		};
	}
}
