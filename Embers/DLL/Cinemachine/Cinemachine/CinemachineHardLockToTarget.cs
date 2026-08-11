using UnityEngine;

namespace Cinemachine;

[DocumentationSorting(DocumentationSortingAttribute.Level.UserRef)]
[AddComponentMenu("")]
[SaveDuringPlay]
public class CinemachineHardLockToTarget : CinemachineComponentBase
{
	[Tooltip("How much time it takes for the position to catch up to the target's position")]
	public float m_Damping;

	private Vector3 m_PreviousTargetPosition;

	public override bool IsValid
	{
		get
		{
			if (base.enabled)
			{
				return base.FollowTarget != null;
			}
			return false;
		}
	}

	public override CinemachineCore.Stage Stage => CinemachineCore.Stage.Body;

	public override float GetMaxDampTime()
	{
		return m_Damping;
	}

	public override void MutateCameraState(ref CameraState curState, float deltaTime)
	{
		if (IsValid)
		{
			Vector3 vector = base.FollowTargetPosition;
			if (deltaTime >= 0f)
			{
				vector = m_PreviousTargetPosition + base.VirtualCamera.DetachedFollowTargetDamp(vector - m_PreviousTargetPosition, m_Damping, deltaTime);
			}
			m_PreviousTargetPosition = vector;
			curState.RawPosition = vector;
		}
	}
}
