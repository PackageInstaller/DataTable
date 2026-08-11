using Ase;
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.BehaviourTrees;

[Name("Sequencer", 10)]
[Category("Composites")]
[Description("Executes its children in order and returns Success if all children return Success. As soon as a child returns Failure, the Sequencer will stop and return Failure as well.")]
[Icon("Sequencer", false, "")]
[Color("bf7fff")]
public class Sequencer : BTComposite
{
	[Tooltip("If true, then higher priority children are re-evaluated per frame and if either returns Failure, then the Sequencer will immediately stop and return Failure as well.")]
	public bool dynamic;

	[Tooltip("If true, the children order of execution is shuffled each time the Sequencer resets.")]
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
			case Status.Failure:
				if (dynamic && i < lastRunningNodeIndex)
				{
					for (int j = i + 1; j <= lastRunningNodeIndex; j++)
					{
						base.outConnections[j].Reset();
					}
				}
				return Status.Failure;
			}
		}
		return Status.Success;
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
