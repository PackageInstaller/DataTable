namespace ACT.Sound.Core;

public interface IAudioBus
{
	void SetVolume(float volume);

	void SetMute(bool mute);

	float GetVolume();

	void StopAllEvents(bool allowFadeOut = true);

	void PauseAllEvents(bool pause);
}
