using System;

namespace ACT.Config;

[Serializable]
public class RogueFeature
{
	public readonly int id;

	public readonly int name;

	public readonly int description;

	public RogueFeature(int id, int name, int description)
	{
		this.id = id;
		this.name = name;
		this.description = description;
	}
}
