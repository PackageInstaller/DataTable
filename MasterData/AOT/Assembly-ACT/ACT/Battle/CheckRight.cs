using ACT.MultiPlayer;
using Bamboo.ECS;
using BehaviorDesigner.Runtime.Tasks;
using UnityEngine;

namespace ACT.Battle;

[TaskCategory("ACT/待定要好好想想的")]
[TaskDescription("检查正方向是否有玩家")]
public class CheckRight : Conditional
{
	[UnityEngine.Tooltip("勾选判断负方向是否有玩家")]
	public bool checkleft;

	private Entity thisEntity;

	public override void OnStart()
	{
		thisEntity = ((ActBehaviorTree)Owner).Entity;
	}

	public override TaskStatus OnUpdate()
	{
		MPPlayer localPlayer = MonoECS.instance.localPlayer;
		if (localPlayer != null && localPlayer.battleEntity.IsValid && localPlayer.battleEntity.IsActive())
		{
			bool flag = localPlayer.battleEntity.GetCompTransform().physicsPosition.x >= thisEntity.GetCompTransform().physicsPosition.x;
			if (checkleft)
			{
				flag = !flag;
			}
			if (flag)
			{
				return TaskStatus.Success;
			}
		}
		return TaskStatus.Failure;
	}
}
