using System;

namespace ACT.Config;

[Serializable]
public class ShortVideo
{
	public readonly int id;

	public readonly string Path = "";

	public ShortVideo(int id, string Path)
	{
		this.id = id;
		this.Path = Path;
	}
}
