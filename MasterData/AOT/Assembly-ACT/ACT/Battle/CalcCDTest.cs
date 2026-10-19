using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;
using UnityEngine;

namespace ACT.Battle;

[TaskCategory("ACT/CD")]
[TaskDescription("查询技能的CD是否好了，CD好了返回True，CD没好返回False")]
public class CalcCDTest : Conditional
{
	public SharedVector2 skillCD;

	public SharedFloat sharedFloat;

	public override TaskStatus OnUpdate()
	{
		skillCD.Value = new Vector2(skillCD.Value.x / (sharedFloat.Value + 1f), skillCD.Value.y);
		return TaskStatus.Success;
	}
}
