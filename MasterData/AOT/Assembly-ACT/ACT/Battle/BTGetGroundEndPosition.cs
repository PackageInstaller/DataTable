using Bamboo.ECS;
using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;
using UnityEngine;

namespace ACT.Battle;

[TaskCategory("ACT/移动节点")]
[TaskDescription("地面单位 基于仇恨目标从范围内获取终点")]
public class BTGetGroundEndPosition : Action
{
	public SharedMoveInfoNodeType sharedMoveInfoNodeType;

	private MoveInfoNodeType moveInfoNodeType;

	public SharedGroundEnemyUpdatePos attackToken;

	public SharedGroundEnemyUpdatePos noAttackToken;

	public SharedGroundEnemyUpdatePos attackTokenNoSamePlatform;

	public SharedGroundEnemyUpdatePos noAttackTokenNoSamePlatform;

	[SharedRequired]
	public SharedVector3 leftEndPos;

	[SharedRequired]
	public SharedVector3 rightEndPos;

	public override TaskStatus OnUpdate()
	{
		Entity entity = Owner.ToEntity();
		CompHatred compHatred = entity.GetCompHatred();
		if (!compHatred.GetHatred().IsValid)
		{
			return TaskStatus.Success;
		}
		if (sharedMoveInfoNodeType == null)
		{
			moveInfoNodeType = MoveInfoNodeType.ground;
		}
		else
		{
			moveInfoNodeType = sharedMoveInfoNodeType.Value;
		}
		CompAI? compAI = entity.GetCompAI();
		bool flag = compAI.HasAttackToken();
		bool isInSamePlatform = compAI.isInSamePlatform;
		CompNav compNav = entity.GetCompNav();
		Vector3 vLeft;
		Vector3 vRight;
		if (flag)
		{
			if (!isInSamePlatform && moveInfoNodeType == MoveInfoNodeType.ground_but_need_vertical_check_move)
			{
				GetEndPos(compNav, compHatred, attackTokenNoSamePlatform.Value, out vLeft, out vRight);
			}
			else
			{
				GetEndPos(compNav, compHatred, attackToken.Value, out vLeft, out vRight);
			}
		}
		else if (!isInSamePlatform && moveInfoNodeType == MoveInfoNodeType.ground_but_need_vertical_check_move)
		{
			GetEndPos(compNav, compHatred, noAttackTokenNoSamePlatform.Value, out vLeft, out vRight);
		}
		else
		{
			GetEndPos(compNav, compHatred, noAttackToken.Value, out vLeft, out vRight);
		}
		leftEndPos.Value = vLeft;
		rightEndPos.Value = vRight;
		return TaskStatus.Success;
	}

	private void GetEndPos(CompNav compNav, CompHatred compHatred, GroundEnemyUpdatePos para, out Vector3 vLeft, out Vector3 vRight)
	{
		int num = 1;
		float num2;
		do
		{
			num2 = Random.Range(para.groundMinHoldDis, para.groundMaxHoldDis);
			num++;
		}
		while (num2 < (para.groundMaxHoldDis - para.groundMinHoldDis) / 3f || num < 10);
		num2 += compNav.sqrStoppingDistance;
		compHatred.GetHatredTargetPos(out var pos);
		vLeft = pos;
		vLeft.x -= num2;
		vRight = pos;
		vRight.x += num2;
	}
}
