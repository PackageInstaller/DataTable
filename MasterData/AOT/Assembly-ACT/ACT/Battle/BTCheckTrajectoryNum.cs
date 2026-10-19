using System.Collections.Generic;
using Bamboo.ECS;
using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;
using Fundamental;

namespace ACT.Battle;

[TaskDescription("ACT/待定要好好想想的/用目标（玩家/敌人）的特定类型的子弹与特定值比较")]
public class BTCheckTrajectoryNum : Conditional
{
	public AbilityEntityType entityType;

	public SharedInt num;

	public Condition condition;

	public override TaskStatus OnUpdate()
	{
		bool flag = false;
		int num = 0;
		List<Entity> list = ListPool<Entity>.Get();
		SystemProduct.GetCasterProductEntity(((ActBehaviorTree)Owner).Entity, ref list);
		num = list.Count;
		ListPool<Entity>.Release(list);
		switch (condition)
		{
		case Condition.Greater:
			flag = num > this.num.Value;
			break;
		case Condition.GreaterAndEqual:
			flag = num >= this.num.Value;
			break;
		case Condition.Equal:
			flag = num == this.num.Value;
			break;
		case Condition.LessAndEqual:
			flag = num <= this.num.Value;
			break;
		case Condition.Less:
			flag = num < this.num.Value;
			break;
		}
		if (flag)
		{
			return TaskStatus.Success;
		}
		return TaskStatus.Failure;
	}
}
