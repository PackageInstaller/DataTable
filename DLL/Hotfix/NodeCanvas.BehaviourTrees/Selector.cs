using Ase;
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.BehaviourTrees;

[Name("Selector", 9)]
[Category("Composites")]
[Description("Executes its childrfen in order and returns Failure if all children return Failure. As soon as a child returns Success, the Selector will stop and return Success as well.")]
[Icon("Selector", false, "")]
[Color("b3ff7f")]
public class Selector : BTComposite
{
	[Tooltip("If true, then higher priority children are re-evaluated per frame and if either returns Success, then the Selector will immediately stop and return Success as well.")]
	public bool dynamic;

	[Tooltip("If true, the children order of execution is shuffled each time the Selector resets.")]
	public bool random;

	private int lastRunningNodeIndex;

	protected override Status OnExecute(Component agent, IBlackboard blackboard)
	{
		for (int i = ((!dynamic) ? lastRunningNodeIndex : 0); i < base.outConnections.Count; i++)
		{
			base.status = base.outConnections[i].Execute(agent, blackboard);
			switch (base.status)
			{
			case Status.Running:
				if (dynamic && i < lastRunningNodeIndex)
				{
					for (int k = i + 1; k <= lastRunningNodeIndex; k++)
					{
						base.outConnections[k].Reset();
					}
				}
				lastRunningNodeIndex = i;
				return Status.Running;
			case Status.Success:
				if (dynamic && i < lastRunningNodeIndex)
				{
					for (int j = i + 1; j <= lastRunningNodeIndex; j++)
					{
						base.outConnections[j].Reset();
					}
				}
				return Status.Success;
			}
		}
		return Status.Failure;
	}

	protected override void OnReset()
	{
		lastRunningNodeIndex = 0;
		if (random)
		{
			BaseEntity baseEntity = base.graph.parentBlackboard.GetVariable<BaseEntity>("BaseEntity")?.value;
			base.outConnections.Shuffle(baseEntity);
		}
	}

	public override void OnChildDisconnected(int index)
	{
		if (index != 0 && index == lastRunningNodeIndex)
		{
			lastRunningNodeIndex--;
		}
	}

	public override void OnGraphStarted()
	{
		OnReset();
	}
}
