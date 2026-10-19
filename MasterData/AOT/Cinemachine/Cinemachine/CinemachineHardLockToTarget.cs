using UnityEngine;

namespace Cinemachine;

[AddComponentMenu("")]
[SaveDuringPlay]
[DocumentationSorting(DocumentationSortingAttribute.Level.UserRef)]
public class CinemachineHardLockToTarget : CinemachineComponentBase
{
	[Tooltip("How much time it takes for the position to catch up to the target's position")]
	public float m_Damping;

	private Vector3 m_PreviousTargetPosition;

	public override bool IsValid
	{
		get
		{
			if (enabled)
			{
				return FollowTarget != null;
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
			Vector3 vector = FollowTargetPosition;
			if (deltaTime >= 0f)
			{
				vector = m_PreviousTargetPosition + VirtualCamera.DetachedFollowTargetDamp(vector - m_PreviousTargetPosition, m_Damping, deltaTime);
			}
			m_PreviousTargetPosition = vector;
			curState.RawPosition = vector;
		}
	}
}
