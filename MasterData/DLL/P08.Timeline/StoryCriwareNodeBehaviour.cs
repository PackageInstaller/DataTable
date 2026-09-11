using System;
using P08.CriLipsEx;
using UnityEngine;
using UnityEngine.Playables;

public class StoryCriwareNodeBehaviour : PlayableBehaviour
{
	public CriLipsExPlayer m_criLipsExPlayer;

	public bool m_isComboSkillAsset;

	public string mCueSheet;

	public string mCueName;

	public bool mUseStream;

	public bool mIsVoice;

	public bool mAutoPlayEnd;

	public bool mIsMusic;

	public bool mLoopIfPlaying;

	private bool start;

	private CriAtomExPlayback _Playback;

	public override void ProcessFrame(Playable playable, FrameData info, object playerData)
	{
		if (!Application.isPlaying || (m_isComboSkillAsset && !BattleScene.FullPlay && NScene.GetCurrentScene() is BattleScene))
		{
			return;
		}
		if (!start)
		{
			start = true;
			if (mIsMusic)
			{
				AudioManager.Instance.Play("music", mCueSheet, mCueName, mUseStream);
			}
			else if (mIsVoice)
			{
				_Playback = AudioManager.Instance.Play("voice", mCueSheet, mCueName, mUseStream);
				if (m_criLipsExPlayer != null)
				{
					m_criLipsExPlayer.Play(mCueSheet, mCueName, _Playback);
				}
			}
			else
			{
				_Playback = AudioManager.Instance.Play("effect", mCueSheet, mCueName, mUseStream);
			}
		}
		else
		{
			if (!mLoopIfPlaying || !mIsVoice || _Playback.status != CriAtomExPlayback.Status.Playing)
			{
				return;
			}
			float num = (float)playable.GetTime();
			if (Math.Abs((float)playable.GetDuration() - num) <= 0.1f)
			{
				PlayableDirector playableDirector = playable.GetGraph().GetResolver() as PlayableDirector;
				if (playableDirector != null)
				{
					playableDirector.time -= 0.10000000149011612;
				}
			}
		}
	}

	public override void OnBehaviourPause(Playable playable, FrameData info)
	{
		base.OnBehaviourPause(playable, info);
		if (Application.isPlaying && start && _Playback.status != CriAtomExPlayback.Status.Removed && !mAutoPlayEnd)
		{
			start = false;
			_Playback.Stop();
			_Playback = new CriAtomExPlayback(uint.MaxValue);
			if (m_criLipsExPlayer != null)
			{
				m_criLipsExPlayer.Stop();
			}
		}
	}
}
