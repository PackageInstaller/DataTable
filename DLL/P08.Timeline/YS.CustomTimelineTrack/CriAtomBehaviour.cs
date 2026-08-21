using System;
using System.Threading;
using UnityEngine;
using UnityEngine.Playables;

namespace YS.CustomTimelineTrack;

[Serializable]
public class CriAtomBehaviour : PlayableBehaviour
{
	[Range(0f, 1f)]
	public float volume = 1f;

	[Range(-1200f, 1200f)]
	public float pitch;

	[Range(0f, 1f)]
	public float AISACValue;

	private static int cPreviewStopTimeMs = 500;

	private CriAtomExAcb m_acb;

	private string m_lastCueSheetName;

	private bool _IsClipPlaying;

	private double _CueLength;

	public CriAtomExPlayback playback { get; private set; }

	public bool IsClipPlaying
	{
		get
		{
			return _IsClipPlaying;
		}
		private set
		{
			_IsClipPlaying = value;
		}
	}

	public double CueLength
	{
		get
		{
			return _CueLength;
		}
		private set
		{
			_CueLength = value;
		}
	}

	public override void OnGraphStop(Playable playable)
	{
		base.OnGraphStop(playable);
		IsClipPlaying = false;
	}

	public void Play(CriAtomSource atomSource, CriAtomClipPlayConfig config)
	{
	}

	public void PreviewPlay(Guid trackId, bool instantStop, CriAtomClipPlayConfig config)
	{
		IsClipPlaying = true;
		if (config.cueSheetName != m_lastCueSheetName)
		{
			m_acb = CriAtomTimelinePreviewer.Instance.GetAcb(config.cueSheetName);
		}
		if (m_acb == null)
		{
			return;
		}
		CriAtomTimelinePreviewer.Instance.SetCue(trackId, m_acb, config.cueName);
		CueLength = GetCueLengthSec(m_acb, config.cueName);
		m_lastCueSheetName = config.cueSheetName;
		if (playback.status != CriAtomExPlayback.Status.Removed)
		{
			playback.Stop();
		}
		if (CueLength > 0.0)
		{
			CriAtomTimelinePreviewer.Instance.SetStartTime(trackId, config.startTimeMs);
			CriAtomTimelinePreviewer.Instance.SetLoop(trackId, config.loop);
			playback = CriAtomTimelinePreviewer.Instance.Play(trackId);
			if (instantStop)
			{
				WaitAndStop();
			}
		}
	}

	private void WaitAndStop()
	{
		new Thread((ThreadStart)delegate
		{
			Thread.Sleep(cPreviewStopTimeMs);
			Stop(noReleaseTime: true);
		}).Start();
	}

	public void Stop(bool noReleaseTime = false)
	{
		playback.Stop(noReleaseTime);
		IsClipPlaying = false;
	}

	private double GetCueLengthSec(CriAtomExAcb acb, string cueName)
	{
		if (acb != null && acb.GetWaveFormInfo(cueName, out var info))
		{
			return (double)info.numSamples / (double)info.samplingRate;
		}
		return 0.0;
	}
}
