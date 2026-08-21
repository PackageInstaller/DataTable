using System;
using Cinemachine.Utility;
using UnityEngine;

namespace Cinemachine;

[DocumentationSorting(DocumentationSortingAttribute.Level.UserRef)]
[AddComponentMenu("")]
[SaveDuringPlay]
public class CinemachineComposer : CinemachineComponentBase
{
	private struct FovCache
	{
		public Rect mFovSoftGuideRect;

		public Rect mFovHardGuideRect;

		public float mFovH;

		public float mFov;

		private float mOrthoSizeOverDistance;

		private float mAspect;

		private Rect mSoftGuideRect;

		private Rect mHardGuideRect;

		public void UpdateCache(LensSettings lens, Rect softGuide, Rect hardGuide, float targetDistance)
		{
			bool flag = mAspect != lens.Aspect || softGuide != mSoftGuideRect || hardGuide != mHardGuideRect;
			if (lens.Orthographic)
			{
				float num = Mathf.Abs(lens.OrthographicSize / targetDistance);
				if (mOrthoSizeOverDistance == 0f || Mathf.Abs(num - mOrthoSizeOverDistance) / mOrthoSizeOverDistance > mOrthoSizeOverDistance * 0.01f)
				{
					flag = true;
				}
				if (flag)
				{
					mFov = 114.59156f * Mathf.Atan(num);
					mFovH = 114.59156f * Mathf.Atan(lens.Aspect * num);
					mOrthoSizeOverDistance = num;
				}
			}
			else
			{
				float fieldOfView = lens.FieldOfView;
				if (mFov != fieldOfView)
				{
					flag = true;
				}
				if (flag)
				{
					mFov = fieldOfView;
					double num2 = 2.0 * Math.Atan(Math.Tan(mFov * (MathF.PI / 180f) / 2f) * (double)lens.Aspect);
					mFovH = (float)(57.295780181884766 * num2);
					mOrthoSizeOverDistance = 0f;
				}
			}
			if (flag)
			{
				mFovSoftGuideRect = ScreenToFOV(softGuide, mFov, mFovH, lens.Aspect);
				mSoftGuideRect = softGuide;
				mFovHardGuideRect = ScreenToFOV(hardGuide, mFov, mFovH, lens.Aspect);
				mHardGuideRect = hardGuide;
				mAspect = lens.Aspect;
			}
		}

		private Rect ScreenToFOV(Rect rScreen, float fov, float fovH, float aspect)
		{
			Rect result = new Rect(rScreen);
			Matrix4x4 inverse = Matrix4x4.Perspective(fov, aspect, 0.0001f, 2f).inverse;
			Vector3 v = inverse.MultiplyPoint(new Vector3(0f, result.yMin * 2f - 1f, 0.5f));
			v.z = 0f - v.z;
			float num = UnityVectorExtensions.SignedAngle(Vector3.forward, v, Vector3.left);
			result.yMin = (fov / 2f + num) / fov;
			v = inverse.MultiplyPoint(new Vector3(0f, result.yMax * 2f - 1f, 0.5f));
			v.z = 0f - v.z;
			num = UnityVectorExtensions.SignedAngle(Vector3.forward, v, Vector3.left);
			result.yMax = (fov / 2f + num) / fov;
			v = inverse.MultiplyPoint(new Vector3(result.xMin * 2f - 1f, 0f, 0.5f));
			v.z = 0f - v.z;
			num = UnityVectorExtensions.SignedAngle(Vector3.forward, v, Vector3.up);
			result.xMin = (fovH / 2f + num) / fovH;
			v = inverse.MultiplyPoint(new Vector3(result.xMax * 2f - 1f, 0f, 0.5f));
			v.z = 0f - v.z;
			num = UnityVectorExtensions.SignedAngle(Vector3.forward, v, Vector3.up);
			result.xMax = (fovH / 2f + num) / fovH;
			return result;
		}
	}

	[Tooltip("Target offset from the target object's center in target-local space. Use this to fine-tune the tracking target position when the desired area is not the tracked object's center.")]
	public Vector3 m_TrackedObjectOffset = Vector3.zero;

