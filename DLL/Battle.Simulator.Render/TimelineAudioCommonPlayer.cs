using System.Collections.Generic;

public class TimelineAudioCommonPlayer : CommonSimpleTimelineClipPlayer<AudioPlayActionClip>, ILoopClipPlayer
{
	public CriAtomSource m_CriAtomSource;

	protected override void _Initialize(List<AudioPlayActionClip> clips)
	{
	}

	protected override void _EnterNodes(List<AudioPlayActionClip> clipsInThisFrame, float normalized, bool isRolleback = false)
	{
	}

	protected override bool _CanTriggerOnInOutOneFrame()
	{
		return true;
	}

	public void PlayCriwareCue(string pCueSheet, string pCueName, bool useStream)
	{
		if (string.IsNullOrEmpty(pCueSheet) || string.IsNullOrEmpty(pCueName))
		{
			return;
		}
		BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
		if (battleScene != null)
		{
			WorldStateManager worldSatetManager = battleScene.GetWorldSatetManager();
			if (!worldSatetManager.notMuteBattleVoice || !worldSatetManager.notMuteEffectVoice)
			{
				return;
			}
		}
		AudioManager.Instance.AddCue("effect", pCueSheet, useStream);
		m_CriAtomSource.cueSheet = pCueSheet;
		m_CriAtomSource.cueName = pCueName;
		m_CriAtomSource.Play();
	}

	public void StopCriwareCue()
	{
		m_CriAtomSource.Stop();
	}

	protected override void _UpdateNodes(List<AudioPlayActionClip> clipsInThisFrame, float normalized)
	{
	}

	protected override void _ExitNodes(List<AudioPlayActionClip> clipsInThisFrame, float normalized, bool isRolleback = false)
	{
	}

	protected override void _Shutdown()
	{
		StopCriwareCue();
	}

	protected override void _Stop(bool isForceClean = true)
	{
	}
}
