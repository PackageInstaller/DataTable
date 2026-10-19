using System;
using Bamboo.ECS;
using Cinemachine;
using Cinemachine.Utility;
using UnityEngine;

namespace ACT.Battle;

public class CinemachineFramingTransposerACT : CinemachineComponentBase
{
	[DocumentationSorting(DocumentationSortingAttribute.Level.UserRef)]
	public enum FramingMode
	{
		Horizontal,
		Vertical,
		HorizontalAndVertical,
		None
	}

	public enum AdjustmentMode
	{
		ZoomOnly,
		DollyOnly,
		DollyThenZoom
	}

	public bool drawGuides;

	public float wallWidth;

	[Tooltip("角色在地面上，会把相机拉高到最高，使得角色在可移动区域的最下方.勾上这个使此功能失效")]
	public bool dontMoveUp;

	[Tooltip("Offset from the Follow Target object (in target-local co-ordinates).  The camera will attempt to frame the point which is the target's position plus this offset.  Use it to correct for cases when the target's origin is not the point of interest for the camera.")]
	public Vector3 m_TrackedObjectOffset;

	[Tooltip("This setting will instruct the composer to adjust its target offset based on the motion of the target.  The composer will look at a point where it estimates the target will be this many seconds into the future.  Note that this setting is sensitive to noisy animation, and can amplify the noise, resulting in undesirable camera jitter.  If the camera jitters unacceptably when the target is in motion, turn down this setting, or animate the target more smoothly.")]
	[Range(0f, 1f)]
	[Space]
	public float m_LookaheadTime;

	[Tooltip("Controls the smoothness of the lookahead algorithm.  Larger values smooth out jittery predictions and also increase prediction lag")]
	[Range(0f, 30f)]
	public float m_LookaheadSmoothing;

	[Tooltip("If checked, movement along the Y axis will be ignored for lookahead calculations")]
	public bool m_LookaheadIgnoreY;

	[Tooltip("How much time it takes for the aim to catch up to the target's rotation")]
	public float m_Damping;

	private Quaternion m_PreviousReferenceOrientation = Quaternion.identity;

	[Space]
	[Range(0f, 20f)]
	[Tooltip("How aggressively the camera tries to maintain the offset in the X-axis.  Small numbers are more responsive, rapidly translating the camera to keep the target's x-axis offset.  Larger numbers give a more heavy slowly responding camera.  Using different settings per axis can yield a wide range of camera behaviors.")]
	public float m_XDamping = 1f;

	[Range(0f, 20f)]
	[Tooltip("How aggressively the camera tries to maintain the offset in the Y-axis.  Small numbers are more responsive, rapidly translating the camera to keep the target's y-axis offset.  Larger numbers give a more heavy slowly responding camera.  Using different settings per axis can yield a wide range of camera behaviors.")]
	public float m_YDamping = 1f;

	[Range(0f, 20f)]
	[Tooltip("How aggressively the camera tries to maintain the offset in the Z-axis.  Small numbers are more responsive, rapidly translating the camera to keep the target's z-axis offset.  Larger numbers give a more heavy slowly responding camera.  Using different settings per axis can yield a wide range of camera behaviors.")]
	public float m_ZDamping = 1f;

	[Tooltip("If set, damping will apply  only to target motion, but not to camera rotation changes.  Turn this on to get an instant response when the rotation changes.  ")]
	public bool m_TargetMovementOnly = true;

	[Space]
	[Range(-0.5f, 1.5f)]
	[Tooltip("Horizontal screen position for target. The camera will move to position the tracked object here.")]
	public float m_ScreenX = 0.5f;

	[Range(-0.5f, 1.5f)]
	[Tooltip("Vertical screen position for target, The camera will move to position the tracked object here.")]
	public float m_ScreenY = 0.5f;

	[Tooltip("The distance along the camera axis that will be maintained from the Follow target")]
	public float m_CameraDistance = 10f;

	[Space]
	[Range(0f, 2f)]
	[Tooltip("Camera will not move horizontally if the target is within this range of the position.")]
	public float m_DeadZoneWidth = 0.06f;

	[Range(0f, 2f)]
	[Tooltip("Camera will not move vertically if the target is within this range of the position.")]
	public float m_DeadZoneHeight;

