using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.BehaviourTrees;

[Category("Decorators")]
[Description("Interupts decorated child node and returns Failure if the child node is still Running after the timeout period.")]
[Icon("Timeout", false, "")]
public class Timeout : BTDecorator
{
	[Tooltip("The timeout period in seconds.")]
	public BBParameter<float> timeout = 1f;

	protected override Status OnExecute(Component agent, IBlackboard blackboard)
	{
		if (base.decoratedConnection == null)
		{
			return Status.Optional;
		}
		base.status = base.decoratedConnection.Execute(agent, blackboard);
		if (base.status == Status.Running && base.elapsedTime >= timeout.value)
		{
			base.decoratedConnection.Reset();
			return Status.Failure;
		}
		return base.status;
	}
}
