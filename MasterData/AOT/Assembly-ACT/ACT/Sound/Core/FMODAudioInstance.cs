using System;
using FMOD.Studio;
using FMODUnity;
using UnityEngine;

namespace ACT.Sound.Core;

internal class FMODAudioInstance : IAudioInstance
{
	private EventInstance _fmodInstance;

	public bool IsValid => _fmodInstance.isValid();

	public bool IsPlaying
	{
		get
		{
			if (!IsValid)
			{
				return false;
			}
			_fmodInstance.getPlaybackState(out var state);
			if (state != PLAYBACK_STATE.PLAYING)
			{
				return state == PLAYBACK_STATE.STARTING;
			}
			return true;
		}
	}

	public bool IsPaused
	{
		get
		{
			if (!IsValid)
			{
				return false;
			}
			_fmodInstance.getPaused(out var paused);
			return paused;
		}
	}

	public float PlaybackTime
	{
		get
		{
			if (!IsValid)
			{
				return 0f;
			}
			_fmodInstance.getTimelinePosition(out var position);
			return (float)position / 1000f;
		}
		set
		{
			if (IsValid)
			{
				int timelinePosition = Mathf.RoundToInt(value * 1000f);
				_fmodInstance.setTimelinePosition(timelinePosition);
			}
		}
	}

	public FMODAudioInstance(EventInstance fmodInstance)
	{
		_fmodInstance = fmodInstance;
	}

	public void Start()
	{
		if (IsValid)
		{
			_fmodInstance.start();
		}
	}

	public void Stop(bool allowFadeOut = true)
	{
		if (IsValid)
		{
			if (IsPaused)
			{
				_fmodInstance.setPaused(paused: false);
				_fmodInstance.stop(FMOD.Studio.STOP_MODE.IMMEDIATE);
			}
			else
			{
				FMOD.Studio.STOP_MODE mode = ((!allowFadeOut) ? FMOD.Studio.STOP_MODE.IMMEDIATE : FMOD.Studio.STOP_MODE.ALLOWFADEOUT);
				_fmodInstance.stop(mode);
			}
		}
	}

	public void Pause(bool pause)
	{
		if (IsValid)
		{
			_fmodInstance.setPaused(pause);
		}
	}

	public void SetVolume(float volume)
	{
		if (IsValid)
		{
			_fmodInstance.setVolume(volume);
		}
	}

	public void SetParameter(string parameterName, float value)
	{
		if (IsValid)
		{
			_fmodInstance.setParameterByName(parameterName, value);
		}
	}

	public void SetParameter(string parameterName, int value)
	{
		if (IsValid)
		{
			_fmodInstance.setParameterByName(parameterName, value);
		}
	}

	public void AttachToGameObject(GameObject gameObject)
	{
		if (IsValid && gameObject != null)
		{
			RuntimeManager.AttachInstanceToGameObject(_fmodInstance, gameObject);
		}
	}

	public void Release()
	{
		if (!IsValid)
		{
			return;
		}
		_fmodInstance.getPlaybackState(out var state);
		if (state != PLAYBACK_STATE.STOPPED)
		{
			if (IsPaused)
			{
				_fmodInstance.setPaused(paused: false);
			}
			_fmodInstance.stop(FMOD.Studio.STOP_MODE.IMMEDIATE);
		}
		_fmodInstance.release();
		_fmodInstance.clearHandle();
	}

	public void GetPlaybackState(out AudioPlaybackState state)
	{
		if (IsValid)
		{
			_fmodInstance.getPlaybackState(out var state2);
			state = ConvertPlaybackState(state2);
		}
		else
		{
			state = AudioPlaybackState.Stopped;
		}
	}

	public void SetCallback(AudioCallbackType callbackMask)
	{
		if (IsValid)
		{
			EVENT_CALLBACK_TYPE eVENT_CALLBACK_TYPE = ~EVENT_CALLBACK_TYPE.ALL;
			if ((callbackMask & AudioCallbackType.TimelineMarker) != 0)
			{
				eVENT_CALLBACK_TYPE |= EVENT_CALLBACK_TYPE.TIMELINE_MARKER;
			}
			_fmodInstance.setCallback(AOTScripts.CGAudioEventCallback, eVENT_CALLBACK_TYPE);
		}
	}

	public IntPtr GetHandle()
	{
		if (!IsValid)
		{
			return IntPtr.Zero;
		}
		return _fmodInstance.handle;
	}

	private static AudioPlaybackState ConvertPlaybackState(PLAYBACK_STATE fmodState)
	{
		return fmodState switch
		{
			PLAYBACK_STATE.PLAYING => AudioPlaybackState.Playing, 
			PLAYBACK_STATE.SUSTAINING => AudioPlaybackState.Sustaining, 
			PLAYBACK_STATE.STARTING => AudioPlaybackState.Starting, 
			PLAYBACK_STATE.STOPPING => AudioPlaybackState.Stopping, 
			PLAYBACK_STATE.STOPPED => AudioPlaybackState.Stopped, 
			_ => AudioPlaybackState.Stopped, 
		};
	}
}
