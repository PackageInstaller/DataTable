using Bamboo.ECS;
using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;

namespace ACT.Battle;

[TaskCategory("ACT/待修改")]
[TaskDescription("设置瞄准目标")]
public class BTSetAim : Action
{
	public enum AimType
	{
		Entity,
		Position
	}

	public AimType aimType;

	[SharedRequired]
	public SharedEntity aimEntity;

	[SharedRequired]
	public SharedVector3 aimPosition;

	public string attachPoint = "waist";

	public override TaskStatus OnUpdate()
	{
		Entity entity = (Owner as ActBehaviorTree).Entity;
		switch (aimType)
		{
		case AimType.Entity:
			entity.GetCompAim().SetAimEntity(aimEntity.Value, attachPoint);
			break;
		case AimType.Position:
			entity.GetCompAim().SetAimPosition(aimPosition.Value);
			break;
		}
		return TaskStatus.Success;
	}
}
