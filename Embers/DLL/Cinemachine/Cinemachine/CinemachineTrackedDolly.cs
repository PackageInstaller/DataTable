using System;
using Cinemachine.Utility;
using UnityEngine;
using UnityEngine.Serialization;

namespace Cinemachine;

[AddComponentMenu("")]
[SaveDuringPlay]
[DocumentationSorting(DocumentationSortingAttribute.Level.UserRef)]
public class CinemachineTrackedDolly : CinemachineComponentBase
{
	[DocumentationSorting(DocumentationSortingAttribute.Level.UserRef)]
	public enum CameraUpMode
	{
		Default,
		Path,
		PathNoRoll,
		FollowTarget,
		FollowTargetNoRoll
	}

	[Serializable]
	[DocumentationSorting(DocumentationSortingAttribute.Level.UserRef)]
	public struct AutoDolly(bool enabled, float positionOffset, int searchRadius, int stepsPerSegment)
	{
		[Tooltip("If checked, will enable automatic dolly, which chooses a path position that is as close as possible to the Follow target.  Note: this can have significant performance impact")]
		public bool m_Enabled = enabled;

		[Tooltip("Offset, in current position units, from the closest point on the path to the follow target")]
		public float m_PositionOffset = positionOffset;

		[Tooltip("Search up to this many waypoints on either side of the current position.  Use 0 for Entire path.")]
		public int m_SearchRadius = searchRadius;

		[FormerlySerializedAs("m_StepsPerSegment")]
		[Tooltip("We search between waypoints by dividing the segment into this many straight pieces.  he higher the number, the more accurate the result, but performance is proportionally slower for higher numbers")]
		public int m_SearchResolution = stepsPerSegment;
	}

	[Tooltip("The path to which the camera will be constrained.  This must be non-null.")]
	public CinemachinePathBase m_Path;

	[Tooltip("The position along the path at which the camera will be placed.  This can be animated directly, or set automatically by the Auto-Dolly feature to get as close as possible to the Follow target.  The value is interpreted according to the Position Units setting.")]
	public float m_PathPosition;

	[Tooltip("How to interpret Path Position.  If set to Path Units, values are as follows: 0 represents the first waypoint on the path, 1 is the second, and so on.  Values in-between are points on the path in between the waypoints.  If set to Distance, then Path Position represents distance along the path.")]
	public CinemachinePathBase.PositionUnits m_PositionUnits;

	[Tooltip("Where to put the camera relative to the path position.  X is perpendicular to the path, Y is up, and Z is parallel to the path.  This allows the camera to be offset from the path itself (as if on a tripod, for example).")]
	public Vector3 m_PathOffset = Vector3.zero;

	[Range(0f, 20f)]
	[Tooltip("How aggressively the camera tries to maintain its position in a direction perpendicular to the path.  Small numbers are more responsive, rapidly translating the camera to keep the target's x-axis offset.  Larger numbers give a more heavy slowly responding camera. Using different settings per axis can yield a wide range of camera behaviors.")]
	public float m_XDamping;

	[Range(0f, 20f)]
	[Tooltip("How aggressively the camera tries to maintain its position in the path-local up direction.  Small numbers are more responsive, rapidly translating the camera to keep the target's y-axis offset.  Larger numbers give a more heavy slowly responding camera. Using different settings per axis can yield a wide range of camera behaviors.")]
	public float m_YDamping;

	[Range(0f, 20f)]
	[Tooltip("How aggressively the camera tries to maintain its position in a direction parallel to the path.  Small numbers are more responsive, rapidly translating the camera to keep the target's z-axis offset.  Larger numbers give a more heavy slowly responding camera. Using different settings per axis can yield a wide range of camera behaviors.")]
	public float m_ZDamping = 1f;

	[Tooltip("How to set the virtual camera's Up vector.  This will affect the screen composition, because the camera Aim behaviours will always try to respect the Up direction.")]
	public CameraUpMode m_CameraUp;

	[Range(0f, 20f)]
	[Tooltip("How aggressively the camera tries to track the target rotation's X angle.  Small numbers are more responsive.  Larger numbers give a more heavy slowly responding camera.")]
	public float m_PitchDamping;

	[Tooltip("How aggressively the camera tries to track the target rotation's Y angle.  Small numbers are more responsive.  Larger numbers give a more heavy slowly responding camera.")]
	[Range(0f, 20f)]
	public float m_YawDamping;

	[Tooltip("How aggressively the camera tries to track the target rotation's Z angle.  Small numbers are more responsive.  Larger numbers give a more heavy slowly responding camera.")]
	[Range(0f, 20f)]
	public float m_RollDamping;

	[Tooltip("Controls how automatic dollying occurs.  A Follow target is necessary to use this feature.")]
	public AutoDolly m_AutoDolly = new AutoDolly(enabled: false, 0f, 2, 5);

	private float m_PreviousPathPosition;

	private Quaternion m_PreviousOrientation = Quaternion.identity;

	private Vector3 m_PreviousCameraPosition = Vector3.zero;

	public override bool IsValid
	{
		get
		{
			if (base.enabled)
			{
				return m_Path != null;
			}
			return false;
		}
	}

	public override CinemachineCore.Stage Stage => CinemachineCore.Stage.Body;

	private Vector3 AngularDamping
	{
		get
		{
			switch (m_CameraUp)
			{
			case CameraUpMode.PathNoRoll:
			case CameraUpMode.FollowTargetNoRoll:
				return new Vector3(m_PitchDamping, m_YawDamping, 0f);
			case CameraUpMode.Default:
				return Vector3.zero;
			default:
				return new Vector3(m_PitchDamping, m_YawDamping, m_RollDamping);
			}
		}
	}

