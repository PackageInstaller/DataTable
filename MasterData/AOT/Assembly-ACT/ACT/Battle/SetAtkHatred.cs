using System.Collections.Generic;
using Bamboo.ECS;
using BehaviorDesigner.Runtime.Tasks;

namespace ACT.Battle;

[TaskCategory("ACT/待修改")]
[TaskDescription("选取攻击力最高/最低的为目标")]
public class SetAtkHatred : Action
{
	public bool isMin;

	public SharedEntityList tagerts;

	public override TaskStatus OnUpdate()
	{
		List<Entity> value = tagerts.Value;
		if (value.Count > 0)
		{
			Entity entity = value[0];
			int hp = entity.GetCompAbility().hp;
			if (isMin)
			{
				for (int i = 1; i < value.Count; i++)
				{
					Entity entity2 = value[i];
					if (entity2.IsAlive() && entity2.GetCompAbility().atk < hp)
					{
						entity = entity2;
					}
				}
			}
			else
			{
				for (int j = 1; j < value.Count; j++)
				{
					Entity entity3 = value[j];
					if (entity3.IsLogicAvailable() && entity3.GetCompAbility().atk > hp)
					{
						entity = entity3;
					}
				}
			}
			(Owner as ActBehaviorTree).Entity.SetHatred(entity);
		}
		return TaskStatus.Success;
	}
}
