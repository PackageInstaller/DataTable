using System.Collections.Generic;
using Bamboo.ECS;
using BehaviorDesigner.Runtime.Tasks;

namespace ACT.Battle;

[TaskCategory("ACT/待修改")]
[TaskDescription("选取伤害量最高/最低的为目标")]
public class SetDamgeHarted : Action
{
	public bool isMin;

	public SharedEntityIdList tagerts;

	public override TaskStatus OnUpdate()
	{
		Entity entity = ((ActBehaviorTree)Owner).Entity;
		List<HatredData> hatredDateList = entity.GetCompHatred().hatredDateList;
		List<EntityId> value = tagerts.Value;
		if (hatredDateList.Count > 0)
		{
			int num = 0;
			EntityId item = hatredDateList[0].attacker;
			while (!tagerts.Value.Contains(item) && num < hatredDateList.Count)
			{
				num++;
				item = hatredDateList[num].attacker;
			}
			float totoalDamge = hatredDateList[num].totoalDamge;
			if (isMin)
			{
				for (int i = num; i < hatredDateList.Count; i++)
				{
					EntityId attacker = hatredDateList[i].attacker;
					if (hatredDateList[i].totoalDamge < totoalDamge && value.Contains(attacker))
					{
						item = attacker;
					}
				}
			}
			else
			{
				for (int j = num; j < hatredDateList.Count; j++)
				{
					EntityId attacker2 = hatredDateList[j].attacker;
					if (hatredDateList[j].totoalDamge > totoalDamge && value.Contains(attacker2))
					{
						item = attacker2;
					}
				}
			}
			Entity entity2 = GameManager.entities.GetEntity(item);
			if (entity2.IsValid)
			{
				entity.SetHatred(entity2);
			}
		}
		return TaskStatus.Success;
	}
}