	[Tooltip("The camera will not move along its z-axis if the Follow target is within this distance of the specified camera distance")]
	public float m_DeadZoneDepth;

	[Space]
	[Tooltip("If checked, then then soft zone will be unlimited in size.")]
	public bool m_UnlimitedSoftZone;

	[Range(0f, 2f)]
	[Tooltip("When target is within this region, camera will gradually move horizontally to re-align towards the desired position, depending on the damping speed.")]
	public float m_SoftZoneWidth = 0.8f;

	[Range(0f, 2f)]
	[Tooltip("When target is within this region, camera will gradually move vertically to re-align towards the desired position, depending on the damping speed.")]
	public float m_SoftZoneHeight = 0.8f;

	[Range(-0.5f, 0.5f)]
	[Tooltip("A non-zero bias will move the target position horizontally away from the center of the soft zone.")]
	public float m_BiasX;

	[Range(-0.5f, 0.5f)]
	[Tooltip("A non-zero bias will move the target position vertically away from the center of the soft zone.")]
	public float m_BiasY;

	[Tooltip("Force target to center of screen when this camera activates.  If false, will clamp target to the edges of the dead zone")]
	public bool m_CenterOnActivate = true;

	[Space]
	[Tooltip("What screen dimensions to consider when framing.  Can be Horizontal, Vertical, or both")]
	public FramingMode m_GroupFramingMode = FramingMode.HorizontalAndVertical;

	[Tooltip("How to adjust the camera to get the desired framing.  You can zoom, dolly in/out, or do both.")]
	public AdjustmentMode m_AdjustmentMode;

	[Tooltip("The bounding box of the targets should occupy this amount of the screen space.  1 means fill the whole screen.  0.5 means fill half the screen, etc.")]
	public float m_GroupFramingSize = 0.8f;

	[Tooltip("The maximum distance toward the target that this behaviour is allowed to move the camera.")]
	public float m_MaxDollyIn = 5000f;

	[Tooltip("The maximum distance away the target that this behaviour is allowed to move the camera.")]
	public float m_MaxDollyOut = 5000f;

	[Tooltip("Set this to limit how close to the target the camera can get.")]
	public float m_MinimumDistance = 1f;

	[Tooltip("Set this to limit how far from the target the camera can get.")]
	public float m_MaximumDistance = 5000f;

	[Range(1f, 179f)]
	[Tooltip("If adjusting FOV, will not set the FOV lower than this.")]
	public float m_MinimumFOV = 3f;

	[Range(1f, 179f)]
	[Tooltip("If adjusting FOV, will not set the FOV higher than this.")]
	public float m_MaximumFOV = 60f;

	[Tooltip("If adjusting Orthographic Size, will not set it lower than this.")]
	public float m_MinimumOrthoSize = 1f;

	[Tooltip("If adjusting Orthographic Size, will not set it higher than this.")]
	public float m_MaximumOrthoSize = 5000f;

	private const float kMinimumCameraDistance = 0.01f;

	private const float kMinimumGroupSize = 0.01f;

	private Vector3 m_PreviousCameraPosition = Vector3.zero;

	private PositionPredictor m_Predictor = new PositionPredictor();

	private bool m_InheritingPosition;

	private float m_prevFOV;

	private Quaternion m_prevRotation;

	private MonoECS m_ECS;

	public Rect SoftGuideRect
	{
		get
		{
			return new Rect(m_ScreenX - m_DeadZoneWidth / 2f, m_ScreenY - m_DeadZoneHeight / 2f, m_DeadZoneWidth, m_DeadZoneHeight);
		}
		set
		{
			m_DeadZoneWidth = Mathf.Clamp(value.width, 0f, 2f);
			m_DeadZoneHeight = Mathf.Clamp(value.height, 0f, 2f);
			m_ScreenX = Mathf.Clamp(value.x + m_DeadZoneWidth / 2f, -0.5f, 1.5f);
			m_ScreenY = Mathf.Clamp(value.y + m_DeadZoneHeight / 2f, -0.5f, 1.5f);
			m_SoftZoneWidth = Mathf.Max(m_SoftZoneWidth, m_DeadZoneWidth);
			m_SoftZoneHeight = Mathf.Max(m_SoftZoneHeight, m_DeadZoneHeight);
		}
	}