	[Space]
	[Tooltip("This setting will instruct the composer to adjust its target offset based on the motion of the target.  The composer will look at a point where it estimates the target will be this many seconds into the future.  Note that this setting is sensitive to noisy animation, and can amplify the noise, resulting in undesirable camera jitter.  If the camera jitters unacceptably when the target is in motion, turn down this setting, or animate the target more smoothly.")]
	[Range(0f, 1f)]
	public float m_LookaheadTime;

	[Tooltip("Controls the smoothness of the lookahead algorithm.  Larger values smooth out jittery predictions and also increase prediction lag")]
	[Range(0f, 30f)]
	public float m_LookaheadSmoothing;

	[Tooltip("If checked, movement along the Y axis will be ignored for lookahead calculations")]
	public bool m_LookaheadIgnoreY;

	[Tooltip("How aggressively the camera tries to follow the target in the screen-horizontal direction. Small numbers are more responsive, rapidly orienting the camera to keep the target in the dead zone. Larger numbers give a more heavy slowly responding camera. Using different vertical and horizontal settings can yield a wide range of camera behaviors.")]
	[Range(0f, 20f)]
	[Space]
	public float m_HorizontalDamping = 0.5f;

	[Range(0f, 20f)]
	[Tooltip("How aggressively the camera tries to follow the target in the screen-vertical direction. Small numbers are more responsive, rapidly orienting the camera to keep the target in the dead zone. Larger numbers give a more heavy slowly responding camera. Using different vertical and horizontal settings can yield a wide range of camera behaviors.")]
	public float m_VerticalDamping = 0.5f;

	[Space]
	[Range(-0.5f, 1.5f)]
	[Tooltip("Horizontal screen position for target. The camera will rotate to position the tracked object here.")]
	public float m_ScreenX = 0.5f;

	[Range(-0.5f, 1.5f)]
	[Tooltip("Vertical screen position for target, The camera will rotate to position the tracked object here.")]
	public float m_ScreenY = 0.5f;

	[Range(0f, 2f)]
	[Tooltip("Camera will not rotate horizontally if the target is within this range of the position.")]
	public float m_DeadZoneWidth;

	[Range(0f, 2f)]
	[Tooltip("Camera will not rotate vertically if the target is within this range of the position.")]
	public float m_DeadZoneHeight;

	[Range(0f, 2f)]
	[Tooltip("When target is within this region, camera will gradually rotate horizontally to re-align towards the desired position, depending on the damping speed.")]
	public float m_SoftZoneWidth = 0.8f;

	[Tooltip("When target is within this region, camera will gradually rotate vertically to re-align towards the desired position, depending on the damping speed.")]
	[Range(0f, 2f)]
	public float m_SoftZoneHeight = 0.8f;

	[Range(-0.5f, 0.5f)]
	[Tooltip("A non-zero bias will move the target position horizontally away from the center of the soft zone.")]
	public float m_BiasX;

	[Tooltip("A non-zero bias will move the target position vertically away from the center of the soft zone.")]
	[Range(-0.5f, 0.5f)]
	public float m_BiasY;

	[Tooltip("Force target to center of screen when this camera activates.  If false, will clamp target to the edges of the dead zone")]
	public bool m_CenterOnActivate = true;

	private Vector3 m_CameraPosPrevFrame = Vector3.zero;

	private Vector3 m_LookAtPrevFrame = Vector3.zero;

	private Vector2 m_ScreenOffsetPrevFrame = Vector2.zero;

	private Quaternion m_CameraOrientationPrevFrame = Quaternion.identity;

	internal PositionPredictor m_Predictor = new PositionPredictor();

	private FovCache mCache;

	public override bool IsValid
	{
		get
		{
			if (base.enabled)
			{
				return base.LookAtTarget != null;
			}
			return false;
		}
	}

	public override CinemachineCore.Stage Stage => CinemachineCore.Stage.Aim;

	public Vector3 TrackedPoint { get; private set; }

	internal Rect SoftGuideRect
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

