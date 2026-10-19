using Bamboo.ECS;
using BehaviorDesigner.Runtime.Tasks;
using UnityEngine;

namespace ACT.Battle;

[TaskCategory("ACT/Group")]
[TaskDescription("判断当前target的condition")]
public class BTGroupCondition : Conditional
{
	[InspectTask]
	[BehaviorDesigner.Runtime.Tasks.Tooltip("The conditional task to evaluate")]
	public Conditional conditionalTask;

	[SharedRequired]
	public SharedEntity targetEntity;

	public override void OnStart()
	{
		if (targetEntity != null)
		{
			GameObject root = targetEntity.Value.GetRoot();
			conditionalTask.Owner = targetEntity.Value.GetBTree();
			conditionalTask.GameObject = root;
			conditionalTask.Transform = root.transform;
		}
		base.OnStart();
	}

	public override TaskStatus OnUpdate()
	{
		if (targetEntity != null)
		{
			return conditionalTask.OnUpdate();
		}
		return TaskStatus.Failure;
	}
}
