using System;

namespace ACT.Config;

[Serializable]
public class SceneMusicData
{
	public readonly int id;

	public readonly string sceneBGM = "";

	public readonly string bankPath = "";

	public SceneMusicData(int id, string sceneBGM, string bankPath)
	{
		this.id = id;
		this.sceneBGM = sceneBGM;
		this.bankPath = bankPath;
	}
}
