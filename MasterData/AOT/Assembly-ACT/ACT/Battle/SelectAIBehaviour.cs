using System;
using System.Collections.Generic;
using ACT.Battle.Configs;
using Bamboo.ECS;
using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;
using UnityEngine;

namespace ACT.Battle;

[TaskCategory("ACT")]
[TaskDescription("从一批行为中选择一个可以执行的行为")]
public class SelectAIBehaviour : BehaviorDesigner.Runtime.Tasks.Action
{
	public SharedAIBehaviourList allBehaviourList;

	public SharedAIBehaviourList canDoBehaviourList;

	public SharedInt priority;

	private List<AIBehaviourData> intersection = new List<AIBehaviourData>();

	private int index = -1;

	private Entity m_entity;

	private AIBehaviourData action;

	public override void OnAwake()
	{
		base.OnAwake();
		action = new AIBehaviourData();
		if (canDoBehaviourList.Value == null)
		{
			canDoBehaviourList.Value = new List<AIBehaviourData>();
		}
	}

	public override void OnStart()
	{
		base.OnStart();
		m_entity = ((ActBehaviorTree)Owner).Entity;
		intersection.Clear();
		index = -1;
		if (allBehaviourList.Value == null || canDoBehaviourList.Value == null)
		{
			return;
		}
		foreach (AIBehaviourData sharedEntityB in allBehaviourList.Value)
		{
			if (sharedEntityB == null || canDoBehaviourList.Value.Find((AIBehaviourData item) => item?.name == sharedEntityB.name) == null)
			{
				continue;
			}
			if (sharedEntityB.weight == 0f || !sharedEntityB.parameterFlag.HasFlag(SubTaskParameterFlag.weight))
			{
				m_entity.GetCompAI().SubmitAttackRequest(sharedEntityB, "SelectAIBehaviour", priority.Value);
				allBehaviourList.Value.Find((AIBehaviourData item) => item.name == sharedEntityB.name).lastTime = Time.time;
				return;
			}
			intersection.Add(sharedEntityB);
		}
		intersection.Sort((AIBehaviourData a, AIBehaviourData b) => a.weight.CompareTo(b.weight));
		float num = 0f;
		foreach (AIBehaviourData item in intersection)
		{
			num += item.weight;
		}
		float num2 = UnityEngine.Random.Range(0f, num);
		float num3 = 0f;
		for (int num4 = 0; num4 < intersection.Count; num4++)
		{
			num3 += intersection[num4].weight;
			if (num2 <= num3)
			{
				index = num4;
				break;
			}
		}
		if (index < 0 || intersection.Count <= 0)
		{
			return;
		}
		m_entity.GetCompAI().SubmitAttackRequest(intersection[index], "SelectAIBehaviour", priority.Value);
		intersection[index].lastTime = Time.time;
		allBehaviourList.Value.Find((AIBehaviourData item) => item.name == intersection[index].name).lastTime = Time.time;
		int num5 = 0;
		for (int num6 = 0; num6 < allBehaviourList.Value.Count; num6++)
		{
			if (allBehaviourList.Value[num6].name == intersection[index].name)
			{
				allBehaviourList.Value[num6].lastTime = Time.time;
				num5 = num6;
				break;
			}
		}
		if (!(allBehaviourList.Value[num5].decoratorCondition != null) || allBehaviourList.Value[num5].decoratorCondition.configAction == null)
		{
			return;
		}
		ActionMemory memory = new ActionMemory(m_entity, m_entity, m_entity);
		try
		{
			allBehaviourList.Value[num5].decoratorCondition.configAction.Do(memory);
		}
		catch (Exception)
		{
			_ = LuminApplication.LogEnabled;
		}
	}

	public override void OnEnd()
	{
		base.OnEnd();
		intersection.Clear();
	}

	public override TaskStatus OnUpdate()
	{
		if (!m_entity.GetCompAI().HasPendingAttackRequest())
		{
			return TaskStatus.Failure;
		}
		return TaskStatus.Success;
	}
}
