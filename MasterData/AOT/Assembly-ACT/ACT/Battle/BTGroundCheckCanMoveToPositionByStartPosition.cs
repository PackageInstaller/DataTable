using ACT.Utility;
using Bamboo.ECS;
using BehaviorDesigner.Runtime.Tasks;
using PathFinding2D.Runtime.Models;
using UnityEngine;

namespace ACT.Battle;

[TaskCategory("ACT/移动节点")]
[TaskDescription("地面单位 判断能不能从 起点 走到 终点")]
public class BTGroundCheckCanMoveToPositionByStartPosition : Conditional
{
	public SharedMoveInfoNodeType sharedmoveInfoNodeType;

	private MoveInfoNodeType moveInfoNodeType;

	public override TaskStatus OnUpdate()
	{
		Entity entity = Owner.ToEntity();
		int areaMask = entity.GetCompNav().areaMask;
		CompHatred compHatred = entity.GetCompHatred();
		entity.GetCompNav();
		if (compHatred == null)
		{
			return TaskStatus.Failure;
		}
		CompTransform compTransform = entity.GetCompTransform();
		Vector3 zero = Vector3.zero;
		Vector3 zero2 = Vector3.zero;
		if (sharedmoveInfoNodeType == null)
		{
			moveInfoNodeType = MoveInfoNodeType.ground;
		}
		else
		{
			moveInfoNodeType = sharedmoveInfoNodeType.Value;
		}
		bool flag = false;
		switch (moveInfoNodeType)
		{
		case MoveInfoNodeType.ground:
		case MoveInfoNodeType.ground_but_need_vertical_check_move:
		{
			Entity hatredTarget = compHatred.hatredTarget;
			if (hatredTarget == null)
			{
				return TaskStatus.Failure;
			}
			CompTransform compTransform2 = hatredTarget.GetCompTransform();
			if (compTransform2 == null)
			{
				return TaskStatus.Failure;
			}
			if (hatredTarget.IsValid)
			{
				zero = (zero2 = compTransform.physicsPosition);
				zero.z = (zero2.z = compTransform2.physicsPosition.z);
				zero.x += 0f - compTransform.size.x - 0.1f;
				zero2.x += compTransform.size.x + 0.1f;
				Vector3 physicsPosition = compTransform2.physicsPosition;
				NavigationMoveCapability moveCapability = entity.GetCompNav().moveCapability;
				flag = ((ACTNavMeshAgent.CanNavigateBetween(zero, physicsPosition, areaMask, moveCapability) || ACTNavMeshAgent.CanNavigateBetween(zero2, physicsPosition, areaMask, moveCapability) || ACTNavMeshAgent.CanNavigateBetween(compTransform.physicsPosition, physicsPosition, areaMask, moveCapability)) ? true : false);
			}
			break;
		}
		case MoveInfoNodeType.air:
			flag = true;
			break;
		case MoveInfoNodeType.build:
			flag = true;
			break;
		}
		CompAI compAI = entity.GetCompAI();
		compAI.isInSamePlatform = flag;
		if (moveInfoNodeType == MoveInfoNodeType.ground_but_need_vertical_check_move)
		{
			flag = (byte)((flag ? 1u : 0u) | 1u) != 0;
		}
		if (compAI.HasGroupAIControl(entity))
		{
			if (flag)
			{
				compAI.SetCanAttack(res: true);
			}
			else if (BoolUtility.IsAttackTokenNeedUpdateByNavMesh(entity))
			{
				compAI.SetAttackToken(res: false);
				compAI.SetCanAttack(res: false);
			}
		}
		if (flag)
		{
			return TaskStatus.Success;
		}
		return TaskStatus.Failure;
	}
}
