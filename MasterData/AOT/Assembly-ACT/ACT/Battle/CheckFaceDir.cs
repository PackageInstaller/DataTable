using Bamboo.ECS;
using BehaviorDesigner.Runtime.Tasks;

namespace ACT.Battle;

[TaskCategory("ACT/待定要好好想想的")]
[TaskDescription("判断自身朝向，朝右为success，朝左为failure")]
public class CheckFaceDir : Conditional
{
	public override TaskStatus OnUpdate()
	{
		if (!((ActBehaviorTree)Owner).Entity.IsFaceLeft())
		{
			return TaskStatus.Success;
		}
		return TaskStatus.Failure;
	}
}
