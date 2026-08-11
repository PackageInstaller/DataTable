using System.Collections.Generic;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.DialogueTrees;

[Category("Branch")]
[Description("Select a child to execute based on it's chance to be selected. An optional pre-Condition Task can be assigned to filter the child in or out of the selection probability.\nThe actor selected will be used for the condition checks.")]
[Icon("ProbabilitySelector", false, "")]
[Color("b3ff7f")]
public class ProbabilitySelector : DTNode
{
	public class Option
	{
		public BBParameter<float> weight;

		public ConditionTask condition;

		public Option(float weightValue, IBlackboard bbValue)
		{
			weight = new BBParameter<float>
			{
				value = weightValue,
				bb = bbValue
			};
			condition = null;
		}
	}

	[SerializeField]
	[AutoSortWithChildrenConnections]
	private List<Option> childOptions = new List<Option>();

	private List<int> successIndeces;

	public override int maxOutConnections => -1;

	public override void OnChildConnected(int index)
	{
		if (childOptions.Count < base.outConnections.Count)
		{
			childOptions.Insert(index, new Option(1f, base.graphBlackboard));
		}
	}

	public override void OnChildDisconnected(int index)
	{
		childOptions.RemoveAt(index);
	}

	protected override Status OnExecute(Component agent, IBlackboard blackboard)
	{
		return Status.Failure;
	}

	private float GetTotal()
	{
		float num = 0f;
		for (int i = 0; i < childOptions.Count; i++)
		{
			Option option = childOptions[i];
			if (successIndeces == null || successIndeces.Contains(i))
			{
				num += option.weight.value;
			}
		}
		return num;
	}

	protected override void OnReset()
	{
		successIndeces = null;
	}
}
