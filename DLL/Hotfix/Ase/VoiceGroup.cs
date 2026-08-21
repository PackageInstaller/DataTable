using System.Collections.Generic;
using FMOD.Studio;
using UnityEngine;

namespace Ase;

public class VoiceGroup
{
	private long uid;

	private EventInstance curVoice;

	private int curPriority = -1;

	private bool playing;

	private Timer stateTimer;

	private AudioGroup audioGroup;

	public AudioGroup Group => audioGroup;

	public static VoiceGroup Create(long uid)
	{
		return new VoiceGroup
		{
			uid = uid,
			audioGroup = new AudioGroup()
		};
	}

	~VoiceGroup()
	{
		Dispose();
	}

	public void Play(int audioId, int priority = 0, float volume = 1f, List<AudioParameterSerializable> pars = null)
	{
		Singleton<AudioSystem>.Instance.Play(uid, audioId, priority, volume, pars);
	}

	public void Play(int audioId, Transform followTransform, int priority = 0, float volume = 1f, List<AudioParameterSerializable> pars = null)
	{
		Singleton<AudioSystem>.Instance.Play(uid, audioId, followTransform, priority, volume, pars);
	}

	public void Stop(List<AudioParameter> fadeOutParams = null)
	{
		audioGroup.Stop((STOP_MODE)0, null, fadeOutParams, clearStack: true, forcePlay: true, playback: false);
	}

	public EventInstance GetCurVoice()
	{
		//IL_000b: Unknown result type (might be due to invalid IL or missing references)
		return audioGroup.GetPeek().EventInstance;
	}

	public void Dispose(bool stopVoice = false, List<AudioParameter> fadeOutParams = null)
	{
		if (stopVoice)
		{
			Stop(fadeOutParams);
		}
		if (stateTimer != null)
		{
			stateTimer.Cancel();
			stateTimer = null;
		}
	}
}
