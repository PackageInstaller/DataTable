using Bamboo.ECS;
using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;
using UnityEngine;

namespace ACT.Battle;

[TaskCategory("ACT/Group")]
[TaskIcon("{SkinColor}ConditionalEvaluatorIcon.png")]
[TaskDescription("判断当前target的condition")]
public class BTGroupConditionalEvaluator : Decorator
{
	[BehaviorDesigner.Runtime.Tasks.Tooltip("Should the conditional task be reevaluated every tick?")]
	public SharedBool reevaluate;

	[InspectTask]
	[BehaviorDesigner.Runtime.Tasks.Tooltip("The conditional task to evaluate")]
	public Conditional conditionalTask;

	[SharedRequired]
	public SharedEntity targetEntity;

	private TaskStatus executionStatus;

	private bool checkConditionalTask = true;

	private bool conditionalTaskFailed;

	public override void OnAwake()
	{
		if (conditionalTask != null)
		{
			conditionalTask.OnAwake();
		}
	}

	public override void OnStart()
	{
		if (targetEntity != null && conditionalTask != null)
		{
			GameObject root = targetEntity.Value.GetRoot();
			conditionalTask.Owner = targetEntity.Value.GetBTree();
			conditionalTask.GameObject = root;
			conditionalTask.Transform = root.transform;
			conditionalTask.OnStart();
		}
	}

	public override bool CanExecute()
	{
		if (checkConditionalTask)
		{
			checkConditionalTask = false;
			OnUpdate();
		}
		if (conditionalTaskFailed)
		{
			return false;
		}
		if (executionStatus != TaskStatus.Inactive)
		{
			return executionStatus == TaskStatus.Running;
		}
		return true;
	}

	public override bool CanReevaluate()
	{
		return reevaluate.Value;
	}

	public override TaskStatus OnUpdate()
	{
		if (targetEntity != null)
		{
			TaskStatus taskStatus = conditionalTask.OnUpdate();
			conditionalTaskFailed = conditionalTask == null || taskStatus == TaskStatus.Failure;
			return taskStatus;
		}
		return TaskStatus.Failure;
	}

	public override void OnChildExecuted(TaskStatus childStatus)
	{
		executionStatus = childStatus;
	}

	public override TaskStatus OverrideStatus()
	{
		return TaskStatus.Failure;
	}

	public override TaskStatus OverrideStatus(TaskStatus status)
	{
		if (conditionalTaskFailed)
		{
			return TaskStatus.Failure;
		}
		return status;
	}

	public override void OnEnd()
	{
		executionStatus = TaskStatus.Inactive;
		checkConditionalTask = true;
		conditionalTaskFailed = false;
		if (conditionalTask != null)
		{
			conditionalTask.OnEnd();
		}
	}

	public override void OnReset()
	{
		conditionalTask = null;
	}
}
