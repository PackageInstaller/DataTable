using Cinemachine.Utility;
using UnityEngine;

namespace Cinemachine;

[AddComponentMenu("")]
[SaveDuringPlay]
public class Cinemachine3rdPersonFollow : CinemachineComponentBase
{
	[Tooltip("How responsively the camera tracks the target.  Each axis (camera-local) can have its own setting.  Value is the approximate time it takes the camera to catch up to the target's new position.  Smaller values give a more rigid effect, larger values give a squishier one")]
	public Vector3 Damping;

	[Header("Rig")]
	[Tooltip("Position of the shoulder pivot relative to the Follow target origin.  This offset is in target-local space")]
	public Vector3 ShoulderOffset;

	[Tooltip("Vertical offset of the hand in relation to the shoulder.  Arm length will affect the follow target's screen position when the camera rotates vertically")]
	public float VerticalArmLength;

	[Range(0f, 1f)]
	[Tooltip("Specifies which shoulder (left, right, or in-between) the camera is on")]
	public float CameraSide;

	[Tooltip("How far behind the hand the camera will be placed")]
	public float CameraDistance;

	[Header("Obstacles")]
	[Tooltip("Camera will avoid obstacles on these layers")]
	public LayerMask CameraCollisionFilter;

	[TagField]
	[Tooltip("Obstacles with this tag will be ignored.  It is a good idea to set this field to the target's tag")]
	public string IgnoreTag = string.Empty;

	[Tooltip("Specifies how close the camera can get to obstacles")]
	[Range(0f, 1f)]
	public float CameraRadius;

	[Range(0f, 10f)]
	[Tooltip("How gradually the camera moves to correct for occlusions.  Higher numbers will move the camera more gradually.")]
	public float DampingIntoCollision;

	[Range(0f, 10f)]
	[Tooltip("How gradually the camera returns to its normal position after having been corrected by the built-in collision resolution system.  Higher numbers will move the camera more gradually back to normal.")]
	public float DampingFromCollision;

	private Vector3 m_PreviousFollowTargetPosition;

	private Vector3 m_DampingCorrection;

	private float m_CamPosCollisionCorrection;

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

	private void OnValidate()
	{
		CameraSide = Mathf.Clamp(CameraSide, -1f, 1f);
		Damping.x = Mathf.Max(0f, Damping.x);
		Damping.y = Mathf.Max(0f, Damping.y);
		Damping.z = Mathf.Max(0f, Damping.z);
		CameraRadius = Mathf.Max(0.001f, CameraRadius);
		DampingIntoCollision = Mathf.Max(0f, DampingIntoCollision);
		DampingFromCollision = Mathf.Max(0f, DampingFromCollision);
	}

	private void Reset()
	{
		ShoulderOffset = new Vector3(0.5f, -0.4f, 0f);
		VerticalArmLength = 0.4f;
		CameraSide = 1f;
		CameraDistance = 2f;
		Damping = new Vector3(0.1f, 0.5f, 0.3f);
		CameraCollisionFilter = 0;
		CameraRadius = 0.2f;
		DampingIntoCollision = 0f;
		DampingFromCollision = 2f;
	}

	private void OnDestroy()
	{
		RuntimeUtility.DestroyScratchCollider();
	}

	public override float GetMaxDampTime()
	{
		return Mathf.Max(Mathf.Max(DampingIntoCollision, DampingFromCollision), Mathf.Max(Damping.x, Mathf.Max(Damping.y, Damping.z)));
	}

	public override void MutateCameraState(ref CameraState curState, float deltaTime)
	{
		if (IsValid)
		{
			if (!base.VirtualCamera.PreviousStateIsValid)
			{
				deltaTime = -1f;
			}
			PositionCamera(ref curState, deltaTime);
		}
	}

	public override void OnTargetObjectWarped(Transform target, Vector3 positionDelta)
	{
		base.OnTargetObjectWarped(target, positionDelta);
		if (target == base.FollowTarget)
		{
			m_PreviousFollowTargetPosition += positionDelta;
		}
	}

