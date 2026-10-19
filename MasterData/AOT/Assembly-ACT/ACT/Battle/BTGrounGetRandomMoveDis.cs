using Bamboo.ECS;
using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;
using UnityEngine;

namespace ACT.Battle;

[TaskCategory("ACT/移动节点")]
[TaskDescription("地面单位 获得执行随机移动的距离")]
public class BTGrounGetRandomMoveDis : Action
{
	public SharedGrounEnemyRandomKeep sharedGrounEnemyRandomKeep;

	[SharedRequired]
	public SharedFloat dis;

	public override TaskStatus OnUpdate()
	{
		Entity entity = Owner.ToEntity();
		if ((float)Random.Range(0, 1) >= 0.7f)
		{
			dis.Value = Random.Range(0f - sharedGrounEnemyRandomKeep.Value.groundMinBackDis, 0f - sharedGrounEnemyRandomKeep.Value.groundMaxBackDis);
			dis.Value -= entity.GetCompNav().sqrStoppingDistance;
		}
		else
		{
			dis.Value = Random.Range(sharedGrounEnemyRandomKeep.Value.groundMinFrontDis, sharedGrounEnemyRandomKeep.Value.groundMaxFrontDis);
			dis.Value += entity.GetCompNav().sqrStoppingDistance;
		}
		return TaskStatus.Success;
	}
}
