using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;
using UnityEngine;

namespace ACT.Battle;

[TaskCategory("ACT/CD")]
[TaskDescription("查询技能的CD是否好了，CD好了返回True，CD没好返回False")]
public class BTQueryCD : Conditional
{
	public SharedVector2 skillCD;

	public override TaskStatus OnUpdate()
	{
		float time = GameManager.timeSystem.time;
		if (skillCD.Value.y == 0f)
		{
			skillCD.Value = new Vector2(skillCD.Value.x, time);
			return TaskStatus.Success;
		}
		if (time - skillCD.Value.y > skillCD.Value.x)
		{
			skillCD.Value = new Vector2(skillCD.Value.x, time);
			return TaskStatus.Success;
		}
		return TaskStatus.Failure;
	}
}
