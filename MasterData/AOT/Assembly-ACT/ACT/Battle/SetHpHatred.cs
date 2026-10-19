using System.Collections.Generic;
using Bamboo.ECS;
using BehaviorDesigner.Runtime.Tasks;

namespace ACT.Battle;

[TaskCategory("ACT")]
[TaskDescription("选取血量最高/最低的为目标")]
public class SetHpHatred : Action
{
	public bool isMin;

	public SharedEntityList tagerts;

	public override TaskStatus OnUpdate()
	{
		List<Entity> value = tagerts.Value;
		if (value.Count > 0)
		{
			Entity entity = value[0];
			int atk = entity.GetCompAbility().atk;
			if (isMin)
			{
				for (int i = 1; i < value.Count; i++)
				{
					Entity entity2 = value[i];
					if (entity2.IsAlive() && entity2.GetCompAbility().hp < atk)
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
					if (entity3.IsAlive() && entity3.GetCompAbility().hp > atk)
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
