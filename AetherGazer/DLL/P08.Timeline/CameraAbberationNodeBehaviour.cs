using UnityEngine;
using UnityEngine.Pipelines.SimPipeline;
using UnityEngine.Playables;

public class CameraAbberationNodeBehaviour : PlayableBehaviour
{
	private CameraExtension m_cameraExtension;

	private float m_abberationIntensityValue;

	private AnimationCurve m_abberationIntensityCurve;

	public static ScriptPlayable<CameraAbberationNodeBehaviour> Create(PlayableGraph graph, params object[] args)
	{
		ScriptPlayable<CameraAbberationNodeBehaviour> result = ScriptPlayable<CameraAbberationNodeBehaviour>.Create(graph);
		result.GetBehaviour().Initialize(args);
		return result;
	}

	public void Initialize(params object[] args)
	{
		m_cameraExtension = Camera.main.gameObject.GetComponent<CameraExtension>();
		m_abberationIntensityValue = (float)args[0];
		m_abberationIntensityCurve = args[1] as AnimationCurve;
	}

	public override void ProcessFrame(Playable playable, FrameData info, object playerData)
	{
		if (!(m_cameraExtension == null))
		{
			double time = playable.GetTime();
			double duration = playable.GetDuration();
			double num = time / duration;
			if (m_abberationIntensityValue != 0f)
			{
				m_cameraExtension.abberationIntensity = m_abberationIntensityValue * m_abberationIntensityCurve.Evaluate((float)num);
			}
		}
	}

	public override void OnBehaviourPause(Playable playable, FrameData info)
	{
		if (!(m_cameraExtension == null))
		{
			m_cameraExtension.abberationIntensity = 0f;
		}
	}
}
