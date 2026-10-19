using Bamboo.ECS;
using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;
using UnityEngine;

namespace ACT.Battle;

[TaskCategory("ACT/移动")]
[TaskDescription("飞向目标点")]
public class FlyToLocation : Action
{
	public enum FlyType
	{
		ToLocation,
		FollowTarget
	}

	[BehaviorDesigner.Runtime.Tasks.Tooltip("ToLocation代表移动到一个位置，FollowTarget代表跟随仇恨目标")]
	public FlyType flyType;

	[BehaviorDesigner.Runtime.Tasks.Tooltip("ToLocation的位置")]
	public SharedVector3 targetLocation;

	[BehaviorDesigner.Runtime.Tasks.Tooltip("FollowTarget跟随目标的偏移")]
	public SharedVector3 targetOffset;

	[BehaviorDesigner.Runtime.Tasks.Tooltip("是否使用stopRange")]
	public SharedBool useStopRange;

	[BehaviorDesigner.Runtime.Tasks.Tooltip("水平方向x~y的范围")]
	public SharedVector2 horizontalStoppingRange;

	[BehaviorDesigner.Runtime.Tasks.Tooltip("竖直方向x~y的范围")]
	public SharedVector2 verticalStoppingRange;

	private Entity m_Entity;

	private Vector3 m_TargetPos;

	private Vector3 m_FixedTargetPos;

	private Vector3 m_Offset;

	public override void OnStart()
	{
		m_Entity = ((ActBehaviorTree)Owner).Entity;
	}

	public override TaskStatus OnUpdate()
	{
		m_TargetPos = ((flyType == FlyType.FollowTarget) ? (m_Entity.GetCompHatred().hatredTarget.GetCompTransform().physicsPosition + targetOffset.Value) : targetLocation.Value);
		CompTransform compTransform = m_Entity.GetCompTransform();
		if (useStopRange.Value)
		{
			m_Offset = compTransform.physicsPosition - m_TargetPos;
			int num = ((m_Offset.x > 0f) ? 1 : (-1));
			m_Offset.x = (float)num * Mathf.Clamp(Mathf.Abs(m_Offset.x), horizontalStoppingRange.Value.x, horizontalStoppingRange.Value.y);
			m_Offset.y = Mathf.Clamp(m_Offset.y, verticalStoppingRange.Value.x, verticalStoppingRange.Value.y);
			m_FixedTargetPos = m_TargetPos + m_Offset;
		}
		else
		{
			m_FixedTargetPos = m_TargetPos;
		}
		CompNav compNav = m_Entity.GetCompNav();
		if (!m_Entity.GetCompAI().TryCommitCombatMoveDestination(compNav, m_FixedTargetPos, "FlyToLocation"))
		{
			m_Entity.GetCompInput().dir = Vector3.zero;
			return TaskStatus.Success;
		}
		if (compNav.isArrived)
		{
			return TaskStatus.Success;
		}
		m_Entity.GetCompInput().dir = (m_FixedTargetPos - compTransform.physicsPosition).normalized;
		return TaskStatus.Running;
	}
}
