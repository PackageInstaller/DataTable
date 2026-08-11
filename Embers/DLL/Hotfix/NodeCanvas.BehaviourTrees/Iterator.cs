using System.Collections;
using NodeCanvas.Framework;
using NodeCanvas.Framework.Internal;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.BehaviourTrees;

[Name("Iterate", 0)]
[Category("Decorators")]
[Description("Iterates a list and executes its child once for each element in that list. Keeps iterating until the Termination Policy is met or until the whole list is iterated, in which case the last iteration child status is returned.")]
[Icon("List", false, "")]
public class Iterator : BTDecorator
{
	public enum TerminationConditions
	{
		None,
		FirstSuccess,
		FirstFailure
	}

	[RequiredField]
	[BlackboardOnly]
	[Tooltip("The list to iterate.")]
	public BBParameter<IList> targetList;

	[BlackboardOnly]
	[Name("Current Element", 0)]
	[Tooltip("Store the currently iterated list element in a variable.")]
	public BBObjectParameter current;

	[BlackboardOnly]
	[Name("Current Index", 0)]
	[Tooltip("Store the currently iterated list index in a variable.")]
	public BBParameter<int> storeIndex;

	[Name("Termination Policy", 0)]
	[Tooltip("The condition for when to terminate the iteration and return status.")]
	public TerminationConditions terminationCondition;

	[Tooltip("The maximum allowed iterations. Leave at -1 to iterate the whole list.")]
	public BBParameter<int> maxIteration = -1;

	[Tooltip("Should the iteration start from the begining after the Iterator node resets?")]
	public bool resetIndex = true;

	private int currentIndex;

	private IList list
	{
		get
		{
			if (targetList == null)
			{
				return null;
			}
			return targetList.value;
		}
	}

	protected override Status OnExecute(Component agent, IBlackboard blackboard)
	{
		if (base.decoratedConnection == null)
		{
			return Status.Optional;
		}
		if (list == null || list.Count == 0)
		{
			return Status.Failure;
		}
		for (int i = currentIndex; i < list.Count; i++)
		{
			current.value = list[i];
			storeIndex.value = i;
			base.status = base.decoratedConnection.Execute(agent, blackboard);
			if (base.status == Status.Success && terminationCondition == TerminationConditions.FirstSuccess)
			{
				return Status.Success;
			}
			if (base.status == Status.Failure && terminationCondition == TerminationConditions.FirstFailure)
			{
				return Status.Failure;
			}
			if (base.status == Status.Running)
			{
				currentIndex = i;
				return Status.Running;
			}
			if (currentIndex == list.Count - 1 || currentIndex == maxIteration.value - 1)
			{
				if (resetIndex)
				{
					currentIndex = 0;
				}
				return base.status;
			}
			base.decoratedConnection.Reset();
			currentIndex++;
		}
		return Status.Running;
	}

	protected override void OnReset()
	{
		if (resetIndex)
		{
			currentIndex = 0;
		}
	}
}
