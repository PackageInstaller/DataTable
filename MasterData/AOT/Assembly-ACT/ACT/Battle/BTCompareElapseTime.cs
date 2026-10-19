using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;

namespace ACT.Battle;

[TaskCategory("ACT/CD")]
[TaskDescription("比较cd.y的经过时间与 time， 大于时间返回ture， 否则为false")]
public class BTCompareElapseTime : Conditional
{
	public SharedVector2 sharedCd;

	public SharedFloat time;

	public override TaskStatus OnUpdate()
	{
		if (!(GameManager.timeSystem.time - sharedCd.Value.y >= time.Value))
		{
			return TaskStatus.Failure;
		}
		return TaskStatus.Success;
	}
}
