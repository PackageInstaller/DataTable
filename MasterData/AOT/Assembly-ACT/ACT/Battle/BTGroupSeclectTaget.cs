using System;
using System.Collections.Generic;
using System.Linq;
using ACT.Battle.Configs;
using Bamboo.ECS;
using BehaviorDesigner.Runtime.Tasks;
using UnityEngine;
using UnityEngine.AI;

namespace ACT.Battle;

[TaskCategory("ACT/Group")]
[TaskDescription("筛选出目标target")]
public class BTGroupSeclectTaget : BehaviorDesigner.Runtime.Tasks.Action
{
	public enum SortMode
	{
		none,
		distance,
		lastAttackTime
	}

	public enum OrderMode
	{
		asc,
		desc,
		random
	}

	[Flags]
	public enum FilterMode
	{
		isAttackable = 2,
		harted = 4,
		characterType = 8,
		monsterAttackType = 0x10
	}

	public SortMode sortMode;

	public OrderMode orderMode;

	[FlagsEnum]
	public FilterMode filterMode;

	public MonsterAttackType[] monsterAttackTypes;

	public EntityType[] entityTypes;

	[BehaviorDesigner.Runtime.Tasks.Tooltip("结果返回的entity")]
	[SharedRequired]
	public SharedEntity outResultEntity;

	public override TaskStatus OnUpdate()
	{
		Sort();
		if (!(outResultEntity.Value != null))
		{
			return TaskStatus.Failure;
		}
		return TaskStatus.Success;
	}

	private void Sort()
	{
		List<Entity> list = (Owner as ActBehaviorTree).Entity.GetCompGroupAI().GetChildrenEntity().ToList();
		for (int num = list.Count - 1; num >= 0; num--)
		{
			Entity entity = list[num];
			if (filterMode.HasFlag(FilterMode.harted))
			{
				CompHatred compHatred = entity.GetCompHatred();
				if (compHatred == null || compHatred.hatredTarget.IsValid)
				{
					list.RemoveAt(num);
					continue;
				}
			}
			if (filterMode.HasFlag(FilterMode.characterType) && entityTypes.Contains(entity.GetEntityType()))
			{
				list.RemoveAt(num);
			}
			else if (filterMode.HasFlag(FilterMode.monsterAttackType) && !monsterAttackTypes.Contains(entity.GetConfig().MonsterAttackType))
			{
				list.RemoveAt(num);
			}
			else if (filterMode.HasFlag(FilterMode.isAttackable) && (entity.GetCompMotion().curMotionState == MotionState.Hit || entity.GetCompNav().pathStatus != NavMeshPathStatus.PathComplete))
			{
				list.RemoveAt(num);
			}
		}
		if (list.Count == 0)
		{
			outResultEntity.Value = default;
			return;
		}
		if (list.Count == 1)
		{
			outResultEntity.Value = list[0];
		}
		Entity mainEntity = MonoECS.instance.mainEntity;
		if (orderMode == OrderMode.random)
		{
			outResultEntity.Value = list[UnityEngine.Random.Range(0, list.Count)];
		}
		else
		{
			switch (sortMode)
			{
			case SortMode.distance:
			{
				Vector3 mainCharacterMovementPos = mainEntity.GetCompPhysics().characterMovement.position;
				list.Sort((Entity a, Entity b) =>
				{
					a.GetCompPhysics();
					b.GetCompPhysics();
					Vector3 position = a.GetCompPhysics().characterMovement.position;
					Vector3 position2 = b.GetCompPhysics().characterMovement.position;
					float num2 = Vector3.SqrMagnitude(position - mainCharacterMovementPos);
					float value = Vector3.SqrMagnitude(position2 - mainCharacterMovementPos);
					return ((orderMode == OrderMode.asc) ? 1 : (-1)) * num2.CompareTo(value);
				});
				break;
			}
			case SortMode.lastAttackTime:
				list.Sort((Entity a, Entity b) =>
				{
					float lastAttackTime = a.GetCompAI().lastAttackTime;
					float lastAttackTime2 = b.GetCompAI().lastAttackTime;
					return lastAttackTime.CompareTo(lastAttackTime2);
				});
				break;
			}
		}
		outResultEntity.Value = list[0];
	}
}
