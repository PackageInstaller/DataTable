using Bamboo.ECS;
using BehaviorDesigner.Runtime.Tasks;

namespace ACT.Battle;

[TaskCategory("ACT/待定要好好想想的")]
[TaskDescription("检查仇恨目标 或者在特定范围内的玩家 是否停留不动")]
public class CheckPlayerStop : Conditional
{
	private Entity player;

	public override void OnStart()
	{
		player = MonoECS.instance.localPlayer.battleEntity;
	}

	public override TaskStatus OnUpdate()
	{
		if (!player.IsValid || player.GetCompInput().inputDir != EInputDir.None)
		{
			return TaskStatus.Failure;
		}
		return TaskStatus.Success;
	}
}
