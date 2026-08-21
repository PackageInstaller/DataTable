using System.Collections.Generic;
using UnityEngine.Pipelines.SimPipeline.Character;

public class TimelineCharacterGhostEffectClipPlayer : CommonSimpleTimelineClipPlayer<CharacterGhostEffectClip>, ILoopClipPlayer
{
	private GhostEffect m_characterGhostEffect;

	private bool m_originAuto;

	private int m_originMaxGhostCount;

	private float m_originInterval;

	private int m_nextIndex;

	public GhostEffect CharacterGhostEffect
	{
		get
		{
			return m_characterGhostEffect;
		}
		set
		{
			m_characterGhostEffect = value;
			if (m_characterGhostEffect != null)
			{
				m_originAuto = m_characterGhostEffect.auto;
				m_originMaxGhostCount = m_characterGhostEffect.maxGhostCount;
				m_originInterval = m_characterGhostEffect.interval;
			}
		}
	}

	protected override void _Initialize(List<CharacterGhostEffectClip> clips)
	{
		m_characterGhostEffect.ClearGhosts();
		m_characterGhostEffect.enabled = false;
		m_nextIndex = 0;
	}

	protected override void _EnterNodes(List<CharacterGhostEffectClip> clipsInThisFrame, float normalized, bool isRolleback = false)
	{
		if (!m_characterGhostEffect.enabled)
		{
			m_characterGhostEffect.enabled = true;
		}
	}

	protected override bool _CanTriggerOnInOutOneFrame()
	{
		return false;
	}

	protected override void _ExitNodes(List<CharacterGhostEffectClip> clipsInThisFrame, float normalized, bool isRolleback = false)
	{
		ResetGhostEffect();
	}

	protected override void _UpdateNodes(List<CharacterGhostEffectClip> clipsInThisFrame, float normalized)
	{
		CharacterGhostEffectClip characterGhostEffectClip = clipsInThisFrame[clipsInThisFrame.Count - 1];
		m_characterGhostEffect.auto = characterGhostEffectClip.AutoCreata;
		m_characterGhostEffect.maxGhostCount = characterGhostEffectClip.GhostNumber;
		m_characterGhostEffect.interval = characterGhostEffectClip.CreateInterval;
		if (normalized > characterGhostEffectClip.CreateEndNormalized)
		{
			m_characterGhostEffect.auto = false;
		}
		float time = (normalized - characterGhostEffectClip.NormalizedBegin) / (characterGhostEffectClip.NormalizedEnd - characterGhostEffectClip.NormalizedBegin);
		m_characterGhostEffect.intensity = characterGhostEffectClip.IntensityCurve.Evaluate(time);
		if (!characterGhostEffectClip.AutoCreata && m_nextIndex < characterGhostEffectClip.CreatePointNormalizedArray.Length && characterGhostEffectClip.CreatePointNormalizedArray[m_nextIndex] <= normalized)
		{
			m_characterGhostEffect.IncGhost();
			m_nextIndex++;
		}
	}

	protected override void _Stop(bool isForceClean = true)
	{
		ResetGhostEffect();
	}

	protected override void _Shutdown()
	{
		ResetGhostEffect();
	}

	public void ResetGhostEffect()
	{
		m_characterGhostEffect.auto = m_originAuto;
		m_characterGhostEffect.maxGhostCount = m_originMaxGhostCount;
		m_characterGhostEffect.interval = m_originInterval;
		m_characterGhostEffect.ClearGhosts();
		m_characterGhostEffect.enabled = false;
	}
}
