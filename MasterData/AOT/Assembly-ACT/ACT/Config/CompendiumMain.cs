using System;

namespace ACT.Config;

[Serializable]
public class CompendiumMain
{
	public readonly int id;

	public readonly int name;

	public readonly int precondition;

	public CompendiumMain(int id, int name, int precondition)
	{
		this.id = id;
		this.name = name;
		this.precondition = precondition;
	}
}
