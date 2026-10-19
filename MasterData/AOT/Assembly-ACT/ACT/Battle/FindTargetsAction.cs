using System.Collections.Generic;
using ACT.MultiPlayer;
using Bamboo.ECS;
using BehaviorDesigner.Runtime.Tasks;
using UnityEngine;

namespace ACT.Battle;

[TaskCategory("ACT/待修改")]
[TaskDescription("检查在自己【min。max】范围的所有敌人 返回一个Entity列表")]
public class FindTargetsAction : Action
{
	public float minDis;

	public float maxDis;

	public SharedEntityList tagerts;

	public SharedEntityIdList uidList;

	private float m_distanceMinSqr;

	private float m_distanceMaxSqr;

	public override void OnStart()
	{
		m_distanceMinSqr = Mathf.Pow(minDis, 2f);
		m_distanceMaxSqr = Mathf.Pow(maxDis, 2f);
		if (tagerts.Value == null)
		{
			tagerts.Value = new List<Entity>();
			uidList.Value = new List<EntityId>();
		}
		else
		{
			tagerts.Value.Clear();
			uidList.Value.Clear();
		}
	}

	public override TaskStatus OnUpdate()
	{
		MonoECS instance = MonoECS.instance;
		Vector3 physicsPosition = ((ActBehaviorTree)Owner).Entity.GetCompTransform().physicsPosition;
		MPPlayer localPlayer = instance.localPlayer;
		if (!localPlayer.battleEntity.IsValid)
		{
			return TaskStatus.Success;
		}
		Entity battleEntity = localPlayer.battleEntity;
		float sqrMagnitude = (battleEntity.GetCompTransform().physicsPosition - physicsPosition).sqrMagnitude;
		if (!(sqrMagnitude >= m_distanceMinSqr) || !(sqrMagnitude <= m_distanceMaxSqr))
		{
			return TaskStatus.Success;
		}
		tagerts.Value.Add(battleEntity);
		uidList.Value.Add(battleEntity.Id);
		return TaskStatus.Success;
	}
}
