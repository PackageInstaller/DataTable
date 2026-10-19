using System.Collections.Generic;
using ACT.Battle;
using ACT.NPC.BehaviorTree.Variables;
using Bamboo.ECS;
using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;
using UnityEngine;

namespace ACT.NPC.BehaviorTree.Action;

[TaskCategory("NPC")]
[TaskDescription("根据巡逻参数修改状态机整数状态")]
public class SetAnimator : NpcActionBase
{
	public SharedInt counter;

	public List<SharedNpcPatrolParam> patrolParams = new List<SharedNpcPatrolParam>();

	[BehaviorTreeLabel("动画状态")]
	public NpcPatrolAnimatorState animatorState;

	private static readonly int AnimatorState = Animator.StringToHash("state");

	public override TaskStatus OnUpdate()
	{
		int num = counter?.Value ?? (-1);
		if (num < 0 || patrolParams == null || num >= patrolParams.Count)
		{
			return TaskStatus.Failure;
		}
		NpcPatrolParam npcPatrolParam = patrolParams[num]?.Value;
		CompNpc compNpc = OwnerEntity.GetCompNpc();
		if (npcPatrolParam != null && compNpc != null)
		{
			Animator animator = compNpc.Animator;
			if ((object)animator != null)
			{
				List<Vector3> list = new List<Vector3>(patrolParams.Count);
				for (int i = 0; i < patrolParams.Count; i++)
				{
					NpcPatrolParam npcPatrolParam2 = patrolParams[i]?.Value;
					if (npcPatrolParam2 != null)
					{
						list.Add(npcPatrolParam2.patrolPoint);
					}
				}
				compNpc.SetPatrolPoints(list);
				compNpc.SetCurrentPatrolPointIndex(num);
				int value = animatorState switch
				{
					NpcPatrolAnimatorState.ReachPoint => npcPatrolParam.onReachPointPlayAnimatorStateInt, 
					NpcPatrolAnimatorState.MovingNextPoint => npcPatrolParam.onMovingNextPointPlayAnimatorStateInt, 
					_ => npcPatrolParam.onReachPointPlayAnimatorStateInt, 
				};
				animator.SetInteger(AnimatorState, value);
				return TaskStatus.Success;
			}
		}
		return TaskStatus.Failure;
	}
}
