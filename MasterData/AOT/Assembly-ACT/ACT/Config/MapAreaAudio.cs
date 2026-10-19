using System;

namespace ACT.Config;

[Serializable]
public class MapAreaAudio
{
	public readonly int id;

	public readonly string bgmSound = "";

	public readonly string envSound = "";

	public readonly string reverb = "";

	public readonly int footStepMat;

	public readonly string bankPath = "";

	public MapAreaAudio(int id, string bgmSound, string envSound, string reverb, int footStepMat, string bankPath)
	{
		this.id = id;
		this.bgmSound = bgmSound;
		this.envSound = envSound;
		this.reverb = reverb;
		this.footStepMat = footStepMat;
		this.bankPath = bankPath;
	}
}
