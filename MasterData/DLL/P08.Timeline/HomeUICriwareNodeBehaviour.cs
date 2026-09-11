using P08.CriLipsEx;
using UnityEngine;
using UnityEngine.Playables;

public class HomeUICriwareNodeBehaviour : PlayableBehaviour
{
	public CriLipsExPlayer m_criLipsExPlayer;

	public string mCueSheet;

	public string mCueName;

	public string mCueAcb;

	public string mCueAwb;

	public bool useStream = true;

	private bool start;

	private CriAtomExPlayback _Playback;

	public override void ProcessFrame(Playable playable, FrameData info, object playerData)
	{
		if (Application.isPlaying && !start)
		{
			start = true;
			_Playback = AudioManager.Instance.Play("voice", mCueSheet, mCueName, useStream);
			if (m_criLipsExPlayer != null)
			{
				m_criLipsExPlayer.Play(mCueSheet, mCueName, _Playback);
			}
		}
	}

	public override void OnBehaviourPause(Playable playable, FrameData info)
	{
		base.OnBehaviourPause(playable, info);
		if (start && _Playback.status != CriAtomExPlayback.Status.Removed)
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
