using System;
using ACT.Sound;
using Fundamental;
using UnityEngine;
using UnityEngine.Playables;

namespace ACT.Timeline;

[Serializable]
public class AudioVoiceBehaviour : PlayableBehaviour
{
	[NonSerialized]
	public AudioEventReference audioEventReference;

	[NonSerialized]
	public float volume;

	[NonSerialized]
	public bool fadeOutOnStop = true;

	[NonSerialized]
	public Transform attachTarget;

	private uint _instanceId;

	private bool _hasPlayed;

	public override void OnBehaviourPlay(Playable playable, FrameData info)
	{
		if (!_hasPlayed)
		{
			_hasPlayed = true;
			AudioPlayOptions options = new AudioPlayOptions
			{
				volume = volume,
				attachTarget = attachTarget,
				forcePlay = true
			};
			if (!audioEventReference.IsNull())
			{
				string eventPath = AudioVoiceManager.ResolveLanguagePath(audioEventReference.GetEventPath());
				_instanceId = Singleton<CGAudioManager>.instance.Play(eventPath, options);
				double time = playable.GetTime();
				Singleton<GameManager>.instance.audioManager.SetPlaybackTime(_instanceId, (float)time);
			}
		}
	}

	public override void OnBehaviourPause(Playable playable, FrameData info)
	{
		if (_instanceId != 0)
		{
			double duration = playable.GetDuration();
			playable.GetTime();
			if (playable.GetTime() + (double)info.deltaTime >= duration || info.effectivePlayState == PlayState.Paused)
			{
				StopVoice();
			}
		}
	}

	public override void OnPlayableDestroy(Playable playable)
	{
		StopVoice();
	}

	public override void OnGraphStop(Playable playable)
	{
		StopVoice();
	}

	private void StopVoice()
	{
		if (_instanceId != 0)
		{
			Singleton<CGAudioManager>.instance?.Stop(_instanceId, fadeOutOnStop);
			_instanceId = 0u;
		}
		_hasPlayed = false;
	}

	public uint GetInstanceId()
	{
		return _instanceId;
	}
}
