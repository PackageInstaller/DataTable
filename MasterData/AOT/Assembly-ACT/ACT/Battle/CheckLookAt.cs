using ACT.MultiPlayer;
using Bamboo.ECS;
using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;
using UnityEngine;

namespace ACT.Battle;

[TaskCategory("ACT/待定要好好想想的")]
[TaskDescription("检查所在朝向上是否有仇恨目标 或者 检查所在朝向上是否有某个坐标")]
public class CheckLookAt : Conditional
{
	[UnityEngine.Tooltip("勾选判断背后,不勾判断面前")]
	public bool CheckBehind;

	[UnityEngine.Tooltip("勾选代表判断一个坐标在前面还是后面")]
	public bool usePosition;

	[UnityEngine.Tooltip("坐标")]
	public SharedVector3 flagPosition;

	private Entity thisEntity;

	public override void OnStart()
	{
		thisEntity = ((ActBehaviorTree)Owner).Entity;
	}

	public override TaskStatus OnUpdate()
	{
		bool flag;
		if (!usePosition)
		{
			MPPlayer localPlayer = MonoECS.instance.localPlayer;
			if (localPlayer == null || !localPlayer.battleEntity.IsValid)
			{
				return TaskStatus.Failure;
			}
			if (!localPlayer.battleEntity.IsAlive() || !localPlayer.battleEntity.IsActive())
			{
				return TaskStatus.Failure;
			}
			flag = localPlayer.battleEntity.GetCompTransform().physicsPosition.x < thisEntity.GetCompTransform().physicsPosition.x;
		}
		else
		{
			flag = flagPosition.Value.x < thisEntity.GetCompTransform().physicsPosition.x;
		}
		if (CheckBehind ^ (flag == thisEntity.IsFaceLeft()))
		{
			return TaskStatus.Success;
		}
		return TaskStatus.Failure;
	}
}
