using System.Collections.Generic;
using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;
using UnityEngine;

namespace ACT.Battle;

[TaskCategory("ACT/CD")]
[TaskDescription("设置cd")]
public class BTSetCd : Action
{
	public List<SharedVector2> sharedCds;

	public override TaskStatus OnUpdate()
	{
		foreach (SharedVector2 sharedCd in sharedCds)
		{
			sharedCd.Value = new Vector2(sharedCd.Value.x, GameManager.timeSystem.time);
		}
		return TaskStatus.Success;
	}
}
