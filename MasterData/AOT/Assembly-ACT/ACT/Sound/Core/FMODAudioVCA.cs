using FMOD.Studio;

namespace ACT.Sound.Core;

internal class FMODAudioVCA : IAudioVCA
{
	private VCA _fmodVca;

	public FMODAudioVCA(VCA fmodVca)
	{
		_fmodVca = fmodVca;
	}

	public void SetVolume(float volume)
	{
		if (_fmodVca.isValid())
		{
			_fmodVca.setVolume(volume);
		}
	}

	public float GetVolume()
	{
		if (_fmodVca.isValid())
		{
			_fmodVca.getVolume(out var volume);
			return volume;
		}
		return 0f;
	}
}
