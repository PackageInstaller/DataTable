using System.Collections.Generic;
using Bamboo.ECS;
using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.Battle;

[TaskCategory("ACT/待修改")]
[TaskDescription("获得ContextPosition")]
public class BTFindClosedContextPosition : Action
{
	[BTContextTypeName]
	public int contextType;

	[SharedRequired]
	public SharedVector3 sharedPosition;

	public bool isList;

	[SharedRequired]
	public SharedVector3List sharedVector3List;

	public override TaskStatus OnUpdate()
	{
		ActBehaviorTree actBehaviorTree = Owner as ActBehaviorTree;
		if (isList)
		{
			List<BattleInteractableObject> list = ListPool<BattleInteractableObject>.Get();
			if (MonoECS.instance.aiContextManager.FindCloseContextsNonAlloc(contextType, actBehaviorTree.Entity.GetCompTransform().physicsPosition, list))
			{
				if (sharedVector3List.Value == null)
				{
					sharedVector3List.Value = new List<Vector3>();
				}
				sharedVector3List.Value.Clear();
				foreach (BattleInteractableObject item in list)
				{
					sharedVector3List.Value.Add(item.transform.position);
				}
				ListPool<BattleInteractableObject>.Release(list);
				return TaskStatus.Success;
			}
			ListPool<BattleInteractableObject>.Release(list);
		}
		else
		{
			BattleInteractableObject battleInteractableObject = MonoECS.instance.aiContextManager.FindClosedContext(contextType, actBehaviorTree.Entity.GetCompTransform().physicsPosition);
			if (battleInteractableObject != null)
			{
				sharedPosition.Value = battleInteractableObject.transform.position;
				return TaskStatus.Success;
			}
		}
		return TaskStatus.Failure;
	}
}
