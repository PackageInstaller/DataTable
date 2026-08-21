using Cinemachine.Utility;
using UnityEngine;

namespace Cinemachine;

[DocumentationSorting(DocumentationSortingAttribute.Level.UserRef)]
[AddComponentMenu("")]
[SaveDuringPlay]
public class CinemachineTransposer : CinemachineComponentBase
{
	[DocumentationSorting(DocumentationSortingAttribute.Level.UserRef)]
	public enum BindingMode
	{
		LockToTargetOnAssign,
		LockToTargetWithWorldUp,
		LockToTargetNoRoll,
		LockToTarget,
		WorldSpace,
		SimpleFollowWithWorldUp
	}

	public enum AngularDampingMode
	{
		Euler,
		Quaternion
	}

	[Tooltip("The coordinate space to use when interpreting the offset from the target.  This is also used to set the camera's Up vector, which will be maintained when aiming the camera.")]
	public BindingMode m_BindingMode = BindingMode.LockToTargetWithWorldUp;

	[Tooltip("The distance vector that the transposer will attempt to maintain from the Follow target")]
	public Vector3 m_FollowOffset = Vector3.back * 10f;

	[Range(0f, 20f)]
	[Tooltip("How aggressively the camera tries to maintain the offset in the X-axis.  Small numbers are more responsive, rapidly translating the camera to keep the target's x-axis offset.  Larger numbers give a more heavy slowly responding camera. Using different settings per axis can yield a wide range of camera behaviors.")]
	public float m_XDamping = 1f;

	[Tooltip("How aggressively the camera tries to maintain the offset in the Y-axis.  Small numbers are more responsive, rapidly translating the camera to keep the target's y-axis offset.  Larger numbers give a more heavy slowly responding camera. Using different settings per axis can yield a wide range of camera behaviors.")]
	[Range(0f, 20f)]
	public float m_YDamping = 1f;

	[Range(0f, 20f)]
	[Tooltip("How aggressively the camera tries to maintain the offset in the Z-axis.  Small numbers are more responsive, rapidly translating the camera to keep the target's z-axis offset.  Larger numbers give a more heavy slowly responding camera. Using different settings per axis can yield a wide range of camera behaviors.")]
	public float m_ZDamping = 1f;

	public AngularDampingMode m_AngularDampingMode;

	[Tooltip("How aggressively the camera tries to track the target rotation's X angle.  Small numbers are more responsive.  Larger numbers give a more heavy slowly responding camera.")]
	[Range(0f, 20f)]
	public float m_PitchDamping;

	[Range(0f, 20f)]
	[Tooltip("How aggressively the camera tries to track the target rotation's Y angle.  Small numbers are more responsive.  Larger numbers give a more heavy slowly responding camera.")]
	public float m_YawDamping;

	[Range(0f, 20f)]
	[Tooltip("How aggressively the camera tries to track the target rotation's Z angle.  Small numbers are more responsive.  Larger numbers give a more heavy slowly responding camera.")]
	public float m_RollDamping;

	[Range(0f, 20f)]
	[Tooltip("How aggressively the camera tries to track the target's orientation.  Small numbers are more responsive.  Larger numbers give a more heavy slowly responding camera.")]
	public float m_AngularDamping;

	private Vector3 m_PreviousTargetPosition = Vector3.zero;

	private Quaternion m_PreviousReferenceOrientation = Quaternion.identity;

	private Quaternion m_targetOrientationOnAssign = Quaternion.identity;

	private Vector3 m_PreviousOffset;

	private Transform m_previousTarget;

	public bool HideOffsetInInspector { get; set; }

	public Vector3 EffectiveOffset
	{
		get
		{
			Vector3 followOffset = m_FollowOffset;
			if (m_BindingMode == BindingMode.SimpleFollowWithWorldUp)
			{
				followOffset.x = 0f;
				followOffset.z = 0f - Mathf.Abs(followOffset.z);
			}
			return followOffset;
		}
	}

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

	protected Vector3 Damping
	{
		get
		{
			if (m_BindingMode == BindingMode.SimpleFollowWithWorldUp)
			{
				return new Vector3(0f, m_YDamping, m_ZDamping);
			}
			return new Vector3(m_XDamping, m_YDamping, m_ZDamping);
		}
	}

