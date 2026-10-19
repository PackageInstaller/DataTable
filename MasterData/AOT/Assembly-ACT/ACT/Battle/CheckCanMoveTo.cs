using System;
using ACT.Utility;
using Bamboo.ECS;
using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;

namespace ACT.Battle;

[Obsolete]
[TaskCategory("ACT/移动节点")]
[TaskDescription("判定能否能从自身位置移动到B点,寻路成功返还success，寻路失败返还failure。startUsePointA==True则是 AB两点的寻路判断")]
public class CheckCanMoveTo : Conditional
{
	public SharedBool startUsePointA = false;

	public SharedVector3 posA;

	public SharedVector3 posB;

	public override TaskStatus OnUpdate()
	{
		Entity entity = Owner.ToEntity();
		CompNav compNav = entity.GetCompNav();
		CompAI compAI = entity.GetCompAI();
		if (entity.GetConfig().motionType == MotionType.Air)
		{
			return TaskStatus.Failure;
		}
		if (!startUsePointA.Value)
		{
			posA.Value = entity.GetCompTransform().physicsPosition;
		}
		if (ACTNavMeshAgent.CanNavigateBetween(posA.Value, posB.Value, compNav.areaMask, compNav.moveCapability))
		{
			return TaskStatus.Success;
		}
		if (compAI.HasAttackToken() && BoolUtility.IsAttackTokenNeedUpdateByNavMesh(entity))
		{
			compAI.SetAttackToken(res: false);
		}
		return TaskStatus.Failure;
	}
}
