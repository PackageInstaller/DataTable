using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.BehaviourTrees;

[Name("Parallel", 8)]
[Category("Composites")]
[Description("Executes all children simultaneously and return Success or Failure depending on the selected Policy.")]
[Icon("Parallel", false, "")]
[Color("ff64cb")]
public class Parallel : BTComposite
{
	public enum ParallelPolicy
	{
		FirstFailure,
		FirstSuccess,
		FirstSuccessOrFailure
	}

	[Tooltip("The policy determines when the Parallel node will end and return its Status.")]
	public ParallelPolicy policy;

	[Name("Repeat", 0)]
	[Tooltip("If true, finished children are repeated until the Policy set is met, or until all children have had a chance to finish at least once.")]
	public bool dynamic;

	private bool[] finishedConnections;

	private int finishedConnectionsCount;

	public override void OnGraphStarted()
	{
		finishedConnections = new bool[base.outConnections.Count];
		finishedConnectionsCount = 0;
	}

	protected override Status OnExecute(Component agent, IBlackboard blackboard)
	{
		Status status = Status.Resting;
		for (int i = 0; i < base.outConnections.Count; i++)
		{
			Connection connection = base.outConnections[i];
			bool flag = finishedConnections[i];
			if (!dynamic & flag)
			{
				continue;
			}
			if ((connection.status != Status.Running) & flag)
			{
				connection.Reset();
			}
			base.status = connection.Execute(agent, blackboard);
			if (status == Status.Resting)
			{
				if (base.status == Status.Failure && (policy == ParallelPolicy.FirstFailure || policy == ParallelPolicy.FirstSuccessOrFailure))
				{
					status = Status.Failure;
				}
				if (base.status == Status.Success && (policy == ParallelPolicy.FirstSuccess || policy == ParallelPolicy.FirstSuccessOrFailure))
				{
					status = Status.Success;
				}
			}
			if (base.status != Status.Running && !flag)
			{
				finishedConnections[i] = true;
				finishedConnectionsCount++;
			}
		}
		if (status != Status.Resting)
		{
			ResetRunning();
			return status;
		}
		if (finishedConnectionsCount == base.outConnections.Count)
		{
			ResetRunning();
			switch (policy)
			{
			case ParallelPolicy.FirstFailure:
				return Status.Success;
			case ParallelPolicy.FirstSuccess:
				return Status.Failure;
			}
		}
		return Status.Running;
	}

	protected override void OnReset()
	{
		for (int i = 0; i < finishedConnections.Length; i++)
		{
			finishedConnections[i] = false;
		}
		finishedConnectionsCount = 0;
	}

	private void ResetRunning()
	{
		for (int i = 0; i < base.outConnections.Count; i++)
		{
			if (base.outConnections[i].status == Status.Running)
			{
				base.outConnections[i].Reset();
			}
		}
	}
}