	private void PositionCamera(ref CameraState curState, float deltaTime)
	{
		Vector3 referenceUp = curState.ReferenceUp;
		Vector3 followTargetPosition = base.FollowTargetPosition;
		Quaternion followTargetRotation = base.FollowTargetRotation;
		Vector3 vector = followTargetRotation * Vector3.forward;
		Quaternion heading = GetHeading(followTargetRotation, referenceUp);
		if (deltaTime < 0f)
		{
			m_DampingCorrection = Vector3.zero;
			m_CamPosCollisionCorrection = 0f;
		}
		else
		{
			m_DampingCorrection += Quaternion.Inverse(heading) * (m_PreviousFollowTargetPosition - followTargetPosition);
			m_DampingCorrection -= base.VirtualCamera.DetachedFollowTargetDamp(m_DampingCorrection, Damping, deltaTime);
		}
		m_PreviousFollowTargetPosition = followTargetPosition;
		Vector3 root = followTargetPosition;
		GetRawRigPositions(root, followTargetRotation, heading, out var _, out var hand);
		Vector3 tip = hand - vector * (CameraDistance - m_DampingCorrection.z);
		float collisionCorrection = 0f;
		Vector3 root2 = ResolveCollisions(root, hand, -1f, CameraRadius * 1.05f, ref collisionCorrection);
		tip = ResolveCollisions(root2, tip, deltaTime, CameraRadius, ref m_CamPosCollisionCorrection);
		curState.RawPosition = tip;
		curState.RawOrientation = followTargetRotation;
	}

	public void GetRigPositions(out Vector3 root, out Vector3 shoulder, out Vector3 hand)
	{
		Vector3 referenceUp = base.VirtualCamera.State.ReferenceUp;
		Quaternion followTargetRotation = base.FollowTargetRotation;
		Quaternion heading = GetHeading(followTargetRotation, referenceUp);
		root = m_PreviousFollowTargetPosition;
		GetRawRigPositions(root, followTargetRotation, heading, out shoulder, out hand);
		float collisionCorrection = 0f;
		hand = ResolveCollisions(root, hand, -1f, CameraRadius * 1.05f, ref collisionCorrection);
	}

	internal static Quaternion GetHeading(Quaternion targetRot, Vector3 up)
	{
		Vector3 vector = targetRot * Vector3.forward;
		Vector3 vector2 = Vector3.Cross(up, Vector3.Cross(vector.ProjectOntoPlane(up), up));
		if (vector2.AlmostZero())
		{
			vector2 = Vector3.Cross(targetRot * Vector3.right, up);
		}
		return Quaternion.LookRotation(vector2, up);
	}

	private void GetRawRigPositions(Vector3 root, Quaternion targetRot, Quaternion heading, out Vector3 shoulder, out Vector3 hand)
	{
		Vector3 shoulderOffset = ShoulderOffset;
		shoulderOffset.x = Mathf.Lerp(0f - shoulderOffset.x, shoulderOffset.x, CameraSide);
		shoulderOffset.x += m_DampingCorrection.x;
		shoulderOffset.y += m_DampingCorrection.y;
		shoulder = root + heading * shoulderOffset;
		hand = shoulder + targetRot * new Vector3(0f, VerticalArmLength, 0f);
	}

	private Vector3 ResolveCollisions(Vector3 root, Vector3 tip, float deltaTime, float cameraRadius, ref float collisionCorrection)
	{
		if (CameraCollisionFilter.value == 0)
		{
			return tip;
		}
		Vector3 vector = tip - root;
		float magnitude = vector.magnitude;
		if (magnitude < 0.0001f)
		{
			return tip;
		}
		vector /= magnitude;
		Vector3 result = tip;
		float num = 0f;
		if (RuntimeUtility.SphereCastIgnoreTag(root, cameraRadius, vector, out var hitInfo, magnitude, CameraCollisionFilter, in IgnoreTag))
		{
			num = (((RaycastHit)(ref hitInfo)).point + ((RaycastHit)(ref hitInfo)).normal * cameraRadius - tip).magnitude;
		}
		collisionCorrection += ((deltaTime < 0f) ? (num - collisionCorrection) : Damper.Damp(num - collisionCorrection, (num > collisionCorrection) ? DampingIntoCollision : DampingFromCollision, deltaTime));
		if (collisionCorrection > 0.0001f)
		{
			result -= vector * collisionCorrection;
		}
		return result;
	}
}
