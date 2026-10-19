using System;
using UnityEngine;

namespace ACT.Sound.Core;

public interface IAudioInstance
{
	bool IsValid { get; }

	bool IsPlaying { get; }

	bool IsPaused { get; }

	float PlaybackTime { get; set; }

	void Start();

	void Stop(bool allowFadeOut = true);

	void Pause(bool pause);

	void SetVolume(float volume);

	void SetParameter(string parameterName, float value);

	void SetParameter(string parameterName, int value);

	void AttachToGameObject(GameObject gameObject);

	void Release();

	void GetPlaybackState(out AudioPlaybackState state);

	void SetCallback(AudioCallbackType callbackMask);

	IntPtr GetHandle();
}
