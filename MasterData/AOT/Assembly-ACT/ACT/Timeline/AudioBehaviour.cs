using System;
using ACT.Sound;
using Fundamental;
using UnityEngine;
using UnityEngine.Playables;

namespace ACT.Timeline;

[Serializable]
public class AudioBehaviour : PlayableBehaviour
{
	[NonSerialized]
	public AudioEventReference audioEventReference;

	[NonSerialized]
	public float volume;

	[NonSerialized]
	public bool fadeOutOnStop = true;

	[NonSerialized]
	public bool ignoreTimelineTime;

	[NonSerialized]
	public Transform attachTarget;

	private uint _instanceId;

	private bool _hasPlayed;

	private bool _pausedWithTimeline;

	private bool _graphStopped;

	private PlayableDirector _director;

	public override void OnBehaviourPlay(Playable playable, FrameData info)
	{
		_director = ResolveDirector(playable);
		if (_graphStopped)
		{
			_graphStopped = false;
			if (_pausedWithTimeline)
			{
				ResumeAudio();
				return;
			}
			StopAudio();
		}
		else if (_pausedWithTimeline)
		{
			ResumeAudio();
			return;
		}
		if (_hasPlayed)
		{
			if (_instanceId != 0 && !ignoreTimelineTime)
			{
				Singleton<GameManager>.instance.audioManager?.SetPlaybackTime(_instanceId, (float)playable.GetTime());
			}
		}
		else if (!audioEventReference.IsNull())
		{
			_hasPlayed = true;
			AudioPlayOptions options = new AudioPlayOptions
			{
				volume = volume,
				attachTarget = attachTarget,
				forcePlay = true
			};
			_instanceId = Singleton<GameManager>.instance.audioManager?.PlaySound(audioEventReference, options) ?? 0;
		}
	}

	public override void OnBehaviourPause(Playable playable, FrameData info)
	{
		if (_instanceId != 0)
		{
			double duration = playable.GetDuration();
			double num = playable.GetTime() + (double)info.deltaTime;
			if (_director != null && _director.state != PlayState.Playing && num < duration)
			{
				PauseAudio();
			}
			else if (num >= duration || info.effectivePlayState == PlayState.Paused)
			{
				StopAudio();
			}
		}
	}

	public override void OnPlayableDestroy(Playable playable)
	{
		StopAudio();
	}

	public override void OnGraphStop(Playable playable)
	{
		_graphStopped = true;
		if (_instanceId != 0 && (!_pausedWithTimeline || !(_director != null) || _director.state == PlayState.Playing))
		{
			StopAudio();
		}
	}

	private void PauseAudio()
	{
		if (_instanceId != 0 && !_pausedWithTimeline)
		{
			_pausedWithTimeline = true;
			Singleton<GameManager>.instance.audioManager?.SetPause(_instanceId, pause: true);
		}
	}

	private void ResumeAudio()
	{
		if (_pausedWithTimeline)
		{
			_pausedWithTimeline = false;
			Singleton<GameManager>.instance.audioManager?.SetPause(_instanceId, pause: false);
		}
	}

	private void StopAudio()
	{
		if (_instanceId != 0)
		{
			Singleton<GameManager>.instance.audioManager?.Stop(_instanceId, fadeOutOnStop);
			_instanceId = 0u;
		}
		_hasPlayed = false;
		_pausedWithTimeline = false;
	}

	private static PlayableDirector ResolveDirector(Playable playable)
	{
		return playable.GetGraph().GetResolver() as PlayableDirector;
	}

	public uint GetInstanceId()
	{
		return _instanceId;
	}
}
