using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;

namespace ACT.Battle;

[TaskCategory("ACT/废弃")]
[TaskDescription("判断辅助机是否进入框内，是的话返回success，否则返回failure")]
public class GetInRectAround : Conditional
{
	public SharedBool isInRect;

	public override TaskStatus OnUpdate()
	{
		if (isInRect.Value)
		{
			return TaskStatus.Success;
		}
		return TaskStatus.Failure;
	}
}
