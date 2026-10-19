using ACT.MultiPlayer;
using Bamboo.ECS;
using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;
using UnityEngine;

namespace ACT.Battle;

[TaskCategory("ACT/废弃节点")]
[TaskDescription("backMoveDistances==-1,后退Ai结点会一直运行,需要依赖其他节点来打断, 使用节点的前提是状态机参数里面有'move_back'这个Boolean参数 ")]
public class BackMove : Action
{
	private Entity m_Entity;

	public SharedFloat backMoveDistances = 5f;

	private Vector3 startPos;

	public SharedFloat leftHorizontalStopRange = 0.15f;

	public SharedFloat rightHorizontalStopRange = 0.15f;

	public override void OnStart()
	{
		m_Entity = (Owner as ActBehaviorTree).Entity;
		m_Entity.SetBool("move_back", value: true);
		m_Entity.SetBool("Move", value: true);
		startPos = m_Entity.GetCompTransform().physicsPosition;
	}

	public override void OnEnd()
	{
		m_Entity.SetBool("move_back", value: false);
		m_Entity.SetBool("Move", value: false);
	}

	public override TaskStatus OnUpdate()
	{
		if (m_Entity.GetCompPhysics().FrameCollided)
		{
			m_Entity.SetBool("move_back", value: false);
			m_Entity.SetBool("Move", value: false);
			return TaskStatus.Success;
		}
		m_Entity.SetBool("move_back", value: true);
		m_Entity.SetBool("Move", value: true);
		FaceDir faceDir = m_Entity.GetFaceDir();
		CompTransform compTransform = m_Entity.GetCompTransform();
		if ((faceDir == FaceDir.Left && Mathf.Abs(compTransform.physicsPosition.x - startPos.x) - leftHorizontalStopRange.Value > backMoveDistances.Value) || (faceDir == FaceDir.Right && Mathf.Abs(compTransform.physicsPosition.x - startPos.x) - rightHorizontalStopRange.Value > backMoveDistances.Value))
		{
			return TaskStatus.Success;
		}
		return TaskStatus.Running;
	}
}
