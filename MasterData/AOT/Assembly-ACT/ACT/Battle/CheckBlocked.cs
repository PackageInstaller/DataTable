using Bamboo.ECS;
using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;
using UnityEngine;

namespace ACT.Battle;

[TaskCategory("ACT/待定要好好想想的")]
[TaskDescription(" useOnePoint为False 以我的waist点坐标来判断某个方向的distance内是否有阻挡，有阻挡返还success，没有阻挡返还failure, useOnePoint为True则表示以pointPostion为起点")]
public class CheckBlocked : Conditional
{
	public EInputDir direction;

	public SharedFloat distance;

	public bool useOnePoint;

	public SharedVector3 pointPostion;

	private Entity m_entity;

	public override void OnStart()
	{
		m_entity = ((ActBehaviorTree)Owner).Entity;
	}

	public override TaskStatus OnUpdate()
	{
		if (useOnePoint)
		{
			Vector3 value = pointPostion.Value;
			Vector3 vector = value;
			switch (direction)
			{
			case EInputDir.Left:
				vector.x += distance.Value;
				break;
			case EInputDir.Right:
				vector.x -= distance.Value;
				break;
			case EInputDir.Up:
				vector.y += distance.Value;
				break;
			case EInputDir.Down:
				vector.y -= distance.Value;
				break;
			}
			if (!Physics.Raycast(value, vector, distance.Value, BattleConsts.enviromentMask))
			{
				return TaskStatus.Failure;
			}
			return TaskStatus.Success;
		}
		Vector3 attachPointPosition = m_entity.GetMono().GetAttachPointPosition(BattleConsts.AIM_ATTACH_POINT);
		Vector3 vector2 = attachPointPosition;
		switch (direction)
		{
		case EInputDir.Left:
			vector2.x += distance.Value;
			break;
		case EInputDir.Right:
			vector2.x -= distance.Value;
			break;
		case EInputDir.Up:
			vector2.y += distance.Value;
			break;
		case EInputDir.Down:
			vector2.y -= distance.Value;
			break;
		}
		if (!Physics.Raycast(attachPointPosition, vector2, distance.Value, BattleConsts.enviromentMask))
		{
			return TaskStatus.Failure;
		}
		return TaskStatus.Success;
	}
}