	public override float GetMaxDampTime()
	{
		Vector3 angularDamping = AngularDamping;
		float a = Mathf.Max(m_XDamping, Mathf.Max(m_YDamping, m_ZDamping));
		float b = Mathf.Max(angularDamping.x, Mathf.Max(angularDamping.y, angularDamping.z));
		return Mathf.Max(a, b);
	}

	public override void MutateCameraState(ref CameraState curState, float deltaTime)
	{
		if (deltaTime < 0f || !base.VirtualCamera.PreviousStateIsValid)
		{
			m_PreviousPathPosition = m_PathPosition;
			m_PreviousCameraPosition = curState.RawPosition;
			m_PreviousOrientation = curState.RawOrientation;
		}
		if (!IsValid)
		{
			return;
		}
		if (m_AutoDolly.m_Enabled && base.FollowTarget != null)
		{
			float f = m_Path.ToNativePathUnits(m_PreviousPathPosition, m_PositionUnits);
			m_PathPosition = m_Path.FindClosestPoint(base.FollowTargetPosition, Mathf.FloorToInt(f), (deltaTime < 0f || m_AutoDolly.m_SearchRadius <= 0) ? (-1) : m_AutoDolly.m_SearchRadius, m_AutoDolly.m_SearchResolution);
			m_PathPosition = m_Path.FromPathNativeUnits(m_PathPosition, m_PositionUnits);
			m_PathPosition += m_AutoDolly.m_PositionOffset;
		}
		float num = m_PathPosition;
		if (deltaTime >= 0f && base.VirtualCamera.PreviousStateIsValid)
		{
			float num2 = m_Path.MaxUnit(m_PositionUnits);
			if (num2 > 0f)
			{
				float num3 = m_Path.StandardizeUnit(m_PreviousPathPosition, m_PositionUnits);
				float num4 = m_Path.StandardizeUnit(num, m_PositionUnits);
				if (m_Path.Looped && Mathf.Abs(num4 - num3) > num2 / 2f)
				{
					num3 = ((!(num4 > num3)) ? (num3 - num2) : (num3 + num2));
				}
				m_PreviousPathPosition = num3;
				num = num4;
			}
			float initial = m_PreviousPathPosition - num;
			initial = Damper.Damp(initial, m_ZDamping, deltaTime);
			num = m_PreviousPathPosition - initial;
		}
		m_PreviousPathPosition = num;
		Quaternion quaternion = m_Path.EvaluateOrientationAtUnit(num, m_PositionUnits);
		Vector3 vector = m_Path.EvaluatePositionAtUnit(num, m_PositionUnits);
		Vector3 vector2 = quaternion * Vector3.right;
		Vector3 vector3 = quaternion * Vector3.up;
		Vector3 vector4 = quaternion * Vector3.forward;
		vector += m_PathOffset.x * vector2;
		vector += m_PathOffset.y * vector3;
		vector += m_PathOffset.z * vector4;
		if (deltaTime >= 0f && base.VirtualCamera.PreviousStateIsValid)
		{
			Vector3 previousCameraPosition = m_PreviousCameraPosition;
			Vector3 vector5 = previousCameraPosition - vector;
			Vector3 vector6 = Vector3.Dot(vector5, vector3) * vector3;
			Vector3 initial2 = vector5 - vector6;
			initial2 = Damper.Damp(initial2, m_XDamping, deltaTime);
			vector6 = Damper.Damp(vector6, m_YDamping, deltaTime);
			vector = previousCameraPosition - (initial2 + vector6);
		}
		curState.RawPosition = (m_PreviousCameraPosition = vector);
		Quaternion quaternion2 = GetCameraOrientationAtPathPoint(quaternion, curState.ReferenceUp);
		if (deltaTime >= 0f && base.VirtualCamera.PreviousStateIsValid)
		{
			Vector3 eulerAngles = (Quaternion.Inverse(m_PreviousOrientation) * quaternion2).eulerAngles;
			for (int i = 0; i < 3; i++)
			{
				if (eulerAngles[i] > 180f)
				{
					eulerAngles[i] -= 360f;
				}
			}
			eulerAngles = Damper.Damp(eulerAngles, AngularDamping, deltaTime);
			quaternion2 = m_PreviousOrientation * Quaternion.Euler(eulerAngles);
		}
		m_PreviousOrientation = quaternion2;
		curState.RawOrientation = quaternion2;
		if (m_CameraUp != CameraUpMode.Default)
		{
			curState.ReferenceUp = curState.RawOrientation * Vector3.up;
		}
	}

	private Quaternion GetCameraOrientationAtPathPoint(Quaternion pathOrientation, Vector3 up)
	{
		switch (m_CameraUp)
		{
		case CameraUpMode.Path:
			return pathOrientation;
		case CameraUpMode.PathNoRoll:
			return Quaternion.LookRotation(pathOrientation * Vector3.forward, up);
		case CameraUpMode.FollowTarget:
			if (base.FollowTarget != null)
			{
				return base.FollowTargetRotation;
			}
			break;
		case CameraUpMode.FollowTargetNoRoll:
			if (base.FollowTarget != null)
			{
				return Quaternion.LookRotation(base.FollowTargetRotation * Vector3.forward, up);
			}
			break;
		}
		return Quaternion.LookRotation(base.VirtualCamera.transform.rotation * Vector3.forward, up);
	}
}
