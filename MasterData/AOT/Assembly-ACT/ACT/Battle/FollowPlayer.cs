using System;
using Bamboo.ECS;
using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;
using UnityEngine;

namespace ACT.Battle;

[Obsolete("使用MoveToLocation替换")]
[TaskCategory("ACT/废弃")]
[TaskDescription("空中单位走导航飞向一个位置，过程中返回Running,停止由别的节点打断")]
public class FollowPlayer : BehaviorDesigner.Runtime.Tasks.Action
{
	public SharedBool inLadder;

	public SharedVector3 targetPos;

	public float baseSpeed = 10f;

	public float acc = 10f;

	public float maxSpeedDistance = 10f;

	public float maxSpeed = 30f;

	public float onLadderSpeed;

	public float onLadderAcc;

	public override void OnStart()
	{
		if (LuminApplication.LogEnabled)
		{
			Debug.LogError("FollowPlayer已过时使用MoveToLocation替换", ((ActBehaviorTree)Owner).Entity.GetRoot());
		}
	}

	public override TaskStatus OnUpdate()
	{
		return TaskStatus.Running;
	}
}
