using System.Collections.Generic;
using ACT.Battle.Configs;
using Bamboo.ECS;
using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;
using UnityEngine;

namespace ACT.Battle;

[TaskCategory("ACT/Group")]
[TaskDescription("下发攻击权限")]
public class BTGroupUpdateAttackToken : Action
{
	private List<Entity> entityList = new List<Entity>();

	public SharedInt attackTokenNum;

	public SharedVector2 CD;

	public List<MonsterAttackType> monsterAttackTypes;

	private int childrenEntityNum;

	private ActBehaviorTree actBt;

	public override void OnStart()
	{
		entityList.Clear();
		actBt = Owner as ActBehaviorTree;
		CompGroupAI compGroupAI = actBt.Entity.GetCompGroupAI();
		childrenEntityNum = compGroupAI.GetChildrenEntity().Count;
		foreach (Entity item in compGroupAI.GetChildrenEntity())
		{
			if (item.IsAlive())
			{
				CompAI compAI = item.GetCompAI();
				if (compAI != null && compAI.NeedGroupAIControl() && compAI.battleState && monsterAttackTypes != null && monsterAttackTypes.Contains(item.GetConfig().MonsterAttackType) && !entityList.Contains(item))
				{
					compAI.dontChangeAttackTokenAndCanAttack = false;
					entityList.Add(item);
				}
			}
		}
		entityList.Sort(SortHatredTargets);
	}

	private static int SortHatredTargets(Entity a, Entity b)
	{
		return a.GetCompHatred().GetDistanceBetweenMeAndHatredTarget(DistanceType.horizontal).CompareTo(b.GetCompAI().hatredTargetDisX);
	}

	public override TaskStatus OnUpdate()
	{
		if (entityList == null)
		{
			return TaskStatus.Success;
		}
		int num = 0;
		int num2 = 0;
		float time = GameManager.timeSystem.time;
		int count = entityList.Count;
		if (count < 1)
		{
			return TaskStatus.Success;
		}
		if (count == 1 && attackTokenNum.Value > 0)
		{
			CompAI compAI = entityList[0].GetCompAI();
			if (!compAI.HasAttackToken())
			{
				compAI.dontChangeAttackTokenAndCanAttack = true;
				compAI.SetAttackToken(res: true);
			}
			return TaskStatus.Success;
		}
		bool flag = entityList[0].IsLogicAvailable();
		for (int i = 0; i < count; i++)
		{
			CompAI compAI2 = entityList[i].GetCompAI();
			if (flag && compAI2.HasAttackToken())
			{
				num++;
				if (!compAI2.GetCanAttack())
				{
					num2++;
				}
			}
		}
		if (num < attackTokenNum.Value)
		{
			for (int j = 0; j < count; j++)
			{
				CompAI compAI3 = entityList[j].GetCompAI();
				if (flag && compAI3.GetCanAttack() && !compAI3.HasAttackToken() && Time.time - compAI3.lastSetAttackTokenTime > 1f)
				{
					compAI3.lastSetAttackTokenTime = Time.time;
					compAI3.SetAttackToken(res: true);
					break;
				}
			}
		}
		if (num2 != 0)
		{
			for (int k = 0; k < count; k++)
			{
				CompAI compAI4 = entityList[k].GetCompAI();
				if (flag && !compAI4.GetCanAttack() && compAI4.HasAttackToken())
				{
					compAI4.SetAttackToken(res: false);
					num--;
					continue;
				}
				if (flag && compAI4.GetCanAttack() && !compAI4.HasAttackToken())
				{
					compAI4.SetAttackToken(res: true);
					num++;
					num2--;
				}
				if (num2 == 0)
				{
					break;
				}
			}
		}
		if (num == attackTokenNum.Value && time - CD.Value.y >= CD.Value.x)
		{
			for (int l = 0; l < count; l++)
			{
				CompAI compAI5 = entityList[l].GetCompAI();
				if (flag && compAI5.HasAttackToken())
				{
					compAI5.SetAttackToken(res: false);
					break;
				}
			}
			for (int num3 = count - 1; num3 >= 0; num3--)
			{
				CompAI compAI6 = entityList[num3].GetCompAI();
				if (flag && compAI6.GetCanAttack() && !compAI6.HasAttackToken())
				{
					CD.Value = new Vector2(CD.Value.x, time);
					compAI6.SetAttackToken(res: true);
					break;
				}
			}
		}
		if (num > attackTokenNum.Value)
		{
			for (int m = 0; m < count; m++)
			{
				if (num <= attackTokenNum.Value)
				{
					break;
				}
				CompAI compAI7 = entityList[m].GetCompAI();
				if (flag && compAI7.HasAttackToken())
				{
					compAI7.SetAttackToken(res: false);
					num--;
				}
			}
		}
		return TaskStatus.Success;
	}
}
