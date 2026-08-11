using System;
using Cinemachine.Utility;
using UnityEngine;

namespace Cinemachine;

[AddComponentMenu("")]
[SaveDuringPlay]
[DocumentationSorting(DocumentationSortingAttribute.Level.UserRef)]
public class CinemachineGroupComposer : CinemachineComposer
{
	[DocumentationSorting(DocumentationSortingAttribute.Level.UserRef)]
	public enum FramingMode
	{
		Horizontal,
		Vertical,
		HorizontalAndVertical
	}

	public enum AdjustmentMode
	{
		ZoomOnly,
		DollyOnly,
		DollyThenZoom
	}

	[Tooltip("The bounding box of the targets should occupy this amount of the screen space.  1 means fill the whole screen.  0.5 means fill half the screen, etc.")]
	[Space]
	public float m_GroupFramingSize = 0.8f;

	[Tooltip("What screen dimensions to consider when framing.  Can be Horizontal, Vertical, or both")]
	public FramingMode m_FramingMode = FramingMode.HorizontalAndVertical;

	[Tooltip("How aggressively the camera tries to frame the group. Small numbers are more responsive, rapidly adjusting the camera to keep the group in the frame.  Larger numbers give a more heavy slowly responding camera.")]
	[Range(0f, 20f)]
	public float m_FrameDamping = 2f;

	[Tooltip("How to adjust the camera to get the desired framing.  You can zoom, dolly in/out, or do both.")]
	public AdjustmentMode m_AdjustmentMode;

	[Tooltip("The maximum distance toward the target that this behaviour is allowed to move the camera.")]
	public float m_MaxDollyIn = 5000f;

	[Tooltip("The maximum distance away the target that this behaviour is allowed to move the camera.")]
	public float m_MaxDollyOut = 5000f;

	[Tooltip("Set this to limit how close to the target the camera can get.")]
	public float m_MinimumDistance = 1f;

	[Tooltip("Set this to limit how far from the target the camera can get.")]
	public float m_MaximumDistance = 5000f;

	[Tooltip("If adjusting FOV, will not set the FOV lower than this.")]
	[Range(1f, 179f)]
	public float m_MinimumFOV = 3f;

	[Tooltip("If adjusting FOV, will not set the FOV higher than this.")]
	[Range(1f, 179f)]
	public float m_MaximumFOV = 60f;

	[Tooltip("If adjusting Orthographic Size, will not set it lower than this.")]
	public float m_MinimumOrthoSize = 1f;

	[Tooltip("If adjusting Orthographic Size, will not set it higher than this.")]
	public float m_MaximumOrthoSize = 5000f;

	private float m_prevFramingDistance;

	private float m_prevFOV;

	public Bounds LastBounds { get; private set; }

	public Matrix4x4 LastBoundsMatrix { get; private set; }

	private void OnValidate()
	{
		m_GroupFramingSize = Mathf.Max(0.001f, m_GroupFramingSize);
		m_MaxDollyIn = Mathf.Max(0f, m_MaxDollyIn);
		m_MaxDollyOut = Mathf.Max(0f, m_MaxDollyOut);
		m_MinimumDistance = Mathf.Max(0f, m_MinimumDistance);
		m_MaximumDistance = Mathf.Max(m_MinimumDistance, m_MaximumDistance);
		m_MinimumFOV = Mathf.Max(1f, m_MinimumFOV);
		m_MaximumFOV = Mathf.Clamp(m_MaximumFOV, m_MinimumFOV, 179f);
		m_MinimumOrthoSize = Mathf.Max(0.01f, m_MinimumOrthoSize);
		m_MaximumOrthoSize = Mathf.Max(m_MinimumOrthoSize, m_MaximumOrthoSize);
	}

	public override float GetMaxDampTime()
	{
		return Mathf.Max(base.GetMaxDampTime(), m_FrameDamping);
	}

