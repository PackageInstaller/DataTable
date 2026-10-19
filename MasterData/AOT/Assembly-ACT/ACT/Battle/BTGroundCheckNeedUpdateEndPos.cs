using ACT.Utility;
using Bamboo.ECS;
using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;
using UnityEngine;

namespace ACT.Battle;

[TaskCategory("ACT/移动节点")]
[TaskDescription("判断需不需要更新 终点位置")]
public class BTGroundCheckNeedUpdateEndPos : Conditional
{
	public SharedMoveInfoNodeType sharedMoveInfoNodeType;

	private MoveInfoNodeType moveInfoNodeType;

	public SharedGroundEnemyUpdatePos attackToken;

	public SharedGroundEnemyUpdatePos noAttackToken;

	public SharedGroundEnemyUpdatePos attackTokenNoSamePlatform;

	public SharedGroundEnemyUpdatePos noAttackTokenNoSamePlatform;

	[SharedRequired]
	public SharedVector3 pos1;

	[SharedRequired]
	public SharedVector3 pos2;

	public SharedBool boolvalue;

	public override void OnStart()
	{
	}

	public override TaskStatus OnUpdate()
	{
		Entity entity = Owner.ToEntity();
		CompAI compAI = entity.GetCompAI();
		CompHatred compHatred = entity.GetCompHatred();
		if (compHatred == null)
		{
			return TaskStatus.Failure;
		}
		CompTransform compTransform = entity.GetCompTransform();
		entity.GetCompNav();
		if (sharedMoveInfoNodeType == null)
		{
			moveInfoNodeType = MoveInfoNodeType.ground;
		}
		else
		{
			moveInfoNodeType = sharedMoveInfoNodeType.Value;
		}
		compAI.SetCanAttack(res: true);
		if (!compHatred.GetHatred().IsValid)
		{
			return TaskStatus.Failure;
		}
		bool needuseHoldDis = false;
		if (boolvalue != null)
		{
			needuseHoldDis = boolvalue.Value;
		}
		Vector3 pos = ((pos1 != null || !pos1.IsShared || !(pos1.Name != "")) ? pos1.Value : compTransform.physicsPosition);
		Vector3 pos2 = ((this.pos2 != null || !this.pos2.IsShared || !(this.pos2.Name != "")) ? this.pos2.Value : compTransform.physicsPosition);
		bool isInSamePlatform = compAI.isInSamePlatform;
		if (compAI.HasAttackToken())
		{
			bool flag;
			bool flag2;
			bool flag3;
			if (moveInfoNodeType == MoveInfoNodeType.ground_but_need_vertical_check_move && !isInSamePlatform)
			{
				flag = CheckDisNeedUpdate(compHatred, attackTokenNoSamePlatform.Value, needuseHoldDis);
				flag2 = CheckDisNeedUpdate(compHatred, attackTokenNoSamePlatform.Value, needuseHoldDis, needCheckPos: true, pos);
				flag3 = CheckDisNeedUpdate(compHatred, attackTokenNoSamePlatform.Value, needuseHoldDis, needCheckPos: true, pos2);
			}
			else
			{
				flag = CheckDisNeedUpdate(compHatred, attackToken.Value, needuseHoldDis);
				flag2 = CheckDisNeedUpdate(compHatred, attackToken.Value, needuseHoldDis, needCheckPos: true, pos);
				flag3 = CheckDisNeedUpdate(compHatred, attackToken.Value, needuseHoldDis, needCheckPos: true, pos2);
			}
			if (flag && (flag2 | flag3))
			{
				return TaskStatus.Success;
			}
		}
		else
		{
			bool flag;
			bool flag2;
			bool flag3;
			if (moveInfoNodeType == MoveInfoNodeType.ground_but_need_vertical_check_move && !isInSamePlatform)
			{
				flag = CheckDisNeedUpdate(compHatred, noAttackTokenNoSamePlatform.Value, needuseHoldDis);
				flag2 = CheckDisNeedUpdate(compHatred, noAttackTokenNoSamePlatform.Value, needuseHoldDis, needCheckPos: true, pos);
				flag3 = CheckDisNeedUpdate(compHatred, noAttackTokenNoSamePlatform.Value, needuseHoldDis, needCheckPos: true, pos2);
			}
			else
			{
				flag = CheckDisNeedUpdate(compHatred, noAttackToken.Value, needuseHoldDis);
				flag2 = CheckDisNeedUpdate(compHatred, noAttackToken.Value, needuseHoldDis, needCheckPos: true, pos);
				flag3 = CheckDisNeedUpdate(compHatred, noAttackToken.Value, needuseHoldDis, needCheckPos: true, pos2);
			}
			if (flag && (flag2 | flag3))
			{
				return TaskStatus.Success;
			}
		}
		return TaskStatus.Failure;
	}

	public bool CheckDisNeedUpdate(CompHatred compHatred, GroundEnemyUpdatePos papra, bool needuseHoldDis = false, bool needCheckPos = false, Vector3 pos = default(Vector3))
	{
		bool result = false;
		float num;
		float num2;
		if (needuseHoldDis)
		{
			num = papra.groundMinHoldDis;
			num2 = papra.groundMaxHoldDis;
		}
		else
		{
			num = papra.groundMinUpdateDis;
			num2 = papra.groundMaxUpdateDis;
		}
		if (needCheckPos)
		{
			compHatred.GetHatredTargetPos(out var pos2);
			bool flag = BoolUtility.IsBetweenApprox(pos.x, pos2.x + num, pos2.x + num2);
			bool flag2 = BoolUtility.IsBetweenApprox(pos.x, pos2.x - num, pos2.x - num2);
			result = !(flag | flag2);
		}
		else
		{
			float distanceBetweenMeAndHatredTarget = compHatred.GetDistanceBetweenMeAndHatredTarget(DistanceType.horizontalAddColliderRadius);
			if (distanceBetweenMeAndHatredTarget < num || distanceBetweenMeAndHatredTarget > num2)
			{
				result = true;
			}
		}
		return result;
	}
}