	protected Vector3 AngularDamping
	{
		get
		{
			switch (m_BindingMode)
			{
			case BindingMode.LockToTargetNoRoll:
				return new Vector3(m_PitchDamping, m_YawDamping, 0f);
			case BindingMode.LockToTargetWithWorldUp:
				return new Vector3(0f, m_YawDamping, 0f);
			case BindingMode.LockToTargetOnAssign:
			case BindingMode.WorldSpace:
			case BindingMode.SimpleFollowWithWorldUp:
				return Vector3.zero;
			default:
				return new Vector3(m_PitchDamping, m_YawDamping, m_RollDamping);
			}
		}
	}

	protected virtual void OnValidate()
	{
		m_FollowOffset = EffectiveOffset;
	}

	public override float GetMaxDampTime()
	{
		Vector3 damping = Damping;
		Vector3 angularDamping = AngularDamping;
		float a = Mathf.Max(damping.x, Mathf.Max(damping.y, damping.z));
		float b = Mathf.Max(angularDamping.x, Mathf.Max(angularDamping.y, angularDamping.z));
		return Mathf.Max(a, b);
	}

	public override void MutateCameraState(ref CameraState curState, float deltaTime)
	{
		InitPrevFrameStateInfo(ref curState, deltaTime);
		if (IsValid)
		{
			Vector3 effectiveOffset = EffectiveOffset;
			TrackTarget(deltaTime, curState.ReferenceUp, effectiveOffset, out var outTargetPosition, out var outTargetOrient);
			effectiveOffset = outTargetOrient * effectiveOffset;
			curState.ReferenceUp = outTargetOrient * Vector3.up;
			Vector3 followTargetPosition = base.FollowTargetPosition;
			outTargetPosition += GetOffsetForMinimumTargetDistance(outTargetPosition, effectiveOffset, curState.RawOrientation * Vector3.forward, curState.ReferenceUp, followTargetPosition);
			curState.RawPosition = outTargetPosition + effectiveOffset;
		}
	}

	public override void OnTargetObjectWarped(Transform target, Vector3 positionDelta)
	{
		base.OnTargetObjectWarped(target, positionDelta);
		if (target == base.FollowTarget)
		{
			m_PreviousTargetPosition += positionDelta;
		}
	}

	public override void ForceCameraPosition(Vector3 pos, Quaternion rot)
	{
		base.ForceCameraPosition(pos, rot);
		Quaternion quaternion = ((m_BindingMode == BindingMode.SimpleFollowWithWorldUp) ? rot : GetReferenceOrientation(base.VirtualCamera.State.ReferenceUp));
		m_PreviousTargetPosition = pos - quaternion * EffectiveOffset;
	}

	protected void InitPrevFrameStateInfo(ref CameraState curState, float deltaTime)
	{
		bool flag = deltaTime >= 0f && base.VirtualCamera.PreviousStateIsValid;
		if (m_previousTarget != base.FollowTarget || !flag)
		{
			m_previousTarget = base.FollowTarget;
			m_targetOrientationOnAssign = base.FollowTargetRotation;
		}
		if (!flag)
		{
			m_PreviousTargetPosition = base.FollowTargetPosition;
			m_PreviousReferenceOrientation = GetReferenceOrientation(curState.ReferenceUp);
		}
	}

