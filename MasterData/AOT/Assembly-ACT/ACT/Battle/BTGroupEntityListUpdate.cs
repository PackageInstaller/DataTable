using ACT.Battle.Configs;
using Bamboo.ECS;
using BehaviorDesigner.Runtime.Tasks;

namespace ACT.Battle;

[TaskCategory("ACT/Group")]
[TaskDescription("每帧更新组AI内，所有组内成员的信息，并根据职业分组")]
public class BTGroupEntityListUpdate : Action
{
	[SharedRequired]
	public SharedEntityList meleeList;

	[SharedRequired]
	public SharedEntityList rangeList;

	[SharedRequired]
	public SharedEntityList supportList;

	private int childrenEntityNum;

	private ActBehaviorTree actBt;

	public override void OnStart()
	{
		actBt = Owner as ActBehaviorTree;
		childrenEntityNum = actBt.Entity.GetCompGroupAI().GetChildrenEntity().Count;
	}

	private void deleteDeadChild(ref SharedEntityList entityList)
	{
		entityList.Value.Clear();
	}

	private void sortChild(ref SharedEntityList entityList)
	{
		entityList.Value.Sort((Entity a, Entity b) =>
		{
			float hatredTargetDisX = a.GetCompAI().hatredTargetDisX;
			float hatredTargetDisX2 = b.GetCompAI().hatredTargetDisX;
			return hatredTargetDisX2.CompareTo(hatredTargetDisX);
		});
	}

	public override TaskStatus OnUpdate()
	{
		deleteDeadChild(ref meleeList);
		deleteDeadChild(ref rangeList);
		foreach (Entity item in actBt.Entity.GetCompGroupAI().GetChildrenEntity())
		{
			CompAI compAI = item.GetCompAI();
			if (compAI == null || !compAI.battleState || !item.IsAlive() || !compAI.NeedGroupAIControl())
			{
				continue;
			}
			switch (item.GetConfig().MonsterAttackType)
			{
			case MonsterAttackType.melee:
				if (!meleeList.Value.Contains(item))
				{
					meleeList.Value.Add(item);
				}
				break;
			case MonsterAttackType.range:
				if (!rangeList.Value.Contains(item))
				{
					rangeList.Value.Add(item);
				}
				break;
			case MonsterAttackType.shortRange:
				if (!rangeList.Value.Contains(item))
				{
					rangeList.Value.Add(item);
				}
				break;
			}
		}
		sortChild(ref meleeList);
		sortChild(ref rangeList);
		return TaskStatus.Success;
	}
}
