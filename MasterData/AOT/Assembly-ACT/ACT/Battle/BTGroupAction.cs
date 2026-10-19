using System.Collections.Generic;
using Bamboo.ECS;
using BehaviorDesigner.Runtime.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.Battle;

[TaskCategory("ACT/Group")]
[TaskDescription("组内成员执行action")]
public class BTGroupAction : Action
{
	[BehaviorDesigner.Runtime.Tasks.Tooltip("action")]
	public Action actionTask;

	[SharedRequired]
	[BehaviorDesigner.Runtime.Tasks.Tooltip("The target entity")]
	public SharedEntity targetEntity;

	public bool isBroadcastToGroupChildren;

	private List<Entity> entities;

	public override TaskStatus OnUpdate()
	{
		if (actionTask == null)
		{
			return TaskStatus.Failure;
		}
		if (isBroadcastToGroupChildren)
		{
			ActBehaviorTree actBehaviorTree = Owner as ActBehaviorTree;
			actBehaviorTree.Entity.GetCompGroupAI();
			if (Singleton<GroupAIManager>.instance.GetGroupAI(actBehaviorTree.Entity.GetCompGroupAI().id, out var entity) && entity.IsValid)
			{
				entities = entity.GetCompGroupAI().GetChildrenEntity();
				if (entities != null)
				{
					foreach (Entity entity2 in entities)
					{
						GameObject root = entity2.GetRoot();
						actionTask.Owner = entity2.GetCompAI().ActBehaviorTree;
						actionTask.GameObject = root;
						actionTask.Transform = root.transform;
						actionTask.OnStart();
						actionTask.OnUpdate();
					}
				}
			}
		}
		else if (targetEntity != null)
		{
			GameObject root2 = targetEntity.Value.GetRoot();
			actionTask.Owner = targetEntity.Value.GetBTree();
			actionTask.GameObject = root2;
			actionTask.Transform = root2.transform;
			actionTask.OnStart();
			actionTask.OnUpdate();
		}
		return TaskStatus.Success;
	}
}
