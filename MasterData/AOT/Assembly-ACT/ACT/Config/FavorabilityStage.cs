using System;

namespace ACT.Config;

[Serializable]
public class FavorabilityStage
{
	public readonly int id;

	public readonly int name;

	public FavorabilityStage(int id, int name)
	{
		this.id = id;
		this.name = name;
	}
}
