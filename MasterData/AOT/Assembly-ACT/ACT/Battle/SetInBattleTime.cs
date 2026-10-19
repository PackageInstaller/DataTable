using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;
using UnityEngine;

namespace ACT.Battle;

[TaskCategory("ACT")]
[TaskDescription("设置进入战斗的时间")]
public class SetInBattleTime : Action
{
	public SharedFloat sharedFloat;

	public override TaskStatus OnUpdate()
	{
		sharedFloat.Value = Time.time;
		return TaskStatus.Success;
	}
}
