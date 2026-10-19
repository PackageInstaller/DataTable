using System;

namespace ACT.Config;

[Serializable]
public class MusicCD
{
	public readonly int id;

	public readonly string name = "";

	public MusicCD(int id, string name)
	{
		this.id = id;
		this.name = name;
	}
}