	internal Rect HardGuideRect
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
		}
	}

	protected virtual Vector3 GetLookAtPointAndSetTrackedPoint(Vector3 lookAt, Vector3 up, float deltaTime)
	{
		Vector3 vector = lookAt;
		if (base.LookAtTarget != null)
		{
			vector += base.LookAtTargetRotation * m_TrackedObjectOffset;
		}
		if (m_LookaheadTime < 0.0001f)
		{
			TrackedPoint = vector;
		}
		else
		{
			bool flag = base.VirtualCamera.LookAtTargetChanged || !base.VirtualCamera.PreviousStateIsValid;
			m_Predictor.Smoothing = m_LookaheadSmoothing;
			m_Predictor.AddPosition(vector, flag ? (-1f) : deltaTime, m_LookaheadTime);
			Vector3 vector2 = m_Predictor.PredictPositionDelta(m_LookaheadTime);
			if (m_LookaheadIgnoreY)
			{
				vector2 = vector2.ProjectOntoPlane(up);
			}
			TrackedPoint = vector + vector2;
		}
		return vector;
	}

	public override void OnTargetObjectWarped(Transform target, Vector3 positionDelta)
	{
		base.OnTargetObjectWarped(target, positionDelta);
		if (target == base.LookAtTarget)
		{
			m_CameraPosPrevFrame += positionDelta;
			m_LookAtPrevFrame += positionDelta;
			m_Predictor.ApplyTransformDelta(positionDelta);
		}
	}

	public override void ForceCameraPosition(Vector3 pos, Quaternion rot)
	{
		base.ForceCameraPosition(pos, rot);
		m_CameraPosPrevFrame = pos;
		m_CameraOrientationPrevFrame = rot;
	}

	public override float GetMaxDampTime()
	{
		return Mathf.Max(m_HorizontalDamping, m_VerticalDamping);
	}

	public override void PrePipelineMutateCameraState(ref CameraState curState, float deltaTime)
	{
		if (IsValid && curState.HasLookAt)
		{
			curState.ReferenceLookAt = GetLookAtPointAndSetTrackedPoint(curState.ReferenceLookAt, curState.ReferenceUp, deltaTime);
		}
	}

	public override void MutateCameraState(ref CameraState curState, float deltaTime)
	{
		if (!IsValid || !curState.HasLookAt)
		{
			return;
		}
		if (!(TrackedPoint - curState.ReferenceLookAt).AlmostZero())
		{
			Vector3 vector = Vector3.Lerp(curState.CorrectedPosition, curState.ReferenceLookAt, 0.5f);
			Vector3 lhs = curState.ReferenceLookAt - vector;
			Vector3 rhs = TrackedPoint - vector;
			if (Vector3.Dot(lhs, rhs) < 0f)
			{
				float t = Vector3.Distance(curState.ReferenceLookAt, vector) / Vector3.Distance(curState.ReferenceLookAt, TrackedPoint);
				TrackedPoint = Vector3.Lerp(curState.ReferenceLookAt, TrackedPoint, t);
			}
		}
		float magnitude = (TrackedPoint - curState.CorrectedPosition).magnitude;
		if (magnitude < 0.0001f)
		{
			if (deltaTime >= 0f && base.VirtualCamera.PreviousStateIsValid)
			{
				curState.RawOrientation = m_CameraOrientationPrevFrame;
			}
			return;
		}
		mCache.UpdateCache(curState.Lens, SoftGuideRect, HardGuideRect, magnitude);
		Quaternion rawOrientation = curState.RawOrientation;
		if (deltaTime < 0f || !base.VirtualCamera.PreviousStateIsValid)
		{
			rawOrientation = Quaternion.LookRotation(rawOrientation * Vector3.forward, curState.ReferenceUp);
			Rect screenRect = mCache.mFovSoftGuideRect;
			if (m_CenterOnActivate)
			{
				screenRect = new Rect(screenRect.center, Vector2.zero);
			}
			RotateToScreenBounds(ref curState, screenRect, curState.ReferenceLookAt, ref rawOrientation, mCache.mFov, mCache.mFovH, -1f);
		}
		else
		{
			Vector3 vector2 = m_LookAtPrevFrame - m_CameraPosPrevFrame;
			if (vector2.AlmostZero())
			{
				rawOrientation = Quaternion.LookRotation(m_CameraOrientationPrevFrame * Vector3.forward, curState.ReferenceUp);
			}
			else
			{
				vector2 = Quaternion.Euler(curState.PositionDampingBypass) * vector2;
				rawOrientation = Quaternion.LookRotation(vector2, curState.ReferenceUp);
				rawOrientation = rawOrientation.ApplyCameraRotation(-m_ScreenOffsetPrevFrame, curState.ReferenceUp);
			}
			RotateToScreenBounds(ref curState, mCache.mFovSoftGuideRect, TrackedPoint, ref rawOrientation, mCache.mFov, mCache.mFovH, deltaTime);
			if (deltaTime < 0f || base.VirtualCamera.LookAtTargetAttachment > 0.9999f)
			{
				RotateToScreenBounds(ref curState, mCache.mFovHardGuideRect, curState.ReferenceLookAt, ref rawOrientation, mCache.mFov, mCache.mFovH, -1f);
			}
		}
		m_CameraPosPrevFrame = curState.CorrectedPosition;
		m_LookAtPrevFrame = TrackedPoint;
		m_CameraOrientationPrevFrame = rawOrientation.Normalized();
		m_ScreenOffsetPrevFrame = m_CameraOrientationPrevFrame.GetCameraRotationToTarget(m_LookAtPrevFrame - curState.CorrectedPosition, curState.ReferenceUp);
		curState.RawOrientation = m_CameraOrientationPrevFrame;
	}

	private void RotateToScreenBounds(ref CameraState state, Rect screenRect, Vector3 trackedPoint, ref Quaternion rigOrientation, float fov, float fovH, float deltaTime)
	{
		Vector3 vector = trackedPoint - state.CorrectedPosition;
		Vector2 cameraRotationToTarget = rigOrientation.GetCameraRotationToTarget(vector, state.ReferenceUp);
		ClampVerticalBounds(ref screenRect, vector, state.ReferenceUp, fov);
		float num = (screenRect.yMin - 0.5f) * fov;
		float num2 = (screenRect.yMax - 0.5f) * fov;
		if (cameraRotationToTarget.x < num)
		{
			cameraRotationToTarget.x -= num;
		}
		else if (cameraRotationToTarget.x > num2)
		{
			cameraRotationToTarget.x -= num2;
		}
		else
		{
			cameraRotationToTarget.x = 0f;
		}
		num = (screenRect.xMin - 0.5f) * fovH;
		num2 = (screenRect.xMax - 0.5f) * fovH;
		if (cameraRotationToTarget.y < num)
		{
			cameraRotationToTarget.y -= num;
		}
		else if (cameraRotationToTarget.y > num2)
		{
			cameraRotationToTarget.y -= num2;
		}
		else
		{
			cameraRotationToTarget.y = 0f;
		}
		if (deltaTime >= 0f && base.VirtualCamera.PreviousStateIsValid)
		{
			cameraRotationToTarget.x = base.VirtualCamera.DetachedLookAtTargetDamp(cameraRotationToTarget.x, m_VerticalDamping, deltaTime);
			cameraRotationToTarget.y = base.VirtualCamera.DetachedLookAtTargetDamp(cameraRotationToTarget.y, m_HorizontalDamping, deltaTime);
		}
		rigOrientation = rigOrientation.ApplyCameraRotation(cameraRotationToTarget, state.ReferenceUp);
	}

	private bool ClampVerticalBounds(ref Rect r, Vector3 dir, Vector3 up, float fov)
	{
		float num = UnityVectorExtensions.Angle(dir, up);
		float num2 = fov / 2f + 1f;
		if (num < num2)
		{
			float num3 = 1f - (num2 - num) / fov;
			if (r.yMax > num3)
			{
				r.yMin = Mathf.Min(r.yMin, num3);
				r.yMax = Mathf.Min(r.yMax, num3);
				return true;
			}
		}
		if (num > 180f - num2)
		{
			float num4 = (num - (180f - num2)) / fov;
			if (num4 > r.yMin)
			{
				r.yMin = Mathf.Max(r.yMin, num4);
				r.yMax = Mathf.Max(r.yMax, num4);
				return true;
			}
		}
		return false;
	}
}
