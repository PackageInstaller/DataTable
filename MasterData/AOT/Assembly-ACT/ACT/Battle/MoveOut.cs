using Bamboo.ECS;
using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;
using UnityEngine;

namespace ACT.Battle;

[TaskCategory("ACT/移动")]
public class MoveOut : Action
{
	public enum OutMoveType
	{
		MainEntityPos,
		hatredTargetPos,
		MonsterInfoPos,
		ContextPoint
	}

	public OutMoveType endPostype;

	public string MonsterInfoPosName;

	public SharedInt contextIndex;

	private Vector3 targetPos;

	private Entity m_Entity;

	private CompAI m_CompAI;

	private CompHatred m_CompHatred;

	private CompPhysics m_CompPhysics;

	private CompTransform m_CompTransform;

	public override void OnStart()
	{
		m_Entity = Owner.ToEntity();
		m_CompAI = m_Entity.GetCompAI();
		m_CompHatred = m_Entity.GetCompHatred();
		m_CompPhysics = m_Entity.GetCompPhysics();
		m_CompTransform = m_Entity.GetCompTransform();
		CompTransform compTransform = MonoECS.instance.mainEntity.GetCompTransform();
		switch (endPostype)
		{
		case OutMoveType.hatredTargetPos:
			targetPos = m_Entity.GetCompHatred().hatredTarget.GetCompTransform().physicsPosition;
			break;
		case OutMoveType.MonsterInfoPos:
		{
			for (int i = 0; i < m_CompAI.infoPosNames.Count; i++)
			{
				if (m_CompAI.infoPosNames[i] == MonsterInfoPosName)
				{
					targetPos = m_CompAI.infoPos[i];
				}
			}
			break;
		}
		case OutMoveType.ContextPoint:
			if (MonoECS.instance.aiContextManager.FindContext(contextIndex.Value) == null)
			{
				targetPos = MonoECS.instance.aiContextManager.FindContext(contextIndex.Value).transform.position;
			}
			else
			{
				targetPos = compTransform.physicsPosition;
			}
			break;
		default:
			targetPos = compTransform.physicsPosition;
			break;
		}
	}

	public override void OnEnd()
	{
		m_Entity.SetBool("move_out", value: false);
		m_CompPhysics.SetConstrainInPlane(constrain: true);
	}

	public override TaskStatus OnUpdate()
	{
		m_CompPhysics.SetConstrainInPlane(constrain: false);
		m_Entity.SetBool("move_out", value: true);
		if (m_CompPhysics.FrameCollided)
		{
			m_Entity.SetBool("move_out", value: false);
			m_CompPhysics.SetConstZ(targetPos.z);
			m_CompPhysics.SetConstrainInPlane(constrain: true);
			return TaskStatus.Success;
		}
		if (Mathf.Abs(m_CompTransform.physicsPosition.z - targetPos.z) < 0.3f)
		{
			m_Entity.SetBool("move_out", value: false);
			m_CompPhysics.SetConstZ(targetPos.z);
			m_CompPhysics.SetConstrainInPlane(constrain: true);
			return TaskStatus.Success;
		}
		return TaskStatus.Running;
	}
}
