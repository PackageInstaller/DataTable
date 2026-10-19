using Bamboo.ECS;
using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;

namespace ACT.Battle;

[TaskCategory("ACT/待定要好好想想的")]
[TaskDescription("用角色距离地面的高度与某个值作比较，满足条件返回True，反之False")]
public class CompareGroundDistance : Conditional
{
	public SharedFloat distance = 1f;

	public Condition condition;

	public override TaskStatus OnUpdate()
	{
		bool flag = ((ActBehaviorTree)Owner).Entity.GetCompPhysics().groundDistance <= distance.Value;
		switch (condition)
		{
		case Condition.Greater:
		case Condition.GreaterAndEqual:
			flag = !flag;
			break;
		case Condition.Equal:
			return TaskStatus.Failure;
		}
		if (flag)
		{
			return TaskStatus.Success;
		}
		return TaskStatus.Failure;
	}
}
