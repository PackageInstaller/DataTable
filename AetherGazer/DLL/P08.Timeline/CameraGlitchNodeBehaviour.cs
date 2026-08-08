using UnityEngine;
using UnityEngine.Pipelines.SimPipeline;
using UnityEngine.Playables;

public class CameraGlitchNodeBehaviour : PlayableBehaviour
{
	private CameraExtension m_cameraExtension;

	private float m_glitchIntensityValue;

	private AnimationCurve m_glitchIntensityCurve;

	private float m_glitchFrequencyValue;

	private AnimationCurve m_glitchFrequencyCurve;

	public static ScriptPlayable<CameraGlitchNodeBehaviour> Create(PlayableGraph graph, params object[] args)
	{
		ScriptPlayable<CameraGlitchNodeBehaviour> result = ScriptPlayable<CameraGlitchNodeBehaviour>.Create(graph);
		result.GetBehaviour().Initialize(args);
		return result;
	}

	public void Initialize(params object[] args)
	{
		m_cameraExtension = Camera.main.gameObject.GetComponent<CameraExtension>();
		m_glitchIntensityValue = (float)args[0];
		m_glitchIntensityCurve = args[1] as AnimationCurve;
		m_glitchFrequencyValue = (float)args[2];
		m_glitchFrequencyCurve = args[3] as AnimationCurve;
	}

	public override void ProcessFrame(Playable playable, FrameData info, object playerData)
	{
		if (!(m_cameraExtension == null))
		{
			double time = playable.GetTime();
			double duration = playable.GetDuration();
			double num = time / duration;
			if (m_glitchIntensityValue != 0f)
			{
				m_cameraExtension.glitchIntensity = m_glitchIntensityValue * m_glitchIntensityCurve.Evaluate((float)num);
			}
			if (m_glitchFrequencyValue != 0f)
			{
				m_cameraExtension.glitchFrequency = m_glitchFrequencyValue * m_glitchFrequencyCurve.Evaluate((float)num);
			}
		}
	}

	public override void OnBehaviourPause(Playable playable, FrameData info)
	{
		if (!(m_cameraExtension == null))
		{
			m_cameraExtension.glitchIntensity = 0f;
			m_cameraExtension.glitchFrequency = 0f;
		}
	}
}