	public Rect HardGuideRect
	{
		get
		{
			Rect result = new Rect(m_ScreenX - m_SoftZoneWidth / 2f, m_ScreenY - m_SoftZoneHeight / 2f, m_SoftZoneWidth, m_SoftZoneHeight);
			result.position += new Vector2(m_BiasX * (m_SoftZoneWidth - m_DeadZoneWidth), m_BiasY * (m_SoftZoneHeight - m_DeadZoneHeight));
			return result;
		}
		set
		{
			m_SoftZoneWidth = Mathf.Clamp(value.width, 0f, 2f);
			m_SoftZoneHeight = Mathf.Clamp(value.height, 0f, 2f);
			m_DeadZoneWidth = Mathf.Min(m_DeadZoneWidth, m_SoftZoneWidth);
			m_DeadZoneHeight = Mathf.Min(m_DeadZoneHeight, m_SoftZoneHeight);
			Vector2 vector = value.center - new Vector2(m_ScreenX, m_ScreenY);
			float num = Mathf.Max(0f, m_SoftZoneWidth - m_DeadZoneWidth);
			float num2 = Mathf.Max(0f, m_SoftZoneHeight - m_DeadZoneHeight);
			m_BiasX = ((num < 0.0001f) ? 0f : Mathf.Clamp(vector.x / num, -0.5f, 0.5f));
			m_BiasY = ((num2 < 0.0001f) ? 0f : Mathf.Clamp(vector.y / num2, -0.5f, 0.5f));
		}
	}

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

	public override bool BodyAppliesAfterAim => true;

	public Vector3 TrackedPoint { get; private set; }

	public Bounds LastBounds { get; private set; }

	public Matrix4x4 LastBoundsMatrix { get; private set; }

	private void Awake()
	{
		if (m_DeadZoneWidth < 0.06f)
		{
			m_DeadZoneWidth = 0.06f;
		}
	}

