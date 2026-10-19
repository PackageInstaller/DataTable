using System;

namespace ACT.Sound;

[Serializable]
public class BGMConfig
{
	public string eventPath;

	public float volume = 1f;

	public BGMConfig(string path, float vol = 1f)
	{
		eventPath = path;
		volume = vol;
	}
}
