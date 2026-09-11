using System;

[Serializable]
public class SoundVolumeConfig
{
	public float sound_music;

	public float sound_effect;

	public float sound_voice;

	public SoundVolumeConfig()
	{
		sound_music = 50f;
		sound_effect = 50f;
		sound_voice = 50f;
	}
}
