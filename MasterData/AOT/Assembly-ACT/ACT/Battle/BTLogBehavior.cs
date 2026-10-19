using Bamboo.ECS;
using BehaviorDesigner.Runtime.Tasks;

namespace ACT.Battle;

[TaskCategory("ACT/待修改")]
public class BTLogBehavior : Action
{
	private Entity _entity;

	public BTLogEnum logEnum;

	[SharedRequired]
	public SharedEntity A;

	public override TaskStatus OnUpdate()
	{
		return logEnum switch
		{
			_ => TaskStatus.Success, 
		};
	}
}
