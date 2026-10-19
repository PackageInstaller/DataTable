using Bamboo.ECS;
using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;
using UnityEngine;

namespace ACT.Battle;

[TaskCategory("ACT/废弃")]
[TaskDescription("跟随角色时间的等待")]
public class BTEntityWait : Action
{
	[BehaviorDesigner.Runtime.Tasks.Tooltip("The amount of time to wait")]
	public SharedFloat waitTime = 1f;

	[BehaviorDesigner.Runtime.Tasks.Tooltip("Should the wait be randomized?")]
	public SharedBool randomWait = false;

	[BehaviorDesigner.Runtime.Tasks.Tooltip("The minimum wait time if random wait is enabled")]
	public SharedFloat randomWaitMin = 1f;

	[BehaviorDesigner.Runtime.Tasks.Tooltip("The maximum wait time if random wait is enabled")]
	public SharedFloat randomWaitMax = 1f;

	private float waitDuration;

	private Entity m_Entity;

	private float time;

	public override void OnStart()
	{
		m_Entity = ((ActBehaviorTree)Owner).Entity;
		time = 0f;
		if (randomWait.Value)
		{
			waitDuration = Random.Range(randomWaitMin.Value, randomWaitMax.Value);
		}
		else
		{
			waitDuration = waitTime.Value;
		}
	}

	public override TaskStatus OnUpdate()
	{
		time += m_Entity.GetCompTime().motionFixedDeltaTime;
		if (!(time > waitDuration))
		{
			return TaskStatus.Running;
		}
		return TaskStatus.Success;
	}

	public override void OnReset()
	{
		waitTime = 1f;
		randomWait = false;
		randomWaitMin = 1f;
		randomWaitMax = 1f;
	}
}
