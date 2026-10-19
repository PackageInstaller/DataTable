using ACT.MultiPlayer;
using Bamboo.ECS;
using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;
using UnityEngine;

namespace ACT.Battle;

[TaskCategory("ACT/待定要好好想想的")]
[TaskDescription("以我的朝向判断是否有环境阻挡，有阻挡返还success，没有阻挡返还failure, 默认用waist点")]
public class CheckBlockedByFaceDir : Conditional
{
	public bool checkBehind;

	public SharedFloat distance = 0.5f;

	private bool res;

	private Entity m_entity;

	private Vector3 startPoint;

	private Vector3 endPoint;

	public override TaskStatus OnUpdate()
	{
		m_entity = ((ActBehaviorTree)Owner).Entity;
		startPoint = m_entity.GetMono().GetAttachPointPosition(BattleConsts.AIM_ATTACH_POINT);
		endPoint = startPoint;
		FaceDir faceDir = m_entity.GetCompTransform().FaceDir;
		if (checkBehind)
		{
			if (faceDir == FaceDir.Right)
			{
				endPoint.x -= distance.Value;
			}
			else
			{
				endPoint.x += distance.Value;
			}
		}
		else if (faceDir == FaceDir.Right)
		{
			endPoint.x += distance.Value;
		}
		else
		{
			endPoint.x -= distance.Value;
		}
		res = Physics.Raycast(startPoint, endPoint - startPoint, distance.Value, BattleConsts.enviromentMask);
		if (!res)
		{
			return TaskStatus.Failure;
		}
		return TaskStatus.Success;
	}
}
