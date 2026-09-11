using System.Collections.Generic;

public class TimelineAudioPlayer : CommonSimpleTimelineClipPlayer<AudioPlayActionClip>, ILoopClipPlayer
{
	public CriAtomSource m_CriAtomSource;

	private List<CriAtomExPlayback> m_EffectPlaybacks = new List<CriAtomExPlayback>(20);

	private List<CriAtomExPlayback> m_VoicePlaybacks = new List<CriAtomExPlayback>(20);

	protected override void _Initialize(List<AudioPlayActionClip> clips)
	{
		m_EffectPlaybacks.Clear();
		m_VoicePlaybacks.Clear();
	}

	protected override void _EnterNodes(List<AudioPlayActionClip> clipsInThisFrame, float normalized, bool isRolleback = false)
	{
		BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
		WorldStateManager worldStateManager = null;
		if (battleScene != null)
		{
			worldStateManager = battleScene.GetWorldSatetManager();
			if (!worldStateManager.notMuteBattleVoice)
			{
				return;
			}
		}
		for (int i = 0; i < clipsInThisFrame.Count; i++)
		{
			AudioPlayActionClip audioPlayActionClip = clipsInThisFrame[i];
			if (string.IsNullOrEmpty(audioPlayActionClip.CueSheet) || string.IsNullOrEmpty(audioPlayActionClip.CueName))
			{
				continue;
			}
			if (audioPlayActionClip.IsVoice)
			{
				if (worldStateManager != null && !worldStateManager.notMuteCharacterVoice)
				{
					continue;
				}
			}
			else if (worldStateManager != null && !worldStateManager.notMuteEffectVoice)
			{
				continue;
			}
			PlayCriwareCue(audioPlayActionClip.CueSheet, audioPlayActionClip.CueName, "", audioPlayActionClip.AwbName, audioPlayActionClip.IsVoice, audioPlayActionClip.StartTimeInMs);
		}
	}

	protected override bool _CanTriggerOnInOutOneFrame()
	{
		return true;
	}

	public void PlayCriwareCue(string pCueSheet, string pCueName, string pCueAcb = "", string pCueAwb = "", bool isVoice = false, int startTime = 0)
	{
		if (!string.IsNullOrEmpty(pCueSheet) && !string.IsNullOrEmpty(pCueName))
		{
			AudioManager.Instance.AddCue(isVoice ? "voice" : "effect", pCueSheet, !string.IsNullOrEmpty(pCueAwb));
			m_CriAtomSource.cueSheet = pCueSheet;
			m_CriAtomSource.cueName = pCueName;
			m_CriAtomSource.startTime = startTime;
			if (isVoice)
			{
				m_VoicePlaybacks.Add(m_CriAtomSource.Play());
			}
			else
			{
				m_EffectPlaybacks.Add(m_CriAtomSource.Play());
			}
		}
	}

	public void StopCriwareCue(bool isVoice = false)
	{
		if (isVoice)
		{
			for (int i = 0; i < m_VoicePlaybacks.Count; i++)
			{
				m_VoicePlaybacks[i].Stop();
			}
			m_VoicePlaybacks.Clear();
		}
		else
		{
			for (int j = 0; j < m_EffectPlaybacks.Count; j++)
			{
				m_EffectPlaybacks[j].Stop();
			}
			m_EffectPlaybacks.Clear();
		}
	}

	protected override void _UpdateNodes(List<AudioPlayActionClip> clipsInThisFrame, float normalized)
	{
	}

	protected override void _ExitNodes(List<AudioPlayActionClip> clipsInThisFrame, float normalized, bool isRolleback = false)
	{
	}

	protected override void _Shutdown()
	{
		m_EffectPlaybacks.Clear();
		m_VoicePlaybacks.Clear();
	}

	protected override void _Stop(bool isForceClean = true)
	{
		if (isForceClean)
		{
			m_CriAtomSource.Stop();
		}
		m_EffectPlaybacks.Clear();
		m_VoicePlaybacks.Clear();
	}
}
