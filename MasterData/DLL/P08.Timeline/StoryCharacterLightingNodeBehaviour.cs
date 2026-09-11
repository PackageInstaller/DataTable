using UnityEngine;
using UnityEngine.Playables;

public class StoryCharacterLightingNodeBehaviour : PlayableBehaviour
{
	public AnimationCurve m_lightInclination;

	public AnimationCurve m_lightAzimuth;

	private bool running;

	private CharacterEffect m_characterEffect;

	private float originInclination;

	private float originAzimuth;

	public bool m_ResetValueAfterEnd = true;

	private void SetRun()
	{
		if (!running && m_characterEffect != null)
		{
			running = true;
			originInclination = m_characterEffect.lightInclination;
			originAzimuth = m_characterEffect.lightAzimuth;
		}
	}

	private void SetStop()
	{
		if (running && m_characterEffect != null)
		{
			running = false;
			if (m_ResetValueAfterEnd)
			{
				m_characterEffect.lightInclination = originInclination;
				m_characterEffect.lightAzimuth = originAzimuth;
			}
		}
	}

	private void SetValue(float ratio)
	{
		if (running && m_characterEffect != null)
		{
			m_characterEffect.lightInclination = m_lightInclination.Evaluate(ratio);
			m_characterEffect.lightAzimuth = m_lightAzimuth.Evaluate(ratio);
		}
	}

	public override void OnBehaviourPlay(Playable playable, FrameData info)
	{
		SetRun();
	}

	public override void OnBehaviourPause(Playable playable, FrameData info)
	{
		SetStop();
	}

	public override void ProcessFrame(Playable playable, FrameData info, object playerData)
	{
		if (m_characterEffect == null)
		{
			m_characterEffect = playerData as CharacterEffect;
		}
		SetRun();
		if (m_characterEffect != null)
		{
			double num = playable.GetTime() / playable.GetDuration();
			SetValue((float)num);
		}
	}
}
