using UnityEngine.Bindings;

namespace UnityEngine;

[NativeHeader("Modules/Animation/Animator.h")]
public struct MatchTargetWeightMask(Vector3 positionXYZWeight, float rotationWeight)
{
	private Vector3 m_PositionXYZWeight = positionXYZWeight;

	private float m_RotationWeight = rotationWeight;
}
