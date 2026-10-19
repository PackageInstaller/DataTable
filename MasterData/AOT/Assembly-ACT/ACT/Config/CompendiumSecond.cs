using System;

namespace ACT.Config;

[Serializable]
public class CompendiumSecond
{
	public readonly int id;

	public readonly int name;

	public readonly int secondName;

	public readonly int[] type = new int[0];

	public CompendiumSecond(int id, int name, int secondName, int[] type)
	{
		this.id = id;
		this.name = name;
		this.secondName = secondName;
		this.type = type;
	}
}
