using Bamboo.ECS;
using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;
using UnityEngine;

namespace ACT.Battle;

[TaskCategory("ACT/移动节点")]
[TaskDescription("地面单位 判断能否执行随机移动")]
public class BTGroundCheckRandomMoveCD : Conditional
{
	public SharedGrounEnemyRandomKeep sharedGrounEnemyRandomKeep;

	[SharedRequired]
	public SharedVector2 cd;

	public override TaskStatus OnUpdate()
	{
		Entity entity = Owner.ToEntity();
		if (sharedGrounEnemyRandomKeep.Value == null)
		{
			return TaskStatus.Failure;
		}
		float time = Time.time;
		if (time - entity.GetCompAI().lastAttackTime < 1f)
		{
			return TaskStatus.Failure;
		}
		if (cd.Value.y == 0f || time - cd.Value.y > cd.Value.x)
		{
			float x = Random.Range(sharedGrounEnemyRandomKeep.Value.groundMinKeepCD, sharedGrounEnemyRandomKeep.Value.groundMaxKeepCD);
			cd.Value = new Vector2(x, time);
			return TaskStatus.Success;
		}
		return TaskStatus.Failure;
	}
}
