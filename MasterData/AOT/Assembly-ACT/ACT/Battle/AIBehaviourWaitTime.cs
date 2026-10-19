using Bamboo.ECS;
using BehaviorDesigner.Runtime.Tasks;
using UnityEngine;

namespace ACT.Battle;

public class AIBehaviourWaitTime : Action
{
	public SharedAIBehaviourList allBehaviourList;

	private Entity m_Entity;

	public float realWaitTime;

	public override void OnStart()
	{
		m_Entity = ((ActBehaviorTree)Owner).Entity;
		AIAttackRequest lastCommittedAttackRequest = m_Entity.GetCompAI().lastCommittedAttackRequest;
		realWaitTime = (lastCommittedAttackRequest.isValid ? lastCommittedAttackRequest.waitTime : 0f);
	}

	public override TaskStatus OnUpdate()
	{
		if (realWaitTime <= 0f)
		{
			return TaskStatus.Success;
		}
		realWaitTime -= Time.deltaTime;
		return TaskStatus.Running;
	}
}
