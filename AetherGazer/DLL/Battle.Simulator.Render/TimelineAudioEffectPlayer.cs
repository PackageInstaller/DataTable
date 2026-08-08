using System.Collections.Generic;
using UnityEngine;

public class TimelineAudioEffectPlayer : CommonSimpleTimelineClipPlayer<AudioPlayActionClip>, ILoopClipPlayer, ITimeScalePlayer
{
	public CriAtomSource m_CriAtomSource;

	protected override void _Initialize(List<AudioPlayActionClip> clips)
	{
	}

	protected override void _EnterNodes(List<AudioPlayActionClip> clipsInThisFrame, float normalized, bool isRolleback = false)
	{
		BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
		if (battleScene != null)
		{
			WorldStateManager worldSatetManager = battleScene.GetWorldSatetManager();
			if (!worldSatetManager.notMuteBattleVoice || !worldSatetManager.notMuteEffectVoice)
			{
				return;
			}
		}
		for (int i = 0; i < clipsInThisFrame.Count; i++)
		{
			AudioPlayActionClip audioPlayActionClip = clipsInThisFrame[i];
			if (audioPlayActionClip.IsVoice)
			{
				continue;
			}
			string text = audioPlayActionClip.CueSheet;
			string text2 = audioPlayActionClip.CueName;
			bool useStream = !string.IsNullOrEmpty(audioPlayActionClip.AwbName);
			int startTime = audioPlayActionClip.StartTimeInMs;
			if (audioPlayActionClip.RandomTotalWitght > 0)
			{
				int num = Random.Range(0, audioPlayActionClip.RandomTotalWitght);
				for (int j = 0; j < audioPlayActionClip.RandomWeight.Length; j++)
				{
					if (audioPlayActionClip.RandomWeight[j] > num)
					{
						CriCueInfo obj = audioPlayActionClip.CriCueInfoArr[j];
						text = obj.mCueSheet;
						text2 = obj.mCueName;
						useStream = obj.mUseStream;
						startTime = ((audioPlayActionClip.RandomStartTimeInMs != null && audioPlayActionClip.RandomStartTimeInMs.Length > j) ? audioPlayActionClip.RandomStartTimeInMs[j] : 0);
						break;
					}
					num -= audioPlayActionClip.RandomWeight[j];
				}
			}
			if (!string.IsNullOrEmpty(text) && !string.IsNullOrEmpty(text2))
			{
				PlayCriwareCue(text, text2, useStream, startTime);
			}
		}
	}

	protected override bool _CanTriggerOnInOutOneFrame()
	{
		return true;
	}

	public void PlayCriwareCue(string pCueSheet, string pCueName, bool useStream, int startTime)
	{
		if (!string.IsNullOrEmpty(pCueSheet) && !string.IsNullOrEmpty(pCueName))
		{
			AudioManager.Instance.AddCue("effect", pCueSheet, useStream);
			m_CriAtomSource.cueSheet = pCueSheet;
			m_CriAtomSource.cueName = pCueName;
			m_CriAtomSource.startTime = startTime;
			m_CriAtomSource.Play();
		}
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
		if (isForceClean)
		{
			m_CriAtomSource.Stop();
		}
	}

	public void SetTimeScale(float timeScale)
	{
	}

	public void Pause(bool isPause = true)
	{
		if (m_CriAtomSource != null)
		{
			m_CriAtomSource.Pause(isPause);
		}
	}
}
