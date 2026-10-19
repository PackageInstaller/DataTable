using System;

namespace ACT.Config;

[Serializable]
public class PresentType
{
	public readonly int id;

	public readonly int name;

	public PresentType(int id, int name)
	{
		this.id = id;
		this.name = name;
	}
}
