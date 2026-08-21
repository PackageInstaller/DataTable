using UnityEngine;
using UnityEngine.Pipelines.SimPipeline;
using UnityEngine.Playables;

public class QWorldStoryRadialBlurNodeBehaviour : PlayableBehaviour
{
	public AnimationCurve ScaleCurve = new AnimationCurve(new Keyframe(0f, 0f), new Keyframe(0.5f, 1f), new Keyframe(1f, 0f));

	public AnimationCurve RangeCurve = new AnimationCurve(new Keyframe(0f, 0f), new Keyframe(0.5f, 0f), new Keyframe(1f, 0f));

	public AnimationCurve SoftCurve = new AnimationCurve(new Keyframe(0f, 0f), new Keyframe(0.5f, 0f), new Keyframe(1f, 0f));

	public bool IsOutward;

	public AnimationCurve WarpLerp = new AnimationCurve(new Keyframe(0f, 0f), new Keyframe(0.5f, 0f), new Keyframe(1f, 0f));

	public AnimationCurve WarpScale = new AnimationCurve(new Keyframe(0f, 0f), new Keyframe(0.5f, 0f), new Keyframe(1f, 0f));

	public AnimationCurve WarpDensity = new AnimationCurve(new Keyframe(0f, 0f), new Keyframe(0.5f, 0f), new Keyframe(1f, 0f));

	public AnimationCurve AbberationIntensity = new AnimationCurve(new Keyframe(0f, 0f), new Keyframe(0.5f, 0f), new Keyframe(1f, 0f));

	public ExposedReference<Transform> CenterER;

	private Transform _center;

	public Vector2 CenterTransform = Vector2.zero;

	public bool IsUseCenterTransform;

	private CameraExtension m_cameraExtension;

	public void ResetCameraRadialBlurParams()
	{
		if (m_cameraExtension == null)
		{
			m_cameraExtension = Camera.main.gameObject.GetComponent<CameraExtension>();
		}
		if (!(m_cameraExtension == null))
		{
			m_cameraExtension.radialBlurScale = 0f;
			m_cameraExtension.radialBlurRange = 1f;
			m_cameraExtension.radialBlurSoft = 1f;
			m_cameraExtension.isRadialOutward = false;
			m_cameraExtension.radialWarpLerp = 0f;
			m_cameraExtension.radialWarpScale = 0f;
			m_cameraExtension.radialWarpDensity = 0f;
			m_cameraExtension.radialAbberationIntensity = 0f;
			m_cameraExtension.radialBlurCenterTransform = Vector2.zero;
			m_cameraExtension.radialBlurTarget = null;
			m_cameraExtension.isUseRadialCenterTransform = false;
		}
	}

	public override void OnGraphStart(Playable playable)
	{
		_center = CenterER.Resolve(playable.GetGraph().GetResolver());
	}

	public override void OnBehaviourPause(Playable playable, FrameData info)
	{
		ResetCameraRadialBlurParams();
	}

	public override void OnBehaviourPlay(Playable playable, FrameData info)
	{
		ResetCameraRadialBlurParams();
	}

	public override void ProcessFrame(Playable playable, FrameData info, object playerData)
	{
		if (m_cameraExtension == null)
		{
			m_cameraExtension = Camera.main.gameObject.GetComponent<CameraExtension>();
		}
		if (!(m_cameraExtension == null))
		{
			double time = playable.GetTime();
			double duration = playable.GetDuration();
			float time2 = (float)(time / duration);
			float radialBlurScale = ScaleCurve.Evaluate(time2);
			float radialBlurRange = RangeCurve.Evaluate(time2);
			float radialBlurSoft = SoftCurve.Evaluate(time2);
			bool isOutward = IsOutward;
			float radialWarpLerp = WarpLerp.Evaluate(time2);
			float radialWarpScale = WarpScale.Evaluate(time2);
			float radialWarpDensity = WarpDensity.Evaluate(time2);
			float radialAbberationIntensity = AbberationIntensity.Evaluate(time2);
			Vector2 centerTransform = CenterTransform;
			bool isUseCenterTransform = IsUseCenterTransform;
			m_cameraExtension.radialBlurScale = radialBlurScale;
			m_cameraExtension.radialBlurRange = radialBlurRange;
			m_cameraExtension.radialBlurSoft = radialBlurSoft;
			m_cameraExtension.isRadialOutward = isOutward;
			m_cameraExtension.radialWarpLerp = radialWarpLerp;
			m_cameraExtension.radialWarpScale = radialWarpScale;
			m_cameraExtension.radialWarpDensity = radialWarpDensity;
			m_cameraExtension.radialAbberationIntensity = radialAbberationIntensity;
			m_cameraExtension.radialBlurCenterTransform = centerTransform;
			m_cameraExtension.isUseRadialCenterTransform = isUseCenterTransform;
			if (m_cameraExtension.radialBlurTarget == null && _center != null)
			{
				m_cameraExtension.radialBlurTarget = _center;
			}
		}
	}
}
