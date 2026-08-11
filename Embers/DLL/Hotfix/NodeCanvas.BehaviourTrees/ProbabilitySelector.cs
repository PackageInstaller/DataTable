using System.Collections.Generic;
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.BehaviourTrees;

[Category("Composites")]
[Description("Select a child to execute based on it's chance to be selected and return Success if it returns Success, otherwise pick another.\nReturns Failure if no child returns Success or a direct 'Failure Chance' is introduced")]
[Icon("ProbabilitySelector", false, "")]
[Color("b3ff7f")]
public class ProbabilitySelector : BTComposite
{
	[AutoSortWithChildrenConnections]
	public List<BBParameter<float>> childWeights;

	public BBParameter<float> failChance;

	private bool[] indexFailed;

	private float tmpDice;

	private float tmpFailWeight;

	private float tmpTotal;

	private float[] tmpWeights;

	public override void OnChildConnected(int index)
	{
		if (childWeights == null)
		{
			childWeights = new List<BBParameter<float>>();
		}
		if (childWeights.Count < base.outConnections.Count)
		{
			childWeights.Insert(index, new BBParameter<float>
			{
				value = 1f,
				bb = base.graphBlackboard
			});
		}
	}

	public override void OnChildDisconnected(int index)
	{
		childWeights.RemoveAt(index);
	}

	public override void OnGraphStarted()
	{
		OnReset();
	}

	protected override Status OnExecute(Component agent, IBlackboard blackboard)
	{
		if (childWeights.Count != base.outConnections.Count)
		{
			return Status.Failure;
		}
		if (base.status == Status.Resting)
		{
			BaseEntity value = blackboard.GetVariable<BaseEntity>("BaseEntity").value;
			if (value == null)
			{
				return Status.Failure;
			}
			tmpDice = value.RandomFloat(0f, 1f);
			tmpFailWeight = failChance.value;
			tmpTotal = tmpFailWeight;
			for (int i = 0; i < childWeights.Count; i++)
			{
				float value2 = childWeights[i].value;
				tmpTotal += value2;
				tmpWeights[i] = value2;
			}
		}
		float num = tmpFailWeight / tmpTotal;
		if (tmpDice < num)
		{
			return Status.Failure;
		}
		for (int j = 0; j < base.outConnections.Count; j++)
		{
			if (indexFailed[j] || tmpWeights[j] == 0f)
			{
				continue;
			}
			num += tmpWeights[j] / tmpTotal;
			if (tmpDice <= num)
			{
				base.status = base.outConnections[j].Execute(agent, blackboard);
				if (base.status == Status.Success || base.status == Status.Running)
				{
					return base.status;
				}
				if (base.status == Status.Failure)
				{
					indexFailed[j] = true;
					tmpTotal -= tmpWeights[j];
					return Status.Running;
				}
			}
		}
		return Status.Failure;
	}

	protected override void OnReset()
	{
		tmpWeights = new float[childWeights.Count];
		indexFailed = new bool[base.outConnections.Count];
	}
}
