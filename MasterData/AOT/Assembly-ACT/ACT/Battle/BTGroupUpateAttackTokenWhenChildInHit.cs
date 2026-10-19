using Bamboo.ECS;
using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;
using UnityEngine;

namespace ACT.Battle;

[TaskCategory("ACT/Group")]
[TaskDescription("剔除有攻击权限，但是不能攻击的，然后给太久没攻击且能攻击的攻击权限,如果有这种情况就会消耗CD，如果没有这种情况就返回失败不消耗CD")]
public class BTGroupUpateAttackTokenWhenChildInHit : Action
{
	[SharedRequired]
	public SharedEntityList entityList;

	public SharedVector2 CD;

	public SharedVector2 waitTime;

	private float startTime;

	private float realWaitTime;

	public override void OnStart()
	{
		startTime = GameManager.timeSystem.time;
		realWaitTime = Random.Range(waitTime.Value.x, waitTime.Value.y);
	}

	public override TaskStatus OnUpdate()
	{
		int count = entityList.Value.Count;
		if (count <= 1)
		{
			return TaskStatus.Success;
		}
		int num = 0;
		for (int i = 0; i < count; i++)
		{
			CompAI compAI = entityList.Value[i].GetCompAI();
			if (compAI.HasAttackToken() && !compAI.GetCanAttack())
			{
				num++;
				break;
			}
		}
		float time = GameManager.timeSystem.time;
		if (num > 0 && time - CD.Value.y >= CD.Value.x)
		{
			if (time - startTime < realWaitTime)
			{
				return TaskStatus.Running;
			}
			CD.Value = new Vector2(CD.Value.x, time);
			num = 0;
			for (int j = 0; j < count; j++)
			{
				CompAI compAI2 = entityList.Value[j].GetCompAI();
				if (compAI2.HasAttackToken() && !compAI2.GetCanAttack())
				{
					num++;
					compAI2.SetAttackToken(res: false);
					break;
				}
			}
			for (int k = count - 1; k >= 0; k++)
			{
				if (num <= 0)
				{
					break;
				}
				CompAI compAI3 = entityList.Value[k].GetCompAI();
				if (compAI3.GetCanAttack() && !compAI3.HasAttackToken())
				{
					num--;
					compAI3.SetAttackToken(res: true);
				}
			}
		}
		return TaskStatus.Success;
	}
}
