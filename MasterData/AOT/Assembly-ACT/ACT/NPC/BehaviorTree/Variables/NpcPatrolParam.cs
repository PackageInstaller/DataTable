using System;
using System.Collections.Generic;
using ACT.NPC.BehaviorTree.Variables.BehaviorTreeAction;
using UnityEngine;

namespace ACT.NPC.BehaviorTree.Variables;

[Serializable]
public class NpcPatrolParam
{
	[BehaviorTreeLabel("巡逻点")]
	public Vector3 patrolPoint;

	[BehaviorTreeLabel("到达距离")]
	public float reachDistance = 0.5f;

	[BehaviorTreeLabel("等待时间")]
	public float waitTime = 3f;

	[BehaviorTreeLabel("到达点位动画状态")]
	public int onReachPointPlayAnimatorStateInt;

	[BehaviorTreeLabel("前往下一点动画状态")]
	public int onMovingNextPointPlayAnimatorStateInt;

	[BehaviorTreeActionList("到达巡逻点要做的Action (按照顺序不等待执行)")]
	public List<BehaviorActionWrap> reachActions = new List<BehaviorActionWrap>();
}