	private void OnValidate()
	{
		m_CameraDistance = Mathf.Max(m_CameraDistance, 0.01f);
		m_DeadZoneDepth = Mathf.Max(m_DeadZoneDepth, 0f);
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

	public override void OnTargetObjectWarped(Transform target, Vector3 positionDelta)
	{
		base.OnTargetObjectWarped(target, positionDelta);
		if (target == FollowTarget)
		{
			m_PreviousCameraPosition += positionDelta;
			m_Predictor.ApplyTransformDelta(positionDelta);
		}
	}

	public override void ForceCameraPosition(Vector3 pos, Quaternion rot)
	{
		base.ForceCameraPosition(pos, rot);
		m_PreviousCameraPosition = pos;
	}

	public override float GetMaxDampTime()
	{
		return Mathf.Max(m_XDamping, Mathf.Max(m_YDamping, m_ZDamping));
	}

	public override bool OnTransitionFromCamera(ICinemachineCamera fromCam, Vector3 worldUp, float deltaTime, ref CinemachineVirtualCameraBase.TransitionParams transitionParams)
	{
		if (fromCam != null && transitionParams.m_InheritPosition && !CinemachineCore.Instance.IsLiveInBlend(VirtualCamera))
		{
			m_PreviousCameraPosition = fromCam.State.RawPosition;
			m_InheritingPosition = true;
			return true;
		}
		return false;
	}

	private Rect ScreenToOrtho(Rect rScreen, float orthoSize, float aspect)
	{
		return new Rect
		{
			yMax = 2f * orthoSize * (1f - rScreen.yMin - 0.5f),
			yMin = 2f * orthoSize * (1f - rScreen.yMax - 0.5f),
			xMin = 2f * orthoSize * aspect * (rScreen.xMin - 0.5f),
			xMax = 2f * orthoSize * aspect * (rScreen.xMax - 0.5f)
		};
	}

	private Vector3 OrthoOffsetToScreenBounds(Vector3 targetPos2D, Rect screenRect)
	{
		Vector3 zero = Vector3.zero;
		if (targetPos2D.x < screenRect.xMin)
		{
			zero.x += targetPos2D.x - screenRect.xMin;
		}
		if (targetPos2D.x > screenRect.xMax)
		{
			zero.x += targetPos2D.x - screenRect.xMax;
		}
		if (targetPos2D.y < screenRect.yMin)
		{
			zero.y += targetPos2D.y - screenRect.yMin;
		}
		if (targetPos2D.y > screenRect.yMax)
		{
			zero.y += targetPos2D.y - screenRect.yMax;
		}
		return zero;
	}

	private Vector3 OrthoOffsetToScreenBoundsLower(Vector3 targetPos2D, Rect screenRect)
	{
		Vector3 zero = Vector3.zero;
		if (targetPos2D.x < screenRect.xMin)
		{
			zero.x += targetPos2D.x - screenRect.xMin;
		}
		if (targetPos2D.x > screenRect.xMax)
		{
			zero.x += targetPos2D.x - screenRect.xMax;
		}
		zero.y += targetPos2D.y - screenRect.yMin;
		return zero;
	}

	public override void MutateCameraState(ref CameraState curState, float deltaTime)
	{
		LensSettings lens = curState.Lens;
		Vector3 vector = FollowTargetPosition + m_TrackedObjectOffset;
		bool flag = deltaTime >= 0f && VirtualCamera.PreviousStateIsValid;
		if (!flag || VirtualCamera.FollowTargetChanged)
		{
			m_Predictor.Reset();
		}
		if (!flag)
		{
			m_PreviousCameraPosition = curState.RawPosition;
			m_prevFOV = (lens.Orthographic ? lens.OrthographicSize : lens.FieldOfView);
			m_prevRotation = curState.RawOrientation;
			if (!m_InheritingPosition && m_CenterOnActivate)
			{
				Vector3 vector2 = curState.RawOrientation * Vector3.back;
				float num = m_CameraDistance / Mathf.Abs(vector2.z);
				m_PreviousCameraPosition = FollowTargetPosition + vector2 * num;
			}
		}
		if (!IsValid)
		{
			m_InheritingPosition = false;
			return;
		}
		if (MonoECS.instance != null && MonoECS.instance.mainEntity.IsValid && MonoECS.instance.mainEntity.IsLogicAvailable())
		{
			Quaternion quaternion = MonoECS.instance.mainEntity.GetCompPhysics().OnPathQuaternion;
			if (deltaTime >= 0f)
			{
				float t = VirtualCamera.DetachedFollowTargetDamp(1f, m_Damping, deltaTime);
				quaternion = Quaternion.Slerp(m_PreviousReferenceOrientation, quaternion, t);
			}
			m_PreviousReferenceOrientation = quaternion;
			curState.RawOrientation = quaternion;
		}
		float fieldOfView = lens.FieldOfView;
		Vector3 vector3 = curState.RawOrientation * Vector3.forward;
		Vector3 vector4 = curState.RawOrientation * Vector3.right;
		Vector3 vector5 = curState.RawOrientation * Vector3.up;
		ICinemachineTargetGroup abstractFollowTargetGroup = AbstractFollowTargetGroup;
		bool flag2 = abstractFollowTargetGroup != null && m_GroupFramingMode != FramingMode.None && !abstractFollowTargetGroup.IsEmpty;
		if (flag2)
		{
			vector = ComputeGroupBounds(abstractFollowTargetGroup, ref curState);
		}
		TrackedPoint = vector;
		if (m_LookaheadTime > 0.0001f)
		{
			m_Predictor.Smoothing = m_LookaheadSmoothing;
			m_Predictor.AddPosition(vector, deltaTime, m_LookaheadTime);
			Vector3 vector6 = m_Predictor.PredictPositionDelta(m_LookaheadTime);
			if (m_LookaheadIgnoreY)
			{
				vector6 = vector6.ProjectOntoPlane(curState.ReferenceUp);
			}
			Vector3 trackedPoint = vector + vector6;
			if (flag2)
			{
				Bounds lastBounds = LastBounds;
				lastBounds.center += LastBoundsMatrix.MultiplyPoint3x4(vector6);
				LastBounds = lastBounds;
			}
			TrackedPoint = trackedPoint;
		}
		if (!curState.HasLookAt)
		{
			curState.ReferenceLookAt = vector;
		}
		float num2 = m_CameraDistance;
		bool orthographic = lens.Orthographic;
		float a = (flag2 ? GetTargetHeight(LastBounds.size / m_GroupFramingSize) : 0f);
		a = Mathf.Max(a, 0.01f);
		if (!orthographic & flag2)
		{
			float z = LastBounds.extents.z;
			float z2 = LastBounds.center.z;
			if (z2 > z)
			{
				a = Mathf.Lerp(0f, a, (z2 - z) / z2);
			}
			if (m_AdjustmentMode != AdjustmentMode.ZoomOnly)
			{
				num2 = a / (2f * Mathf.Tan(fieldOfView * (MathF.PI / 180f) / 2f));
				num2 = Mathf.Clamp(num2, m_MinimumDistance, m_MaximumDistance);
				float value = num2 - m_CameraDistance;
				value = Mathf.Clamp(value, 0f - m_MaxDollyIn, m_MaxDollyOut);
				num2 = m_CameraDistance + value;
			}
		}
		Quaternion rawOrientation = curState.RawOrientation;
		if (flag && m_TargetMovementOnly)
		{
			Quaternion quaternion2 = rawOrientation * Quaternion.Inverse(m_prevRotation);
			m_PreviousCameraPosition = TrackedPoint + quaternion2 * (m_PreviousCameraPosition - TrackedPoint);
		}
		m_prevRotation = rawOrientation;
		Vector3 previousCameraPosition = m_PreviousCameraPosition;
		Quaternion quaternion3 = Quaternion.Inverse(rawOrientation);
		Vector3 vector7 = quaternion3 * previousCameraPosition;
		Vector3 targetPos2D = quaternion3 * TrackedPoint - vector7;
		Vector3 initial = new Vector3(0f, 0f, targetPos2D.z - num2);
		float orthoSize = (lens.Orthographic ? lens.OrthographicSize : (Mathf.Tan(0.5f * fieldOfView * (MathF.PI / 180f)) * (num2 / vector3.magnitude)));
		Rect rect = ScreenToOrtho(SoftGuideRect, orthoSize, lens.Aspect);
		if (!flag)
		{
			Rect screenRect = rect;
			if (m_CenterOnActivate && !m_InheritingPosition)
			{
				screenRect = new Rect(screenRect.center, Vector2.zero);
			}
			initial += OrthoOffsetToScreenBounds(targetPos2D, screenRect);
		}
		else
		{
			if (!dontMoveUp && LocalPlayerLanded())
			{
				initial += OrthoOffsetToScreenBoundsLower(targetPos2D, rect);
			}
			else
			{
				initial += OrthoOffsetToScreenBounds(targetPos2D, rect);
			}
			initial = VirtualCamera.DetachedFollowTargetDamp(initial, new Vector3(m_XDamping, m_YDamping, m_ZDamping), deltaTime);
			if (!m_UnlimitedSoftZone && (deltaTime < 0f || VirtualCamera.FollowTargetAttachment > 0.9999f))
			{
				Rect screenRect2 = ScreenToOrtho(HardGuideRect, orthoSize, lens.Aspect);
				Vector3 vector8 = quaternion3 * vector - vector7;
				initial += OrthoOffsetToScreenBounds(vector8 - vector3 * initial.z - vector4 * initial.x - vector5 * initial.y, screenRect2);
			}
		}
		initial.x /= vector3.magnitude;
		m_PreviousCameraPosition = (curState.RawPosition = previousCameraPosition + vector3 * initial.z + vector4 * initial.x + vector5 * initial.y);
		if (flag2)
		{
			if (orthographic)
			{
				a = Mathf.Clamp(a / 2f, m_MinimumOrthoSize, m_MaximumOrthoSize);
				if (flag)
				{
					a = m_prevFOV + VirtualCamera.DetachedFollowTargetDamp(a - m_prevFOV, m_ZDamping, deltaTime);
				}
				m_prevFOV = a;
				lens.OrthographicSize = Mathf.Clamp(a, m_MinimumOrthoSize, m_MaximumOrthoSize);
				curState.Lens = lens;
			}
			else if (m_AdjustmentMode != AdjustmentMode.DollyOnly)
			{
				float z3 = (Quaternion.Inverse(curState.RawOrientation) * (vector - curState.RawPosition)).z;
				float value2 = 179f;
				if (z3 > 0.0001f)
				{
					value2 = 2f * Mathf.Atan(a / (2f * z3)) * 57.29578f;
				}
				value2 = Mathf.Clamp(value2, m_MinimumFOV, m_MaximumFOV);
				if (flag)
				{
					value2 = m_prevFOV + VirtualCamera.DetachedFollowTargetDamp(value2 - m_prevFOV, m_ZDamping, deltaTime);
				}
				m_prevFOV = value2;
				lens.FieldOfView = value2;
				curState.Lens = lens;
			}
		}
		m_InheritingPosition = false;
	}

	private float GetTargetHeight(Vector2 boundsSize)
	{
		return m_GroupFramingMode switch
		{
			FramingMode.Horizontal => boundsSize.x / VcamState.Lens.Aspect, 
			FramingMode.Vertical => boundsSize.y, 
			_ => Mathf.Max(boundsSize.x / VcamState.Lens.Aspect, boundsSize.y), 
		};
	}

	private Vector3 ComputeGroupBounds(ICinemachineTargetGroup group, ref CameraState curState)
	{
		Vector3 rawPosition = curState.RawPosition;
		Vector3 vector = curState.RawOrientation * Vector3.forward;
		LastBoundsMatrix = Matrix4x4.TRS(rawPosition, curState.RawOrientation, Vector3.one);
		Bounds lastBounds = group.GetViewSpaceBoundingBox(LastBoundsMatrix);
		Vector3 vector2 = LastBoundsMatrix.MultiplyPoint3x4(lastBounds.center);
		float z = lastBounds.extents.z;
		if (!curState.Lens.Orthographic)
		{
			float z2 = (Quaternion.Inverse(curState.RawOrientation) * (vector2 - rawPosition)).z;
			rawPosition = vector2 - vector * (Mathf.Max(z2, z) + z);
			lastBounds = GetScreenSpaceGroupBoundingBox(group, ref rawPosition, curState.RawOrientation);
			LastBoundsMatrix = Matrix4x4.TRS(rawPosition, curState.RawOrientation, Vector3.one);
			vector2 = LastBoundsMatrix.MultiplyPoint3x4(lastBounds.center);
		}
		LastBounds = lastBounds;
		return vector2 - vector * z;
	}

	private static Bounds GetScreenSpaceGroupBoundingBox(ICinemachineTargetGroup group, ref Vector3 pos, Quaternion orientation)
	{
		Matrix4x4 observer = Matrix4x4.TRS(pos, orientation, Vector3.one);
		group.GetViewSpaceAngularBounds(observer, out var minAngles, out var maxAngles, out var zRange);
		Vector3 point = Quaternion.identity.ApplyCameraRotation((minAngles + maxAngles) / 2f, Vector3.up) * new Vector3(0f, 0f, (zRange.y + zRange.x) / 2f);
		point.z = 0f;
		pos = observer.MultiplyPoint3x4(point);
		observer = Matrix4x4.TRS(pos, orientation, Vector3.one);
		group.GetViewSpaceAngularBounds(observer, out minAngles, out maxAngles, out zRange);
		float num = zRange.y - zRange.x;
		float num2 = zRange.x + num / 2f;
		Vector2 vector = new Vector2(89.5f, 89.5f);
		if (zRange.x > 0f)
		{
			vector = Vector2.Max(maxAngles, minAngles.Abs());
			vector = Vector2.Min(vector, new Vector2(89.5f, 89.5f));
		}
		vector *= MathF.PI / 180f;
		return new Bounds(new Vector3(0f, 0f, num2), new Vector3(Mathf.Tan(vector.y) * num2 * 2f, Mathf.Tan(vector.x) * num2 * 2f, num));
	}

	private bool LocalPlayerLanded()
	{
		if (m_ECS == null)
		{
			m_ECS = MonoECS.instance;
			if (m_ECS == null)
			{
				return false;
			}
		}
		if (m_ECS.mainEntity.IsLogicAvailable())
		{
			return m_ECS.mainEntity.GetCompPhysics().state != ACTMovementMode.Falling;
		}
		return false;
	}
}
