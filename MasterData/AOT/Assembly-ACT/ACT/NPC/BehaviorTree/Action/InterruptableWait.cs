using System.Collections.Generic;
using ACT.Battle;
using ACT.Battle.ECS.System.SystemNPC;
using ACT.NPC.BehaviorTree.Variables;
using Bamboo.ECS;
using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.NPC.BehaviorTree.Action;

[TaskDescription("可被对话打断的wait节点")]
[TaskIcon("{SkinColor}WaitIcon.png")]
[TaskCategory("NPC")]
public class InterruptableWait : NpcActionBase
{
	public SharedInt counter;

	public List<SharedNpcPatrolParam> patrolParams = new List<SharedNpcPatrolParam>();

	[UnityEngine.Tooltip("Should the wait be randomized?")]
	public SharedBool randomWait = false;

	[UnityEngine.Tooltip("The minimum wait time if random wait is enabled")]
	public SharedFloat randomWaitMin = 1f;

	[UnityEngine.Tooltip("The maximum wait time if random wait is enabled")]
	public SharedFloat randomWaitMax = 1f;

	private float waitDuration;

	private float startTime;

	private float pauseTime;

	private bool hasValidWaitTime;

	public override void OnStart()
	{
		startTime = Time.time;
		hasValidWaitTime = true;
		if (randomWait.Value)
		{
			waitDuration = Random.Range(randomWaitMin.Value, randomWaitMax.Value);
			return;
		}
		int num = counter?.Value ?? (-1);
		if (num < 0 || patrolParams == null || num >= patrolParams.Count)
		{
			hasValidWaitTime = false;
			return;
		}
		NpcPatrolParam npcPatrolParam = patrolParams[num]?.Value;
		if (npcPatrolParam == null)
		{
			hasValidWaitTime = false;
		}
		else
		{
			waitDuration = npcPatrolParam.waitTime;
		}
	}

	public override TaskStatus OnUpdate()
	{
		if (!hasValidWaitTime)
		{
			return TaskStatus.Failure;
		}
		if (Singleton<GameState>.instance.InInteractObjectProcessing)
		{
			CompNpc compNpc = OwnerEntity.GetCompNpc();
			if (Singleton<RuntimeNpcManager>.instance.CurrentDialogueNpc == compNpc)
			{
				return TaskStatus.Failure;
			}
		}
		if (startTime + waitDuration < Time.time)
		{
			return TaskStatus.Success;
		}
		return TaskStatus.Running;
	}

	public override void OnPause(bool paused)
	{
		if (paused)
		{
			pauseTime = Time.time;
		}
		else
		{
			startTime += Time.time - pauseTime;
		}
	}

	public override void OnReset()
	{
		counter = 0;
		patrolParams = new List<SharedNpcPatrolParam>();
		randomWait = false;
		randomWaitMin = 1f;
		randomWaitMax = 1f;
	}
}
