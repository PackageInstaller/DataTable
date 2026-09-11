using UnityEngine;
using UnityEngine.Pipelines.SimPipeline;
using UnityEngine.Playables;

public class StoryDarkCornerNodeBehaviour : PlayableBehaviour
{
	public Color color;

	public AnimationCurve strengthCurve;

	public AnimationCurve softCurve;

	public bool bounded;

	public bool isUseScreenPos;

	public Transform trans;

	public Vector2 screenPos;

	private CameraExtension m_cameraExtension;

	public void ResetCameraVignetteParams()
	{
		if (m_cameraExtension == null)
		{
			m_cameraExtension = Camera.main.gameObject.GetComponent<CameraExtension>();
		}
		if (!(m_cameraExtension == null))
		{
			m_cameraExtension.vignetteColor = Color.black;
			m_cameraExtension.vignetteStrength = 0f;
			m_cameraExtension.vignetteSoft = 0.2f;
			m_cameraExtension.vignetteBounded = false;
			m_cameraExtension.vignetteTransform = Vector2.one * 0.5f;
			m_cameraExtension.vignetteTarget = null;
		}
	}

	public override void OnBehaviourPause(Playable playable, FrameData info)
	{
		ResetCameraVignetteParams();
	}

	public override void OnBehaviourPlay(Playable playable, FrameData info)
	{
		ResetCameraVignetteParams();
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
			float vignetteStrength = strengthCurve.Evaluate(time2);
			float vignetteSoft = softCurve.Evaluate(time2);
			m_cameraExtension.vignetteColor = color;
			m_cameraExtension.vignetteStrength = vignetteStrength;
			m_cameraExtension.vignetteSoft = vignetteSoft;
			m_cameraExtension.vignetteBounded = bounded;
			if (!isUseScreenPos)
			{
				m_cameraExtension.vignetteTarget = trans;
			}
			else
			{
				m_cameraExtension.vignetteTransform = screenPos;
			}
		}
	}
}
