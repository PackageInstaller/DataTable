using System.Collections.Generic;
using ACT.Battle.Configs;
using Bamboo.ECS;
using BehaviorDesigner.Runtime.Tasks;
using UnityEngine;

namespace ACT.Battle;

[TaskCategory("ACT")]
[TaskDescription("执行行为并更新到对应行为列表中的数据")]
public class DoAIBehaviour : Action
{
	public SharedAIBehaviourList allBehaviourList;

	private Entity m_Entity;

	private string committedActionName;

	public override void OnStart()
	{
		m_Entity = ((ActBehaviorTree)Owner).Entity;
		if (!m_Entity.IsValid || !m_Entity.GetCompAI().TryCommitAttackRequest(out var request))
		{
			committedActionName = string.Empty;
			return;
		}
		committedActionName = request.behaviourName;
		AIBehaviourData aIBehaviourData = allBehaviourList.Value.Find((AIBehaviourData item) => item.name == committedActionName);
		if (aIBehaviourData != null)
		{
			aIBehaviourData.lastTime = Time.time;
		}
		CompMotion? compMotion = m_Entity.GetCompMotion();
		compMotion.SetBool(committedActionName, b: true);
		compMotion.SetTrigger("UseSkill");
		m_Entity.GetCompAI().behaviorDepth = 0;
	}

	public override TaskStatus OnUpdate()
	{
		if (string.IsNullOrEmpty(committedActionName))
		{
			return TaskStatus.Failure;
		}
		CompMotion compMotion = m_Entity.GetCompMotion();
		compMotion.parameters.TryGetValue("UseSkill", out var value);
		if (!value.defaultBool && compMotion.curMotionState != MotionState.Attack)
		{
			return TaskStatus.Success;
		}
		if (compMotion.curMotionState == MotionState.Hit)
		{
			m_Entity.ResetTrigger("UseSkill");
			return TaskStatus.Success;
		}
		compMotion.SetBool(committedActionName, b: true);
		return TaskStatus.Running;
	}

	public override void OnEnd()
	{
		if (string.IsNullOrEmpty(committedActionName))
		{
			return;
		}
		m_Entity.GetCompMotion().SetBool(committedActionName, b: false);
		m_Entity.GetCompAI().ReleaseAttackBody(committedActionName);
		List<AIBehaviourData> list = allBehaviourList?.Value;
		if (list != null)
		{
			for (int i = 0; i < list.Count; i++)
			{
				AIBehaviourData aIBehaviourData = list[i];
				if (aIBehaviourData?.name != committedActionName)
				{
					continue;
				}
				aIBehaviourData.lastTime = Time.time;
				if (m_Entity.IsValid)
				{
					CompAI compAI = m_Entity.GetCompAI();
					if (compAI != null)
					{
						compAI.lastAttackTime = aIBehaviourData.lastTime;
					}
				}
			}
		}
		committedActionName = string.Empty;
	}
}
