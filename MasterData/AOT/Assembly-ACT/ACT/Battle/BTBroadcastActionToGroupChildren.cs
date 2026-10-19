using System.Collections.Generic;
using Bamboo.ECS;
using BehaviorDesigner.Runtime.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.Battle;

[TaskCategory("ACT/Group")]
[TaskDescription("组成员广播动作, 用于组成员共享动作, 例如面向, 设置仇恨目标等, 只可用于短暂的行为, 不可用于长时间的行为, 例如移动, 攻击等")]
public class BTBroadcastActionToGroupChildren : Action
{
	[BehaviorDesigner.Runtime.Tasks.Tooltip("The action task")]
	public Action actionTask;

	private List<Entity> entities;

	public override void OnStart()
	{
		if (!(Owner is ActBehaviorTree actBehaviorTree) || actionTask == null)
		{
			return;
		}
		if (Singleton<GroupAIManager>.instance.GetGroupAI(actBehaviorTree.Entity.GetCompAI().groupUid, out var entity) && entity.IsValid)
		{
			entities = entity.GetCompGroupAI().GetChildrenEntity();
		}
		if (entities == null)
		{
			return;
		}
		foreach (Entity entity2 in entities)
		{
			GameObject root = entity2.GetRoot();
			actionTask.Owner = entity2.GetCompAI().ActBehaviorTree;
			actionTask.GameObject = root;
			actionTask.Transform = root.transform;
		}
		actionTask.OnStart();
	}

	public override TaskStatus OnUpdate()
	{
		if (actionTask != null && entities != null)
		{
			foreach (Entity entity in entities)
			{
				GameObject root = entity.GetRoot();
				actionTask.Owner = entity.GetCompAI().ActBehaviorTree;
				actionTask.GameObject = root;
				actionTask.Transform = root.transform;
			}
			actionTask.OnUpdate();
		}
		return TaskStatus.Success;
	}
}
