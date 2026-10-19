using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;
using UnityEngine;

namespace ACT.Battle;

[TaskCategory("ACT/CD")]
[TaskDescription("设置最大cd")]
public class BTSetMaxCd : Action
{
	public SharedVector2 sharedCd;

	public SharedFloat maxCd;

	public override TaskStatus OnUpdate()
	{
		sharedCd.Value = new Vector2(maxCd.Value, sharedCd.Value.y);
		return TaskStatus.Success;
	}
}
