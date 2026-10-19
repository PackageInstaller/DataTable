using System.Collections.Generic;
using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;
using UnityEngine;

namespace ACT.Battle;

public class RandomListSelector : Composite
{
	public List<SharedFloat> probabilities;

	private TaskStatus executionStatus;

	private int index;

	public override int CurrentChildIndex()
	{
		return index;
	}

	public override void OnStart()
	{
		base.OnStart();
		float num = 0f;
		foreach (SharedFloat probability in probabilities)
		{
			num += probability.Value;
		}
		float num2 = Random.Range(0f, num);
		float num3 = 0f;
		for (int i = 0; i < probabilities.Count; i++)
		{
			num3 += probabilities[i].Value;
			if (num2 <= num3)
			{
				index = i;
				break;
			}
		}
		executionStatus = TaskStatus.Running;
	}

	public override bool CanExecute()
	{
		if (index < children.Count)
		{
			return executionStatus == TaskStatus.Running;
		}
		return false;
	}

	public override void OnChildExecuted(TaskStatus childStatus)
	{
		executionStatus = childStatus;
	}

	public override void OnConditionalAbort(int childIndex)
	{
		executionStatus = TaskStatus.Inactive;
	}

	public override void OnEnd()
	{
		executionStatus = TaskStatus.Inactive;
	}
}
