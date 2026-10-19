using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;

namespace ACT.Battle;

[TaskCategory("ACT/CD")]
[TaskDescription("判断Cd超过maxCd")]
public class BTCheckCd : Conditional
{
	public SharedVector2 sharedCd;

	public override TaskStatus OnUpdate()
	{
		float time = GameManager.timeSystem.time;
		if (sharedCd.Value.y != 0f && !(time - sharedCd.Value.y >= sharedCd.Value.x))
		{
			return TaskStatus.Failure;
		}
		return TaskStatus.Success;
	}
}