	public override void MutateCameraState(ref CameraState curState, float deltaTime)
	{
		ICinemachineTargetGroup abstractLookAtTargetGroup = base.AbstractLookAtTargetGroup;
		if (abstractLookAtTargetGroup == null)
		{
			base.MutateCameraState(ref curState, deltaTime);
			return;
		}
		if (!IsValid || !curState.HasLookAt)
		{
			m_prevFramingDistance = 0f;
			m_prevFOV = 0f;
			return;
		}
		bool orthographic = curState.Lens.Orthographic;
		bool flag = !orthographic && m_AdjustmentMode != AdjustmentMode.ZoomOnly;
		Vector3 referenceUp = curState.ReferenceUp;
		Vector3 rawPosition = curState.RawPosition;
		Vector3 position = abstractLookAtTargetGroup.Sphere.position;
		Vector3 newFwd = position - rawPosition;
		float magnitude = newFwd.magnitude;
		if (magnitude < 0.0001f)
		{
			return;
		}
		newFwd /= magnitude;
		LastBoundsMatrix = Matrix4x4.TRS(rawPosition, Quaternion.LookRotation(newFwd, referenceUp), Vector3.one);
		Bounds viewSpaceBoundingBox;
		if (orthographic)
		{
			viewSpaceBoundingBox = abstractLookAtTargetGroup.GetViewSpaceBoundingBox(LastBoundsMatrix);
			position = LastBoundsMatrix.MultiplyPoint3x4(viewSpaceBoundingBox.center);
			newFwd = (position - rawPosition).normalized;
			LastBoundsMatrix = Matrix4x4.TRS(rawPosition, Quaternion.LookRotation(newFwd, referenceUp), Vector3.one);
			viewSpaceBoundingBox = (LastBounds = abstractLookAtTargetGroup.GetViewSpaceBoundingBox(LastBoundsMatrix));
		}
		else
		{
			viewSpaceBoundingBox = GetScreenSpaceGroupBoundingBox(abstractLookAtTargetGroup, LastBoundsMatrix, out newFwd);
			LastBoundsMatrix = Matrix4x4.TRS(rawPosition, Quaternion.LookRotation(newFwd, referenceUp), Vector3.one);
			LastBounds = viewSpaceBoundingBox;
			position = rawPosition + newFwd * viewSpaceBoundingBox.center.z;
		}
		float z = viewSpaceBoundingBox.extents.z;
		float num = GetTargetHeight(viewSpaceBoundingBox.size / m_GroupFramingSize);
		if (orthographic)
		{
			num = Mathf.Clamp(num / 2f, m_MinimumOrthoSize, m_MaximumOrthoSize);
			if (deltaTime >= 0f && base.VirtualCamera.PreviousStateIsValid)
			{
				num = m_prevFOV + base.VirtualCamera.DetachedLookAtTargetDamp(num - m_prevFOV, m_FrameDamping, deltaTime);
			}
			m_prevFOV = num;
			LensSettings lens = curState.Lens;
			lens.OrthographicSize = Mathf.Clamp(num, m_MinimumOrthoSize, m_MaximumOrthoSize);
			curState.Lens = lens;
		}
		else
		{
			float z2 = viewSpaceBoundingBox.center.z;
			if (z2 > z)
			{
				num = Mathf.Lerp(0f, num, (z2 - z) / z2);
			}
			if (flag)
			{
				float value = Mathf.Clamp(z + num / (2f * Mathf.Tan(curState.Lens.FieldOfView * (MathF.PI / 180f) / 2f)), z + m_MinimumDistance, z + m_MaximumDistance) - Vector3.Distance(curState.RawPosition, position);
				value = Mathf.Clamp(value, 0f - m_MaxDollyIn, m_MaxDollyOut);
				if (deltaTime >= 0f && base.VirtualCamera.PreviousStateIsValid)
				{
					float initial = value - m_prevFramingDistance;
					initial = base.VirtualCamera.DetachedLookAtTargetDamp(initial, m_FrameDamping, deltaTime);
					value = m_prevFramingDistance + initial;
				}
				m_prevFramingDistance = value;
				curState.PositionCorrection -= newFwd * value;
				rawPosition -= newFwd * value;
			}
			if (m_AdjustmentMode != AdjustmentMode.DollyOnly)
			{
				float num2 = (position - rawPosition).magnitude - z;
				float value2 = 179f;
				if (num2 > 0.0001f)
				{
					value2 = 2f * Mathf.Atan(num / (2f * num2)) * 57.29578f;
				}
				value2 = Mathf.Clamp(value2, m_MinimumFOV, m_MaximumFOV);
				if (deltaTime >= 0f && m_prevFOV != 0f && base.VirtualCamera.PreviousStateIsValid)
				{
					value2 = m_prevFOV + base.VirtualCamera.DetachedLookAtTargetDamp(value2 - m_prevFOV, m_FrameDamping, deltaTime);
				}
				m_prevFOV = value2;
				LensSettings lens2 = curState.Lens;
				lens2.FieldOfView = value2;
				curState.Lens = lens2;
			}
		}
		curState.ReferenceLookAt = GetLookAtPointAndSetTrackedPoint(position, curState.ReferenceUp, deltaTime);
		base.MutateCameraState(ref curState, deltaTime);
	}

	private float GetTargetHeight(Vector2 boundsSize)
	{
		return m_FramingMode switch
		{
			FramingMode.Horizontal => Mathf.Max(0.0001f, boundsSize.x) / base.VcamState.Lens.Aspect, 
			FramingMode.Vertical => Mathf.Max(0.0001f, boundsSize.y), 
			_ => Mathf.Max(Mathf.Max(0.0001f, boundsSize.x) / base.VcamState.Lens.Aspect, Mathf.Max(0.0001f, boundsSize.y)), 
		};
	}

	private static Bounds GetScreenSpaceGroupBoundingBox(ICinemachineTargetGroup group, Matrix4x4 observer, out Vector3 newFwd)
	{
		group.GetViewSpaceAngularBounds(observer, out var minAngles, out var maxAngles, out var zRange);
		Vector2 vector = (minAngles + maxAngles) / 2f;
		newFwd = Quaternion.identity.ApplyCameraRotation(new Vector2(0f - vector.x, vector.y), Vector3.up) * Vector3.forward;
		newFwd = observer.MultiplyVector(newFwd);
		float num = zRange.y + zRange.x;
		Vector2 vector2 = Vector2.Min(maxAngles - vector, new Vector2(89.5f, 89.5f)) * (MathF.PI / 180f);
		return new Bounds(new Vector3(0f, 0f, num / 2f), new Vector3(Mathf.Tan(vector2.y) * num, Mathf.Tan(vector2.x) * num, zRange.y - zRange.x));
	}
}
