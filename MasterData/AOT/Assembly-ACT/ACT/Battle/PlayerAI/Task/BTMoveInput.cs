using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;

namespace ACT.Battle.PlayerAI.Task;

[TaskCategory("ACT/Player")]
[TaskDescription("玩家移动输入")]
public class BTMoveInput : Action
{
	public SharedVector2 dir;
}
