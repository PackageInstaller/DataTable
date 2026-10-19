using UnityEngine;
using UnityEngine.Serialization;

namespace Cinemachine;

[AddComponentMenu("")]
[DocumentationSorting(DocumentationSortingAttribute.Level.UserRef)]
[SaveDuringPlay]
public class CinemachineSameAsFollowTarget : CinemachineComponentBase
{
	[Tooltip("How much time it takes for the aim to catch up to the target's rotation")]
	[FormerlySerializedAs("m_AngularDamping")]
	public float m_Damping;

	private Quaternion m_PreviousReferenceOrientation = Quaternion.identity;

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

	public override CinemachineCore.Stage Stage => CinemachineCore.Stage.Aim;

	public override float GetMaxDampTime()
	{
		return m_Damping;
	}

	public override void MutateCameraState(ref CameraState curState, float deltaTime)
	{
		if (IsValid)
		{
			Quaternion quaternion = FollowTargetRotation;
			if (deltaTime >= 0f)
			{
				float t = VirtualCamera.DetachedFollowTargetDamp(1f, m_Damping, deltaTime);
				quaternion = Quaternion.Slerp(m_PreviousReferenceOrientation, FollowTargetRotation, t);
			}
			m_PreviousReferenceOrientation = quaternion;
			curState.RawOrientation = quaternion;
		}
	}
}