	protected void TrackTarget(float deltaTime, Vector3 up, Vector3 desiredCameraOffset, out Vector3 outTargetPosition, out Quaternion outTargetOrient)
	{
		Quaternion referenceOrientation = GetReferenceOrientation(up);
		Quaternion quaternion = referenceOrientation;
		bool flag = deltaTime >= 0f && base.VirtualCamera.PreviousStateIsValid;
		if (flag)
		{
			if (m_AngularDampingMode == AngularDampingMode.Quaternion && m_BindingMode == BindingMode.LockToTarget)
			{
				float t = base.VirtualCamera.DetachedFollowTargetDamp(1f, m_AngularDamping, deltaTime);
				quaternion = Quaternion.Slerp(m_PreviousReferenceOrientation, referenceOrientation, t);
			}
			else if (m_BindingMode != BindingMode.SimpleFollowWithWorldUp)
			{
				Vector3 eulerAngles = (Quaternion.Inverse(m_PreviousReferenceOrientation) * referenceOrientation).eulerAngles;
				for (int i = 0; i < 3; i++)
				{
					if (eulerAngles[i] > 180f)
					{
						eulerAngles[i] -= 360f;
					}
					if (Mathf.Abs(eulerAngles[i]) < 0.01f)
					{
						eulerAngles[i] = 0f;
					}
				}
				eulerAngles = base.VirtualCamera.DetachedFollowTargetDamp(eulerAngles, AngularDamping, deltaTime);
				quaternion = m_PreviousReferenceOrientation * Quaternion.Euler(eulerAngles);
			}
		}
		m_PreviousReferenceOrientation = quaternion;
		Vector3 followTargetPosition = base.FollowTargetPosition;
		Vector3 vector = m_PreviousTargetPosition;
		Vector3 vector2 = (flag ? m_PreviousOffset : desiredCameraOffset);
		if ((desiredCameraOffset - vector2).sqrMagnitude > 0.01f)
		{
			Quaternion quaternion2 = UnityVectorExtensions.SafeFromToRotation(m_PreviousOffset.ProjectOntoPlane(up), desiredCameraOffset.ProjectOntoPlane(up), up);
			vector = followTargetPosition + quaternion2 * (m_PreviousTargetPosition - followTargetPosition);
		}
		m_PreviousOffset = desiredCameraOffset;
		Vector3 vector3 = followTargetPosition - vector;
		if (flag)
		{
			Quaternion quaternion3 = ((!desiredCameraOffset.AlmostZero()) ? Quaternion.LookRotation(quaternion * desiredCameraOffset, up) : base.VcamState.RawOrientation);
			Vector3 initial = Quaternion.Inverse(quaternion3) * vector3;
			initial = base.VirtualCamera.DetachedFollowTargetDamp(initial, Damping, deltaTime);
			vector3 = quaternion3 * initial;
		}
		vector += vector3;
		outTargetPosition = (m_PreviousTargetPosition = vector);
		outTargetOrient = quaternion;
	}

	protected Vector3 GetOffsetForMinimumTargetDistance(Vector3 dampedTargetPos, Vector3 cameraOffset, Vector3 cameraFwd, Vector3 up, Vector3 actualTargetPos)
	{
		Vector3 vector = Vector3.zero;
		if (base.VirtualCamera.FollowTargetAttachment > 0.9999f)
		{
			cameraOffset = cameraOffset.ProjectOntoPlane(up);
			float num = cameraOffset.magnitude * 0.2f;
			if (num > 0f)
			{
				actualTargetPos = actualTargetPos.ProjectOntoPlane(up);
				dampedTargetPos = dampedTargetPos.ProjectOntoPlane(up);
				Vector3 vector2 = dampedTargetPos + cameraOffset;
				float num2 = Vector3.Dot(actualTargetPos - vector2, (dampedTargetPos - vector2).normalized);
				if (num2 < num)
				{
					Vector3 vector3 = actualTargetPos - dampedTargetPos;
					float magnitude = vector3.magnitude;
					if (magnitude < 0.01f)
					{
						vector3 = -cameraFwd.ProjectOntoPlane(up);
					}
					else
					{
						vector3 /= magnitude;
					}
					vector = vector3 * (num - num2);
				}
				m_PreviousTargetPosition += vector;
			}
		}
		return vector;
	}

	public virtual Vector3 GetTargetCameraPosition(Vector3 worldUp)
	{
		if (!IsValid)
		{
			return Vector3.zero;
		}
		return base.FollowTargetPosition + GetReferenceOrientation(worldUp) * EffectiveOffset;
	}

	public Quaternion GetReferenceOrientation(Vector3 worldUp)
	{
		if (m_BindingMode == BindingMode.WorldSpace)
		{
			return Quaternion.identity;
		}
		if (base.FollowTarget != null)
		{
			Quaternion rotation = base.FollowTarget.rotation;
			switch (m_BindingMode)
			{
			case BindingMode.LockToTargetOnAssign:
				return m_targetOrientationOnAssign;
			case BindingMode.LockToTargetWithWorldUp:
			{
				Vector3 vector2 = (rotation * Vector3.forward).ProjectOntoPlane(worldUp);
				if (!vector2.AlmostZero())
				{
					return Quaternion.LookRotation(vector2, worldUp);
				}
				break;
			}
			case BindingMode.LockToTargetNoRoll:
				return Quaternion.LookRotation(rotation * Vector3.forward, worldUp);
			case BindingMode.LockToTarget:
				return rotation;
			case BindingMode.SimpleFollowWithWorldUp:
			{
				Vector3 vector = (base.FollowTargetPosition - base.VcamState.RawPosition).ProjectOntoPlane(worldUp);
				if (!vector.AlmostZero())
				{
					return Quaternion.LookRotation(vector, worldUp);
				}
				break;
			}
			}
		}
		return m_PreviousReferenceOrientation.normalized;
	}
}
