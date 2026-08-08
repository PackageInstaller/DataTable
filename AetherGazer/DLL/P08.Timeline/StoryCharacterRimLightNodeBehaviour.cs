using UnityEngine;
using UnityEngine.Playables;

public class StoryCharacterRimLightNodeBehaviour : PlayableBehaviour
{
	public Gradient m_rimLightColor;

	public AnimationCurve m_rimLightThreshold;

	public AnimationCurve m_rimLightFade;

	public AnimationCurve m_rimLightRange;

	public AnimationCurve m_rimLightInclination;

	public AnimationCurve m_rimLightAzimuth1;

	public AnimationCurve m_rimLightAzimuth2;

	public bool m_resetValueAfterEnd = true;

	private Color oldRimLightColor;

	private float oldRimLightThreshold;

	private float oldRimLightFade;

	private float oldRimLightRange;

	private float oldRimLightInclination;

	private float oldRimLightAzimuth1;

	private float oldRimLightAzimuth2;

	private bool running;

	private CharacterEffect characterEffect;

	private void SetRun()
	{
		if (!running && characterEffect != null)
		{
			running = true;
			oldRimLightColor = characterEffect.rimLightColor;
			oldRimLightThreshold = characterEffect.rimLightThreshold;
			oldRimLightFade = characterEffect.rimLightFade;
			oldRimLightRange = characterEffect.rimLightRange;
			oldRimLightInclination = characterEffect.rimLightInclination;
			oldRimLightAzimuth1 = characterEffect.rimLightAzimuth1;
			oldRimLightAzimuth2 = characterEffect.rimLightAzimuth2;
		}
	}

	private void SetStop()
	{
		if (running && characterEffect != null)
		{
			running = false;
			if (m_resetValueAfterEnd)
			{
				characterEffect.rimLightColor = oldRimLightColor;
				characterEffect.rimLightThreshold = oldRimLightThreshold;
				characterEffect.rimLightFade = oldRimLightFade;
				characterEffect.rimLightRange = oldRimLightRange;
				characterEffect.rimLightInclination = oldRimLightInclination;
				characterEffect.rimLightAzimuth1 = oldRimLightAzimuth1;
				characterEffect.rimLightAzimuth2 = oldRimLightAzimuth2;
			}
		}
	}

	private void SetValue(float ratio)
	{
		if (running && characterEffect != null)
		{
			characterEffect.rimLightColor = m_rimLightColor.Evaluate(ratio);
			characterEffect.rimLightThreshold = m_rimLightThreshold.Evaluate(ratio);
			characterEffect.rimLightFade = m_rimLightFade.Evaluate(ratio);
			characterEffect.rimLightRange = m_rimLightRange.Evaluate(ratio);
			characterEffect.rimLightInclination = m_rimLightInclination.Evaluate(ratio);
			characterEffect.rimLightAzimuth1 = m_rimLightAzimuth1.Evaluate(ratio);
			characterEffect.rimLightAzimuth2 = m_rimLightAzimuth2.Evaluate(ratio);
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
		if (characterEffect == null)
		{
			characterEffect = (CharacterEffect)playerData;
		}
		SetRun();
		if (characterEffect != null)
		{
			double time = playable.GetTime();
			double duration = playable.GetDuration();
			float value = (float)(time / duration);
			SetValue(value);
		}
	}
}
