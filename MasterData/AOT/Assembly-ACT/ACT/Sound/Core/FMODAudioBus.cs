using FMOD.Studio;

namespace ACT.Sound.Core;

internal class FMODAudioBus : IAudioBus
{
	private Bus _fmodBus;

	public FMODAudioBus(Bus fmodBus)
	{
		_fmodBus = fmodBus;
	}

	public void SetVolume(float volume)
	{
		if (_fmodBus.isValid())
		{
			_fmodBus.setVolume(volume);
		}
	}

	public void SetMute(bool mute)
	{
		if (_fmodBus.isValid())
		{
			_fmodBus.setMute(mute);
		}
	}

	public float GetVolume()
	{
		if (_fmodBus.isValid())
		{
			_fmodBus.getVolume(out var volume);
			return volume;
		}
		return 0f;
	}

	public void StopAllEvents(bool allowFadeOut = true)
	{
		if (_fmodBus.isValid())
		{
			STOP_MODE mode = ((!allowFadeOut) ? STOP_MODE.IMMEDIATE : STOP_MODE.ALLOWFADEOUT);
			_fmodBus.stopAllEvents(mode);
		}
	}

	public void PauseAllEvents(bool pause)
	{
		if (_fmodBus.isValid())
		{
			_fmodBus.setPaused(pause);
		}
	}
}
