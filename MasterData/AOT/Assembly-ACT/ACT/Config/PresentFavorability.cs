using System;

namespace ACT.Config;

[Serializable]
public class PresentFavorability
{
	public readonly int id;

	public readonly int name;

	public PresentFavorability(int id, int name)
	{
		this.id = id;
		this.name = name;
	}
}
