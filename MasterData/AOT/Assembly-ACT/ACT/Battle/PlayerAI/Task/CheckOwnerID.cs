using Bamboo.ECS;
using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;

namespace ACT.Battle.PlayerAI.Task;

[TaskCategory("ACT/Player")]
[TaskDescription("检测角色id")]
public class CheckOwnerID : Conditional
{
	public SharedInt id;

	public override TaskStatus OnUpdate()
	{
		Entity entity = ((ActBehaviorTree)Owner).Entity;
		if (entity.IsBehaveEntity())
		{
			if (id.Value != entity.GetTableId())
			{
				return TaskStatus.Failure;
			}
			return TaskStatus.Success;
		}
		return TaskStatus.Failure;
	}
}
