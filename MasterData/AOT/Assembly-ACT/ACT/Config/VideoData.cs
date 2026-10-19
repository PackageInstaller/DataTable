using System;

namespace ACT.Config;

[Serializable]
public class VideoData
{
	public readonly int id;

	public readonly string configPath = "";

	public VideoData(int id, string configPath)
	{
		this.id = id;
		this.configPath = configPath;
	}
}
