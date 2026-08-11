using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.BehaviourTrees;

[Name("KiifRepeat", 0)]
[Category("Decorators")]
[Description("一帧执行完循环节点")]
[Icon("Repeat", false, "")]
public class KiifRepeater : BTDecorator
{
	public BBParameter<int> repeatTimes = 1;

	private int currentIteration = 1;

	protected override Status OnExecute(Component agent, IBlackboard blackboard)
	{
		if (base.decoratedConnection == null)
		{
			return Status.Optional;
		}
		for (int i = 0; i < repeatTimes.value; i++)
		{
			base.status = base.decoratedConnection.Execute(agent, blackboard);
			currentIteration++;
			if (base.decoratedConnection.status == Status.Success || base.decoratedConnection.status == Status.Failure)
			{
				base.decoratedConnection.Reset();
			}
		}
		if (currentIteration >= repeatTimes.value)
		{
			return base.status;
		}
		return Status.Running;
	}

	protected override void OnReset()
	{
		currentIteration = 1;
	}
}
