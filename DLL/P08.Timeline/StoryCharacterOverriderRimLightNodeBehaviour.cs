using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Pipelines.SimPipeline.Character;
using UnityEngine.Playables;

public class StoryCharacterOverriderRimLightNodeBehaviour : PlayableBehaviour
{
	public Gradient m_rimLightColor;

	public AnimationCurve m_rimLightThreshold;

	public AnimationCurve m_rimLightFade;

	public AnimationCurve m_rimLightRange;

	public AnimationCurve m_rimLightInclination;

	public AnimationCurve m_rimLightAzimuth1;

	public AnimationCurve m_rimLightAzimuth2;

	public bool m_resetValueAfterEnd = true;

	public bool m_assignMaterial;

	public List<int> m_materialIndexes;

	private Color oldRimLightColor;

	private float oldRimLightThreshold;

	private float oldRimLightFade;

	private float oldRimLightRange;

	private float oldRimLightInclination;

	private float oldRimLightAzimuth1;

	private float oldRimLightAzimuth2;

	private bool oldAssignMaterial;

	private List<int> oldMaterialIndexes;

	private bool running;

	private CharacterEffectOverrider characterEffectOverrider;

	private void SetRun()
	{
		if (!running && characterEffectOverrider != null)
		{
			running = true;
			characterEffectOverrider.overrideRimLight = true;
			oldRimLightColor = characterEffectOverrider.rimLightColor;
			oldRimLightThreshold = characterEffectOverrider.rimLightThreshold;
			oldRimLightFade = characterEffectOverrider.rimLightFade;
			oldRimLightRange = characterEffectOverrider.rimLightRange;
			oldRimLightInclination = characterEffectOverrider.rimLightInclination;
			oldRimLightAzimuth1 = characterEffectOverrider.rimLightAzimuth1;
			oldRimLightAzimuth2 = characterEffectOverrider.rimLightAzimuth2;
			oldAssignMaterial = characterEffectOverrider.assignMaterial;
			oldMaterialIndexes = new List<int>(characterEffectOverrider.materialIndexes);
		}
	}

	private void SetStop()
	{
		if (running && characterEffectOverrider != null)
		{
			running = false;
			if (m_resetValueAfterEnd)
			{
				characterEffectOverrider.rimLightColor = oldRimLightColor;
				characterEffectOverrider.rimLightThreshold = oldRimLightThreshold;
				characterEffectOverrider.rimLightFade = oldRimLightFade;
				characterEffectOverrider.rimLightRange = oldRimLightRange;
				characterEffectOverrider.rimLightInclination = oldRimLightInclination;
				characterEffectOverrider.rimLightAzimuth1 = oldRimLightAzimuth1;
				characterEffectOverrider.rimLightAzimuth2 = oldRimLightAzimuth2;
				characterEffectOverrider.assignMaterial = oldAssignMaterial;
				characterEffectOverrider.materialIndexes = oldMaterialIndexes;
				oldMaterialIndexes = null;
			}
		}
	}

	private void SetValue(float ratio)
	{
		if (running && characterEffectOverrider != null)
		{
			characterEffectOverrider.rimLightColor = m_rimLightColor.Evaluate(ratio);
			characterEffectOverrider.rimLightThreshold = m_rimLightThreshold.Evaluate(ratio);
			characterEffectOverrider.rimLightFade = m_rimLightFade.Evaluate(ratio);
			characterEffectOverrider.rimLightRange = m_rimLightRange.Evaluate(ratio);
			characterEffectOverrider.rimLightInclination = m_rimLightInclination.Evaluate(ratio);
			characterEffectOverrider.rimLightAzimuth1 = m_rimLightAzimuth1.Evaluate(ratio);
			characterEffectOverrider.rimLightAzimuth2 = m_rimLightAzimuth2.Evaluate(ratio);
			characterEffectOverrider.assignMaterial = m_assignMaterial;
			characterEffectOverrider.materialIndexes = m_materialIndexes;
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
		if (characterEffectOverrider == null)
		{
			characterEffectOverrider = (CharacterEffectOverrider)playerData;
		}
		SetRun();
		if (characterEffectOverrider != null)
		{
			double time = playable.GetTime();
			double duration = playable.GetDuration();
			float value = (float)(time / duration);
			SetValue(value);
		}
	}
}
