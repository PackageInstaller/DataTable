using Ase;
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.BehaviourTrees;

[Name("Filter", 0)]
[Category("Decorators")]
[Description("Filters the access of its child either a specific number of times, or every specific amount of time.")]
[Icon("Filter", false, "")]
public class Filter : BTDecorator
{
	public enum FilterMode
	{
		LimitNumberOfTimes,
		CoolDown
	}

	public enum Policy
	{
		SuccessOrFailure,
		SuccessOnly,
		FailureOnly
	}

	[Tooltip("The mode to use.")]
	public FilterMode filterMode = FilterMode.CoolDown;

	[ShowIf("filterMode", 0)]
	[Name("Max Times", 0)]
	[Tooltip("The max ammount of times to allow the child to execute until the tree is completely restarted.")]
	public BBParameter<int> maxCount = 1;

	[ShowIf("filterMode", 0)]
	[Name("Increase Count When", 0)]
	[Tooltip("Only increase count if the selected status is returned from the child.")]
	public Policy policy;

	[ShowIf("filterMode", 1)]
	[Tooltip("The time to disallow execution for.")]
	public BBParameter<float> coolDownTime = 5f;

	[Name("Optional When Filtered", 0)]
	[Tooltip("If enabled, the Filter Decorator will return an Optional status when it is filtered. Otherwise it will return Failure.")]
	public bool inactiveWhenLimited = true;

	private int executedCount;

	private ParadoxTimer _paradoxTimer;

	public override void OnGraphStoped()
	{
		executedCount = 0;
		if (_paradoxTimer != null)
		{
			_paradoxTimer.Clear();
		}
	}

	protected override Status OnExecute(Component agent, IBlackboard blackboard)
	{
		if (base.decoratedConnection == null)
		{
			return Status.Optional;
		}
		switch (filterMode)
		{
		case FilterMode.CoolDown:
			if (_paradoxTimer == null)
			{
				base.status = base.decoratedConnection.Execute(agent, blackboard);
				if (base.status == Status.Success || base.status == Status.Failure)
				{
					NewCooldown(blackboard);
				}
				break;
			}
			if (_paradoxTimer.CurrentTime > 0f)
			{
				if (!inactiveWhenLimited)
				{
					return Status.Failure;
				}
				return Status.Optional;
			}
			base.status = base.decoratedConnection.Execute(agent, blackboard);
			if (base.status == Status.Success || base.status == Status.Failure)
			{
				InitCooldown();
			}
			break;
		case FilterMode.LimitNumberOfTimes:
			if (executedCount >= maxCount.value)
			{
				if (!inactiveWhenLimited)
				{
					return Status.Failure;
				}
				return Status.Optional;
			}
			base.status = base.decoratedConnection.Execute(agent, blackboard);
			if ((base.status == Status.Success && policy == Policy.SuccessOnly) || (base.status == Status.Failure && policy == Policy.FailureOnly) || ((base.status == Status.Success || base.status == Status.Failure) && policy == Policy.SuccessOrFailure))
			{
				executedCount++;
			}
			break;
		}
		return base.status;
	}

	private void NewCooldown(IBlackboard blackboard)
	{
		BaseEntity value = blackboard.GetVariable<BaseEntity>("BaseEntity").value;
		_paradoxTimer = value.GetSystem<ParadoxSystem>().ApplyTimer(coolDownTime.value);
	}

	private void InitCooldown()
	{
		_paradoxTimer.Init(coolDownTime.value);
	}

	private void Cooldown()
	{
	}
}
