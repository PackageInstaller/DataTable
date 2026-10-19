using ACT.Battle.Configs;
using ACT.MultiPlayer;
using ACT.Utility;
using Bamboo.ECS;
using BehaviorDesigner.Runtime.Tasks;
using UnityEngine;

namespace ACT.Battle;

[TaskCategory("ACT/移动节点")]
[TaskDescription("将面向调向指定左右方向")]
public class FaceTo : Action
{
	public bool useMove;

	public bool faceToLeft;

	private Entity m_Entity;

	public override void OnStart()
	{
		m_Entity = ((ActBehaviorTree)Owner).Entity;
		ClearTurnParams();
	}

	public override TaskStatus OnUpdate()
	{
		if (m_Entity.GetCompMotion().curMotionState == MotionState.Hit)
		{
			return TaskStatus.Success;
		}
		AnimationSchema animationSchema = m_Entity.GetConfig().animationSchema;
		if (animationSchema == AnimationSchema.CantTurn || animationSchema == AnimationSchema.LookAtCamera)
		{
			return TaskStatus.Success;
		}
		FaceDir faceDir = ((!faceToLeft) ? FaceDir.Right : FaceDir.Left);
		if (animationSchema == AnimationSchema.LockRotation)
		{
			if (m_Entity.GetFaceDir() == faceDir)
			{
				return TaskStatus.Success;
			}
			SetTurnParams(turning: true);
			return TaskStatus.Running;
		}
		float b = QuaternionUtility.FaceLocalYAngle(faceDir);
		if (Mathf.Approximately(m_Entity.GetCompTransform().physicsRotateDegree, b))
		{
			ClearTurnParams();
			return TaskStatus.Success;
		}
		FaceDir faceDir2 = m_Entity.GetFaceDir();
		if (useMove)
		{
			if (faceDir2 == faceDir)
			{
				ClearTurnParams();
			}
			else
			{
				SetTurnParams(turning: true);
			}
		}
		else
		{
			CompMotion compMotion = m_Entity.GetCompMotion();
			if (faceDir2 != faceDir && compMotion.curMotionState != MotionState.Attack)
			{
				m_Entity.SetFaceLeft(faceToLeft);
				compMotion.layer0Peak.startFaceDir = faceDir;
			}
		}
		return TaskStatus.Running;
	}

	public override void OnEnd()
	{
		m_Entity = ((ActBehaviorTree)Owner).Entity;
		ClearTurnParams();
		if (useMove)
		{
			m_Entity.GetCompNav().manual = false;
			m_Entity.GetCompInput().inputDir = EInputDir.None;
		}
	}

	private void SetTurnParams(bool turning)
	{
		m_Entity.SetBool("turn", turning);
		m_Entity.SetBool("turn_to_left", turning && faceToLeft);
		m_Entity.SetBool("turn_to_right", turning && !faceToLeft);
	}

	private void ClearTurnParams()
	{
		SetTurnParams(turning: false);
	}
}
