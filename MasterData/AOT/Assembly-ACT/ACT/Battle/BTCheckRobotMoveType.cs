using BehaviorDesigner.Runtime.Tasks;

namespace ACT.Battle;

[TaskCategory("ACT/Ӧ\ufffd\ufffdҪ\ufffd\ufffd\ufffd\ufffd\ufffd\ufffd")]
public class BTCheckRobotMoveType : Conditional
{
	public SharedRobotMoveType moveType;

	public RobotMoveType type;

	public override TaskStatus OnUpdate()
	{
		if (moveType.Value != type)
		{
			return TaskStatus.Failure;
		}
		return TaskStatus.Success;
	}
}
